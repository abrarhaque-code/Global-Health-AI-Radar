---
slug: composite-tb-cxr
name: "Composite: AI chest-X-ray TB triage"
card_type: anonymized_composite
aliases: []
hq_country: "KEN"
impact_geographies: ["KEN", "ZMB", "NGA"]
disease_areas: ["tuberculosis", "respiratory_infections", "primary_care"]
ai_category: "health_data_diagnostics_genomics"
technical_archetype: "ai_native"
ai_modalities: ["computer_vision", "predictive_ml"]
primary_modality: "computer_vision"
themes: ["theme_1"]
funding_stage: "series_b"
last_round_date: "2025-06-01"
last_round_amount_usd: 18000000
total_raised_usd: 31000000
notable_investors: ["example_health_ventures", "example_global_fund"]
proprietary_data_asset: "Multi-country chest-X-ray corpus paired with molecular TB reference results from primary-care and community-screening sites"
clinical_validation_status: "rwe_published"
regulatory_status_by_market:
  KEN: "nmra_approved"
  NGA: "device_registration_pending"
  EU: "ce_marked"
org_type: "for_profit_company"
revenue_signal: "government_contract"
source_of_discovery: "thesis_anchor"
discovery_date: "2026-07-16"
last_updated: "2026-07-16"
sources:
  - id: web-001
    type: web
    url: "https://www.who.int/teams/global-programme-on-tuberculosis-and-lung-health/tb-reports/global-tuberculosis-report-2024"
    fetch_date: "2026-07-16"
  - id: web-002
    type: web
    url: "https://www.who.int/publications/i/item/9789240022676"
    fetch_date: "2026-07-16"
  - id: pm-001
    type: pubmed
    pmid: "34446265"
  - id: co
    type: withheld
    note: "Company-specific claims are grounded in real diligence but their sources would identify a real company, so they are withheld by design."
lmic_impact_score: 4
investability_score: 4
fit_rating: "likely_fit"
outreach_status: "none"
recent_signals:
  - "2025-06: named_co_investor_round [co]"
  - "2024-11: regulatory_approval (national device approval in the home market) [co]"
---

> Anonymized composite. This profile is built from real diligence on several real companies, with identifying details altered and blended so it maps to no single company. Domain-level claims (disease burden, regulatory pathways, published evidence, the funder landscape) carry real, checkable citations. Company-specific claims cite `[co]`, a deliberately withheld source, because a real citation would identify a real company. No real company is scored or rated anywhere in this repository.

## What they do

The company builds an AI reader that flags presumptive pulmonary tuberculosis on a digital chest X-ray at the point of care, so a frontline health worker with no radiologist on site can decide within seconds who needs a confirmatory molecular test [co]. This is the diagnostic problem the field has the most independent evidence for: an impartial evaluation of five commercial algorithms on 23,954 chest X-rays in Bangladesh found the leading tools cleared the WHO triage target product profile and reduced the number of confirmatory Xpert tests needed by roughly half while holding sensitivity above 90% [pm-001]. The product is AI-native: the computer-vision model and the labeled clinical corpus behind it are the business, not a feature bolted onto a services company [co].

## Where the impact lands

TB is the anchor because the burden is concentrated where the diagnostic workforce is thinnest. WHO estimates 10.8 million people fell ill with TB in 2023 and 1.25 million died, the largest infectious-disease killer again that year [web-001]. Documented deployment for this company is in Kenya (a county-level primary-care network), Zambia (community active-case-finding campaigns), and Nigeria (a state TB program), with the served population being adults presenting with respiratory symptoms where same-day molecular testing is rationed [co]. The claim is limited to those three named programs; no "across Africa" language is used.

## Key people

Leadership is described by role, not name, because this is a composite. The founder-CEO comes from a clinical-informatics background in East Africa with a prior imaging-AI research post [co]. A clinical lead carries pulmonology and national-TB-program experience [co]. A commercial lead has public-health procurement experience across two of the three deployment countries [co]. Depth below this team is `[uncertain]`.

## Funding history

| Date | Round | Amount (USD) | Lead |
|------|-------|--------------|------|
| 2022-03 | Seed | 4,000,000 | Health-specialist seed investor [co] |
| 2023-08 | Series A | 9,000,000 | Global health fund [co] |
| 2025-06 | Series B | 18,000,000 | Cross-over growth investor [co] |

Total disclosed all-in capital is USD 31M, inclusive of a named screening-innovation grant broken out here rather than in the headline figure [co].

## AI approach

Primary modality is computer vision: a convolutional model returning a per-image TB-abnormality probability, with a downstream predictive-ML layer that fuses the image score with structured symptom data for triage [co]. The training corpus is the proprietary multi-country chest-X-ray set with paired molecular reference labels [co]. The `ai_native` archetype holds because that labeled dataset and the model are the moat. The independent literature is clear that performance is not uniform across vendors and degrades in older patients and people with prior TB, so any deployment claim has to be anchored to the specific population tested [pm-001].

## Recent traction

- Real-world-evidence accuracy against molecular reference published from the active sites [co].
- National medical-device approval secured in the home market, with a second-country registration in progress [co].
- WHO recommended CAD software for automated chest-X-ray reading in people aged 15 and older in 2021, which is the policy tailwind this category rides; the recommendation is conditional, so program-level validation still gates procurement [web-002].
- A Series B in 2025 led by a cross-over investor [co].

## Proprietary data or distribution asset

The durable asset is the labeled chest-X-ray corpus tied to molecular TB reference results from LMIC screening sites, which is expensive to assemble and compounds with each deployment [co]. Distribution through national TB programs creates switching cost once the tool is embedded in a screening pathway [co]. The moat is rated moderate-to-strong; the concentration risk on a few public programs is the offsetting weakness.

## LMIC impact reasoning

Scored 4. The product targets a high-burden LMIC disease, validation comes from LMIC populations rather than borrowed high-income data, and there are active public-sector deployments in three countries [web-001][co]. It falls short of 5 because deployment is program-scale rather than national, and published evidence is diagnostic accuracy, not downstream treatment or mortality outcomes. See `docs/scoring_rubric.md` for level definitions.

## Open questions and risks

- Revenue concentration on a small number of donor-influenced public contracts [co].
- Outcome-evidence gap: accuracy is published, patient outcomes are not [pm-001].
- Vendor-performance spread in the independent literature means the company's own numbers must be read against the population tested, not the marketing claim [pm-001].
- Regulatory timing in the second and third markets [co].
- Leadership depth below the founding team is `[uncertain]`.

## Recent signals

- 2025-06: named_co_investor_round (Series B led by a cross-over investor) [co]
- 2024-11: regulatory_approval (national device approval in the home market) [co]

## Fit assessment

Fits the thesis directly as a Theme 1 anchor: AI-native diagnostics for a high-burden disease in LMIC primary care, with LMIC-sourced validation and a real proprietary dataset. The 4/4 scoring and `likely_fit` rating place it in the priority cohort. A warm introduction through a co-investor is the preferred first contact.

## Outreach notes

High-level only. In a working radar, real outreach content and meeting notes live in the CRM, not the card. Outreach status here is `none`.
