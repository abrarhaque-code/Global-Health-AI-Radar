# Build the Four Typed CRM Notes per Card

Generate four CRM-utility-shaped notes per opportunity card. Called by `prompts/export_to_attio.md` Step 4. Each note has a fixed title prefix for in-CRM filtering and a hard length cap. All notes are append-only and date-stamped. The reference CRM here is Attio (swap for Airtable, Notion, or HubSpot); the `create-note` verb names are the reference implementation.

## When to use this

- During a CRM export to build or refresh the four notes for a single card.
- Quarterly note refresh (run for every active-tier card without re-running the full export).
- Ad hoc before a first meeting if the notes on file are older than 60 days.

## Inputs to provide

- **Slug** (required): the card slug at `landscape/companies/{slug}.md`.
- **Company record id** (required when called by export; otherwise the prompt can skip the write step and only generate content).
- **Mode** (default: `dry_run`): `dry_run` returns the four notes as plain text; `live` calls `create-note` for each.

## Note contract

Each note has:
- Title format: `[Radar] {Type} {YYYY-MM-DD}` where `{Type}` is one of `Brief`, `Fit and angle`, `Warm path`, `Open questions`.
- Hard length cap (words).
- Writing rules applied (zero em dashes, no "It's not just," no adjective stacking, every claim anchored to the card's source IDs).
- Never paraphrased card prose; synthesized for CRM utility.

| Note type | Cap | Purpose | Source on the card |
|---|---|---|---|
| `Brief` | 250 words | five-minute prep for a first meeting | "What they do", "Where the impact lands", "Key people", `funding_stage` |
| `Fit and angle` | 200 words | why this is on the radar; lean-in or pass thesis; what would change our mind | "Fit assessment", `themes`, scoring justifications |
| `Warm path` | 150 words | named connections only; mutuals; one concrete intro ask | `notable_investors`, "Key people", `capital_partners.yaml` |
| `Open questions` | 200 words | first-call questions and unknowns | "Open questions and risks" |

## Tool sequence

### Step 0: Load context

1. Parse `landscape/companies/{slug}.md` front-matter and body sections.
2. Load `taxonomy/capital_partners.yaml` for id-to-name resolution.
3. Load `landscape/people/*.md` (the slugs referenced in the card's "Key people" body section) for cross-reference.
4. Capture today's date as ISO for the title stamps.

### Step 1: Build `[Radar] Brief {date}`

One paragraph or three short paragraphs, ≤250 words. Anchored to citations from the card body. Structure:

1. **What they do** (1-2 sentences). One sentence on the product. One sentence on the AI core and the unit of value delivered (per encounter, per patient, per facility).
2. **Where the impact lands** (1-2 sentences). Geographies, deployment scale, patient population. Use real numbers from the card with citations.
3. **Who runs it** (1 sentence). CEO name, prior relevant role. If multiple co-founders, name two max.
4. **Stage and capital** (1 sentence). `funding_stage`, last round amount and date, notable investors (display names).

Citation style: bracketed source IDs as on the card (e.g., `[web-001]`). Do not invent new sources. Do not push the full source URLs into the CRM note (the card body is the place for that).

### Step 2: Build `[Radar] Fit and angle {date}`

≤200 words. Lifted-and-rewritten from the card's "Fit assessment" section, tightened to CRM utility.

Structure:
1. **Why this is on the radar** (1-2 sentences). The triggering thesis or signal. Reference the relevant theme by label (e.g., "Theme 1: AI diagnostics for LMIC primary care").
2. **Lean-in or pass thesis** (2-3 sentences). The strongest argument for engaging, and the strongest argument against. Both should be anchored.
3. **What would change our mind** (1 sentence). The specific signal or event that would move the rating up or down (e.g., "WHO PQ filing"; "named African manufacturer partnership"; "founder departure").

Use the actual `lmic_impact_score` and `investability_score` numerals. Do not soften the call.

### Step 3: Build `[Radar] Warm path {date}`

≤150 words. **Named connections only.** No "the team has strong networks" filler.

Cross-reference logic:
1. For each id in `notable_investors`, look up the display name in `capital_partners.yaml`. Mark any that overlap with the fund's network (every id in the YAML qualifies; the YAML is the fund's network).
2. For each person in "Key people" of the card, check whether any of their `prior_roles` (from the matching `landscape/people/{slug}.md` if it exists) reference firms in `capital_partners.yaml`. Mark mutuals.
3. List mutuals (max 5 lines). One line per: `- {network entity}: connected via {investor on cap table | board member | advisor | prior role}`.
4. End with one concrete suggestion: `Suggested ask: {who at the fund} -> {who at the network entity} -> {who at the company}`.

If no mutuals surface, the note says exactly: `No named warm-path connections surfaced. Recommended: cold outreach via {prompts/draft_outreach.md} with the {anchor} from the Fit-and-angle note.` Filler about LinkedIn connections is forbidden.

### Step 4: Build `[Radar] Open questions {date}`

≤200 words. Lifted-and-tightened from the card's "Open questions and risks" section.

Structure:
1. Take the top 3-5 questions or risks from the card section.
2. Reformulate each as a question to ask in a first call. Format: bullet list, one line per question, max 25 words each.
3. If the card has fewer than 3 entries in "Open questions and risks", the note flags this: `Card's open-questions section is thin; recommend re-enrichment per prompts/enrich_company.md before first meeting.`

### Step 5: Apply writing-rule scan

Before returning each note, run a regex pass for the banned tokens:
- em dash (U+2014)
- ellipsis (U+2026)
- the literal phrases "It's not just", "transformative", "industry-leading", "groundbreaking", "synergize"

Any hit fails the note. Re-draft and re-scan. Do not return notes that fail the scan.

### Step 6: Return or write

- If `dry_run`: return the four notes as a single structured payload `{brief: ..., fit: ..., warm_path: ..., open_questions: ...}` with titles and bodies.
- If `live`: call `create-note record_id={company_record_id} title={title} content={body}` four times. Never `update-note`. Log every call to the export log under the card's section.

## Anti-patterns to avoid

- Copy-pasting the card body. The notes are synthesized for CRM utility, not duplicated content.
- Filler in the Warm path note. If no named connections exist, say so.
- Soft-balling the Fit and angle note. The "what would change our mind" sentence has to be specific.
- Writing the Open questions as statements instead of questions. They go into a first-call prep workflow; make them ask-able.
- Quoting more than 10 consecutive words from any external source (e.g., a press release referenced on the card). Synthesize.
- Banned-token leakage. If the scan in Step 5 fails, re-draft; do not push.

## Verification

After running:

1. Word counts on each note are within the cap.
2. The banned-token regex returns zero hits.
3. The Warm path note either lists real named connections from `capital_partners.yaml`, or says "no warm-path connections surfaced." No middle ground.
4. The Brief note's citation IDs all appear in the card's `sources[]` array.
5. The four titles all carry today's date stamp.
