# Sync from the CRM Back into Cards

Pull CRM updates (status changes, new notes, meetings, tasks) into card "Outreach notes" and front-matter. Append-only on the card side. Paraphrase, never copy verbatim. Newer-wins on outreach status, never downgrade. The reference CRM here is Attio (swap for Airtable, Notion, or HubSpot); the verb names below are the Attio reference.

## Prerequisites

1. `prompts/setup_attio_radar_schema.md` has been run; `private/_attio-mode.json` exists.
2. At least one prior `prompts/export_to_attio.md` run has populated `attio_record_id` on cards.
3. The Attio outreach pipeline values match the crosswalk in `docs/attio_mapping.md`.

## When to use this

- After a week of outreach activity to fold meeting outcomes back into cards.
- Quarterly refresh to ensure cards reflect the latest Attio state.
- Before writing a thematic memo (so the memo reflects current intelligence).

## Inputs to provide

- **Scope** (default: `incremental`): `incremental` (only cards changed in Attio since `last_synced_at`), or `all`, or a theme filter (`theme=theme_1`), or a slug list.
- **Mode** (default: `live`): `dry_run` prints planned card edits without writing; `live` writes.

## Tool sequence

### Step 0: Load mode and sync state

1. Read `private/_attio-mode.json`. If missing, stop.
2. Read `private/_sync-state.json`. Initialize if missing:

```json
{
  "last_synced_at": "<30 days ago ISO>",
  "history": []
}
```

3. Capture `sync_started_at` as the current ISO timestamp.

### Step 1: Page Attio for the scope

Branch on `MODE` (from `_attio-mode.json`):

#### `MODE = "list"`

`list-records-in-list list=ai_global_health_radar` with pagination. For each entry:

- `radar_slug` is the join key.
- `outreach_status`, `point_person`, `next_milestone_label`, `next_milestone_date`, `key_risks`, `radar_last_updated` are read straight off the list entry.
- `company_record_id` is the parent company.

#### `MODE = "flat"`

`search-records object=companies` paginated. Same field set, all on the company object. `radar_slug` is still the join key.

For `incremental` scope, filter entries server-side where supported (`updated_after`); otherwise filter client-side by `radar_last_updated > last_synced_at`.

### Step 2: Per card, gather Attio activity since `last_synced_at`

For each list entry (or company record in flat mode):

1. Locate the matching card: `landscape/companies/{radar_slug}.md`. If missing, log and continue (Attio has a record that does not exist in the radar; surfacing this is the point of the sync).
2. `list-notes record_id={company_record_id}` paginated. Filter to notes where `created_at > last_synced_at`. Capture `title`, `created_at`, `created_by`, `content`.
3. `search-meetings filter=company_record_id:{company_record_id} updated_after:{last_synced_at}`. Capture date, attendees, summary.
4. `list-tasks filter=company_record_id:{company_record_id}` (if the connector supports task listing). Capture open task titles and due dates.

### Step 3: Per card, build the card edit

1. **Status update.** Read the Attio `outreach_status`. Compare against the card's current `outreach_status`. Apply the crosswalk in `docs/attio_mapping.md`. Decide:
   - If Attio status > card status in pipeline order: update the card front-matter `outreach_status` to the Attio value.
   - If Attio status < card status: **leave the card alone.** Never downgrade. Log "skipped: card more advanced".
   - If equal: no change.
   - Pipeline order: `none < queued < drafted < sent < in_dialog < meeting_held < diligence < term_sheet < invested`. `passed` is terminal; if Attio reads `passed`, accept it.

2. **Outreach notes append.** For each new Attio note, meeting, or task from Step 2, build a one-line entry for the card's "Outreach notes" section:

```
- 2026-MM-DD | source=attio | <paraphrased one-line summary>
```

Paraphrase rules:
- Replace named external individuals with their role ("the CMO", "the lead investor at firm X" becomes "a lead investor"). Your own team members may be named.
- Strip valuations, term-sheet numbers, LP identities, and any quoted text.
- Compress to one line. If the source is a meeting, the line is `- {date} | meeting | {attendees-as-roles} | {single-sentence takeaway}`. If a task, `- {date} | task | {paraphrased title} | due {date or "open"}`.
- Never copy more than 10 consecutive words from the Attio note body.

3. **Front-matter updates:**
   - `last_updated`: today's ISO date.
   - `outreach_status`: per the rule above.
4. **Body section append.** Append the new "Outreach notes" lines under the existing section. Do not reorder. Do not edit prior lines (append-only).

### Step 4: Write

- If `dry_run`: print the planned diff per card (status before/after, new outreach-notes lines, no front-matter write). End.
- If `live`: write each card edit. Save the file.

### Step 5: Update sync state

1. Write `private/_sync-state.json`:

```json
{
  "last_synced_at": "<sync_started_at>",
  "history": [
    ...
    {"synced_at": "<sync_started_at>", "scope": "<scope>", "cards_touched": N, "status_promotions": K, "notes_appended": M}
  ]
}
```

History is append-only; keep the last 30 entries.

### Step 6: Logging

Write `private/_attio-sync-log-{YYYY-MM-DD}.md` with:

- Sync window: `last_synced_at` to `sync_started_at`
- Cards touched count
- Per card section: status before/after, lines appended count, skipped-as-more-advanced flag
- Roll-up at the end

## Privacy boundaries

Real outreach content, external prospect names, individual quotes, LP names, and valuation discussions stay in the CRM. Committed cards capture only paraphrased public-safe summaries. The 10-word maximum-copy rule is a hard rule; treat it as a regex check post-build before saving.

## Append-only discipline

- Never delete or rewrite existing "Outreach notes" content; only append new lines below.
- If a status was wrongly promoted in a prior sync, add a corrective new line ("- YYYY-MM-DD | source=correction | prior status promotion reverted; verified Attio status is X"); do not edit the prior line or the prior front-matter writeback.
- The git history of card edits is also a secondary audit trail; do not amend prior commits.

## Anti-patterns to avoid

- Copying Attio note content verbatim (violates the 10-word rule and the privacy boundary).
- Downgrading `outreach_status` from a stale Attio note that pre-dates a card's manual update.
- Promoting status based on an ambiguous note (e.g., a `[Radar] Brief` reposted note does not mean `meeting_held`). When unsure, log "ambiguous; left unchanged" and skip.
- Including Attio's `[Radar] ...` self-generated notes in the outreach-notes append (filter them out by title prefix; they are the radar's own output bouncing back).
- Running `live` mode before a `dry_run` walkthrough confirms the planned diffs look right.

## Verification (post-run)

1. Open `private/_attio-sync-log-{date}.md`. Counts reconcile against the scope.
2. Pick three random cards that had `status_promotions` and confirm the new `outreach_status` is the Attio value, not an older one.
3. Pick three cards that had `notes_appended` and confirm the appended lines:
   - Start with a date.
   - Contain no quoted text longer than 10 consecutive words.
   - Contain no LP names or valuation numbers.
4. `git diff` the touched cards. Diffs should be additive only (front-matter `last_updated`/`outreach_status` plus new "Outreach notes" lines). No section reordering, no deletions.
