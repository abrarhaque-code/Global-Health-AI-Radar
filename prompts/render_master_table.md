# Render the Master Table (Regenerate landscape/INDEX.md)

Deterministic regeneration of `landscape/INDEX.md` from `landscape/companies/*.md` front-matter. Re-running produces the same file modulo card edits. Commit the regenerated file alongside any card change so the index never drifts.

## When to use this

- After any company card creation, deletion, or front-matter edit that changes scoring, fit rating, status, theme, or stage.
- After a thematic memo update that changes the high-conviction tier composition.
- Quarterly refresh sanity-check (counts and distributions should reconcile with the file counts under `landscape/` and `memos/`, and with the README status section if one is maintained).

## Inputs to provide

- **Mode** (default: `live`): `dry_run` writes to `/tmp/INDEX-preview.md` and prints a diff against `landscape/INDEX.md`; `live` overwrites `landscape/INDEX.md`.
- **Verify counts** (default: `true`): print a roll-up summary and assert against expected counts (`landscape/companies/*.md` count minus `_watchlist.md` and `.gitkeep`).

## Tool sequence

### Step 0: Enumerate cards

1. List `landscape/companies/*.md`, excluding `_watchlist.md` and `.gitkeep`.
2. For each, parse the front-matter into a record. Required fields: `slug`, `name`, `hq_country`, `themes`, `funding_stage`, `total_raised_usd`, `last_round_date`, `last_updated`, `lmic_impact_score`, `investability_score`, `fit_rating`, `outreach_status`, `recent_signals`.
3. Capture the master record set.

### Step 1: Compute the snapshot table

| Artifact | Counted from |
|---|---|
| Full opportunity cards | step 0 |
| Watchlist entries | row count in `landscape/companies/_watchlist.md` |
| People cards | files in `landscape/people/*.md` minus `.gitkeep` |
| Trial cards | files in `landscape/trials/*.md` minus `.gitkeep` |
| Paper cards | files in `landscape/papers/*.md` minus `.gitkeep` |
| Thematic memos | files in `memos/*.md` matching `{YYYY-MM-DD}-{theme-slug}.md` |
| High-conviction tier memo (optional) | check for `memos/*high-conviction-tier*.md`; when absent, omit the tier callout in Step 6 |
| ADR entries | count `^## ` headers in `docs/decisions.md` |

### Step 2: Compute distributions

1. **By fit rating:** group by `fit_rating`. Standard order: `likely_fit`, `adjacent`, `monitor_only`, `out_of_scope`.
2. **By HQ region:** map `hq_country` ISO-3 to region using the canonical region map below.
3. **By outreach status:** group by `outreach_status` value. Order: `none`, `queued`, `drafted`, `sent`, `contacted`, `in_dialog`, `meeting_held`, `diligence`, `term_sheet`, `invested`, `passed`.
4. **Score quadrant (2D):** grid of `investability_score` (rows, 4 down to 2) × `lmic_impact_score` (columns, 1 to 5). For each cell, list slugs sorted alphabetically.

### Region map (canonical; do not edit without ADR)

| Region | ISO-3 codes |
|---|---|
| Sub-Saharan Africa | NGA, KEN, ZAF, GHA, TZA, UGA, RWA, ETH, SEN, CIV, CMR |
| North Africa / MENA | EGY, MAR, TUN, DZA, JOR, ARE, SAU |
| Southern Africa | ZMB, ZWE, BWA, NAM, MOZ, MWI |
| Mauritius (Africa hub) | MUS |
| South Asia | IND, PAK, BGD, LKA, NPL |
| Southeast Asia | IDN, VNM, PHL, THA, MYS |
| Latin America | BRA, MEX, COL, ARG, CHL, PER |
| North America | USA, CAN |
| Europe | GBR, FRA, DEU, NLD, ESP, ITA, CHE, IRL |
| Israel | ISR |
| Other | (catch-all; flag in log for region-map update) |

### Step 3: Compute the master table rows

Sort all cards alphabetically by slug. Per row:

| Column | Formatting |
|---|---|
| Slug | front-matter `slug`; append ` ★` if the slug is flagged in the pending-decisions list (see Step 5) |
| Name | front-matter `name` (strip surrounding quotes) |
| HQ | front-matter `hq_country` (ISO-3) |
| Themes | count of entries in `themes` array (single integer; full list lives on the card) |
| Stage | `funding_stage` |
| Total raised | `$X.XM` if value < 1B; `$X.XB` if ≥ 1B; `-` if `null`, `[uncertain]`, or missing |
| LMIC | `lmic_impact_score` |
| Inv | `investability_score` |
| Fit | `fit_rating` |
| Status | `outreach_status` |

### Step 4: Compute the four filter views

1. **Priority outreach:** cards where `fit_rating = likely_fit` AND `lmic_impact_score >= 4` AND `investability_score >= 4`.
2. **Active dialogue:** cards where `outreach_status` is in `{in_dialog, meeting_held, diligence, term_sheet}`.
3. **Recent signals (last 30 days):** cards where any entry in `recent_signals[]` has a date within the last 30 days of today. Date may be ISO 8601 full date or month-level; treat month-level as the first day of the month.
4. **Needs refresh:** cards where `last_updated` is older than 60 days.

Each view renders as a small table with slug, name, and the most relevant column (anchor for priority outreach; current status for active dialogue; signal trigger and date for recent signals; days-since-update for needs refresh).

### Step 5: Pending decisions

Read `docs/decisions.md` for the most recent ADR that flags rating-change candidates. For example, an ADR titled `Pre-outreach lead validation pass` might flag slugs such as `exampledx` and `genomeafrica`. Render a small table per the ADR text. The `★` annotation in the master table comes from this list.

If a future ADR adds or removes flags, the generator parses that ADR's "rating-change candidates flagged for partner-level review" table to refresh the list. No hardcoding beyond the most-recent ADR pointer.

If no ADR flags rating-change candidates, omit the Pending decisions section and the `★` annotations entirely.

### Step 6: Assemble the file

Layout (top to bottom; the canonical layout below; sections marked optional are omitted when empty, so a small landscape produces a short file):

1. Title (`# AI x Global Health Radar: Index`) and Generated/Repo-home block.
2. Snapshot table.
3. Cohort distribution: By fit rating always renders; render the score quadrant (2D), By HQ region, and By outreach status distributions only when there are 5 or more company cards.
4. All companies (master table).
5. By theme: one section per theme, with the theme label and the slugs grouped under it. Memo path footer per theme.
6. High-conviction tier callout (Tier A, Tier B; only when the high-conviction memo exists).
7. People (table from `landscape/people/*.md` front-matter).
8. Trial cards (file list).
9. Paper cards (file list).
10. Memos (file list).
11. Pending decisions (Step 5 output; only when the latest ADR flags candidates).
12. Source files reference (canonical tree).
13. Resume protocol footer.

### Step 7: Write

- If `dry_run`: write to `/tmp/INDEX-preview.md`. Diff against `landscape/INDEX.md` and print.
- If `live`: overwrite `landscape/INDEX.md`.

### Step 8: Writing-rule scan

After writing, scan the file for:
- em dash (U+2014)
- ellipsis (U+2026)

Any hit triggers a re-emit pass (substitute `:` for em dashes, `...` for U+2026). Re-scan. If still failing, stop and report the offending line.

## Anti-patterns to avoid

- Hardcoding card counts or distributions; always recompute from the file system.
- Re-ordering body sections from the canonical layout in Step 6. Cross-session diffs should be clean.
- Inventing region assignments for ISO-3 codes not in the region map. Add the code to the map via ADR; do not silently bucket.
- Including watchlist rows in the master table. They live in `_watchlist.md`.
- Bumping a card's `last_updated` as a side effect of this prompt. The generator is read-only on cards.

## Verification

After running:

1. `wc -l landscape/INDEX.md` should be within ±5 lines of the prior version unless cards were added or removed.
2. `git diff landscape/INDEX.md` shows only intended changes (additions or status changes from card edits).
3. The snapshot table counts reconcile against `ls landscape/companies/*.md | wc -l` and the people/trials/papers/memos directories.
4. The master table row count equals the snapshot table's "Full opportunity cards" count.
5. The em-dash and ellipsis scan returns zero hits.
6. The "Pending decisions" table matches the slugs in the most recent ADR's rating-change-candidates section.
