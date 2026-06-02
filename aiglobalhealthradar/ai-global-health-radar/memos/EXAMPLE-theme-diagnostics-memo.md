# Theme 1: AI-native diagnostics for LMIC primary care

> Fictional illustration. All companies, people, and data here are invented; sources are placeholders. Replace with your own.

Date: 2026-05-22 (illustrative)
Theme classification: lean-in
Status: example memo demonstrating structure

## Theme definition

AI extends specialist diagnostic capability to frontline workers in disease areas where the burden is concentrated in LMICs and the diagnostic workforce gap is structural. The investable shape is a company that owns a labeled clinical dataset from LMIC settings and the model trained on it, deployed into a real care pathway rather than sold as a standalone algorithm.

The diagnostic workforce gap is the core constraint. In many LMIC primary-care settings the radiologist-to-population ratio makes specialist reads unavailable at the point of care. AI that lets a clinical officer or community health worker triage accurately is a labor-substitution play with a measurable denominator.

### Sub-threads

1. AI chest X-ray for tuberculosis. Highest-evidence sub-thread; an established computer-aided-detection category with public-sector demand.
2. AI obstetric ultrasound. Gestational-age and risk estimation from low-cost probes operated by non-specialists.
3. AI dermatology and cervical screening. Image-based triage for high-burden, under-screened conditions.
4. Retinal screening for diabetic retinopathy. Camera-plus-model triage as diabetes prevalence rises in LMICs.

## Evidence walkthrough

The fictional anchor for this theme is ExampleDx (`landscape/companies/EXAMPLE-exampledx.md`), an AI chest-X-ray TB-screening company headquartered in Kenya. It illustrates the pattern the theme is looking for:

- Real LMIC deployment. Documented sites in Kenya and Uganda with a planned third in Tanzania, serving adults presenting to primary care with respiratory symptoms [card: exampledx].
- LMIC-sourced validation. A real-world-evidence study uses LMIC patient data rather than borrowing accuracy from high-income datasets, with a prospective study registered as NCT00000000 [card: exampledx].
- A proprietary data moat. The labeled chest-X-ray corpus tied to molecular TB reference results is expensive to assemble and compounds with each deployment [card: exampledx].

What the anchor does not yet show is also instructive. Deployment is pilot-scale across a small number of public programs, and published evidence is diagnostic accuracy rather than downstream treatment or mortality outcomes. That gap is why the example card scores 4 rather than 5 on LMIC impact, and it is the kind of gap a memo should name plainly.

## What we'd back

A forward-looking statement of the bet, not a description of the current market.

- AI-native diagnostics where the company owns LMIC-sourced labeled data and the model, not a wrapper on a third-party algorithm. The data is the moat; a model without proprietary data is a feature.
- A care pathway, not an algorithm. We want the tool embedded in a screening workflow with a public-sector or integrated-provider channel, which creates switching cost and a revenue path beyond per-read licensing.
- Founders who pair LMIC clinical-system experience with model expertise. Jane Okafor's fictional profile (clinical informatics plus medical imaging) is the shape the theme weights highly.
- Evidence that moves past accuracy toward outcomes. The strongest future cards will show case-detection yield or treatment-initiation gains, not just sensitivity and specificity.

## Open gaps

- Outcome evidence. The sub-thread is rich in diagnostic-accuracy data and thin on downstream patient-outcome data. We undercount companies that have not yet published outcomes and overcount sensitivity-and-specificity stories.
- Revenue concentration. Public-sector TB-program revenue is donor-influenced and slow; we have not stress-tested the unit economics of any anchor against a program loss.
- Coverage outside chest X-ray. The non-TB sub-threads (ultrasound, dermatology, retinal) are underexplored in the current example set; a real sweep should populate them before drawing theme-level conclusions.
- Regulatory timing. Device-registration timelines in priority markets are a gating risk we track per card but have not modeled at the theme level.
