# AI x Global Health Radar: Index

> Example content. Company cards are anonymized composites built from real diligence (see each card's disclosure blockquote); the trial and paper cards are real public objects with real identifiers. No real company is scored or rated. Replace with your own cards.

This is a generated panoramic view of the workbench. It is regenerated from card front-matter by `prompts/render_master_table.md`; do not hand-edit. Re-running the prompt after any card change produces the same file modulo those edits, so the index never drifts from the cards.

Generated: 2026-07-16
Repo home: `landscape/`

## Snapshot

| Artifact | Count |
|----------|-------|
| Full opportunity cards | 6 |
| Watchlist entries | 5 |
| People cards | 0 |
| Trial cards | 1 |
| Paper cards | 1 |
| Thematic memos | 1 |

## By fit rating

| Fit rating | Count | Slugs |
|------------|-------|-------|
| likely_fit | 2 | composite-llm-navigation, composite-tb-cxr |
| adjacent | 2 | composite-fetal-ultrasound, composite-genomics-registry |
| monitor_only | 2 | composite-cmc-manufacturing-hic, composite-supply-chain |
| out_of_scope | 0 | - |

## By score quadrant

Investability (rows) by LMIC impact (columns). Slugs sorted alphabetically per cell.

| Inv \ LMIC | 1 | 2 | 3 | 4 | 5 |
|-----------|---|---|---|---|---|
| 4 | - | - | - | composite-llm-navigation, composite-tb-cxr | - |
| 3 | - | composite-cmc-manufacturing-hic | composite-genomics-registry | composite-fetal-ultrasound | - |
| 2 | - | - | - | composite-supply-chain | - |

## By HQ region

| Region | Count | Slugs |
|--------|-------|-------|
| Sub-Saharan Africa | 4 | composite-genomics-registry, composite-llm-navigation, composite-supply-chain, composite-tb-cxr |
| North Africa / MENA | 1 | composite-fetal-ultrasound |
| North America | 1 | composite-cmc-manufacturing-hic |

## By outreach status

| Status | Count |
|--------|-------|
| none | 6 |

## All companies

Sorted alphabetically by slug.

| Slug | Name | HQ | Themes | Stage | Total raised | LMIC | Inv | Fit | Status |
|------|------|----|--------|-------|--------------|------|-----|-----|--------|
| [composite-cmc-manufacturing-hic](companies/composite-cmc-manufacturing-hic.md) | Composite: AI biologics CMC (HIC, off-thesis) | USA | 1 | seed | $8.0M | 2 | 3 | monitor_only | none |
| [composite-fetal-ultrasound](companies/composite-fetal-ultrasound.md) | Composite: AI obstetric ultrasound | MAR | 1 | series_a | $13.2M | 4 | 3 | adjacent | none |
| [composite-genomics-registry](companies/composite-genomics-registry.md) | Composite: African population-genomics platform | NGA | 1 | series_a | $24.0M | 3 | 3 | adjacent | none |
| [composite-llm-navigation](companies/composite-llm-navigation.md) | Composite: vernacular LLM care navigation | KEN | 1 | series_a | $17.5M | 4 | 4 | likely_fit | none |
| [composite-supply-chain](companies/composite-supply-chain.md) | Composite: AI pharma supply-chain integrity | NGA | 1 | seed | $4.6M | 4 | 2 | monitor_only | none |
| [composite-tb-cxr](companies/composite-tb-cxr.md) | Composite: AI chest-X-ray TB triage | KEN | 1 | series_b | $31.0M | 4 | 4 | likely_fit | none |

## Priority outreach

Cards with `likely_fit` and both scores at 4 or higher.

| Slug | Name | Anchor |
|------|------|--------|
| [composite-tb-cxr](companies/composite-tb-cxr.md) | Composite: AI chest-X-ray TB triage | Theme 1 anchor; national device approval and RWE published |
| [composite-llm-navigation](companies/composite-llm-navigation.md) | Composite: vernacular LLM care navigation | Vertically integrated pathway; payer-integrated launch |

## By theme

### theme_1: AI-native diagnostics for high-burden disease in LMIC primary care
- [composite-tb-cxr](companies/composite-tb-cxr.md)
- [composite-fetal-ultrasound](companies/composite-fetal-ultrasound.md)

Memo: `memos/2026-07-16-theme-1-ai-tb-screening.md`

### theme_2: African genomic and health data infrastructure with recurring revenue
- [composite-genomics-registry](companies/composite-genomics-registry.md)

### theme_3: Manufacturing intelligence and cloud-lab infrastructure for African and MEA biopharma
- [composite-supply-chain](companies/composite-supply-chain.md)
- [composite-cmc-manufacturing-hic](companies/composite-cmc-manufacturing-hic.md)

### theme_4: LLM-mediated patient navigation, care coordination, and clinical decision support
- [composite-llm-navigation](companies/composite-llm-navigation.md)

## People

No people cards in the example set.

## Trial cards

- [NCT05139940](trials/NCT05139940.md): CIDRZ Zambia validation of AI-enabled TB chest-X-ray screening (real trial)

## Paper cards

- [qin-2021-tb-cad-triage](papers/qin-2021-tb-cad-triage.md): independent five-algorithm CAD-for-TB evaluation, Lancet Digital Health 2021 (real paper)

## Memos

- [2026-07-16-theme-1-ai-tb-screening](../memos/2026-07-16-theme-1-ai-tb-screening.md): Theme 1, AI chest-X-ray TB screening

## How this file is regenerated

Run `prompts/render_master_table.md` in `live` mode. The generator enumerates `landscape/companies/*.md` (excluding `_watchlist.md` and `.gitkeep`), parses front-matter, computes the snapshot, distributions, and the master table, then overwrites this file. It is read-only on cards: it never bumps a card's `last_updated`.
