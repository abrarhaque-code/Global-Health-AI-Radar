# Push Key People to the CRM

For each company being exported, parse the "Key people" body section and upsert person records in a CRM (reference implementation: Attio; swap for Airtable, Notion, or HubSpot), linked to the company. Append a `[Radar] Background` note per person. Called by `prompts/export_to_attio.md` Step 5. The `search-records`, `create-record`, and similar verb names below are the Attio reference implementation.

## Prerequisites

1. `prompts/setup_attio_radar_schema.md` has been run; `private/_attio-mode.json` exists.
2. The company record exists in Attio with the `company_record_id` known (the export prompt provides this).
3. The Attio people object exists with at least these attributes: `name`, `current_role`, `current_org`, plus the radar-added `themes` and `expertise` (the setup prompt creates these on first run).

## When to use this

- During an Attio export, immediately after the company-object upsert (Step 5 of `export_to_attio.md`).
- Standalone: refresh a single person record after a `landscape/people/{slug}.md` edit.

## Inputs to provide

- **Company slug** (required): the source company at `landscape/companies/{slug}.md`.
- **Company record id** (required): the Attio company record this person belongs to.
- **Mode** (default: `dry_run`): `dry_run` prints planned writes; `live` writes.

## Tool sequence

### Step 0: Load context

1. Parse `landscape/companies/{slug}.md` "Key people" body section. Each bullet becomes a candidate person.
2. For each candidate, look for a matching `landscape/people/{person-slug}.md` (slug-style name match, e.g., "Jane Doe" -> `jane-doe.md`). If found, parse the front-matter; the card has richer data than the inline bullet.
3. Skip any person flagged `[uncertain]` in the name field. Skip board observers and advisors named only as "and additional advisors" or similar non-individuals.

### Step 1: Per person, search for an existing Attio record

1. `search-records object=people query={name}`. Filter results where `current_org` (or any historical org) matches `{company_record_id}` or the company name.
2. If a unique match exists, capture `person_record_id` and proceed to update.
3. If multiple matches exist, log the ambiguity and skip this person (require operator review).
4. If no match exists, prepare to create.

### Step 2: Build the person payload

| Source | Attio attribute | Notes |
|---|---|---|
| name | `name` | text |
| current_role (from people card, or bullet text) | `current_role` | text |
| company_record_id | `current_org` | reference to companies object |
| prior_roles (from people card) | `prior_role_summary` | text; comma-joined or newline-joined |
| themes (from people card) | `themes` | multi-select; from `taxonomy/themes.yaml` |
| expertise (from people card) | `expertise` | multi-select; create attribute on the people object if absent |
| linkedin_url (from people card) | `linkedin_url` | text |
| notable (from people card) | `notable` | boolean |

If the person bullet is inline-only (no `landscape/people/{slug}.md`), populate only `name`, `current_role`, and `current_org`. Do not fabricate prior roles, themes, or expertise.

### Step 3: Write

- If `dry_run`: print the payload. No call.
- If `live` and existing: `update-record object=people record_id={person_record_id} data={payload}`.
- If `live` and new: `create-record object=people data={payload}`. Capture the new `person_record_id`.

### Step 4: Append `[Radar] Background` note

Build a single note per person:

- Title: `[Radar] Background {YYYY-MM-DD}`.
- Body (≤200 words):
  - One sentence: current role at the company.
  - One paragraph: relevant prior roles and what they bring to the company's thesis. Anchored to the person card's `sources[]` if it exists.
  - One sentence: any cross-reference to the fund's network (e.g., "Previously at {firm in capital_partners.yaml}"; "Co-author with {advisor X} on {paper card}").
- Banned-token scan (same as `build_attio_notes.md` Step 5).

If `dry_run`: print. If `live`: `create-note record_id={person_record_id} title={title} content={body}`. Never `update-note`.

### Step 5: Writeback to the people card

If a `landscape/people/{person-slug}.md` exists and was the source of any field, update its front-matter:

- `attio_person_id`: set to the live Attio record ID (no longer `PRIVATE_REF_ONLY`).
- `last_updated`: today's ISO date.

If no people card exists (the person came from an inline bullet only), do not create one in this prompt. People-card creation is `prompts/enrich_person.md`'s job; this prompt only pushes existing data.

### Step 6: Logging

Append a per-person block to the export log under the company's section:

```
- {person name}: {action} (record_id={person_record_id}); background note created
```

Roll-up: total people processed, created, updated, skipped (with reason).

## Anti-patterns to avoid

- Creating a person record for "additional advisors" or any non-individual bullet. Skip and log.
- Fabricating prior roles or themes for inline-only bullets. The people card is the only source for those fields.
- Updating `current_org` to overwrite a prior employer relationship without preserving prior history. If the person has moved companies, the prior `current_org` value should be archived in `prior_role_summary` before the update.
- Pushing multiple `[Radar] Background` notes per export. One per export pass per person. Future refreshes append a new dated note; do not amend.
- Creating people-object attributes (`themes`, `expertise`) during this prompt. That is `setup_attio_radar_schema.md`'s responsibility; this prompt assumes they exist.

## Verification

After running:

1. Pick one company. In Attio, navigate to the company record, scroll to associated people. Each name in the card's "Key people" section appears (except `[uncertain]` and non-individual entries).
2. Each person record has a `[Radar] Background` note dated today.
3. The corresponding `landscape/people/{slug}.md` (where present) has `attio_person_id` populated and `last_updated` bumped.
4. No person record was created with a fabricated prior role or theme.
