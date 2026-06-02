# Discover Companies (private-market-data-first; v1 narrow-filter variant)

A private-market data provider (reference implementation: PitchBook; swap for Crunchbase, Dealroom, or manual entry) is the primary source here.

**v2 note:** the canonical discovery prompt is now `prompts/discover_by_theme.md`, which fans out across the private-market data provider plus foundation grant DBs, PubMed, ClinicalTrials.gov, news, conferences, and thesis references. This file remains as a provider-only variant for cases where a quick provider-only scan is sufficient. The operating principle (false positives at Discovery; gates applied at Triage) is the same as `discover_by_theme.md`.

Use this prompt to discover candidate companies in a specific disease area or AI modality. Apply the two gates from `docs/methodology.md` at Triage, not at Discovery: bias toward inclusion. The positive-signals list items are confidence builders at Vetting, not gates at Discovery.

## When to use this

You want a quick provider-only scan for a specific disease area or modality, and you don't need the multi-source fan-out. For full theme discovery, use `prompts/discover_by_theme.md` instead.

## Inputs to provide

- **Disease area or AI modality** (required): one or two values from `taxonomy/disease_areas.yaml` or `taxonomy/ai_modalities.yaml`
- **Geographic focus** (optional): a region or country list from `taxonomy/lmic.yaml`; defaults to "any LMIC"
- **Stage filter** (default): Seed through Series C per `taxonomy/funding_stages.yaml`
- **Lookback window** (default): 36 months for `last_round_date`

## Process

### Step 1: Private-market data provider search

Call `pitchbook_search` with filters:
- Industry tags relevant to the disease area or modality (e.g., for `tuberculosis`: "diagnostics," "infectious disease," "medical devices," "healthcare IT," "AI/ML")
- Stage filter per the included stages list in `taxonomy/funding_stages.yaml`
- Last priced round within the lookback window

Pull the top 50-100 candidates ranked by recency of last priced round.

### Step 2: Per-candidate validation

For each candidate, call in this order:
- `pitchbook_get_profile`: company description, HQ country, sector, operating status
- `pitchbook_get_company_deals`: full priced-round history with dates, amounts, lead investors (provider stage tags can be misleading; the deals sequence is canonical)

For each candidate, apply the four screening criteria:

1. **Sector**: read the company description. Does the product depend on AI as a meaningful value driver? "Uses ML internally" is not enough; the customer-facing product must require AI.
2. **Impact**: check the description for LMIC operations, partnerships, or trial sites. If not visible in the provider data, queue a follow-up web search in Step 3.
3. **Stage**: validated by the deals call. Most recent priced round should be in the included list. Large seed rounds (over $10M) get flagged for review per `funding_stages.yaml`.
4. **Methodology fit**: not on the exclusions list (surveillance, HIC-only, military, drug discovery, non-AI digital health, per `docs/methodology.md`).

### Step 3: LMIC-evidence validation (web search)

For candidates that look promising on criteria 1, 3, 4 but lack visible LMIC evidence in PitchBook:
- Run a web search for the company name plus LMIC region terms ("Africa," "India," "Latin America," specific country names)
- Look for deployment announcements, government partnerships, trial registrations, regulatory filings
- If no public LMIC evidence emerges, downgrade to watchlist with a note

### Step 4: Triage

Assign each candidate to one of four buckets:

- **Real opportunity**: meets all four screening criteria; queue for enrichment via `prompts/enrich_company.md`
- **Watchlist**: interesting but fails one criterion (often LMIC evidence is thin or stage is borderline); track lightly
- **Not investable**: academic-only, wrong stage, or no LMIC story
- **Excluded**: out of scope per methodology

### Step 5: Output

Write a markdown candidate list at `private/_inbox-{YYYY-MM-DD}-{focus-slug}.md` (gitignored). Use the format below.

```markdown
# Discovery Run: {disease_area or modality}, {date}

## Real opportunity ({count})

- **{Company Name}** (HQ: {country}, last round: {date}, {stage}, ${amount})
  - PitchBook ID: {pb_id}
  - One-sentence description: ...
  - Why it qualifies: ...

## Watchlist ({count})

- **{Company Name}** (HQ, last round, stage, amount)
  - Why watchlist (which criterion is borderline): ...

## Not investable ({count})

- **{Company Name}** - reason

## Excluded ({count})

- **{Company Name}** - reason
```

The user reviews the inbox and approves which companies move to enrichment.

## Citation requirements

Every candidate must reference a PitchBook record ID (private, in `private/` only). LMIC operations evidence must reference a public URL with fetch date or a PubMed PMID.

## Anti-patterns to avoid

- Do not include "AI-keyword-only" companies without product-level AI; verify against the actual product description
- Do not include companies where LMIC operations are aspirational only ("planning to launch in Africa" with no current presence)
- Do not include Series D and later companies as "real opportunity" even if otherwise interesting; they belong on watchlist with a note
- Do not pad the "real opportunity" bucket; better to surface 5 strong candidates than 20 marginal ones
- Do not commit PitchBook content to the repo; the inbox file lives in `private/` only

## Hand-off to enrichment

After the user approves candidates, run `prompts/enrich_company.md` for each. Each enrichment produces a full opportunity card at `landscape/companies/{slug}.md`.
