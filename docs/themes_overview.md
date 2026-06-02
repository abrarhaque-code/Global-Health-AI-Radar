# Themes Overview

The seven example AI-for-global-health investment themes from the thesis, with their lean-in / selective / monitor classification and pointers to the kind of pipeline anchor each theme expects.

These themes are an illustrative worked example. Replace them with the themes from your own thesis (`docs/thesis.example.md`).

See `taxonomy/themes.yaml` for the machine-readable version. See `docs/thesis.example.md` for the full reasoning behind each theme.

## Lean-in (build the pipeline aggressively; 1-2 anchors per theme)

### Theme 1: AI-native diagnostics for high-burden disease in LMIC primary care

AI extends specialist diagnostic capability to frontline workers. First wave: TB chest X-ray. Second: obstetric ultrasound. Third: dermatology and cervical screening. Echocardiography and retinal screening are credible adjacents.

**Pipeline anchor (illustrative):** ExampleDx, a fictional AI chest-X-ray TB-screening company, HQ Kenya

**Why it ranks lean-in:** real evidence base (computer-aided detection for TB on chest X-ray reaches roughly 90% sensitivity in published meta-analyses), near-term procurement catalysts (Gavi, the Global Fund, Africa CDC), live pipeline anchors.

**Risks:** LMIC population validation (algorithms trained on HIC data perform worse), WHO PQ timing, public procurement cycles long, talent retention to global tech firms.

### Theme 2: African genomic and health data infrastructure with recurring revenue

The data layer underneath LMIC health systems is the most durable AI moat available because it has not been built and because once built it compounds. Pharma co-development revenue near-term; clinical decision-support and diagnostic licensing later.

**Pipeline anchor (illustrative):** GenomeAfrica, a fictional population-genomics and health-data platform, HQ Ghana

**Watch:** regional genomics initiatives surfacing from continental health agencies and science foundations

**Why it ranks lean-in:** highest moat compounding, validated pharma demand, capital absorption fits a multi-instrument structure.

**Risks:** capital-intensive genomics platforms have a track record of slow commercial conversion. Capital-intensive lab build, slow conversion of academic partnerships into commercial revenue. Require commercial revenue conversion evidence before equity follow-on.

### Theme 3: Manufacturing intelligence and cloud-lab infrastructure for African and MEA biopharma

LMIC pharma manufacturing capacity is scaling fast but production economics lag. Batch failures, cold-chain breaks, regulatory dossier inefficiency are binding constraints. AI applied to these chokepoints improves yield, reduces cost per dose, accelerates WHO prequalification.

**Pipeline anchor (illustrative):** a cloud-lab and process-intelligence company serving regional biomanufacturers

**Watch:** tech-transfer-enabled vaccine and biologics manufacturers building AI-assisted process design

**Why it ranks lean-in:** highest applicability for venture debt and project finance, underbuilt category.

**Risks:** conflation of "infrastructure" with "AI" (cloud-lab tooling is not always AI-native). Depends on LMIC manufacturer scale. Tech transfer is slow and politically sensitive.

## Selective (one diligence sprint each; narrow filter)

### Theme 4: LLM-mediated patient navigation, care coordination, and clinical decision support

Vernacular-language LLMs plus SMS or WhatsApp plus structured clinical workflows. The proof points are large maternal-health messaging programs that fine-tune open models on local-language data. The investable shape is a vertically integrated clinical pathway company.

**Reference (illustrative):** an NGO-run maternal-health messaging program reaching millions of mothers

**Filter:** needs an existing clinical or payer franchise to bolt the AI onto. Pure greenfield LLM-only deployments are too risky; past general-purpose symptom-checker deployments in LMIC markets are a cautionary tale.

### Theme 5: AI-enabled clinical trials and pharmacovigilance for LMIC-relevant indications

Two bets: (a) AI-native African and South Asian CROs that solve structural underrepresentation of LMIC populations in pivotal trials; (b) RWE and pharmacovigilance platforms for mixed-paper, mixed-digital LMIC settings.

**Watch:** regulatory signals on AI-enabled and decentralized trial design from major medicines agencies

**Risks:** long cycle. Adoption depends on changes in WHO and FDA guidance that are uncertain over a 5-year horizon. Should not chase unless an exceptional founder surfaces.

## Monitor (track quarterly; do not lead)

### Theme 6: AI for disease surveillance, vector control, and pandemic preparedness

Catalytic capital from pandemic-preparedness funders is concentrating around AI-enabled pathogen surveillance and rapid-response missions. AI-native vector control (for example, machine-vision-guided sterile insect technique) is a credible adjacent.

**Watch:** AI-native vector-control and pathogen-surveillance companies with field validation

**Risks:** procurement-bound. Hype risk high. Real-world impact in non-pandemic periods is harder to demonstrate. Hard to underwrite as a venture-scale return without procurement guarantees.

### Theme 7: AI for emerging-market health financing and claims

AI claims adjudication, fraud detection, and underwriting are moving fastest in markets with active private-insurance digitization, where claims approval has dropped from weeks to hours with high automation rates.

**References (illustrative):** claims-automation and embedded-financing platforms in emerging-market insurance

**Risks:** LMIC payer markets are shallow. Algorithmic denial bias is a live policy concern globally. Regulator scrutiny is rising.

## Avoid

Documented in the `docs/methodology.md` exclusions section. Categories deliberately out of scope:

- Pure-play AI drug discovery platforms targeting HIC indications
- Foundation-model bets in healthcare (wrong scale of capital, wrong instrument)
- AI symptom checkers as standalone direct-to-consumer products
- Consumer wellness AI in LMICs
- HIC AI manufacturing pure-plays without an African footprint

## Cross-theme observations

- **Capital partner concentration**: the major global health foundations, pandemic-preparedness funders, and AI-infrastructure programs all converge on these themes. Co-investor signals matter and are tracked in `taxonomy/capital_partners.yaml`.
- **Africa-led**: most lean-in anchors are African; the workbench weights African company discovery heavily.
- **Data sovereignty**: continental health-data governance frameworks shift the moat math toward in-region hosted, locally trained platforms. Companies designed offline-first and locally hosted get a positive signal.
- **Foundation-model trajectory**: African-language LLMs may or may not be defensible against open-sourced multilingual models within 24 months. This affects Theme 4 specifically.

## Ranked investable opportunity areas

From the thesis, ranked by venture-scale return potential (35%), measurable impact (25%), fund defensibility (20%), capital absorption (10%), and regulatory/adoption timing fit (10%):

| Rank | Area | Notes |
|------|------|-------|
| 1 | African genomic and biomarker data platforms with pharma revenue | Theme 2 |
| 2 | LMIC-validated AI diagnostics for TB, obstetrics, cardiology with POC hardware integration | Theme 1 |
| 3 | Cloud-lab infrastructure and African biomanufacturing intelligence | Theme 3 |
| 4 | Pharmacy supply chain and predictive cold chain logistics | Theme 3 adjacent |
| 5 | LLM-mediated maternal, neonatal, and chronic disease care coordination | Theme 4 selective |
| 6 | AI-enabled CROs for African and South Asian clinical trial inclusion | Theme 5 selective |
| 7 | AI claims and underwriting platforms for emerging-market private insurers | Theme 7 monitor |
| 8 | AI vector control and pathogen surveillance | Theme 6 monitor |
