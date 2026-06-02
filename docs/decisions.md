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
