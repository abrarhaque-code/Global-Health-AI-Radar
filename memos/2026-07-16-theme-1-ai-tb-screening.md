# AI chest-X-ray TB screening: a view of the space, 2026-07-16

Theme: theme_1 (AI-native diagnostics for high-burden disease in LMIC primary care)
Classification: lean-in
Audience: external-ready

This memo is grounded in real public evidence. Company examples are anonymized composites (see `../landscape/companies/composite-tb-cxr.md`); the trial and paper cards it links are real public objects with real identifiers. No real company is scored or rated.

## What the space is

Tuberculosis is again the world's deadliest infectious disease. WHO estimates 10.8 million people fell ill with TB in 2023 and 1.25 million died, with an incidence of roughly 134 per 100,000 population ([WHO Global Tuberculosis Report 2024](https://www.who.int/teams/global-programme-on-tuberculosis-and-lung-health/tb-reports/global-tuberculosis-report-2024)). The 8.2 million people newly diagnosed in 2023 were the most since WHO began global monitoring in 1995, which is progress in case-finding and also a measure of how many cases went undetected in prior years ([WHO 2024](https://www.who.int/teams/global-programme-on-tuberculosis-and-lung-health/tb-reports/global-tuberculosis-report-2024)).

The binding constraint on screening is not the imaging hardware but the reader. Chest radiography is a sensitive screening tool for pulmonary TB, but in the high-burden settings where it matters most there is often no radiologist at the point of care. That is the gap computer-aided detection (CAD) fills, and in 2021 WHO recommended CAD software as an alternative to human reading of digital chest X-rays for TB screening and triage in people aged 15 and older ([WHO consolidated guidelines on tuberculosis, module 2: screening](https://www.who.int/publications/i/item/9789240022676)). The recommendation is conditional and rests on low-certainty evidence, so it opened the category rather than settling it: programs still have to validate a specific tool at a specific operating point in their own population.

The bar the category is measured against is the WHO target product profile for a triage test: at least 90% sensitivity and at least 70% specificity.

## What we've seen

Three threads sit inside this space, in descending order of evidence.

### AI chest-X-ray triage

The highest-evidence sub-thread. The reference study is an independent head-to-head evaluation of five commercial algorithms on chest X-rays from 23,954 people in Dhaka, Bangladesh, using a molecular test as the reference standard and a dataset none of the algorithms had trained on (`../landscape/papers/qin-2021-tb-cad-triage.md`). Two of the five cleared both WHO TPP bars at 90% sensitivity, all five reduced the confirmatory molecular tests required by roughly half, and all five degraded in people over 60 and people with a prior TB history. In-country validation continues: a completed prospective study run by the Centre for Infectious Disease Research in Zambia measured a CAD algorithm against a radiologist panel and the WHO targets across three Lusaka facilities (`../landscape/trials/NCT05139940.md`). The anonymized composite `../landscape/companies/composite-tb-cxr.md` illustrates the investable shape here.

### Cough and audio analysis for community screening

An earlier-stage thread: models that classify cough sound or other audio as a pre-screen before imaging or molecular testing. The appeal is that a smartphone microphone reaches further than an X-ray unit. The evidence base is thinner than for CAD and the failure modes (ambient noise, confounding respiratory disease) are less characterized, so this sits in discovery rather than diligence for now.

### Risk-stratification ML for active case finding

Models that rank who to screen first, using demographic, symptom, and geographic data to concentrate scarce testing on the highest-yield contacts and households. This is complementary to imaging rather than competing with it, and its value is in the economics of a screening campaign rather than in a single diagnostic read.

## What's working

The chest-X-ray triage thread has genuine product-market fit signals. The clinical case is proven on an untrained dataset, the WHO recommendation gives programs cover to procure, and the unit economics are real: a large reduction in expensive molecular tests per case found is the number that makes community screening affordable, and it is measured, not asserted ([Qin 2021](../landscape/papers/qin-2021-tb-cad-triage.md)). The public-sector demand is backed by a concrete funder landscape (the Global Fund, Stop TB Partnership and its TB REACH facility, FIND, Unitaid, and the Gates Foundation), which shortens the distance from a validated tool to a funded deployment.

## What's not (yet)

Two honest gaps. First, the published evidence is diagnostic accuracy, not downstream outcomes. Almost no company can yet show that its tool increased case-detection yield or treatment initiation at the population level, as opposed to matching a reference standard in a study. That is the difference between a 4 and a 5 on the impact rubric. Second, performance is not portable: the vendor spread in the independent literature is wide, and a universal cutoff score performs differently in each population, so a tool that clears the TPP in one setting can miss it in another ([Qin 2021](../landscape/papers/qin-2021-tb-cad-triage.md)). This means "AI-read chest X-ray" is not one capability, and in-population validation at a calibrated operating point is not optional. The subgroup degradation in older patients and prior-TB cases is a third, quieter gap that any deployment plan has to price in.

## What we'd back

A forward-looking profile, not a list of names:

- An AI-native company that owns an LMIC-sourced labeled chest-X-ray corpus tied to molecular reference results, not a wrapper on a third-party model. The data is the moat.
- A tool embedded in a screening pathway with a public-sector or integrated-provider channel, so revenue is more than per-read licensing and switching cost is real.
- Founders who pair LMIC clinical-program experience with model expertise, and who report performance against the WHO TPP at a named operating point in the population they serve.
- Evidence that moves past accuracy toward yield: case-detection or treatment-initiation gains from a real campaign, not just sensitivity and specificity from a study.

## Open questions

- Will any vendor publish population-level outcome data (yield, treatment initiation) rather than accuracy, and how soon?
- How stable is CAD performance in the HIV-positive subgroup, where TB radiographic findings are frequently atypical? The Zambia validation cohort explicitly included people living with HIV (`../landscape/trials/NCT05139940.md`).
- Does the ~50% reduction in confirmatory molecular tests hold at program scale outside the study setting, and does it survive the operating-point recalibration each new population requires?
- Where does reimbursement come from when donor TB-program budgets tighten?

## Linked cards

- [composite-tb-cxr](../landscape/companies/composite-tb-cxr.md) (anonymized composite)
- [Qin et al. 2021, Lancet Digital Health, five-algorithm CAD evaluation](../landscape/papers/qin-2021-tb-cad-triage.md)
- [NCT05139940, CIDRZ Zambia AI TB screening validation](../landscape/trials/NCT05139940.md)
