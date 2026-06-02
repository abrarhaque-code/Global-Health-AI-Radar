# CRM Mapping: Radar to CRM Contract

Single source of truth for the radar-to-CRM field contract. Every other CRM-touching prompt in this repo points here. When the mapping disagrees with a prompt, the mapping wins; update the prompt.

This file documents the contract against a CRM (reference: Attio; swap for Airtable, Notion, HubSpot). The reference verbs and types below are Attio's; the field shape is what matters, so adapt the verbs and attribute types when you swap the connector.

## Target list

| Field | Value |
|-------|-------|
| Display name | AI x Global Health Radar |
| API slug | `ai_global_health_radar` |
| Parent object | `companies` |
| Workspace access | full-access |

Architectural choice: radar opinion and process state live on a **list entry** in `ai_global_health_radar`; intrinsic company facts live on the **company object**. A flat fallback is documented at the bottom of this file for the case where the live connector cannot write list-entry attributes.

Capability detection at `prompts/setup_attio_radar_schema.md` resolves which mode to use on first run. The mode lands in `private/_attio-mode.json` as `{"mode": "list" | "flat", "detected_at": "ISO"}` and every export reads that file.

## CRM constants (verify on first run; do not trust blindly)

| Constant | Value | Captured |
|----------|-------|----------|
| Workspace ID | `<your-workspace-id>` | first run |
| Companies object ID | `<your-companies-object-id>` | first run |

`prompts/setup_attio_radar_schema.md` re-verifies both via `whoami` (or the connector equivalent) and `list-attribute-definitions object=companies`. If either fails to round-trip, the constant is wrong and gets overwritten in this file.

## Table 1: Company-object attributes (intrinsic company facts)

These move with the company across any list or context. Set via `update-record object=companies` or `create-record object=companies`.

| Radar field | Attio API slug | Attio type | Option set / notes |
|---|---|---|---|
| `name` | `name` | text | Attio default |
| `aliases` | `aliases` | text | comma-separated; create if absent |
| `hq_country` | `primary_location` | location | populate country (ISO-3) plus region |
| derived | `domains` | domain | derivation rule below |
| derived | `description` | text | one-sentence synthesis from "What they do" body section; max 280 chars |
| `ai_category` | `ai_category` | select | `drug_discovery_and_development`, `health_data_diagnostics_genomics`, `manufacturing_and_supply_chain` |
| `technical_archetype` | `technical_archetype` | select | `ai_native`, `ai_enabled`, `foundational_platform` |
| `ai_modalities` | `ai_modalities` | multi-select | from `taxonomy/ai_modalities.yaml` (8 IDs) |
| `primary_modality` | `primary_modality` | select | single ID from `taxonomy/ai_modalities.yaml` |
| `disease_areas` | `disease_areas` | multi-select | from `taxonomy/disease_areas.yaml` (25 IDs) |
| `clinical_validation_status` | `clinical_validation_status` | select | `none`, `preclinical`, `phase_1`, `phase_2`, `phase_3`, `approved_for_use`, `rwe_published`, `not_applicable` |
| `revenue_signal` | `revenue_signal` | select | `pre_revenue`, `grant_funded`, `pharma_research`, `enterprise_saas`, `government_contract`, `mixed`, `undisclosed` |
| `impact_geographies` | `impact_geographies` | multi-select | ISO-3 codes; seed from union across cards plus the thesis priority geos |
| `proprietary_data_asset` | `proprietary_data_asset` | text | one-sentence summary; max 500 chars; full prose stays in card body |
| `org_type` | `org_type` | select | from `taxonomy/org_types.yaml` (8 IDs) |
| `pitchbook_id` | `pitchbook_id` | text | opaque ref to a private-market data provider (reference: PitchBook; swap for Crunchbase, Dealroom, or manual entry); record ID only, never provider content; `PRIVATE_REF_ONLY` is a valid value |
| `total_raised_usd` | `funding_raised_usd` | currency | Attio currency type stores integer cents in some configs; setup confirms |

### Derivation rule for `domains`

No `domain` or `website` field exists in card front-matter. Derive by:
1. Walk `sources[]` in front-matter.
2. Take the first entry where `type: web` AND the URL host matches the company name (case-insensitive token match against `slug` or `name`).
3. Use the host (no path, no protocol) as the domain.
4. If no clean match, leave `domains` unset and write `[uncertain]` in the export log. Do not fabricate.

## Table 2: List-entry attributes (radar opinion and process)

These are radar-specific. Set via the list-entry verbs (see capability detection). In flat fallback, all of these collapse onto the company object with the same slugs.

| Radar field | List API slug | Attio type | Notes |
|---|---|---|---|
| `slug` | `radar_slug` | text (unique) | **upsert key**; case-sensitive |
| `lmic_impact_score` | `lmic_impact_score` | number | 1-5 integer |
| `investability_score` | `investability_score` | number | 1-5 integer |
| `fit_rating` | `fit_rating` | select | `likely_fit`, `adjacent`, `monitor_only`, `out_of_scope` |
| `outreach_status` | `outreach_status` | select | 10 values; see crosswalk below |
| `themes` | `themes` | multi-select | `theme_1` through `theme_7` |
| `funding_stage` | `funding_stage_radar` | select | from `taxonomy/funding_stages.yaml`; the `_radar` suffix keeps it separate from any Attio default stage field |
| `last_round_date` | `last_round_date` | date | ISO 8601 |
| `last_round_amount_usd` | `last_round_amount_usd` | currency | |
| `notable_investors` | `notable_investors` | text | comma-separated display names resolved from `taxonomy/capital_partners.yaml` IDs (e.g., `gates` → "Bill & Melinda Gates Foundation") |
| `source_of_discovery` | `source_of_discovery` | select | `pitchbook`, `pubmed`, `clinicaltrials`, `news`, `referral`, `thesis_anchor`, `thesis_watchlist`, `attio`, `cross_reference`, `other` |
| `discovery_date` | `discovery_date` | date | |
| `last_updated` | `radar_last_updated` | date | |
| `recent_signals` (last 3 formatted) | `recent_signals_summary` | text | newline-separated; format: `YYYY-MM \| trigger \| source_id` |
| parsed from body | `open_questions` | text | flattened bullets from "Open questions and risks" section; max 1000 chars |
| analyst-assigned | `point_person` | actor-reference | resolved via `list-workspace-members` name match; otherwise unset, awaiting UI assignment |
| analyst-assigned | `next_milestone_label` | text | short label, e.g. "Phase 2 readout", "Series A close", "WHO PQ filing" |
| analyst-assigned | `next_milestone_date` | date | the date being watched |
| analyst-assigned | `key_risks` | text | one paragraph; synthesized from "Open questions and risks" plus reviewer judgment; max 600 chars |

## Outreach status crosswalk

Cards historically use a 4-value subset. Attio's pipeline uses 10. The pipeline is canonical; cards must accept any of the 10 values going forward. Update `docs/card_schema.md` to reflect this.

| Card value (historical) | Attio pipeline value | Notes |
|---|---|---|
| `none` | `none` | default |
| (new) | `queued` | analyst queued the company for outreach but no draft exists |
| (new) | `drafted` | outreach email drafted, not sent |
| `contacted` | `sent` | rename on next card touch |
| (new) | `in_dialog` (already used) | one-way or two-way conversation underway |
| `in_dialog` | `in_dialog` | preserved |
| `meeting_held` | `meeting_held` | preserved |
| (new) | `diligence` | post-meeting diligence active |
| (new) | `term_sheet` | term sheet issued or received |
| (new) | `invested` | investment closed |
| (new) | `passed` | declined; document reason in note |

**Sync-back rule:** Newer-wins by `created_at` on the most recent status-change note in Attio. **Never downgrade** a more-advanced card state from a stale Attio note. If Attio is `sent` and card is `in_dialog`, leave the card alone.

## Notes contract

Four typed notes per company, titles prefixed for in-Attio filtering. Generated by `prompts/build_attio_notes.md`. All notes are append-only with a date stamp in the title.

| Note title prefix | Length cap | Purpose |
|---|---|---|
| `[Radar] Brief YYYY-MM-DD` | 250 words | five-minute prep before a first meeting; what they do, where the impact lands, who runs it, what stage |
| `[Radar] Fit and angle YYYY-MM-DD` | 200 words | why this is on our radar, which theme, lean-in or pass thesis, what would change our mind |
| `[Radar] Warm path YYYY-MM-DD` | 150 words | named connections only; mutuals from `capital_partners.yaml`; one concrete intro suggestion |
| `[Radar] Open questions YYYY-MM-DD` | 200 words | first-call questions; lifted from "Open questions and risks" |

`[Radar] Background YYYY-MM-DD` is the equivalent for person records, generated by `prompts/push_people_to_attio.md`.

## Idempotency rules

1. **Upsert key:** `radar_slug` on the list entry. Every export starts with `search-records` (or `list-records-in-list filter=radar_slug`) before any write.
2. **Fallback search:** if no list-entry hit, fall back to company-object search by `name` then `aliases`. Match must be unique; ambiguity stops the export for that card and logs to the export log.
3. **Notes are append-only.** `create-note` always creates a fresh date-stamped note even if a same-prefix note exists. Never `update-note`.
4. **Status newer-wins.** Use the most recent `created_at` on a `[Status]`-tagged note in Attio. Never overwrite a more-advanced card state.
5. **Front-matter writeback.** After a successful export, write `attio_record_id` and `notes_pushed_at` (ISO timestamp) back into the card so future exports skip the name fallback.

## Flat fallback table

If `setup_attio_radar_schema.md` finds the connector cannot write list-entry attributes, the same data lands on the company object under the slugs in the right-hand column. All slugs preserved; `radar_slug` collapses to a unique attribute on the company itself.

| List slug (list mode) | Company-object slug (flat mode) |
|---|---|
| `radar_slug` | `radar_slug` |
| `lmic_impact_score` | `lmic_impact_score` |
| `investability_score` | `investability_score` |
| `fit_rating` | `fit_rating` |
| `outreach_status` | `outreach_status` |
| `themes` | `themes` |
| `funding_stage_radar` | `funding_stage_radar` |
| `last_round_date` | `last_round_date` |
| `last_round_amount_usd` | `last_round_amount_usd` |
| `notable_investors` | `notable_investors` |
| `source_of_discovery` | `source_of_discovery` |
| `discovery_date` | `discovery_date` |
| `radar_last_updated` | `radar_last_updated` |
| `recent_signals_summary` | `recent_signals_summary` |
| `open_questions` | `open_questions` |
| `point_person` | `point_person` |
| `next_milestone_label` | `next_milestone_label` |
| `next_milestone_date` | `next_milestone_date` |
| `key_risks` | `key_risks` |

Flat mode loses the "view this radar slice" affordance in Attio. Notes contract, idempotency, and all derivation rules are unchanged.

## Source-of-truth boundaries

- The card body (`landscape/companies/{slug}.md`) is the source of truth for analytical reasoning, citations, scoring justification.
- This file is the source of truth for the Attio field shape.
- The list entry (or company-object in flat mode) is the source of truth for outreach status, point person, next milestone, and date-stamped notes after first dialog.
- Cards push to Attio; Attio meeting outcomes and status changes flow back to card "Outreach notes" via `prompts/sync_from_attio.md`.
- Neither overwrites the other; both append.
