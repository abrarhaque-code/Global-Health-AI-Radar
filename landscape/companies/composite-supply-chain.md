---
slug: composite-supply-chain
name: "Composite: AI pharma supply-chain integrity"
card_type: anonymized_composite
aliases: []
hq_country: "NGA"
impact_geographies: ["NGA", "GHA"]
disease_areas: ["primary_care", "infectious_disease"]
ai_category: "manufacturing_and_supply_chain"
technical_archetype: "ai_enabled"
ai_modalities: ["predictive_ml", "supply_chain_ops_ml"]
primary_modality: "supply_chain_ops_ml"
themes: ["theme_3"]
funding_stage: "seed"
last_round_date: "2024-05-01"
last_round_amount_usd: 3200000
total_raised_usd: 4600000
notable_investors: ["example_africa_vc", "example_accelerator"]
proprietary_data_asset: "Transaction and scan data from a pharmacy and distributor network used to flag diversion and falsified product"
clinical_validation_status: "not_applicable"
regulatory_status_by_market:
  NGA: "not_applicable"
org_type: "for_profit_company"
revenue_signal: "enterprise_saas"
source_of_discovery: "thesis_watchlist"
discovery_date: "2026-07-16"
last_updated: "2026-07-16"
sources:
  - id: web-001
    type: web
    url: "https://www.who.int/news-room/fact-sheets/detail/substandard-and-falsified-medical-products"
    fetch_date: "2026-07-16"
  - id: co
    type: withheld
    note: "Company-specific claims are grounded in real diligence but their sources would identify a real company, so they are withheld by design."
lmic_impact_score: 4
investability_score: 2
fit_rating: "monitor_only"
outreach_status: "none"
recent_signals:
  - "2024-05: named_co_investor_round (seed) [co]"
---

> Anonymized composite. This profile is built from real diligence on several real companies, with identifying details altered and blended so it maps to no single company. Domain-level claims (disease burden, regulatory pathways, published evidence, the funder landscape) carry real, checkable citations. Company-specific claims cite `[co]`, a deliberately withheld source, because a real citation would identify a real company. No real company is scored or rated anywhere in this repository.

## What they do

The company applies machine learning to pharmacy and distributor transaction and scan data to flag diverted and falsified medicines before they reach patients, across a West African supply network [co]. The problem is large and well quantified: WHO estimates that around 1 in 10 medical products in low- and middle-income countries is substandard or falsified, with an associated economic cost estimated at USD 30.5 billion a year [web-001]. An AI layer that catches bad product in the distribution chain has clear public-health value.

## Where the impact lands

Deployment is in Nigeria (a pharmacy and distributor network) with an early Ghana expansion [co]. The beneficiary is any patient in that chain who would otherwise receive a falsified or degraded product, concentrated in the infectious-disease and primary-care categories where falsification is common [web-001][co].

## Key people

By role. The founder has a pharmacy-supply-chain operating background [co]. A data lead built the anomaly-detection pipeline [co]. The team is small and early; depth beyond the founders is `[uncertain]`.

## Funding history

| Date | Round | Amount (USD) | Lead |
|------|-------|--------------|------|
| 2023-01 | Pre-seed | 1,400,000 | Accelerator plus angels [co] |
| 2024-05 | Seed | 3,200,000 | Africa-focused VC [co] |

Total disclosed all-in capital is USD 4.6M [co].

## AI approach

The AI is `ai_enabled`: supply-chain-operations ML and anomaly detection over transaction and scan data, valuable but not a novel model moat on its own [co]. The durable question is whether the data network is proprietary enough to defend. Modality specifics are `[uncertain]`.

## Recent traction

- An enterprise SaaS model with early distributor and pharmacy customers [co].
- Network coverage growing within the home market [co].
- No independent evaluation of detection performance is published yet [co].

## Proprietary data or distribution asset

The asset is the transaction-and-scan data network, which has network-effect potential but is early and not yet clearly defensible against a larger distributor building the same capability in-house [co]. This is the crux of the low investability score.

## LMIC impact reasoning

Scored 4. The target problem is a documented, large LMIC health harm, and the company has active deployment in the affected market with a plausible mechanism to reduce it [web-001][co]. The impact is strong on the problem it addresses; the score is not a 5 because scale is early and outcome evidence (falsified product actually removed, harm actually avoided) is not yet published.

## Open questions and risks

- Stage and moat: seed-stage with an unproven data-network defensibility, which caps investability at 2 and the rating at `monitor_only` per `docs/scoring_rubric.md` [co].
- Buyer incentive: distributors and pharmacies are not always motivated to surface diversion in their own chain, which complicates the sales motion [co].
- No published detection-performance evaluation yet [co].
- Regulatory dependency: impact scales fastest where a national medicines regulator mandates or endorses the tool [co].

**Promotion hypothesis.** This card is `monitor_only` today because of stage and moat, not mission. It promotes to a full diligence candidate on any one of: (1) a priced Series A with a named institutional lead; (2) a multilateral or national-regulator procurement or endorsement (for example a national medicines agency or a Global Fund quality-assurance program); or (3) a published independent evaluation of detection performance. These are the `taxonomy/signal_triggers.yaml` events to watch.

## Recent signals

- 2024-05: named_co_investor_round (seed round led by an Africa-focused VC) [co]

## Fit assessment

Meets the mission gate strongly on a large, documented LMIC harm, but seed stage and an unproven moat put investability at 2, which bounds the rating at `monitor_only`. The value of the card is the explicit promotion hypothesis above: it tells a future reader exactly what evidence would move this into the active cohort.

## Outreach notes

High-level only. Outreach status is `none`.
