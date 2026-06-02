---
slug: genomeafrica
name: "GenomeAfrica"
aliases: ["Genome Africa", "GenomeAfrica Health"]
hq_country: "GHA"
impact_geographies: ["GHA", "NGA", "KEN"]
disease_areas: ["cancer", "health_information_systems", "primary_care"]
ai_category: "health_data_diagnostics_genomics"
technical_archetype: "ai_native"
ai_modalities: ["genomics_ml", "predictive_ml"]
primary_modality: "genomics_ml"
themes: ["theme_2"]
funding_stage: "seed"
last_round_date: "2025-03-10"
last_round_amount_usd: 6000000
total_raised_usd: 8000000
notable_investors: ["example_health_ventures"]
proprietary_data_asset: "Consented population-genomics cohort from West African participants linked to structured phenotype and electronic health records"
clinical_validation_status: "not_applicable"
regulatory_status_by_market:
  GHA: "not_applicable"
  NGA: "not_applicable"
org_type: "for_profit_company"
revenue_signal: "pharma_research"
source_of_discovery: "thesis_watchlist"
discovery_date: "2026-05-22"
last_updated: "2026-05-22"
sources:
  - id: web-001
    type: web
    url: "https://example.com/genomeafrica/about"
    fetch_date: "2026-05-22"
  - id: web-002
    type: web
    url: "https://example.com/genomeafrica/seed-round"
    fetch_date: "2026-05-22"
  - id: pm-001
    type: pubmed
    pmid: "00000000"
lmic_impact_score: 3
investability_score: 3
fit_rating: "adjacent"
outreach_status: "none"
recent_signals:
  - "2025-03: named_co_investor_round [web-002]"
---

> Fictional illustration. All companies, people, and data here are invented; sources are placeholders. Replace with your own.

## What they do

GenomeAfrica is building a population-genomics and health-data platform centered on West African participants, with the stated aim of supplying pharma and academic partners with consented, well-phenotyped genomic data that underrepresented populations currently lack [web-001]. The product is the consented cohort plus the tooling to link genomic, phenotype, and electronic-health-record data, with machine-learning layers for variant interpretation [web-001]. It is AI-native in that the data asset and the interpretation models are the core offering [web-001].

## Where the impact lands

Recruitment and biobanking run in Ghana, with stated expansion sites in Nigeria and Kenya [web-001][web-002]. The near-term beneficiaries are research and pharma partners; the longer-term clinical impact for LMIC patients (better-calibrated risk models and locally relevant variant interpretation) is a hypothesis, not yet demonstrated outcome data [web-001]. The claim here is limited to the named recruitment geographies; broader "serving the continent" language is avoided.

## Key people

- A founder and CEO with a population-genetics research background and prior work at a West African genomics institute [web-001].
- A scientific co-founder with bioinformatics and variant-interpretation expertise [web-001].

Detail beyond the above is `[uncertain]` pending direct confirmation. No person card has been created yet.

## Funding history

| Date | Round | Amount (USD) | Lead investor |
|------|-------|--------------|---------------|
| 2024-01 | Pre-seed | 2,000,000 | Undisclosed [web-002] |
| 2025-03 | Seed | 6,000,000 | Example Health Ventures [web-002] |

Total disclosed raised: USD 8.0M [web-002].

## AI approach

Primary modality is genomics machine learning: models for variant calling and interpretation tuned on the West African cohort, with a predictive-ML layer linking genotype to phenotype [web-001]. Training data is the proprietary consented cohort [web-001]. There is no clinical-device validation track because the present offering is a research-data platform rather than a regulated diagnostic, which is why `clinical_validation_status` is `not_applicable`. Model detail is `[uncertain]`. The `ai_native` archetype holds because the cohort and interpretation models are the product.

## Recent traction

- A USD 6M seed round in March 2025 with a named lead investor [web-002].
- A 2025 methods publication describing the cohort design and consent framework [pm-001].
- Stated pharma research discussions; no signed multi-year contract is confirmed, so this is logged as `[uncertain]` [web-001]. Unquantified growth claims are excluded.

## Proprietary data or distribution asset

The asset is a consented, phenotype-linked population-genomics cohort from a population underrepresented in existing genomic references, which is hard to replicate and accrues value as it grows [web-001]. The asset is real but earlier-stage than a revenue-proven platform: the path from cohort to recurring pharma revenue is the open question, and capital-intensive genomics platforms have a track record of slow commercial conversion. The moat is rated moderate, with the discount reflecting unproven monetization.

## LMIC impact reasoning

Scored 3 on LMIC impact. The work addresses a genuine LMIC-relevant gap (genomic underrepresentation of African populations) and recruits LMIC participants [web-001], which supports a mid-level score. It does not yet reach 4 because there is no demonstrated clinical or population-health outcome for LMIC patients; the benefit today accrues mainly to research and pharma partners, with patient-level impact still hypothesized [web-001]. See `docs/scoring_rubric.md`.

## Open questions and risks

- Monetization: no confirmed multi-year pharma contract; revenue model is stated, not proven [web-001].
- Commercial-conversion risk: genomics-platform peers have converted cohorts to durable revenue slowly.
- Data governance: consent, benefit-sharing, and cross-border data rules for African genomic data are evolving and carry reputational and legal risk.
- Clinical translation: the patient-impact thesis is unproven [web-001].
- Capital intensity: biobanking and sequencing burn is high relative to seed-stage runway [web-002].

## Recent signals

- 2025-03: named_co_investor_round (USD 6M seed with a named lead) [web-002]

## Fit assessment

Adjacent rather than core. GenomeAfrica sits squarely in Theme 2 (genomic and health-data infrastructure), which is a lean-in theme, but the 3/3 scoring and unproven monetization place it as `adjacent` and `thesis_watchlist`-sourced rather than priority outreach. The right posture is to monitor for a signed pharma contract or a priced Series A, either of which would justify a re-score. This is a fictional example of how an adjacent card reads; replace with your own.

## Outreach notes

High-level only. Real outreach content, prospect names, and meeting notes live in the CRM (Attio), not in this card. As of the discovery date, outreach status is `none`.
