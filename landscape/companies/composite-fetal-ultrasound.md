---
slug: composite-fetal-ultrasound
name: "Composite: AI obstetric ultrasound"
card_type: anonymized_composite
aliases: []
hq_country: "MAR"
impact_geographies: ["MAR", "SEN", "CIV"]
disease_areas: ["maternal_care", "neonatal_care", "primary_care"]
ai_category: "health_data_diagnostics_genomics"
technical_archetype: "ai_native"
ai_modalities: ["computer_vision"]
primary_modality: "computer_vision"
themes: ["theme_1"]
funding_stage: "series_a"
last_round_date: "2025-02-10"
last_round_amount_usd: 8500000
total_raised_usd: 13200000
notable_investors: ["example_health_vc", "example_africa_vc"]
proprietary_data_asset: "Labeled blind-sweep ultrasound clips from low-resource antenatal sites with paired reference gestational-age and presentation labels"
clinical_validation_status: "rwe_published"
regulatory_status_by_market:
  MAR: "device_registration_pending"
  EU: "ce_marked"
  USA: "not_yet_filed"
org_type: "for_profit_company"
revenue_signal: "mixed"
source_of_discovery: "thesis_anchor"
discovery_date: "2026-07-16"
last_updated: "2026-07-16"
sources:
  - id: web-001
    type: web
    url: "https://www.who.int/news/item/07-11-2016-new-guidelines-on-antenatal-care-for-a-positive-pregnancy-experience"
    fetch_date: "2026-07-16"
  - id: pm-001
    type: pubmed
    pmid: "39088200"
  - id: web-002
    type: web
    url: "https://evidence.nejm.org/doi/full/10.1056/EVIDoa2100058"
    fetch_date: "2026-07-16"
  - id: co
    type: withheld
    note: "Company-specific claims are grounded in real diligence but their sources would identify a real company, so they are withheld by design."
lmic_impact_score: 4
investability_score: 3
fit_rating: "adjacent"
outreach_status: "none"
recent_signals:
  - "2025-02: named_co_investor_round [co]"
  - "2024-09: top_journal_publication (accuracy study, blind-sweep dating) [co]"
---

> Anonymized composite. This profile is built from real diligence on several real companies, with identifying details altered and blended so it maps to no single company. Domain-level claims (disease burden, regulatory pathways, published evidence, the funder landscape) carry real, checkable citations. Company-specific claims cite `[co]`, a deliberately withheld source, because a real citation would identify a real company. No real company is scored or rated anywhere in this repository.

## What they do

The company turns a low-cost portable probe plus AI into an obstetric-ultrasound tool that a midwife or community health worker with no sonography training can use to estimate gestational age and detect fetal malpresentation from a set of "blind sweeps" rather than a skilled targeted scan [co]. The clinical premise is well established: a prospective study across sites in Zambia and the United States showed that novice users with a low-cost AI-enabled device estimated gestational age between 14 and 27 weeks as accurately as credentialed sonographers on high-end machines [web-002], and a later integrated AI tool reported comparable accuracy for dating and malpresentation from blind sweeps [pm-001]. The product is AI-native: the model that reads untrained sweeps is the whole point.

## Where the impact lands

WHO has recommended one ultrasound scan before 24 weeks of pregnancy since 2016, for gestational-age estimation, anomaly detection, and multiple-pregnancy detection, but in much of the target geography the scan does not happen because there is no one trained to perform it [web-001]. Documented deployment for this company is in Morocco (private and semi-public antenatal clinics), Senegal (a maternal-health NGO network), and Cote d'Ivoire (a pilot in public primary care) [co]. The served population is pregnant women attending antenatal care where ultrasound access is otherwise absent.

## Key people

By role, not name. The founder has a biomedical-engineering background and prior work on point-of-care imaging [co]. A clinical co-founder is an obstetrician with francophone West Africa experience [co]. A machine-learning lead came from an academic ultrasound-AI group [co]. Commercial depth is `[uncertain]`.

## Funding history

| Date | Round | Amount (USD) | Lead |
|------|-------|--------------|------|
| 2022-11 | Seed | 4,700,000 | Health-specialist VC [co] |
| 2025-02 | Series A | 8,500,000 | Africa-focused VC [co] |

Total disclosed all-in capital is USD 13.2M [co].

## AI approach

Computer vision on ultrasound video: a model trained on labeled blind-sweep clips with reference gestational-age and presentation labels, designed so acquisition quality does not depend on operator skill [co]. The published evidence base for this approach is real and specific, including the equivalence-to-expert dating result in a low-resource cohort [web-002][pm-001]. Architecture detail beyond "video-based deep model" is `[uncertain]`. The `ai_native` archetype holds because the sweep-reading model is the product.

## Recent traction

- An accuracy study of the dating model in a low-resource antenatal population [co], consistent with the published blind-sweep literature [web-002][pm-001].
- CE marking obtained; home-market device registration in progress [co].
- Deployments across three countries at pilot-to-program scale [co].

## Proprietary data or distribution asset

The asset is the labeled blind-sweep corpus from low-resource sites, which is scarce because most ultrasound data comes from skilled operators in high-income settings [co]. The distribution question is unresolved, which is the crux of the investability score: the clinical value is proven, the willingness and mechanism to pay for it at scale in the target markets is not [co].

## LMIC impact reasoning

Scored 4. The tool addresses a WHO-recommended antenatal intervention that is largely undelivered in the target geography for want of skilled operators, the validation population is LMIC, and there are active multi-country deployments [web-001][web-002]. It is not a 5 because outcome data (reduced adverse pregnancy outcomes, not just dating accuracy) is not yet published and scale is pilot-to-program.

## Open questions and risks

- Monetization is the binding question: no clear reimbursement or public-procurement path in the target markets, so revenue is a mix of grants, NGO contracts, and device sales without a proven recurring model [co].
- Single-region concentration in the strongest deployment market [co].
- Outcome-evidence gap beyond gestational-age accuracy [pm-001].
- Hardware dependency: the model rides on a probe supply chain the company may not control [co].

## Recent signals

- 2025-02: named_co_investor_round (Series A led by an Africa-focused VC) [co]
- 2024-09: top_journal_publication (blind-sweep dating accuracy study) [co]

## Fit assessment

Meets the mission gate clearly on a proven, WHO-recommended intervention, but the investability gate is borderline on an unresolved monetization path, which is why it scores 4/3 and rates `adjacent` rather than `likely_fit`. Worth tracking through the next round for evidence of a repeatable payer or procurement model; a first conversation to understand the commercial plan is warranted before deeper diligence.

## Outreach notes

High-level only. Outreach status is `none`.
