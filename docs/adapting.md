# Worked example: adapting the radar to a new domain

This walks one alternate thesis, AI for antimicrobial resistance (AMR) surveillance and stewardship, through the full swap. Use it as a template for any domain. The framework does not change; the thesis, the taxonomy, and one scoring axis do.

AMR is a good illustration because it sits at the right distance from the shipped global-health example: the machinery is identical (the two gates, the card schema, the 5-step loop, the CRM-sync pattern), but the thesis is genuinely different. `antimicrobial_resistance` is already a leaf tag in `taxonomy/disease_areas.yaml`, so the taxonomy delta is a re-weighting, not an invention.

## 1. Rewrite the thesis

Replace the body of `docs/thesis.example.md`. The AMR instance reads roughly like this:

> This instance backs companies, trials, and research where artificial intelligence is a meaningful value driver and the work reduces the burden of antimicrobial resistance: faster pathogen and susceptibility detection, sharper stewardship at the point of care, or surveillance that turns resistance data into action. Impact is measured in appropriate-prescribing rates, time to effective therapy, and resistance-trend visibility, not in generic claims.

### The two gates, re-instantiated

The gates keep their shape; only the mission clause changes.

1. **Mission alignment:** AI is a meaningful product driver AND the product moves an AMR outcome (diagnosis, stewardship, or surveillance), with evidence or a stated deployment path.
2. **Investability potential:** unchanged. A real company, identifiable founders, and an asset or trajectory.

### Example themes

- Theme 1: AI rapid diagnostics for pathogen identification and antibiotic susceptibility at the point of care.
- Theme 2: AI antimicrobial stewardship decision support embedded in prescribing workflows.
- Theme 3: AI genomic and syndromic surveillance for resistance trends across hospital networks and regions.
- Theme 4 (selective): AI-assisted discovery of novel antibiotics and phage therapeutics.

## 2. Swap the taxonomy

Two swapped `taxonomy/themes.yaml` entries, in the same shape as the shipped file:

```yaml
  - id: theme_1
    label: "AI rapid diagnostics for pathogen ID and antibiotic susceptibility at point of care"
    classification: "lean_in"
    category: "health_data_diagnostics_genomics"
    description: "AI shortens the path from sample to an actionable susceptibility result where culture-based AST is slow or unavailable, so clinicians can narrow therapy early."
    sub_threads:
      - "AI-read rapid phenotypic AST"
      - "Sequence-based resistance prediction"
      - "Syndromic panel interpretation"
    pipeline_anchors: []
    risks: "Reference-standard validation, regulatory clearance, integration into lab workflows"

  - id: theme_2
    label: "AI antimicrobial stewardship decision support in prescribing workflows"
    classification: "lean_in"
    category: "health_data_diagnostics_genomics"
    description: "Decision support that recommends narrower, guideline-concordant therapy at the moment of prescribing, trained on local resistance patterns."
    sub_threads:
      - "EHR-embedded stewardship prompts"
      - "Local-antibiogram-aware recommendation engines"
    pipeline_anchors: []
    risks: "Clinician trust, alert fatigue, dependence on local resistance-data quality"
```

What happens to the other taxonomy files:

- `taxonomy/disease_areas.yaml`: light edit, mostly kept. `antimicrobial_resistance` already exists; promote it and add companion leaves (`sepsis`, `hospital_acquired_infection`) as needed. The category scaffold stays.
- `taxonomy/lmic.yaml`: kept as-is if you retain an LMIC lens, optionally widened. AMR is global, so a domain that drops the LMIC restriction relaxes `priority_markets` (add high-income hospital markets) but leaves the file structure and the World Bank source discipline unchanged. Document the scope choice in `docs/decisions.md`.
- `taxonomy/capital_partners.yaml`: repopulate entities, keep the structure. Swap in AMR-relevant funders and strategics (for example CARB-X, Wellcome, GARDP, the AMR Action Fund) in the same `foundations_and_dfis` / `strategics` / `specialist_vcs` shape. IDs stay lowercase snake_case.
- `taxonomy/ai_categories.yaml`, `ai_modalities.yaml`, `funding_stages.yaml`, `org_types.yaml`, `signal_triggers.yaml`: structurally fixed. Edit descriptions and example strings only.

## 3. Adapt one card

Only the values change; every field name and enum comes straight from `docs/card_schema.md`.

```yaml
---
slug: example-ast
name: "Example AST"
hq_country: "IND"
impact_geographies: ["IND", "KEN", "NGA"]
disease_areas: ["antimicrobial_resistance", "sepsis", "hospital_acquired_infection"]
ai_category: "health_data_diagnostics_genomics"
technical_archetype: "ai_native"
ai_modalities: ["computer_vision", "predictive_ml"]
primary_modality: "predictive_ml"
themes: ["theme_1"]
funding_stage: "series_a"
proprietary_data_asset: "Paired phenotypic AST images and genotypic resistance labels from hospital microbiology labs across three countries"
clinical_validation_status: "rwe_published"
fit_rating: "likely_fit"
lmic_impact_score: 4
investability_score: 4
---
```

The only structural change from a shipped card's front-matter is the values (`disease_areas`, `proprietary_data_asset`, `themes`). That is the point of the guide: the schema is fixed.

## 4. What changes, what stays fixed

| File / area | Changes when re-pointing | Stays fixed |
|-------------|--------------------------|-------------|
| `docs/thesis.example.md` | rewritten entirely | file location and role |
| `taxonomy/themes.yaml` | all theme entries | id / label / classification / description keys |
| `taxonomy/capital_partners.yaml` | entity list | category structure, id conventions |
| `taxonomy/disease_areas.yaml` | tag emphasis, a few leaves | category scaffold |
| `taxonomy/lmic.yaml` | `priority_markets` (if scope changes) | World Bank source discipline |
| `docs/scoring_rubric.md` | impact-axis level definitions | investability axis, fit-rating mapping |
| `docs/methodology.md` | scope and exclusions prose | two gates, source-bias framing, citation discipline |
| `prompts/*.md` | connector names in tool sequences only | schema, output locations, workflow steps |
| `docs/card_schema.md` | nothing | entire schema |
| `docs/workflow.md` | worked-example names | the 5-step loop |
| `landscape/`, `memos/` | clear example cards | directory layout, INDEX generation |
| `scripts/preflight.sh` | `private/banned_tokens.txt` extension file | check logic |

## 5. Re-instantiate the scoring rubric

Only the impact axis is domain-specific. Redefine its five levels around AMR outcomes, keeping the "evidence at each level" discipline from `docs/scoring_rubric.md`:

- 5: multi-site deployment with published data showing reduced inappropriate prescribing or faster time-to-effective-therapy.
- 4: active deployments in two or more sites with traction and interim outcome signals.
- 3: documented pilots or a signed network, thin outcome evidence.
- 2: stated AMR focus, limited concrete deployment.
- 1: no real AMR outcome linkage.

The investability axis is portable: stage-appropriateness, team, moat, capital efficiency, and mandate fit do not depend on the domain. Change nothing but the illustrative examples. The fit-rating mapping table carries over unchanged.
