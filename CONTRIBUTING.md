# Contributing to AI x Global Health Radar

Thanks for contributing. This is a domain-agnostic template for thesis-driven deal sourcing. It ships with "AI for global health in LMICs" as a worked example. Most contributions either improve the framework or improve the example content.

## How the repository is structured

The repository splits into framework and content.

Framework (the reusable engine, replace the example values with your own):

- `prompts/`: the discovery-to-action workflows Claude Code runs against MCP connectors.
- `taxonomy/`: controlled vocabularies (themes, AI categories, funding stages, disease areas, signal triggers, capital partners). These are example configuration.
- `docs/`: methodology, card schema, scoring rubric, workflow, and the example thesis.

Content (the cards the engine produces):

- `landscape/companies/`: full opportunity cards, one per company, plus `_watchlist.md` for lightweight rows.
- `landscape/people/`, `landscape/trials/`, `landscape/papers/`: lighter cards for people, trials, and publications.
- `landscape/INDEX.md`: a generated panoramic index. Do not hand-edit; regenerate it with `prompts/render_master_table.md`.
- `memos/`: thematic synthesis.
- `outreach/log.md`: aggregate, redacted activity counts only.

Example scaffolding files are prefixed `EXAMPLE-` so they are easy to find and delete when you adopt the template for your own thesis.

## How to add a prompt

1. Create `prompts/{verb}_{noun}.md`.
2. State when to use it, the inputs to provide, the tool sequence (name the MCP connectors), the output location, and anti-patterns.
3. Defer field and CRM-mapping questions to `docs/`. Prompts should not redefine the schema.
4. Add a row to the workflow table in `CLAUDE.md` and `README.md` if it is a top-level workflow.

## How to add a taxonomy entry

1. Open the relevant file in `taxonomy/` (for example `taxonomy/themes.yaml`).
2. Add the entry with a stable `id`, a `label`, and a short `description`. Keep IDs lowercase and snake_case.
3. If the change affects how cards are categorized or scored, record the decision in `docs/decisions.md`.
4. Update any example card that should reference the new entry.

## Writing rules (house style)

- No em dashes.
- No ellipses for rhetorical effect.
- No "It's not just X, it's Y" constructions.
- A citation on every factual claim. A claim without a source gets removed or flagged in review.
- Direct register, specific anchors (numbers, names, citations), no adjective stacking.

`scripts/preflight.sh` enforces the punctuation rules and a few others.

## Confidential and raw data

Never commit confidential or raw data. Raw provider pulls, CRM exports, unredacted outreach content, and discovery inboxes belong in the gitignored `private/` directory, never in a committed card. Cards may reference opaque record IDs as private references; body content synthesizes from public, cited sources.

## Before opening a pull request

1. Run `bash scripts/preflight.sh` from the repository root and resolve any FAIL.
2. Confirm `private/` is gitignored (`git check-ignore private/anything.json` should print the path).
3. Review your `git diff` for leaked raw provider or CRM content.
4. Confirm every new factual claim has a citation.
