# Export Cards to the CRM

Push opportunity cards from the workbench into a CRM (reference implementation: Attio; swap for Airtable, Notion, or HubSpot) via the field mapping in `docs/attio_mapping.md`. Idempotent, append-only on notes, search-first on every record. The `search-records`, `create-record`, and similar verb names below are the Attio reference implementation.

## Prerequisites

1. `prompts/setup_attio_radar_schema.md` has been run at least once and `private/_attio-mode.json` exists.
2. `prompts/validate_attio_readiness.md` has passed (green or yellow only; no red) for the cards in scope.
3. The writing rules are in effect (zero em dashes, no banned tokens; the validate prompt enforces).

## When to use this

- After a bulk discovery and enrichment cycle (theme sweep, watchlist promotion).
- During a quarterly refresh to re-push updated front-matter.
- Before an outreach push to ensure the CRM reflects current radar state.

## Inputs to provide

- **Scope** (required): comma-separated slug list, or `all`, or a filter (`fit=likely_fit`, `theme=theme_1`, `updated_since=YYYY-MM-DD`).
- **Mode** (required): `dry_run` or `live`. Default `dry_run`.
- **Notes refresh** (optional, default `true`): rebuild and append the four typed notes per card. Set `false` to skip notes during a fast metadata-only sync.

## Tool sequence

### Step 0: Load mode and capabilities

1. Read `private/_attio-mode.json`. If missing or empty, stop and tell the operator to run `setup_attio_radar_schema.md` first.
2. Set `MODE` to `"list"` or `"flat"`. Every step below branches on this flag.
3. Read `private/_attio-workspace-members.json` for actor-reference resolution.
4. Load `docs/attio_mapping.md` Table 1 and Table 2 as the field contract.
5. Load `taxonomy/capital_partners.yaml` for investor-id-to-name resolution.

### Step 1: Resolve the scope

Build the list of cards to process. Parse each `landscape/companies/{slug}.md` front-matter. Skip any with `outreach_status: passed` or `fit_rating: out_of_scope` (these do not belong in active CRM pipeline; log and continue).

### Step 2: Per card, upsert the company object

1. **Find existing company record.**
   - Search by `radar_slug` first: `search-records object=companies query={radar_slug}`.
   - If no match, fall back to `name` exact match, then each entry in `aliases`. Match must be unique. Ambiguous match (more than one company hit) stops processing for this card and logs the names found.
   - If found, capture `company_record_id`.
   - If not found and mode is `live`, prepare to create.

2. **Build the company payload from Table 1.** For each row:
   - Parse the radar field from front-matter.
   - Skip if value is `null`, `[uncertain]`, or empty.
   - Apply derivations:
     - `domains`: walk `sources[]`, take the first `type: web` whose host token-matches `name` or `slug`. If no clean match, omit and log `[uncertain]`.
     - `description`: synthesize one sentence (max 280 chars) from "What they do" body section. Strip citations brackets.
     - `proprietary_data_asset`: take the front-matter field value, truncate to 500 chars if needed (add ellipsis-free truncation: cut at the last full word).
   - Use typed-wrapper shapes for select, multi-select, and text fields per `docs/attio_mapping.md` gotcha 3.

3. **Write.**
   - If `dry_run`: print the payload as a flat list (slug, action, fields-with-values). No call.
   - If `live` and existing: `update-record object=companies record_id={company_record_id} data={payload}`.
   - If `live` and new: `create-record object=companies data={payload}`. Capture the new `company_record_id`.

### Step 3: Per card, upsert the list entry (or company-flat fields)

Branch on `MODE`:

#### `MODE = "list"`

1. **Find existing list entry:** `list-records-in-list list=ai_global_health_radar filter=radar_slug:{slug}`.
2. **Build the list-entry payload from Table 2** with the same skip / typed-wrapper rules as Step 2. Special handling:
   - `notable_investors`: resolve each id against `capital_partners.yaml`; output comma-separated display names. Unresolved ids stay as the literal id and are flagged in the export log.
   - `recent_signals_summary`: take the last 3 entries from `recent_signals[]`, format each as `{date} | {trigger} | {source or source_id}`, newline-joined.
   - `open_questions`: parse the "Open questions and risks" body section. Flatten bullets into a single string; truncate at 1000 chars at the last word.
   - `key_risks`: synthesize one paragraph from the top 2-3 bullets in "Open questions and risks"; truncate at 600 chars. If a `key_risks` line already exists in the card's "Fit assessment" section, prefer that.
   - `point_person`: read from optional front-matter key `point_person` (free-text name). Resolve against `_attio-workspace-members.json` by exact name. If no match, leave unset.
   - `next_milestone_label`, `next_milestone_date`: read from optional front-matter keys; leave unset if absent.
3. **Write:**
   - If `dry_run`: print.
   - If `live` and existing: `update-list-entry-by-record-id list=ai_global_health_radar record_id={company_record_id} data={payload}`.
   - If `live` and new: `add-record-to-list list=ai_global_health_radar record_id={company_record_id} data={payload}`.

#### `MODE = "flat"`

Merge the Table 2 payload into the same company-object payload from Step 2, using the right-hand-column slugs from the flat fallback table in `docs/attio_mapping.md`. Single `update-record` or `create-record` call per card.

### Step 4: Build and append the four typed notes (if `notes_refresh=true`)

Delegate to `prompts/build_attio_notes.md` for content generation. This step orchestrates:

1. For each note type (`Brief`, `Fit and angle`, `Warm path`, `Open questions`):
   - Call the note-builder with the card slug and `company_record_id`.
   - Get back the note title (with date stamp) and body.
   - `list-notes record_id={company_record_id}` to enumerate existing notes for this company. (Notes are append-only; this check is informational, not blocking.)
   - If `dry_run`: print title and first 100 chars of body.
   - If `live`: `create-note record_id={company_record_id} title={title} content={body}`. Never `update-note`.

### Step 5: Push key people

Delegate to `prompts/push_people_to_attio.md` for the same card. Pass `company_record_id` so the people records can be linked.

### Step 6: Writeback

For each successfully exported card:

1. Update the card front-matter:
   - `attio_record_id`: set to the live record ID (no longer `PRIVATE_REF_ONLY`).
   - `notes_pushed_at`: ISO timestamp of the export.
   - `last_updated`: today's ISO date.
2. If any value in front-matter was overwritten (rare; only when Attio normalized a slug), log it.

### Step 7: Logging

Write `private/_attio-export-log-{YYYY-MM-DD}.md` with one section per card:

```
## {slug}

- Mode: list | flat
- Company action: created | updated | skipped (reason)
- Company record id: <id>
- List-entry action: created | updated | n/a (flat mode)
- Notes created: Brief, Fit and angle, Warm path, Open questions
- People pushed: N (link to people log section)
- Unresolved investor ids: [list or none]
- domains derivation: <value> | [uncertain]
- Errors: [list or none]
```

End the file with a roll-up: total cards in scope, created, updated, skipped, errored.

## Error handling

- 4xx response: log the request body and the response body to the export log; continue to the next card. Do not crash the run.
- 5xx response: retry once after 2 seconds. If still failing, log and continue.
- Ambiguous name match in Step 2: log the candidate names; do not write; require operator review.
- Connector returns a tool-missing error mid-run: stop and report. The mode flag was probably stale; re-run setup.

## Privacy and discipline

- Do not push the raw card markdown body to the CRM. The `description` attribute and the four notes are synthesized.
- Private-market-provider record IDs (opaque) are OK in the CRM. Provider content is not.
- Never overwrite an existing CRM note; always `create-note` with a fresh date stamp.
- The writing rules apply to all note content (zero em dashes, no banned tokens). The note-builder enforces.
- Cards with `outreach_status: passed` or `fit_rating: out_of_scope` are skipped silently; they do not belong in the active CRM list.

## Anti-patterns to avoid

- Running `live` without a prior `dry_run` on the same scope.
- Bulk-overwriting CRM fields without first searching by `radar_slug`.
- Pushing the full body of "Open questions and risks" as a 5000-char text attribute (truncate to 1000 at the last word).
- Resolving `notable_investors` by lower-casing the display name and hoping. Use the YAML id-to-name lookup.
- Setting `point_person` by string match on email when only a first name is in the card. Leave unset rather than risk wrong-actor assignment.
- Treating a 4xx on one card as a reason to abort the entire batch.

## Verification (post-run)

1. Open the export log. Roll-up totals should reconcile against the scope count.
2. Open the CRM AI x Global Health Radar list. Pick three random cards and confirm:
   - `radar_slug` matches the file slug.
   - `fit_rating`, `lmic_impact_score`, `investability_score` match front-matter.
   - Four `[Radar] ...` notes are present with today's date stamp.
3. Spot-check one card's front-matter for the `attio_record_id` writeback.
4. Run `prompts/sync_from_attio.md` immediately after; confirm it round-trips without producing spurious "Outreach notes" appends.
