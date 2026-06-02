---
slug: exampledx
name: "ExampleDx"
aliases: ["Example Diagnostics", "ExampleDx Health Ltd"]
hq_country: "KEN"
impact_geographies: ["KEN", "UGA", "TZA"]
disease_areas: ["tuberculosis", "respiratory_infections", "primary_care"]
ai_category: "health_data_diagnostics_genomics"
technical_archetype: "ai_native"
ai_modalities: ["computer_vision", "predictive_ml"]
primary_modality: "computer_vision"
themes: ["theme_1"]
funding_stage: "series_a"
last_round_date: "2025-09-15"
last_round_amount_usd: 12000000
total_raised_usd: 16500000
notable_investors: ["example_health_ventures", "example_global_fund"]
proprietary_data_asset: "Multi-site dataset of chest X-rays from Kenyan and Ugandan primary-care clinics with paired sputum and molecular TB reference results"
clinical_validation_status: "rwe_published"
regulatory_status_by_market:
  KEN: "device_registration_pending"
  UGA: "not_yet_filed"
  EU: "not_yet_filed"
org_type: "for_profit_company"
revenue_signal: "government_contract"
source_of_discovery: "thesis_anchor"
discovery_date: "2026-05-22"
last_updated: "2026-05-22"
sources:
  - id: web-001
    type: web
    url: "https://example.com/exampledx/about"
    fetch_date: "2026-05-22"
  - id: web-002
    type: web
    url: "https://example.com/exampledx/series-a"
    fetch_date: "2026-05-22"
  - id: pm-001
    type: pubmed
    pmid: "00000000"
  - id: ct-001
    type: clinicaltrials_gov
    nct_id: "NCT00000000"
lmic_impact_score: 4
investability_score: 4
fit_rating: "likely_fit"
outreach_status: "none"
recent_signals:
  - "2025-09: named_co_investor_round [web-002]"
  - "2025-11: top_journal_publication [pm-001]"
---

> Fictional illustration. All companies, people, and data here are invented; sources are placeholders. Replace with your own.

## What they do

ExampleDx builds an AI chest-X-ray reader that flags presumptive tuberculosis at the point of care, targeting primary-care clinics where no radiologist is on site [web-001]. A frontline health worker captures an X-ray on a portable detector, and the software returns an abnormality score within seconds to triage who needs a confirmatory molecular test [web-001]. The company is AI-native: the computer-vision model and the labeled clinical dataset behind it are the product, not an add-on to an existing service [web-001].

## Where the impact lands

Documented deployment sites are in Kenya (a county primary-care network in the western region) and Uganda (a Ministry of Health screening pilot in the eastern region), with a planned third site in Tanzania under a regional TB program [web-001][web-002]. The served population is adults presenting to primary care with respiratory symptoms in settings where radiologist coverage is sparse and same-day molecular testing is rationed [web-001]. Sentences like "reaching patients across Africa" are not used here; the claim is limited to the three named programs above.

## Key people

- Jane Okafor, Founder and CEO. Prior clinical-informatics work at a Nairobi teaching hospital and a postdoc in medical imaging [web-001]. Person card: `landscape/people/EXAMPLE-jane-okafor.md`.
- A clinical lead with pulmonology and TB-program experience in East Africa [web-001].
- A board chair drawn from the lead Series A investor [web-002].

Founder and clinical-lead detail beyond the above is `[uncertain]` pending direct confirmation.

## Funding history

| Date | Round | Amount (USD) | Lead investor |
|------|-------|--------------|---------------|
| 2023-06 | Seed | 4,500,000 | Example Health Ventures [web-002] |
| 2025-09 | Series A | 12,000,000 | Example Global Fund [web-002] |

Total disclosed raised: USD 16.5M [web-002].

## AI approach

Primary modality is computer vision: a convolutional model that outputs a per-image TB-abnormality probability, with a downstream predictive-ML layer that combines the image score with structured symptom data for triage [web-001]. Training data is the proprietary multi-site chest-X-ray corpus with paired sputum and molecular reference labels [web-001]. Reported validation is real-world evidence from the Kenyan and Ugandan sites, summarized in a 2025 publication [pm-001]. Model architecture detail beyond "convolutional" is `[uncertain]`. The `ai_native` archetype is assigned because the labeled dataset and the model are the core moat rather than a feature layered on a legacy workflow.

## Recent traction

- A 2025 real-world-evidence publication reporting sensitivity and specificity against molecular reference across the two active sites [pm-001].
- A prospective validation study registered as `NCT00000000`, recruiting in Kenya [ct-001].
- A USD 12M Series A in September 2025 led by a named global health fund [web-002].
- Device registration in progress with the Kenyan regulator [web-001]. "Growing fast" claims without numbers are excluded.

## Proprietary data or distribution asset

The defensible asset is the labeled chest-X-ray corpus tied to molecular TB reference results from LMIC primary-care sites, which is expensive to assemble and compounds with each deployment [web-001]. Distribution runs through public-sector TB programs, which creates switching cost once the tool is embedded in a national screening pathway [web-002]. The moat is rated moderate-to-strong: the data is genuinely scarce, though dependence on a small number of public programs is a concentration risk noted below.

## LMIC impact reasoning

Scored 4 on LMIC impact. The product targets a high-burden LMIC disease (TB), validation data comes from LMIC patient populations rather than being borrowed from high-income settings [pm-001], and there are active public-sector deployments in two LMIC countries [web-001]. It falls short of a 5 because deployment is still pilot-scale across three programs rather than a national rollout, and population-level outcome data (not just diagnostic accuracy) is not yet published. See `docs/scoring_rubric.md` for level definitions.

## Open questions and risks

- Revenue concentration: near-term revenue depends on a small number of public-sector contracts; loss of one program would be material [web-002].
- Regulatory timing: Kenyan device registration is pending and Ugandan filing has not started; approval slippage delays scaling [web-001].
- Reimbursement and procurement cycles: public TB-program budgets are donor-influenced and slow.
- Outcome evidence gap: published data is diagnostic accuracy, not downstream treatment or mortality outcomes [pm-001].
- Founder concentration: leadership depth below the CEO and clinical lead is `[uncertain]`.

## Recent signals

- 2025-09: named_co_investor_round (Series A led by a named global health fund) [web-002]
- 2025-11: top_journal_publication (real-world-evidence diagnostic-accuracy study) [pm-001]

## Fit assessment

Fits the thesis directly as a Theme 1 anchor: AI-native diagnostics for a high-burden disease in LMIC primary care, with LMIC-sourced validation data and a real proprietary dataset. The 4/4 scoring and `likely_fit` rating put it in the priority cohort. A warm introduction through the lead Series A investor is the preferred first contact; cold outreach to the CEO is the fallback. This paragraph illustrates how a fictional card argues fit; replace with your own reasoning.

## Outreach notes

High-level only. Real outreach content, prospect names, and meeting notes live in the CRM (Attio), not in this card. As of the discovery date, outreach status is `none` and no contact has been logged.
