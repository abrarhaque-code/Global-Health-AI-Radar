# Architecture Decision Records

This log captures the non-obvious choices behind AI x Global Health Radar. Each ADR records one decision in a fixed shape: Status, Context, Decision, Consequences. Append a new ADR whenever you make a judgment call that a future reader would otherwise have to reverse-engineer; never rewrite an accepted ADR, supersede it with a new one instead.

---

## ADR-001: Use Git as the runtime, not a database

**Status:** Accepted

**Context:** The workbench produces opportunity cards, scores, and analytical notes that need to be reviewed, corrected, and shared. The candidate substrates were a relational or document database with a custom UI, a hosted SaaS tool, or a Git repository of plain-markdown files. A database gives structured queries; it also requires hosting, schema migrations, access control, and a UI layer before anyone can read a single card.

**Decision:** Store everything as plain-markdown files with YAML front-matter in a Git repository. Cards, taxonomy, prompts, methodology, and memos are all files. The "tool" is an AI agent driving MCP connectors, not a bespoke application. Programmatic queries, if needed later, come from a small parser over the front-matter, not from migrating off Git.

**Consequences:**
- Cards are diffable: every change is a reviewable commit, and the history is the audit trail.
- The repo is portable and browsable on any Git host with zero infrastructure to stand up.
- Onboarding is reading files in order, not learning an application.
- The cost is that cross-card queries (for example, "all `likely_fit` cards in one theme") are not free; they require grep, a parser, or a generated master table rather than a database index.
- Concurrency is Git-shaped: parallel edits to the same card merge like code, so append-only discipline matters on shared files such as the watchlist.

---

## ADR-002: Bias toward false positives at Discovery; filter at Triage and Vetting

**Status:** Accepted

**Context:** Discovery casts across several sources (a private-market data provider, PubMed, ClinicalTrials.gov, news, conference rosters, cross-references). A pipeline can fail in two directions: it can admit too many irrelevant candidates, or it can reject relevant candidates too early. A false positive surfaces later at Triage or Vetting and costs a few minutes. A false negative is a company that never enters the system and is therefore never reconsidered.

**Decision:** Tune Discovery for recall, not precision. When a candidate cannot be ruled out immediately, admit it. Concentrate filtering at two later, explicit gates: Triage applies the two gates (mission alignment and investability potential), and Vetting applies the 1-5 scoring rubric. Positive signals raise confidence at Vetting; they do not decide entry at Discovery or Triage.

**Consequences:**
- Discovery output is intentionally noisy; the inbox carries many candidates that will not become cards.
- The two downstream gates do the real work, so the gate definitions and the rubric must stay sharp.
- A wrong rejection is the expensive error, so reviewers err toward enrichment when in doubt.
- Throughput at Triage matters; the step is designed as a fast pass per candidate, not a deep read.

---

## ADR-003: Keep raw provider data out of Git; commit only synthesized cards with citations

**Status:** Accepted

**Context:** Discovery and enrichment pull from licensed or proprietary sources (a private-market data provider, a CRM) whose raw content cannot be redistributed, alongside public sources (PubMed, ClinicalTrials.gov, the open web) that can be cited freely. The repository is intended to be shareable. Committing raw provider exports would create a licensing and privacy problem and would couple the public record to a specific vendor.

**Decision:** Raw provider pulls, CRM exports, discovery inboxes, and unredacted outreach live in a gitignored `private/` directory (and under the `*-private.md` filename pattern). Committed cards synthesize from public sources with a citation on every factual claim. A card may reference a provider record by an opaque ID as a private reference, but no provider content enters the committed body. Before any public push, review `git log` and `git diff` for leakage.

**Consequences:**
- The repository can be made public without redistributing licensed data.
- Every committed claim is independently verifiable through its citation, which raises the credibility of the shareable record.
- The boundary is defense-in-depth: a gitignored directory plus a filename pattern plus a pre-push review.
- The cost is duplication of effort: an analyst reads provider data privately, then re-states the verifiable parts with public citations rather than pasting the source.
- Swapping the private-market data provider or the CRM does not change the public cards, because the cards never depended on a specific vendor's text.

---

## ADR-004: The active-card stage window is Seed through Series C

**Status:** Accepted

**Context:** Discovery surfaces companies at every stage, from idea-stage accelerator entrants to public companies. A radar that cards everything dilutes analyst attention; a radar that cards only one stage misses the companies that will enter the fund's window within a year or two. The stage filter also has to be expressible as a clean query against a private-market data provider, or discovery sweeps become hand-curation.

**Decision:** Active opportunity cards require a funding stage between Seed and Series C inclusive (including extensions). Pre-seed, Series D and later, growth equity, and public companies do not get active cards, but they can hold watchlist rows. Edge cases (a very large seed, a SAFE-only company, a down round) are handled by the round-amount review rules in `taxonomy/funding_stages.yaml`, not by widening the window.

**Consequences:**
- Discovery queries are stage-filterable at the source, which keeps sweep output tractable.
- Companies age into and out of the window; the quarterly refresh re-checks watchlist rows for stage transitions in both directions.
- A narrower window (Seed to Series B) was considered and rejected because Series C companies in this field often still have open questions the radar exists to answer.
- The window is a template default. A fund with a different entry point changes the included list in `taxonomy/funding_stages.yaml` and nothing else.

---

## ADR-005: Impact is defined by where it lands, not by company HQ

**Status:** Accepted

**Context:** Many of the strongest AI-for-health companies serving low- and middle-income countries are headquartered in the US, Europe, or India. Filtering by HQ geography would remove them from the radar while keeping weaker companies that happen to be locally registered. The failure mode in both directions is real: HQ-only filtering misses globally scaled operators, and no geographic discipline at all admits companies whose LMIC language is aspirational.

**Decision:** HQ country is metadata, never a filter. A company qualifies on evidence of where its product actually operates: named deployments, named partners, named programs in the geographies the thesis cares about. The card schema separates `hq_country` from `impact_geographies`, and the scoring rubric's impact axis demands deployment evidence, not mission statements.

**Consequences:**
- The "Where the impact lands" body section is mandatory and citation-bearing; it is the enforcement point for this rule.
- Marketing claims of the form "serving patients across Africa" do not satisfy the section; named countries and programs do.
- The rubric, not an HQ field, carries the burden of geographic discipline, so the rubric's evidence bars must stay sharp.
- HIC-headquartered companies with no LMIC operations still enter the radar when relevant, but through the explicit off-thesis path in ADR-007, not by quietly passing.

---

## ADR-006: High-burden disease verticals get their own leaf tags

**Status:** Accepted

**Context:** A disease taxonomy can stay at the category level (infectious disease, non-communicable disease) or break out individual diseases. Category-level tagging reads cleaner but makes the highest-value filters impossible: tuberculosis, HIV, and malaria each have distinct funder ecosystems, procurement channels, regulatory pathways, and AI literatures. "Show me the TB screening companies" is a question the radar must answer directly.

**Decision:** Diseases with distinct global-health funding programs and distinct AI application literatures are leaf tags in `taxonomy/disease_areas.yaml` (tuberculosis, HIV, malaria, and peers), grouped under parent categories for roll-up. The test for adding a leaf: does a major funder run a named program for it, and does the AI literature treat it as its own problem?

**Consequences:**
- Theme-level discovery sweeps can target a disease vertical without hand-filtering.
- The taxonomy grows by evidence of a distinct ecosystem, not by enumerating ICD codes; most conditions stay at category level.
- Cards tag every applicable leaf, so cross-disease platforms carry several tags rather than a lossy primary one.

---

## ADR-007: Real-but-off-thesis companies get a monitor_only card with an explicit pivot hypothesis

**Status:** Accepted

**Context:** Discovery regularly surfaces companies that fail the mission-alignment gate on current evidence but pass the investability gate convincingly: strong founders, real technology, top-tier accelerator backing, no current positioning in the thesis geography or population. Strict gate application would exclude them entirely, which deletes exactly the companies most likely to matter if they pivot. Silently including them corrupts the scoring distribution.

**Decision:** Such a company gets a full card scored honestly (impact score reflecting its current lack of thesis-relevant operations), `fit_rating: monitor_only`, and a mandatory, explicit pivot hypothesis in "Open questions and risks": the concrete, checkable conditions under which the company would become thesis-relevant. The card also lists the promotion criteria, drawn from `taxonomy/signal_triggers.yaml`, that would upgrade the rating.

**Consequences:**
- The radar keeps watching companies the strict gates would delete, without pretending they currently fit.
- Scores stay honest: a monitor_only card with an impact score of 1 is a statement, not an error.
- Each such card costs enrichment effort; the pattern is for companies with strong Gate 2 evidence, not every off-thesis startup.
- Quarterly signal-trigger scans check the pivot hypothesis, so the card has a built-in review loop rather than rotting.

---

## ADR-008: total_raised_usd is all-in capital, not equity-only

**Status:** Accepted

**Context:** Companies in this field finance themselves with a mix of priced equity, SAFEs and notes, foundation grants, and occasional venture debt. An equity-only total systematically understates grant-heavy companies, which in global health are often the most traction-rich. Data providers disagree with each other and with company statements, and no convention at all produces cards whose funding fields cannot be compared.

**Decision:** `total_raised_usd` is all-in capital: priced equity plus SAFEs and notes plus named grants plus disclosed venture debt. The "Funding history" body section breaks out the components for grant-heavy companies, so a reader can always reconstruct the equity-only figure. Separate `total_equity_usd` and `total_capital_usd` fields were considered and rejected to keep the CRM column set stable.

**Consequences:**
- Grant-heavy companies compare fairly against equity-financed peers in the master table.
- The convention must be stated on the schema field definition, or future contributors will silently revert to equity-only.
- The single-field compromise loses one distinction; the body section carries it instead.
- CRM sync pushes one number, which is what a pipeline view needs.

---

## ADR-009: Funding fields hard-fail validation on inversion or provider-only sourcing

**Status:** Accepted

**Context:** A refresh pass across the full card set found multiple cards where `last_round_amount_usd` exceeded `total_raised_usd`, usually because one field was updated and the other was stale or null. Funding fields drive outreach prioritization, so silent inconsistency here propagates into cohort decisions. Separately, funding figures sourced only from a licensed provider cannot be cited publicly, which breaks the citation discipline that makes committed cards shareable.

**Decision:** The pre-export validator treats two funding conditions as hard failures: (1) `last_round_amount_usd > total_raised_usd` when both are integers, and (2) funding fields whose only support is a private provider reference. Every funding claim needs at least one public source (news, company statement, grant database, regulatory filing) cited in the "Funding history" section. Null and `[uncertain]` values skip check 1 rather than faking a zero.

**Consequences:**
- The inversion class of error is caught at validation, not discovered in the CRM.
- Enrichment costs more per card: a provider figure must be re-anchored to a public source before it can be committed.
- Cards where no public funding source exists carry `[uncertain]` honestly instead of an uncitable number.

---

## ADR-010: fit_rating is a derived, bounded field with a firm-neutral name

**Status:** Accepted

**Context:** The rating field that drives outreach decisions could be a free judgment call, and its name could encode the operating firm. A free judgment drifts from the scores it supposedly summarizes; a firm-specific field name makes every card and every prompt non-portable.

**Decision:** The field is named `fit_rating` (no firm prefix), takes one of four values (`likely_fit`, `adjacent`, `monitor_only`, `out_of_scope`), and is bounded by the two scores via the mapping table in `docs/scoring_rubric.md`: any score of 2 caps the rating at `monitor_only`, any score of 1 forces `out_of_scope`. Within the bounds the analyst chooses; outside them the rating is invalid and the validator flags it.

**Consequences:**
- A rating can never silently contradict the scores that justify it.
- Template adopters rename nothing; the field carries no firm identity.
- The mapping table is load-bearing and changes only by a superseding ADR.

---

## ADR-011: Hygiene is enforced by a preflight script in CI, with confidential tokens in a gitignored extension file

**Status:** Accepted

**Context:** The repository's publishability depends on rules that humans reliably forget under deadline: no em dashes or ellipses (house style), no leaked confidential names, no missing source declarations, `private/` stays gitignored. A checklist in CLAUDE.md is guidance; only an executable check is a gate. But a public hygiene script with a hardcoded list of confidential names would itself leak the very names it guards, which is a self-defeating design.

**Decision:** `scripts/preflight.sh` runs the checks and exits nonzero on failure; `.github/workflows/preflight.yml` runs it on every pull request and push to main. The public script ships with only a generic sentinel token in its banned-token list (the literal is documented in the script header, which is excluded from its own scan) and reads real confidential tokens from `private/banned_tokens.txt`, which is gitignored, so the token list never becomes public. An optional `--history` mode sweeps the full git history before a first public push.

**Consequences:**
- Style and leakage rules are enforced mechanically on every contribution, including the maintainer's.
- Each operator maintains their own token file; a fresh clone passes preflight with the sentinel alone.
- The working-tree scan does not cover history by default; the `--history` mode exists for the one moment that matters, taking a repo public.

---

## ADR-012: landscape/INDEX.md is generated, never hand-edited

**Status:** Accepted

**Context:** A master table over the card set is the single most-read artifact in the repository, and the most tempting one to patch by hand. Hand edits drift from the cards within days, and a drifted dashboard is worse than none because readers trust it.

**Decision:** `landscape/INDEX.md` is regenerated from card front-matter by `prompts/render_master_table.md` and committed alongside any card change. The generator is deterministic (same cards produce the same file), read-only on cards, and recomputes every count from the file system. Optional sections (score quadrant, tier callouts, pending decisions) render only when their inputs exist, so a small landscape produces a short honest file rather than empty scaffolding.

**Consequences:**
- The dashboard cannot drift from the cards for longer than one regeneration.
- Every card-changing workflow ends with a regeneration step; forgetting it is visible in review because the PR template asks.
- Hand-tuning the table layout means editing the generator prompt, which is the point: layout decisions become versioned decisions.

---

## ADR-013: Published example cards are anonymized composites, not real scored companies

**Status:** Accepted

**Context:** A public template needs example cards. Hollow fictional examples with placeholder citations demonstrate the schema but not the method, and they signal nothing about whether the methodology survives contact with reality. Real cards with real names would demonstrate the method fully, but publishing a scored assessment of a named startup is a public investment opinion, with reputational consequences for both the company and the author.

**Decision:** The shipped company cards are anonymized composites (`card_type: anonymized_composite`): each is built from real diligence on several real companies with identifying details altered and blended so the profile maps back to no single company. Domain-level claims carry real, checkable citations; company-specific claims cite a disclosed `withheld` source. Every composite opens with a disclosure blockquote. Trial and paper cards are the opposite case: trials and papers are public objects and carry no company rating, so those cards use real registry IDs and real citations (see ADR-014).

**Consequences:**
- The examples demonstrate research depth (real epidemiology, real regulatory pathways, real funder landscape) without rating any named company.
- No reader can mistake a composite for a real company, because the card says so before its first claim.
- Composite cards cannot be fully re-verified by a reader, which is the honest cost of anonymization; the disclosure states which claims are checkable and which are withheld.
- Template adopters delete the composites and build real cards; the composites exist to show what a finished card looks like at full rigor.

---

## ADR-014: Trial and paper cards use real registry identifiers

**Status:** Accepted

**Context:** The secondary landscape track (clinical trials, research papers) could have followed the same anonymization as company cards. But an NCT number and a PMID are public records about public objects, a trial card carries no company score, and a fabricated registry ID is exactly the kind of plausible-looking fake that erodes trust in everything else the repository claims.

**Decision:** Trial cards use real NCT IDs verified against ClinicalTrials.gov; paper cards use real PMIDs and DOIs verified against PubMed. Facts on these cards are fully citable and are checked against the registries at write time. The schema's quality rule "no fabricated NCT IDs or PMIDs" applies with no example-card exemption.

**Consequences:**
- Every secondary-track card is independently verifiable by any reader in under a minute.
- Secondary cards demonstrate the citation discipline the methodology claims, on real evidence.
- Writing one costs a registry lookup, which is the intended price of admission.

---

## ADR-015: Themes are a tag set, not a partition

**Status:** Accepted

**Context:** Real companies straddle thesis themes: a diagnostics platform with a supply-chain product, a genomics company whose data asset feeds drug discovery. Forcing a single primary theme makes sweep coverage look cleaner but hides exactly the cross-theme companies that tend to be the most interesting, and it forces arbitrary calls that the next analyst re-litigates.

**Decision:** The `themes` front-matter field is a list. A card carries every theme whose definition it substantively matches, with the reasoning visible in the body. Theme-level views (INDEX sections, memos) list a multi-theme card under each of its themes. When a theme assignment is genuinely contested, the call and its reasoning go in an ADR rather than in a reverted edit war.

**Consequences:**
- Theme counts across the index sum to more than the card count; the snapshot table counts cards, not tags.
- Discovery sweeps per theme re-surface known cross-theme cards, which acts as a cheap consistency check.
- Ambiguous assignments have a documented home (this log), so category drift is visible over time.
