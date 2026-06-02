# Opportunity Card Schema (v2)

This document defines the structure every card must follow. Cards are markdown files with YAML front-matter. The v2 schema incorporates CRM-compatible fields so cards can export to a CRM (reference: Attio; swap for Airtable, Notion, HubSpot).

## File locations and slug conventions

- Company cards: `landscape/companies/{slug}.md`
- People cards: `landscape/people/{slug}.md`
- Trial cards: `landscape/trials/{nct-id}.md`
- Paper cards: `landscape/papers/{slug}.md`
- Watchlist: `landscape/companies/_watchlist.md` (single file, one-line entries)

Slugs are lowercase, hyphenated, no special characters. Use the canonical short name (e.g., `exampledx`, `genomeafrica`). For name conflicts, append a country code (`exampledx-rw`).

## Company card structure

### Required front-matter (v2)

```yaml
---
slug: example-co
name: "Example Co"
aliases: ["Example Health", "ExampleCo Inc"]
hq_country: "USA"
impact_geographies: ["KEN", "UGA", "TZA"]
disease_areas: ["maternal_care", "neonatal_care"]
ai_category: "health_data_diagnostics_genomics"   # from taxonomy/ai_categories.yaml
technical_archetype: "ai_native"                   # from taxonomy/ai_categories.yaml
ai_modalities: ["computer_vision", "predictive_ml"]
primary_modality: "computer_vision"
themes: ["theme_1"]                                # from taxonomy/themes.yaml (one or more)
funding_stage: "series_a"                          # from taxonomy/funding_stages.yaml
last_round_date: "2025-09-15"
last_round_amount_usd: 15000000
total_raised_usd: 22000000
notable_investors: ["gates", "example_vc"]         # from taxonomy/capital_partners.yaml IDs
proprietary_data_asset: "Multi-country dataset of fetal ultrasound clips with paired gold-standard gestational age estimates"
clinical_validation_status: "rwe_published"        # see field definitions below
regulatory_status_by_market:
  KEN: "device_registration_pending"
  UGA: "device_registration_pending"
  EU: "ce_marked"
  USA: "not_yet_filed"
org_type: "for_profit_company"
revenue_signal: "government_contract_plus_grants"  # see field definitions below
source_of_discovery: "thesis_anchor"               # see field definitions below
discovery_date: "2026-05-22"
last_updated: "2026-05-22"
sources:
  - id: web-001
    type: web
    url: "https://example.com/about"
    fetch_date: "2026-05-22"
  - id: pm-001
    type: pubmed
    pmid: "12345678"
  - id: ct-001
    type: clinicaltrials_gov
    nct_id: "NCT01234567"
  - id: pb-001
    type: pitchbook
    ref: "PRIVATE_REF_ONLY"
lmic_impact_score: 4
investability_score: 4
fit_rating: "likely_fit"                           # likely_fit / adjacent / monitor_only / out_of_scope
outreach_status: "none"
pitchbook_id: "PRIVATE_REF_ONLY"
attio_record_id: "PRIVATE_REF_ONLY"
recent_signals: []                                 # list of signal trigger events
---
```

### Required body sections (in order)

```markdown
## What they do

One paragraph anchored to a citation. What problem, what product, what AI approach.

## Where the impact lands

Specific countries, partners, patient populations served. Citations required.
"Reaches patients across Africa" is a marketing claim, not a body section.
Replace with: "Active deployments in Kenya (Kisumu County primary care network),
Uganda (Ministry of Health pilot, Eastern Region), and Tanzania (Aga Khan Health
Services antenatal program)."

## Key people

Founders, CEO, clinical lead, board chair. Note prior LMIC experience and
clinical credentials. Source from private-market data provider team data
(private references) and public bios.

## Funding history

Brief table or list of priced rounds with date, amount, lead investor.

## AI approach

Modality, model architecture (if known), training data, validation status. Mark
`[uncertain]` where data is unavailable. Note `technical_archetype` reasoning.

## Recent traction

Citations required. Pilot deployments, regulatory approvals, customer contracts,
publication of outcome data, partnerships. "Growing fast" without numbers is
not traction.

## Proprietary data or distribution asset

What is the durable moat? Proprietary data (clinical, genomic, operational),
distribution channel, regulatory position, integrated workflow. One paragraph
defending the asset claim. If thin, mark `[uncertain]` and lower investability
score.

## LMIC impact reasoning

Paragraph defending the `lmic_impact_score`. Cite specific evidence. Reference
rubric levels in `docs/scoring_rubric.md`.

## Open questions and risks

What you don't know and what would shift your view. Regulatory risk, unit
economics, dependency on a single donor, founder concentration, technical
maturity, defensibility.

## Recent signals

Any `signal_triggers.yaml` events with dates and source IDs.
Example:
- 2025-09: pharma_collaboration (partnership with a major pharma partner for a regional cancer-genomics atlas) [web-001]
- 2025-12: named_co_investor_round (Series A led by a global health foundation) [pb-001]

## Fit assessment

One paragraph. Why this fits or doesn't fit the fund's mandate. What stage of
relationship makes sense (cold outreach, warm intro, watch).

## Outreach notes

High-level only. Real outreach content, prospect names, and meeting notes live
in the CRM.
```

## Field definitions (CRM-compatible fields)

- **`ai_category`**: required. From `taxonomy/ai_categories.yaml`. One of `drug_discovery_and_development`, `health_data_diagnostics_genomics`, `manufacturing_and_supply_chain`.
- **`technical_archetype`**: required. From `taxonomy/ai_categories.yaml`. One of `ai_native`, `ai_enabled`. (`foundational_platform` is excluded from active opportunity cards but valid for relations or watchlist context.)
- **`themes`**: required, list. From `taxonomy/themes.yaml`. One or more theme IDs (theme_1 through theme_7).
- **`proprietary_data_asset`**: required as a body section; also stored as a one-sentence summary in front-matter for filtering.
- **`clinical_validation_status`**: required. One of `none`, `preclinical`, `phase_1`, `phase_2`, `phase_3`, `approved_for_use`, `rwe_published`, `not_applicable` (for non-clinical companies).
- **`regulatory_status_by_market`**: optional, dictionary. Keys are ISO-3 country codes (or `EU`, `USA`). Values: `ce_marked`, `device_registration_pending`, `nmra_approved`, `not_yet_filed`, `not_applicable`, etc.
- **`source_of_discovery`**: required. One of `pitchbook`, `pubmed`, `clinicaltrials`, `news`, `referral`, `thesis_anchor`, `thesis_watchlist`, `attio`, `cross_reference`, `other`.
- **`fit_rating`**: required. One of `likely_fit`, `adjacent`, `monitor_only`, `out_of_scope`.
- **`outreach_status`**: required. One of the 10 pipeline values aligned with the CRM: `none`, `queued`, `drafted`, `sent`, `contacted` (legacy synonym for `sent`), `in_dialog`, `meeting_held`, `diligence`, `term_sheet`, `invested`, `passed`. Pipeline order is preserved during sync per the crosswalk in `docs/attio_mapping.md`; `prompts/sync_from_attio.md` never downgrades a more-advanced card state from a stale CRM note.
- **`discovery_date`**: required. ISO date when first identified.
- **`revenue_signal`**: optional. One of `pre_revenue`, `grant_funded`, `pharma_research`, `enterprise_saas`, `government_contract`, `mixed`, `undisclosed`. Used because real revenue figures are hard to verify; this captures the stated or likely model.
- **`recent_signals`**: list of recent signal trigger events with dates, trigger type from `taxonomy/signal_triggers.yaml`, and source IDs.

## Trial card structure (lighter)

For `landscape/trials/{nct-id}.md`. Used for the secondary landscape track.

```yaml
---
nct_id: "NCT01234567"
title: "Short title"
sponsor_orgs: ["Org A", "Org B"]
sponsor_org_slugs: ["org-a"]
principal_investigators: ["Dr. Name"]
pi_slugs: ["dr-name"]
disease_areas: ["tuberculosis"]
ai_category: "health_data_diagnostics_genomics"
ai_modalities: ["computer_vision"]
themes: ["theme_1"]
phase: "phase_2"
countries: ["KEN", "UGA"]
start_date: "2024-06-01"
status: "recruiting"
last_updated: "2026-05-22"
sources:
  - id: ct-001
    type: clinicaltrials_gov
    nct_id: "NCT01234567"
notable: true
---
```

Body: "Summary" (hypothesis, AI component, why it matters); "Watch for" (readouts or events that would change the assessment).

## Paper card structure (lighter)

For `landscape/papers/{slug}.md`. Slug format: `{first-author-lastname}-{year}-{short-topic}`.

```yaml
---
pmid: "12345678"
doi: "10.xxxx/xxxx"
title: "Paper title"
authors: ["First Last", "..."]
author_affiliations: ["Org A (KEN)", "..."]
publication_year: 2025
journal: "Journal Name"
disease_areas: ["maternal_care"]
ai_category: "health_data_diagnostics_genomics"
ai_modalities: ["computer_vision"]
themes: ["theme_1"]
study_type: "observational"
countries_of_data: ["KEN"]
last_updated: "2026-05-22"
sources:
  - id: pm-001
    type: pubmed
    pmid: "12345678"
signal_strength: "medium"
linked_companies: ["exampledx"]
---
```

Body: "Summary" (the finding); "Why it matters" (relevance); "Linked entities" (companies, people by slug).

## People card structure (lighter)

For `landscape/people/{slug}.md`.

```yaml
---
slug: jane-okafor
name: "Jane Okafor"
current_role: "Founder and CEO, ExampleDx"
current_org_slug: "exampledx"
prior_roles:
  - "Postdoc, university radiology AI lab"
  - "Clinical lead, national referral hospital"
expertise: ["tuberculosis", "computer_vision"]
themes: ["theme_1"]
notable: true
linkedin_url: "https://linkedin.com/in/janedoe"
last_updated: "2026-05-22"
sources:
  - id: web-001
    type: web
    url: "https://example.com/about"
    fetch_date: "2026-05-22"
---
```

Body: "Background"; "Why we track"; "Linked entities".

## Watchlist structure

For `landscape/companies/_watchlist.md`. Single file with one-line entries for companies that don't warrant full cards but should be tracked.

```markdown
# Watchlist

Companies tracked lightly. Refresh quarterly.

| Slug | Name | Country | AI category | Reason on watchlist | Last seen |
|------|------|---------|-------------|---------------------|-----------|
| genomeafrica | GenomeAfrica | GHA | health_data_diagnostics_genomics | Population genomics; capital-intensive lab build; tracked for commercial-conversion evidence | 2026-04 |
| exampledx | ExampleDx | KEN | health_data_diagnostics_genomics | AI chest-X-ray TB screening; primary-care deployment in progress | 2026-04 |
```

## Quality requirements (all card types)

- Every factual claim must reference a source ID listed in front-matter
- Where data is unavailable, mark `[uncertain]` rather than guessing
- No fabricated executive names, trial NCT IDs, or PubMed PMIDs
- No "industry-leading," "transformative," or other adjective-heavy language without quantitative support
- PitchBook content stays out of committed cards; private references only
