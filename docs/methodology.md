# Methodology

This document defines what the workbench includes, what is excluded, how relevance and investability are scored, and what biases are known and accepted. It is the credibility artifact for external readers and the operating manual for internal use.

The canonical source of truth for the investment thesis and discovery framing is your thesis (`docs/thesis.example.md`). Replace the example thesis with your own.

This methodology operationalizes that thesis. Where conflicts arise, the thesis takes precedence; flag the conflict in `docs/decisions.md`.

## Scope

The workbench is focused on companies, trials, and research projects building or deploying artificial intelligence for global health outcomes in low- and middle-income countries (LMICs).

### What counts as "AI for health"

A product, project, or trial is in scope if **artificial intelligence is a meaningful value driver** of the offering. The taxonomy distinguishes three categories (see `taxonomy/ai_categories.yaml`):

- **Drug Discovery and Development AI** (selective conviction): AI applied to therapeutics, vaccines, and trial design
- **Health Data, Diagnostics, and Genomics** (core conviction): clinical decision support, point-of-care diagnostics, genomic platforms, population health surveillance
- **Manufacturing and Supply Chain AI** (core conviction): biomanufacturing yield, cold chain, demand forecasting, regulatory workflows

Within these categories, three technical archetypes:

- **AI foundational platforms** (out of scope as opportunity cards): model labs, sovereign compute, infrastructure
- **AI-native complete products** (in scope): built around AI from day one; AI is the core moat
- **AI-enabled businesses** (in scope): traditional global health businesses with AI applied to a core workflow

### What counts as "LMIC impact"

A company drives LMIC impact if it has **evidence or stated commitment to operations, deployments, partnerships, or trials that benefit LMIC patients, providers, or health systems**. Headquartered geography is metadata; what matters is where the impact lands.

Evidence types accepted:
- Documented pilots, deployments, or sales in LMIC countries
- Regulatory filings or device registrations in LMIC jurisdictions
- Clinical trials with LMIC sites
- Partnerships with LMIC governments or multilaterals
- Published outcome studies with LMIC patient populations
- Public commitment to LMIC commercial work in stated company strategy

Pre-revenue biotech and early-stage companies with credible LMIC orientation qualify. Revenue is not required.

## The two gates

A company gets a full opportunity card if it meets these two criteria:

1. **Mission alignment**: AI is a meaningful product driver AND the company is positioned to drive LMIC global health impact (per the scope definitions above)
2. **Investability potential**: a real company exists, with identifiable founders, and some asset or trajectory (proprietary data, distribution, IP, named partnerships, regulatory progress, founder credentials, OR similar)

That is all. Revenue, named foundation inclusion, WHO PQ are not gating.

## Positive signals (raise confidence, do not gate)

These signals, drawn from the positive-signals list, raise scoring confidence and inform `fit_rating`. Their presence elevates a card; their absence does not exclude.

- AI-native product with clinical validation underway or completed in an LMIC population
- Proprietary clinical, genomic, or operational dataset from LMIC sources
- Partnership with a pharma, biotech, or large foundation for LMIC commercial work
- WHO prequalification in progress, or NMRA approval in a priority market
- Inclusion in CEPI, Gavi, GFF, Gates Foundation, Wellcome, Novo Nordisk, EVAH, or Anthropic Frontier Catalyst initiatives
- AI workflow integrated into a regulated GMP or GLP environment
- Series A or later with named institutional investors, or a notable seed with a clear path to A
- Recurring revenue from enterprise, pharma research, or government contracts
- Founders or scientific leadership with prior LMIC product experience
- Anchor customer in an LMIC public health system or regional pharma manufacturer

## Exclusions

These categories are deliberately out of scope (the exclusions list):

- **Pre-product, pre-data hype** with no proprietary asset
- **HIC-only deployment plans** with no LMIC translation roadmap
- **Pure clinical operations software** for US or EU providers
- **Consumer wellness apps** without a clinical endpoint
- **Foundation-model labs** without an applied product
- **API-wrapper "AI"** with no defensible data layer
- **Single-modality direct-to-consumer telehealth** without a B2B or population health angle
- **Surveillance and social control** AI regardless of stated health justification
- **Military and defense** applications
- **Companies with no plausible path** to local regulatory clearance in target markets

Borderline cases are documented in `docs/decisions.md`.

## Geographic prioritization

Priority markets in rough order of activity:

- **Sub-Saharan Africa**: Nigeria, Kenya, Ghana, Rwanda, South Africa, Ethiopia, Senegal, Uganda, Tanzania
- **North Africa and MENA**: Egypt, Morocco, Saudi Arabia, UAE (commercial bases serving LMICs)
- **South Asia**: India, Bangladesh, Pakistan
- **Southeast Asia**: Indonesia, Vietnam, Philippines
- **Latin America**: Brazil, Mexico, Colombia, Peru
- **Cross-border**: HQ in the US, UK, EU, or Singapore with primary commercial activity in LMICs

Cards record both HQ and primary commercial markets.

## Themes

Seven prioritized example themes from the thesis (`docs/themes_overview.md` and `taxonomy/themes.yaml`):

- **Lean-in** (core): Theme 1 AI diagnostics in LMIC primary care, Theme 2 African genomic infrastructure, Theme 3 manufacturing intelligence and cloud-lab
- **Selective**: Theme 4 LLM care delivery, Theme 5 AI clinical trials
- **Monitor**: Theme 6 surveillance and vector control, Theme 7 health financing

## Scoring

See `docs/scoring_rubric.md` for the 1-5 LMIC impact and investability rubrics with worked examples.

Both scores plus `fit_rating` (`likely_fit` / `adjacent` / `monitor_only` / `out_of_scope`) are required on every active card.

**Sparse evidence does not auto-lower the score.** A pre-revenue biotech with credible scientific founders and named clinical advisors can score 4 on investability if the evidence supports that level. The rubric requires evidence cited in the card; it does not require a long card.

## The discovery-to-action workflow

Documented in `docs/workflow.md`. Five steps: Discovery, Triage, Enrichment, Vetting, Action. The operating principle is **bias toward false positives at Discovery** (the discovery principle). Filter at Triage using the two gates, and at Vetting using the scoring rubric.

## Source biases (acknowledged)

- **Private-market database bias toward VC-backed companies**: bootstrapped, founder-funded, or grant-funded companies may be underrepresented in a private-market data provider (reference: PitchBook; swap for Crunchbase, Dealroom, or manual entry)
- **English-language source bias**: PubMed, news search, and private-market databases all skew toward English-language coverage
- **ClinicalTrials.gov registration bias**: dominated by US- and EU-sponsored trials; LMIC-sponsored or unregistered work is underrepresented
- **Foundation grant database bias**: some funders publish grant data more openly than others, so coverage is uneven across funders
- **Recency bias**: a recent fundraise can over-weight relevance; companies that have gone quiet may be undervalued
- **Survivorship bias**: failed companies are systematically harder to find than survivors, which skews the visible landscape toward winners
- **Accelerator-directory bias**: accelerator rosters skew toward USA and HIC companies even when those companies target LMICs. Cross-reference each accelerator candidate against the LMIC gate before promoting. A HIC-headquartered accelerator graduate that fails the LMIC gate but has a plausible LMIC-pivot hypothesis is tracked at `monitor_only` until LMIC commitment is verified.

## Entity resolution

The same company may appear under multiple names. Resolution discipline:

1. Use the private-market data provider's canonical name as the primary identifier when available
2. Keep all aliases in the card front-matter `aliases` field
3. Weekly review scans for near-duplicate slugs and merges
4. Merging retains all source IDs from both originals

## Citation discipline

Every factual claim in an opportunity card must be traceable to a source. Citation IDs in the body link to entries in front-matter `sources`:

- PubMed PMID
- ClinicalTrials.gov NCT ID
- Web URL with fetch date
- Private-market data provider record ID (private reference; underlying data not committed)
- CRM note ID (private reference)

Claims without citations are flagged for removal or follow-up during weekly review.

## Public vs private boundary

- `private/` is gitignored. Raw private-market data provider pulls, CRM exports, discovery inboxes, unredacted memos live there
- Filename pattern `*-private.md` is also gitignored
- Card front-matter may reference private-market data provider record IDs as opaque identifiers; underlying data lives only in `private/` or in the source platform
- Outreach content lives in the CRM; only aggregate, redacted counts go in `outreach/log.md`
- Before any public push, review `git log` and `git diff` against the exclusion patterns

## CRM interoperability

The workbench cards are the source of truth for shareable analytical content. A CRM (reference: Attio; swap for Airtable, Notion, HubSpot) is the system of record for relationships, outreach, and meeting notes. The two are kept in sync via:

- `prompts/export_to_attio.md`: pushes card front-matter into CRM company and person records
- `prompts/sync_from_attio.md`: pulls CRM updates (notes, meetings, status changes) back into card "Outreach notes" sections

Append-only discipline on both directions: never overwrite an existing CRM note; never delete prior card outreach history.

## Updates and review cadence

- **Weekly**: scan new cards for duplicates, scoring drift, citation gaps; run signal-trigger scan per `taxonomy/signal_triggers.yaml`
- **Monthly**: refresh open cards with `last_updated` older than 60 days; promote or remove watchlist entries
- **Quarterly**: review the full landscape for theme balance, scope creep, taxonomy drift; refresh `taxonomy/capital_partners.yaml` if major new programs announced
- **Annually**: refresh `taxonomy/lmic.yaml` against the latest World Bank classification
