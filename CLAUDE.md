# AI x Global Health Radar: project guide for Claude Code

This file orients Claude Code (and humans) working in this repository. AI x Global Health Radar is a git-native horizon-scanning workbench for AI in global health. You point it at a thesis, and Claude Code drives MCP connectors to discover, enrich, score, and track the field as plain-markdown cards you can diff, review, and share.

This repository is configured for "AI for global health in low- and middle-income countries (LMICs)". The methodology and tooling are general: swap the thesis, taxonomy, and scoring to point it at any fast-moving field.

## What this repository is

- Taxonomy, prompts, methodology, scoring rubric, and example opportunity cards.
- The "tool" is Claude Code itself, driving reference MCP connectors. Connectors are pluggable.
- Cards are the source of truth for shareable analysis. Raw provider data and CRM exports stay out of git.

## Read these first

1. `README.md`
2. `docs/thesis.example.md`: the example thesis the config operationalizes. Replace with your own.
3. `docs/methodology.md`: scope, the two gates, scoring overview, source biases.
4. `docs/workflow.md`: the 5-step discovery-to-action loop with worked examples.
5. `docs/card_schema.md`: card front-matter and body structure.

## Hard rules

1. Never commit anything under `private/`. It is gitignored. Raw provider pulls, CRM exports, and discovery inboxes live there.
2. Raw provider content does not enter committed cards. Cards may reference opaque record IDs as private references. Body content synthesizes from public sources with citations.
3. Citations on every factual claim. A claim without a citation gets removed or flagged during review.
4. Writing rules (house style; adjust to taste): no em dashes, no ellipses, no "It's not just X, it's Y" constructions, specific anchors on every claim, direct register. `scripts/preflight.sh` enforces the punctuation rules.
5. Bias toward false positives at Discovery. Filtering happens at Triage (the two gates) and Vetting (the rubric), not at Discovery.

## The two gates (apply at Triage, not at Discovery)

1. **Mission alignment**: the thesis driver is real AND the company is positioned to deliver the impact the thesis cares about.
2. **Investability potential**: a real company, identifiable founders, and an asset or trajectory.

Positive signals (revenue, regulatory progress, named partnerships, founder track record) raise confidence at Vetting. They are not gates at Triage.

## Common workflows

| Request | Use prompt |
|---------|-----------|
| Build the universe for a theme | `prompts/discover_by_theme.md` |
| Enrich a known company | `prompts/enrich_company.md` |
| Score a card | `prompts/score_relevance.md` |
| Draft outreach | `prompts/draft_outreach.md` |
| Push cards to the CRM | `prompts/export_to_attio.md` |
| Pull CRM updates back | `prompts/sync_from_attio.md` |
| Thematic memo | `prompts/thematic_memo.md` |
| Discover trials | `prompts/discover_trials.md` |
| Discover papers | `prompts/discover_papers.md` |
| Enrich a person | `prompts/enrich_person.md` |
| Validate cards before export | `prompts/validate_attio_readiness.md` |
| Regenerate the master table | `prompts/render_master_table.md` |

## MCP connectors (reference implementation, all pluggable)

- **Private-market data**: reference connector PitchBook. Swap for Crunchbase, Dealroom, or manual entry.
- **CRM**: reference connector Attio. Swap for Airtable, Notion, or HubSpot.
- **PubMed**, **ClinicalTrials.gov**, **bioRxiv/medRxiv**: public and free.
- **Web search** for everything else.

The prompts name the reference tools in their tool sequences. Replacing a connector means editing the relevant prompt's tool steps; the card schema and methodology do not change.

## Output discipline

- Company cards: `landscape/companies/{slug}.md`
- People cards: `landscape/people/{slug}.md`
- Trial cards: `landscape/trials/{nct-id}.md`
- Paper cards: `landscape/papers/{slug}.md`
- Watchlist: `landscape/companies/_watchlist.md`
- Thematic memos: `memos/{YYYY-MM-DD}-{slug}.md`
- Discovery triage inboxes: `private/_inbox-{date}-{focus}.md` (gitignored)

## Before any public push

1. Review `git log` and `git diff` for any leaked raw provider or CRM content.
2. Confirm `private/` is gitignored (test: `git check-ignore private/anything.json` should output the path).
3. Run `bash scripts/preflight.sh` and resolve any FAIL.
4. Confirm every new factual claim has a citation.

## Operating reminders

- Append, do not overwrite (CRM notes, the `Outreach notes` sections of cards, and the `_watchlist.md` tables).
- Tag every new card with `discovery_date` and `source_of_discovery`.
- When in doubt about category assignment, choose the closest fit and add an entry to `docs/decisions.md`.

## Resume protocol (for a new session)

Read in this order: `README.md`, then `docs/thesis.example.md`, then the most recent ADRs in `docs/decisions.md`, then `git log --oneline -20`. Then state the intended next action in one or two sentences before making any changes.
