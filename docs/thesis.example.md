# Example Investment Thesis

This is a template. Replace it with your own thesis.

Everything else in AI x Global Health Radar (the taxonomy, the methodology, the scoring rubric, the workflow, the themes) operationalizes this document. When you change the thesis, you change what the workbench discovers, how it triages, and how it scores. The worked example below is fictional and illustrative. It uses "AI for global health in low- and middle-income countries (LMICs)" as the domain because that is a concrete, well-bounded example. Swap in your own focus, gates, signals, exclusions, geographies, and themes.

## The fund's focus

The fund backs companies, trials, and research projects where artificial intelligence is a meaningful value driver and the company is positioned to improve health outcomes for patients, providers, or health systems in LMICs.

AI value driver means one of three categories (see `taxonomy/ai_categories.yaml`): drug discovery and development AI; health data, diagnostics, and genomics; or manufacturing and supply chain AI. Foundation-model labs and pure infrastructure are out of scope as opportunity cards.

LMIC impact means evidence or stated commitment to operations, deployments, partnerships, or trials that benefit LMIC patients. Headquarters geography is metadata; what matters is where the impact lands. Pre-revenue companies with credible LMIC orientation qualify.

## The two gates

A company earns a full opportunity card if it passes both gates. Apply the gates at Triage, not at Discovery.

1. **Mission alignment**: AI is a meaningful product driver AND the company is positioned to drive LMIC global health impact.
2. **Investability potential**: a real company exists, with identifiable founders, and some asset or trajectory (proprietary data, distribution, IP, named partnerships, regulatory progress, founder credentials, or similar).

Nothing else gates. Revenue, foundation inclusion, and WHO prequalification are not gating criteria.

## Positive signals (raise confidence, do not gate)

These raise scoring confidence and inform `fit_rating`. Their presence elevates a card; their absence does not exclude it.

- AI-native product with clinical validation underway or completed in an LMIC population
- Proprietary clinical, genomic, or operational dataset from LMIC sources
- Partnership with a pharma, biotech, or large foundation for LMIC commercial work
- WHO prequalification in progress, or national regulatory approval in a priority market
- Inclusion in a major global health funder or AI-for-good initiative
- AI workflow integrated into a regulated GMP or GLP environment
- Series A or later with named institutional investors, or a notable seed with a clear path to A
- Recurring revenue from enterprise, pharma research, or government contracts
- Founders or scientific leadership with prior LMIC product experience
- Anchor customer in an LMIC public health system or regional pharma manufacturer

## Exclusions

Deliberately out of scope:

- Pre-product, pre-data hype with no proprietary asset
- HIC-only deployment plans with no LMIC translation roadmap
- Pure clinical operations software for US or EU providers
- Consumer wellness apps without a clinical endpoint
- Foundation-model labs without an applied product
- API-wrapper "AI" with no defensible data layer
- Single-modality direct-to-consumer telehealth without a B2B or population-health angle
- Surveillance and social control AI regardless of stated health justification
- Military and defense applications
- Companies with no plausible path to local regulatory clearance in target markets

## Geographic priorities

Priority markets in rough order of activity:

- **Sub-Saharan Africa**: Nigeria, Kenya, Ghana, Rwanda, South Africa, Ethiopia, Senegal, Uganda, Tanzania
- **North Africa and MENA**: Egypt, Morocco, Saudi Arabia, UAE (commercial bases serving LMICs)
- **South Asia**: India, Bangladesh, Pakistan
- **Southeast Asia**: Indonesia, Vietnam, Philippines
- **Latin America**: Brazil, Mexico, Colombia, Peru
- **Cross-border**: HQ in the US, UK, EU, or Singapore with primary commercial activity in LMICs

Cards record both HQ and primary commercial markets.

## Themes

Seven prioritized themes, classified lean-in, selective, or monitor. Full reasoning and illustrative anchors are in `docs/themes_overview.md`; the machine-readable version is `taxonomy/themes.yaml`.

- **Lean-in (build the pipeline aggressively)**
  - Theme 1: AI-native diagnostics for high-burden disease in LMIC primary care
  - Theme 2: African genomic and health data infrastructure with recurring revenue
  - Theme 3: Manufacturing intelligence and cloud-lab infrastructure for biopharma
- **Selective (one diligence sprint each)**
  - Theme 4: LLM-mediated patient navigation, care coordination, and clinical decision support
  - Theme 5: AI-enabled clinical trials and pharmacovigilance for LMIC-relevant indications
- **Monitor (track quarterly, do not lead)**
  - Theme 6: AI for disease surveillance, vector control, and pandemic preparedness
  - Theme 7: AI for emerging-market health financing and claims

## How to replace this file

1. Write your own one-page thesis here: the focus, the two gates, the positive signals, the exclusions, the geographies, and the themes.
2. Update `taxonomy/themes.yaml`, `taxonomy/ai_categories.yaml`, and the other taxonomy files to match.
3. Re-read `docs/methodology.md`; it operationalizes this thesis, so confirm the scope, gates, and scoring still align.
4. Anything that conflicts between this thesis and the methodology gets resolved in favor of the thesis, with the conflict logged in `docs/decisions.md`.
