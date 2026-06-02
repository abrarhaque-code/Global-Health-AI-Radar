# AI x Global Health Radar

A git-native horizon-scanning workbench for AI in global health, driven by [Claude Code](https://claude.com/claude-code) and MCP connectors. Point it at a thesis and an AI agent maps the field into cited, scored, version-controlled briefs you can diff, audit, and share. Built for strategic foresight: reproducible, source-anchored landscape analysis instead of a black box.

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Built with Claude Code](https://img.shields.io/badge/built%20with-Claude%20Code-d97757)
![PRs welcome](https://img.shields.io/badge/PRs-welcome-success)

This instance is configured for **AI for global health in low- and middle-income countries (LMICs)**. The methodology and tooling are general: swap the thesis, taxonomy, and scoring to point it at any fast-moving field.

> The companies, people, trials, papers, and memos in `landscape/` and `memos/` are fictional illustrations. All names and data are invented and sources are placeholders. Replace them with your own.

## Why this exists

Scanning a fast-moving field usually lives in spreadsheets, a CRM, and someone's head. AI x Global Health Radar turns horizon scanning into a versioned, reviewable, citation-backed artifact:

- Every opportunity is a markdown card with a citation on every factual claim.
- Claude Code does the research across reference connectors (private-market data, PubMed, ClinicalTrials.gov, a CRM, web search).
- Raw provider data and CRM exports never enter git. Only synthesized, cited cards do.
- No database and no backend to run. The repo is the product.

## How it works

Every candidate runs through the same five-step loop (full walkthrough in `docs/workflow.md`):

```
[1. Discovery: cast wide]      fan out across data sources for one theme
        |
[2. Triage: two gates]         mission alignment + investability; bias toward inclusion
        |
[3. Enrichment: build card]    pull from all sources, write to schema, cite every claim
        |
[4. Vetting: score]            1-5 impact + 1-5 investability, evidence-driven
        |
[5. Action: outreach or watch] draft outreach for strong fits; watchlist the rest
```

You run it. Claude Code with MCP connectors executes each step.

## Quickstart

1. Clone this repo and open it in Claude Code (CLI, desktop, web, or an IDE extension).
2. Configure the MCP connectors you want (see [Connectors](#connectors)). PubMed, ClinicalTrials.gov, and web search are free; the private-market data provider and CRM are optional.
3. Edit `docs/thesis.example.md` to describe your thesis, then align `taxonomy/themes.yaml` and `taxonomy/capital_partners.yaml` to match.
4. Run a discovery sweep: open `prompts/discover_by_theme.md` and follow it for one theme.
5. Enrich a candidate into a card: `prompts/enrich_company.md`. Score it: `prompts/score_relevance.md`.
6. Draft outreach for strong fits: `prompts/draft_outreach.md`. Sync with your CRM: `prompts/export_to_attio.md`.
7. Before sharing publicly, run `bash scripts/preflight.sh`.

## Repository structure

```
ai-global-health-radar/
├── README.md                 this file
├── CLAUDE.md                 project guide for Claude Code
├── LICENSE                   MIT
├── CONTRIBUTING.md           contributor guide
├── docs/
│   ├── thesis.example.md     example thesis the config operationalizes (replace this)
│   ├── methodology.md        scope, exclusions, two gates, scoring, source biases
│   ├── card_schema.md        opportunity card front-matter and body structure
│   ├── scoring_rubric.md     1-5 impact and investability rubrics
│   ├── workflow.md           the 5-step loop with worked examples
│   ├── attio_mapping.md      card to CRM field mapping (reference: Attio)
│   ├── themes_overview.md    map of the example themes
│   ├── decisions.md          architecture decision records (ADR log)
│   └── known_limitations.md  method-level limitations and biases
├── prompts/                  16 reusable discovery, enrichment, scoring, outreach, sync prompts
├── taxonomy/                 example config: categories, themes, stages, partners, signals
├── landscape/
│   ├── companies/            opportunity cards (+ _watchlist.md)
│   ├── people/               founder and operator cards
│   ├── trials/               clinical trial cards (secondary track)
│   ├── papers/               research paper cards (secondary track)
│   └── INDEX.md              browsable master table
├── memos/                    thematic deep-dives
├── outreach/
│   └── log.md                redacted aggregate counts only (real content lives in the CRM)
├── scripts/
│   └── preflight.sh          pre-push hygiene checks
└── .github/workflows/
    └── preflight.yml         runs preflight on pull requests
```

## The two gates and scoring

A candidate earns a full card when it passes two gates at Triage:

1. **Mission alignment**: the thesis driver is real AND the company can deliver the impact the thesis cares about.
2. **Investability potential**: a real company, identifiable founders, an asset or trajectory.

Cards then get a 1-5 impact score and a 1-5 investability score, each defended with cited evidence, plus a `fit_rating` of `likely_fit`, `adjacent`, `monitor_only`, or `out_of_scope`. See `docs/scoring_rubric.md` and `docs/methodology.md`.

## Adapt it to your domain

The framework is domain-agnostic. To repoint it:

1. Rewrite `docs/thesis.example.md` as your thesis.
2. Edit `taxonomy/themes.yaml` (your themes), `taxonomy/capital_partners.yaml` (your relevant investors and partners), and the other taxonomy files.
3. Adjust the impact axis in `docs/scoring_rubric.md` to your impact definition (the investability axis is largely portable).
4. Swap connectors in the prompt tool sequences if you use different data sources or CRM.
5. Clear the fictional cards in `landscape/` and `memos/`, keep the schema.

The global-health/LMIC example is one instantiation. The card schema, the two gates, the 5-step loop, and the CRM-sync pattern carry over to any thesis-driven sourcing problem.

## Connectors

Reference implementation, all pluggable:

| Role | Reference connector | Swap for |
|------|--------------------|----------|
| Private-market data | PitchBook | Crunchbase, Dealroom, manual entry |
| CRM | Attio | Airtable, Notion, HubSpot |
| Biomedical literature | PubMed | (public, free) |
| Clinical trials | ClinicalTrials.gov | (public, free) |
| Preprints | bioRxiv / medRxiv | (public, free) |
| Everything else | Web search | any web search MCP |

## Privacy model

The repo is built to be shared without leaking confidential data:

- `private/` is gitignored. Raw provider pulls, CRM exports, and discovery inboxes live there.
- The `*-private.md` filename pattern is also gitignored.
- Cards may carry opaque provider record IDs as private references; the underlying data is never committed.
- Outreach content lives in the CRM. Only aggregate, redacted counts go in `outreach/log.md`.
- `scripts/preflight.sh` scans for leaked tokens and writing-rule violations before a push.

## Prompt library

| Request | Prompt |
|---------|--------|
| Build the universe for a theme | `prompts/discover_by_theme.md` |
| Enrich a known company | `prompts/enrich_company.md` |
| Score a card against the rubric | `prompts/score_relevance.md` |
| Draft outreach | `prompts/draft_outreach.md` |
| Push cards to the CRM | `prompts/export_to_attio.md` |
| Pull CRM updates back | `prompts/sync_from_attio.md` |
| Write a thematic memo | `prompts/thematic_memo.md` |
| Discover trials or papers | `prompts/discover_trials.md`, `prompts/discover_papers.md` |
| Enrich a person | `prompts/enrich_person.md` |
| Validate cards before export | `prompts/validate_attio_readiness.md` |
| Regenerate the master table | `prompts/render_master_table.md` |

## Contributing

Issues and pull requests are welcome. See `CONTRIBUTING.md`. Run `bash scripts/preflight.sh` before opening a PR.

## License

MIT. See `LICENSE`.
