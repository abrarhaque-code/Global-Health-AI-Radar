# Validate Attio Readiness (Pre-Export Gate)

Per-card validation pass that runs before `prompts/export_to_attio.md`. Catches missing fields, schema violations, and banned-token leakage so Attio never sees bad data. Output is green / yellow / red per card with a roll-up; yellow and red block the export.

## When to use this

- Before every `export_to_attio.md --live` run.
- After a bulk discovery / enrichment cycle.
- After taxonomy refreshes (option-set drift can demote previously-green cards).

## Inputs to provide

- **Scope** (default: `all`): comma-separated slug list, `all`, or filter (`fit=likely_fit`, `theme=theme_1`).
- **Mode** (default: `report`): `report` prints the roll-up; `enforce` exits non-zero if any red.

## Per-card check sequence

For each `landscape/companies/{slug}.md` in scope, run the checks below. Each check is `pass`, `warn`, or `fail`. Per-card severity:

- **Green:** every check `pass`.
- **Yellow:** 1-3 `warn`, zero `fail`.
- **Red:** any `fail` OR more than 3 `warn`.

Yellow and red block the export.

### Required-field checks (failures are red)

1. **Required front-matter fields present.** All of: `slug`, `name`, `hq_country`, `ai_category`, `technical_archetype`, `themes`, `funding_stage`, `lmic_impact_score`, `investability_score`, `fit_rating`, `outreach_status`, `discovery_date`, `last_updated`, `sources`, `proprietary_data_asset`, `clinical_validation_status`, `revenue_signal`, `source_of_discovery`. A field marked `[uncertain]` counts as present; missing entirely is a fail.
2. **Score integers 1-5.** `lmic_impact_score` and `investability_score` must be integers 1, 2, 3, 4, or 5. Floats, strings, or out-of-range values fail.
3. **`fit_rating` enum.** Must be one of `likely_fit`, `adjacent`, `monitor_only`, `out_of_scope`.
4. **`ai_category` enum.** Must resolve against `taxonomy/ai_categories.yaml`.
5. **`technical_archetype` enum.** Must resolve against `taxonomy/ai_categories.yaml`.
6. **`themes` enum.** Every entry must resolve against `taxonomy/themes.yaml` ids.
7. **`funding_stage` enum.** Must resolve against `taxonomy/funding_stages.yaml`.
8. **`org_type` enum.** Must resolve against `taxonomy/org_types.yaml`.
9. **`ai_modalities` enum.** Every entry must resolve against `taxonomy/ai_modalities.yaml`.
10. **`primary_modality` enum.** Must resolve against `taxonomy/ai_modalities.yaml` and must also appear in `ai_modalities[]`.
11. **`disease_areas` enum.** Every entry must resolve against `taxonomy/disease_areas.yaml`.
12. **ISO dates.** `discovery_date`, `last_updated`, `last_round_date` (if present) must parse as ISO 8601.
13. **`sources` non-empty.** Must be a list with at least one entry.
14. **Source ID consistency.** Every `id` referenced in front-matter (e.g., in `recent_signals[].source` or `recent_signals[].source_id`) must appear in `sources[]`. Every source id in `sources[]` should appear in the body at least once.
15. **`notable_investors` resolution.** Every id in `notable_investors[]` must resolve against `taxonomy/capital_partners.yaml`. Unresolved ids fail.
16. **`attio_record_id` shape.** Either an Attio-shaped ID, or `PRIVATE_REF_ONLY`, or `null`. Free-text fails.

### Body-structure checks (failures are red)

17. **Required body sections present** (verbatim header match against the schema in `docs/card_schema.md`):
   - `## What they do`
   - `## Where the impact lands`
   - `## Key people`
   - `## Funding history`
   - `## AI approach`
   - `## Recent traction`
   - `## Proprietary data or distribution asset`
   - `## LMIC impact reasoning`
   - `## Open questions and risks`
   - `## Recent signals`
   - `## Fit assessment`
   - `## Outreach notes`

18. **Defending paragraphs.** `## LMIC impact reasoning` and `## Fit assessment` sections are non-empty and contain at least one paragraph defending the corresponding score.

### Writing-rule checks (failures are red)

19. **Banned tokens.** Body text contains none of:
   - em dash (U+2014)
   - ellipsis (U+2026)
   - "It's not just"
   - "transformative"
   - "industry-leading"
   - "groundbreaking"
   - "synergize"

   Quoted citations are exempt (e.g., a quoted press-release headline that contains "transformative"); use a hint heuristic: tokens inside markdown blockquotes `>` are exempt; tokens elsewhere are flagged.

### Soft checks (failures are warnings)

20. **`recent_signals` shape consistency** (warn). The key for source reference is either `source` or `source_id` across all entries on the card. Mixed usage on the same card warns. (Cross-card inconsistency is acceptable; the export handles both.)
21. **`recent_signals` date format** (warn). Month-level (`YYYY-MM`) versus full-date (`YYYY-MM-DD`) mixed on the same card warns.
22. **Card freshness** (warn). `last_updated` older than 90 days warns.
23. **Score reasoning length** (warn). The defending paragraphs under `## LMIC impact reasoning` and `## Fit assessment` should each have at least 50 words. Shorter warns.
24. **Open questions count** (warn). `## Open questions and risks` has fewer than 3 bullets warns (the Brief and Open-questions notes will be thin).
25. **Key people uncertainty** (warn). All entries in `## Key people` flagged `[uncertain]` warns; at least one named person is preferable for outreach.
26. **domains derivation** (warn). The derivation in `docs/attio_mapping.md` cannot pick a clean web source for this card.
27. **`source_of_discovery` enum** (warn). Value not in the canonical 10-value list (`pitchbook`, `pubmed`, `clinicaltrials`, `news`, `referral`, `thesis_anchor`, `thesis_watchlist`, `attio`, `cross_reference`, `other`). The card still exports; flag for the next refresh.
28. **`outreach_status` crosswalk** (warn). Value not in the 10-value Attio pipeline. `docs/attio_mapping.md` crosswalk applies; warn so the operator confirms the intended Attio target value.

## Output

Per-card line:

```
[GREEN | YELLOW | RED] {slug} | {checks_passed}/{total_checks} | warns: [check_ids] | fails: [check_ids]
```

Roll-up at the end:

```
Total cards in scope: N
Green: A
Yellow: B  (blocked from export)
Red: C     (blocked from export)
Ready to export: A
Common failures: [check_id: count, ...]
Common warnings: [check_id: count, ...]
```

If `mode=enforce` and any red or yellow exists, exit code 1.

## Anti-patterns to avoid

- Treating soft checks as hard fails. Soft checks are warnings by design; the operator may consciously ship with them.
- Failing the banned-token check on quoted citations. The blockquote heuristic exempts those.
- Failing a card because `notable_investors` is empty. Empty is fine; only unresolved ids fail.
- Validating against a stale `attio_mapping.md`. If the mapping has been edited but `_attio-mode.json` is older, the validate prompt still uses the latest mapping; the mode flag affects export, not validation.
- Auto-fixing problems. This prompt reports; it does not edit cards. Fixes happen in `prompts/enrich_company.md`.

## Verification

After running:

1. The output reconciles against the scope count.
2. Re-running with the same scope produces the same output (deterministic).
3. Picking one yellow card and reading the warned lines explains the warning.
4. Picking one red card and reading the failed lines explains the failure.
5. After fixing one failure on one card, re-running shows that card promoted to yellow or green.
