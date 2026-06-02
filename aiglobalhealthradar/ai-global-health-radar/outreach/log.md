# Outreach log (redacted by design)

This file is a TEMPLATE. It holds aggregate, redacted outreach counts only.

Real outreach content lives in the CRM (reference: Attio), not in git. That includes prospect names, email and message text, call and meeting notes, and any non-public commentary. None of it belongs in this repository.

What goes here: a dated, aggregate roll-up per outreach wave, with counts by pipeline stage and no names. The point is a committable, shareable record of activity volume that leaks nothing confidential. Pipeline stage names match the `outreach_status` enum in `docs/card_schema.md`.

## How to add an entry

1. Pull the current pipeline counts from the CRM.
2. Append one line per wave below. Do not edit prior lines; append only.
3. Use stage labels from the enum: `queued`, `drafted`, `sent`, `in_dialog`, `meeting_held`, `diligence`, `term_sheet`, `invested`, `passed`.
4. No names, no message text, no company-identifying notes.

## Aggregate log

> The entry below is a fictional illustration with invented counts. Replace with your own.

- Wave 1 (2026-05-29): 10 queued / 4 sent / 1 in_dialog / 0 meeting_held
