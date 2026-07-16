# Setup the CRM Radar Schema (One-Time)

Run once after CRM access is available and before any export. The reference implementation here is Attio (swap for Airtable, Notion, or HubSpot); the verb names below are the Attio reference. Detects connector capability, creates or verifies every attribute the export needs, and writes the canonical mode flag the export prompts read from.

## When to use this

- First setup against a fresh CRM workspace.
- After a CRM plan migration (e.g., free to paid) that may have reset custom attributes.
- After any taxonomy refresh that added option values to a `select` attribute (re-runs are idempotent; only missing options get created).

Do not run this against a production CRM workspace without a dry-run scan first; see the `--dry_run` mode in Tool sequence step 0.

## Inputs to provide

- **Mode** (default: `dry_run`):
  - `dry_run`: enumerate what would be created without writing
  - `live`: create missing attributes and options
- **Confirm constants** (default: `true`): re-verify `workspace_id` and companies object ID from `docs/attio_mapping.md` against the live workspace.

## Gotchas embedded (these have bitten prior operators)

1. **`config: {}` is required on attribute create.** Even text and date types fail validation without an empty config object in the request body.
2. **Select options are not honored in the attribute create body.** Create the attribute first, then POST options one at a time to `/v2/objects/{object}/attributes/{slug}/options` (or the connector's equivalent verb). Same for list-entry select attributes.
3. **Entry-value shape uses typed wrappers.** Selects expect `[{"option": "value"}]`; multi-selects expect arrays of the same; text expects `[{"value": "string"}]`. Connectors usually wrap this for you but the raw shape matters when falling back to REST.
4. **The `notes` slug collides with a system attribute.** Do not create a custom text field called `notes` on either the company object or the list. Use a different name (e.g., `analyst_notes`) if a free-text field is ever needed.
5. **View column configuration is not in the public REST API.** This prompt does not configure default columns; a UI recipe is printed at the end for the operator to apply manually.

## Tool sequence

### Step 0: Capability detection

Goal: determine whether the live connector can read and write list-entry attributes (list mode) or only company-object attributes (flat mode).

1. Verify identity. Call the connector's identity verb (`whoami` if present; otherwise the first MCP tool that returns workspace info). Confirm `workspace_id` matches the value recorded in `docs/attio_mapping.md` (set this to your own workspace ID on first setup). If it does not match, stop and ask the operator to confirm the workspace before continuing.
2. Enumerate exposed tools. List the connector's available verbs. Check for the presence of every operation listed below. Mark each `available` or `missing`:
   - Required for list mode: `list-lists`, `list-list-attribute-definitions`, `add-record-to-list`, `update-list-entry-by-record-id`, `list-records-in-list`
   - Required for flat mode: `list-attribute-definitions`, `search-records`, `create-record`, `update-record`, `create-note`, `list-notes`
   - Required for either: `list-workspace-members` (for actor-reference resolution)
3. Decide mode:
   - All list-mode verbs present → `mode = "list"`
   - Any list-mode verb missing AND all flat-mode verbs present → `mode = "flat"`
   - Flat-mode verbs also missing → stop and report; the workspace is not usable through this connector
4. Write `private/_attio-mode.json`:

```json
{
  "mode": "list",
  "detected_at": "2026-MM-DDTHH:MM:SSZ",
  "workspace_id_verified": true,
  "tools_available": ["whoami", "list-lists", "..."],
  "tools_missing": []
}
```

This file is the canonical mode flag every other Attio prompt reads.

### Step 1: Verify the companies object

1. Call `list-attribute-definitions object=companies`. Confirm the object exists and the returned object ID matches the value recorded in `docs/attio_mapping.md` (set this to your own companies-object ID on first setup). If different, overwrite the constant in the mapping doc with the live value.
2. Index the existing attribute slugs into a local set `existing_company_attrs`.

### Step 2: Create or verify company-object attributes

Iterate Table 1 in `docs/attio_mapping.md`. For each row:

1. If `attio_api_slug` is in `existing_company_attrs`, skip with a "verified" log line.
2. If missing, attempt to create via the connector's create-attribute verb if it exists; otherwise fall back to REST passthrough with the gotcha-compliant body shape:

```
POST /v2/objects/companies/attributes
{
  "data": {
    "api_slug": "<slug>",
    "title": "<human label>",
    "type": "<attio_type>",
    "config": {}
  }
}
```

3. If neither path works, log the row as "manual" and print the UI recipe (Settings → Objects → Companies → Attributes → New attribute) for the operator to apply by hand. Continue.
4. For each `select` or `multi-select` row, after the attribute exists, POST each option separately:

```
POST /v2/objects/companies/attributes/<slug>/options
{
  "data": { "title": "<option value>" }
}
```

Source the option set from the path noted in Table 1 (e.g., `taxonomy/ai_modalities.yaml`). For multi-selects, every value used across the committed cards plus any future-proof additions from the taxonomy file goes in. Capture the canonical `api_slug` Attio returns (Attio sometimes normalizes punctuation or case) and write it back into `docs/attio_mapping.md` if it differs.

### Step 3: Verify or create the AI x Global Health Radar list

Only run this step if `mode = "list"`.

1. Call `list-lists`. Search for `api_slug: ai_global_health_radar`.
2. If missing, create via the connector's create-list verb if available; otherwise REST passthrough:

```
POST /v2/lists
{
  "data": {
    "name": "AI x Global Health Radar",
    "api_slug": "ai_global_health_radar",
    "parent_object": "companies",
    "workspace_access": "full-access"
  }
}
```

3. If neither path works, print the UI recipe (Lists -> New list -> Companies parent -> name "AI x Global Health Radar") and stop. The export cannot run in list mode without the list.

### Step 4: Create or verify list-entry attributes

Only run this step if `mode = "list"`.

1. Call `list-list-attribute-definitions list=ai_global_health_radar`. Index existing slugs.
2. Iterate Table 2 in `docs/attio_mapping.md`. For each row, same logic as Step 2: skip if present, create if missing, manual log if neither works. Same option POSTs for selects. `radar_slug` requires uniqueness; create it with the uniqueness flag if the connector supports that, otherwise enforce uniqueness at export time via search-before-create.

### Step 5: Resolve workspace members for actor-reference attributes

1. Call `list-workspace-members`. Cache the result to `private/_attio-workspace-members.json` (gitignored) as `[{"id": "...", "name": "...", "email": "..."}]`.
2. Used by export to resolve `point_person` name strings to actor IDs.

### Step 6: Report

Print a structured summary:

- Mode chosen and why (which list verbs present/absent)
- Workspace constants verified (yes/no, any drift)
- Company-object attributes: `created`, `verified`, `manual` counts plus per-row table
- List existence: `created`, `verified`, `manual`
- List-entry attributes: `created`, `verified`, `manual` counts plus per-row table
- Workspace members cached: count
- Any canonical-slug drift written back to `docs/attio_mapping.md`

Also print the UI recipe for default column configuration (this part of the CRM may not be API-configurable):

```
UI step (operator runs this once):
1. Open the CRM -> Lists -> AI x Global Health Radar
2. Click "View settings" -> "Attributes"
3. Toggle on (in this order): radar_slug, name, fit_rating, lmic_impact_score, investability_score, outreach_status, themes, funding_stage_radar, last_round_date, last_round_amount_usd, notable_investors, point_person, next_milestone_label, next_milestone_date, recent_signals_summary, key_risks, radar_last_updated
4. Drag radar_slug to leftmost; fit_rating second; lmic_impact_score and investability_score next; outreach_status next
5. Save view as default for "AI x Global Health Radar"
```

## Output

- `private/_attio-mode.json` written
- `private/_attio-workspace-members.json` written
- `private/_attio-setup-log-{YYYY-MM-DD}.md` with the structured summary above
- `docs/attio_mapping.md` updated in-place if any constant or canonical slug drifted

## Anti-patterns to avoid

- Trusting prior-session constants without re-verification. Always round-trip them.
- Creating attributes with options inline (the option set is silently dropped).
- Skipping the workspace-member cache; the export will then fail on actor-reference assignment.
- Running in `live` mode without `dry_run` first.
- Falling back to REST when the operator has not pre-provisioned an API key with the right scope. If REST fails on a 401, switch to UI recipe and continue.

## Verification

After running:

1. Open `private/_attio-mode.json` and confirm mode is set and tools list looks correct.
2. Open `private/_attio-setup-log-{date}.md` and confirm no row is in the "manual" bucket that the operator did not handle.
3. In the CRM UI, navigate to the AI x Global Health Radar list and confirm every list-entry attribute from Table 2 is visible in "Attributes". If any is missing, re-run this prompt in `live` mode for the missing rows only (pass the slug list as input).
4. Run `prompts/export_to_attio.md` with one card and `--dry_run` to confirm the full sequence works against the schema this prompt produced.
