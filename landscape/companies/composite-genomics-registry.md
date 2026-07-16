---
slug: composite-genomics-registry
name: "Composite: African population-genomics platform"
card_type: anonymized_composite
aliases: []
hq_country: "NGA"
impact_geographies: ["NGA", "KEN", "GHA"]
disease_areas: ["genomics", "non_communicable_disease", "infectious_disease"]
ai_category: "health_data_diagnostics_genomics"
technical_archetype: "ai_enabled"
ai_modalities: ["predictive_ml"]
primary_modality: "predictive_ml"
themes: ["theme_2"]
funding_stage: "series_a"
last_round_date: "2024-10-01"
last_round_amount_usd: 15000000
total_raised_usd: 24000000
notable_investors: ["example_global_vc", "example_health_vc"]
proprietary_data_asset: "Consented multi-country African genomic and phenotypic dataset with linked clinical records"
clinical_validation_status: "not_applicable"
regulatory_status_by_market:
  NGA: "not_applicable"
  KEN: "not_applicable"
org_type: "for_profit_company"
revenue_signal: "pharma_research"
source_of_discovery: "thesis_anchor"
discovery_date: "2026-07-16"
last_updated: "2026-07-16"
sources:
  - id: pm-001
    type: pubmed
    pmid: "31051100"
  - id: web-001
    type: web
    url: "https://www.cell.com/cell/fulltext/S0092-8674(19)30451-9"
    fetch_date: "2026-07-16"
  - id: co
    type: withheld
    note: "Company-specific claims are grounded in real diligence but their sources would identify a real company, so they are withheld by design."
lmic_impact_score: 3
investability_score: 3
fit_rating: "adjacent"
outreach_status: "none"
recent_signals:
  - "2024-10: named_co_investor_round [co]"
  - "2025-05: pharma_collaboration (research partnership for an African variant atlas) [co]"
---

> Anonymized composite. This profile is built from real diligence on several real companies, with identifying details altered and blended so it maps to no single company. Domain-level claims (disease burden, regulatory pathways, published evidence, the funder landscape) carry real, checkable citations. Company-specific claims cite `[co]`, a deliberately withheld source, because a real citation would identify a real company. No real company is scored or rated anywhere in this repository.

## What they do

The company assembles a consented African genomic and phenotypic dataset with linked clinical records and sells research access and analysis to pharmaceutical and academic partners, positioning AI-driven variant interpretation on top of the data as the value layer [co]. The thesis rests on a documented gap: a widely cited 2019 commentary showed that the large majority of participants in genome-wide association studies were of European ancestry, which limits the transferability of genetic risk prediction to African and other underrepresented populations [pm-001][web-001]. A dataset that closes part of that gap has genuine scientific and commercial pull.

## Where the impact lands

The near-term "impact" is scientific-infrastructure rather than direct patient care: cohorts recruited in Nigeria, Kenya, and Ghana feed a variant atlas whose downstream uses are drug-target work and, eventually, locally calibrated risk models [co]. This is why the impact score is a 3 rather than a 4: the pathway to patient outcomes is real but indirect, and the immediate customers are pharma research teams, not LMIC health systems [co].

## Key people

By role. The founder is a genomicist with a diaspora-return profile and prior work on African cohort studies [co]. A commercial lead handles pharma business development [co]. A bioinformatics lead runs the interpretation pipeline [co]. Governance and consent oversight is described as a formal ethics board, membership `[uncertain]`.

## Funding history

| Date | Round | Amount (USD) | Lead |
|------|-------|--------------|------|
| 2022-06 | Seed | 6,000,000 | Deep-tech VC [co] |
| 2024-10 | Series A | 15,000,000 | Generalist growth VC [co] |

Total disclosed all-in capital is USD 24M, inclusive of a named research grant [co].

## AI approach

The AI is `ai_enabled` rather than `ai_native`: predictive-ML variant interpretation and quality-control models sit on top of the data asset, but the durable value is the consented, well-phenotyped dataset itself, not a proprietary model [co]. The scientific rationale for African-specific reference data is the transferability problem documented in the literature [pm-001]. Model specifics are `[uncertain]`.

## Recent traction

- A research partnership with a pharmaceutical company for an African variant atlas [co].
- Multi-country recruitment reaching a cohort scale meaningful for GWAS work [co].
- Early research-access revenue, though recurring-revenue durability is unproven [co].

## Proprietary data or distribution asset

The consented multi-country dataset with linked phenotypes is the asset, and it is genuinely scarce [pm-001]. The open question is commercial conversion. Population-genomics platforms in this space have a track record of slow monetization and at least one prominent wind-down where a well-funded African genomics company failed to convert its data asset into durable revenue; that precedent is the reason this card demands revenue evidence before a follow-on [co]. The precedent is referenced as a pattern, not a named company.

## LMIC impact reasoning

Scored 3. The data asset is real and addresses a documented equity gap in genomics [pm-001][web-001], but the impact on LMIC patients is indirect and depends on downstream products that do not yet exist. Documented pilots and partnerships exist; deployment-to-outcome evidence does not. That is the definition of a 3 in `docs/scoring_rubric.md`.

## Open questions and risks

- Commercial-conversion risk: the central question, given the sector's wind-down precedents [co].
- Consent and data-sovereignty exposure: African genomic data governance is politically and ethically charged; a misstep is existential [co].
- Dependence on a small number of pharma research contracts for near-term revenue [co].
- Indirect impact pathway means the LMIC-outcome story is a hypothesis, not evidence.

## Recent signals

- 2024-10: named_co_investor_round (Series A led by a generalist growth VC) [co]
- 2025-05: pharma_collaboration (research partnership for an African variant atlas) [co]

## Fit assessment

Meets the mission gate on the data-equity thesis and has a real asset, but middling scoring on an unproven commercial model puts it at 3/3 and `adjacent`. The right posture is to track for recurring-revenue evidence and consent-governance maturity before engaging on a round.

## Outreach notes

High-level only. Outreach status is `none`.
