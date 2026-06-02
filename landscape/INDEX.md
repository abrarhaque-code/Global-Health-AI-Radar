# AI x Global Health Radar: Index

> Fictional illustration. All companies, people, and data here are invented; sources are placeholders. Replace with your own.

This is a generated panoramic view of the workbench. It is regenerated from card front-matter by `prompts/render_master_table.md`; do not hand-edit. Re-running the prompt after any card change produces the same file modulo those edits, so the index never drifts from the cards.

Generated: 2026-05-22 (illustrative)
Repo home: `landscape/`

## Snapshot

| Artifact | Count |
|----------|-------|
| Full opportunity cards | 2 |
| Watchlist entries | 2 |
| People cards | 1 |
| Trial cards | 1 |
| Paper cards | 1 |
| Thematic memos | 1 |

## By fit rating

| Fit rating | Count | Slugs |
|------------|-------|-------|
| likely_fit | 1 | exampledx |
| adjacent | 1 | genomeafrica |
| monitor_only | 0 | - |
| out_of_scope | 0 | - |

## All companies

Sorted alphabetically by slug.

| Slug | Name | HQ | AI category | Themes | LMIC | Inv | Fit | Status |
|------|------|----|-------------|--------|------|-----|-----|--------|
| [exampledx](companies/EXAMPLE-exampledx.md) | ExampleDx | KEN | health_data_diagnostics_genomics | theme_1 | 4 | 4 | likely_fit | none |
| [genomeafrica](companies/EXAMPLE-genomeafrica.md) | GenomeAfrica | GHA | health_data_diagnostics_genomics | theme_2 | 3 | 3 | adjacent | none |

## By theme

### theme_1: AI-native diagnostics for high-burden disease in LMIC primary care
- [exampledx](companies/EXAMPLE-exampledx.md)

Memo: `memos/EXAMPLE-theme-diagnostics-memo.md`

### theme_2: African genomic and health data infrastructure with recurring revenue
- [genomeafrica](companies/EXAMPLE-genomeafrica.md)

## People

| Slug | Name | Role | Org |
|------|------|------|-----|
| [jane-okafor](people/EXAMPLE-jane-okafor.md) | Jane Okafor | Founder and CEO | exampledx |

## Trial cards

- [NCT00000000](trials/EXAMPLE-NCT00000000.md): AI chest-X-ray TB triage validation, Kenya (sponsor exampledx)

## Paper cards

- [okafor-2025-tb-ai](papers/EXAMPLE-okafor-2025-tb-ai.md): real-world accuracy of an AI TB-triage tool (linked: exampledx)

## Memos

- [EXAMPLE-theme-diagnostics-memo](../memos/EXAMPLE-theme-diagnostics-memo.md): Theme 1, AI-native diagnostics for LMIC primary care

## How this file is regenerated

Run `prompts/render_master_table.md` in `live` mode. The generator enumerates `landscape/companies/*.md` (excluding `_watchlist.md`), parses front-matter, computes the snapshot, distributions, and the master table, then overwrites this file. It is read-only on cards: it never bumps a card's `last_updated`.
