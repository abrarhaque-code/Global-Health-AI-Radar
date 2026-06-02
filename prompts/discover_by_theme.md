# Discover Companies by Theme (Multi-Source Fan-out)

The workhorse prompt for building the investable universe. Run once per theme. Casts wide across all source channels, triages, and produces a candidate inbox in `private/`.

## When to use this

You're building the database for a specific theme (e.g., Theme 1: AI diagnostics in LMIC primary care). You want 50-200 candidate names from all sources, triaged into four buckets.

## Inputs to provide

- **Theme ID** (required): from `taxonomy/themes.yaml` (theme_1 through theme_7)
- **Optional sub-thread focus** (e.g., "TB chest X-ray" within Theme 1)
- **Optional geographic focus**: priority countries from `taxonomy/lmic.yaml` (defaults to all priority)
- **Lookback window** (default): 24-36 months for funding and news; 24 months for papers and trials

## Process

### Step 1: Multi-source fan-out (cast wide)

Run all of these where applicable. Bias toward inclusion.

**A. Private-market data provider** (reference implementation: PitchBook; swap for Crunchbase, Dealroom, or manual entry)
- `pitchbook_search` with industry tags matching the theme's `category` (see `taxonomy/ai_categories.yaml`)
- Geography filter: HQ in priority countries (`taxonomy/lmic.yaml`) OR mention of LMIC operations in description
- Stage filter: cast wide (pre-seed through Series C); stage filtering happens at vetting, not discovery
- Lookback: last priced round within 36 months
- For each candidate: `pitchbook_get_profile` for description and HQ

**B. Foundation grant databases (web search)**
- Major global-health funder grant databases (e.g., large philanthropic foundations, Wellcome Trust)
- Disease-specific and pandemic-preparedness funders (e.g., CEPI awardee lists)
- Government and multilateral grant trackers relevant to the theme
- For each: capture company name, grant amount, date, program

**C. PubMed**
- `search_articles`: theme's disease area + "Africa" / "India" / "Latin America" / specific country names
- `search_articles`: "machine learning" or "deep learning" + theme keyword + LMIC author affiliations
- For each notable paper: capture authors, affiliations, year, journal
- Cross-reference: are any authors associated with a company? Surface the company.

**D. ClinicalTrials.gov**
- `search_trials`: theme keywords (e.g., "AI tuberculosis," "deep learning ultrasound")
- Filter by site countries in priority list
- `search_by_sponsor` for known LMIC sponsors and corporate sponsors
- For each notable trial: capture sponsor name, PI name, sites

**E. News and press (web search)**
- Theme + "Africa funding" or "India Series A" or specific country + year
- Look for: funding announcements, partnership press releases, regulatory approvals
- Regional tech and biopharma trade press relevant to the theme's geographies

**F. Conference rosters (web search)**
- Regional health-tech summit speakers and exhibitors
- Global health and AI-for-health conference programs
- Sector-specific events with a relevant geographic track

**G. Thesis references**
- The thesis anchors (named companies) in `docs/thesis.example.md`
- The adjacency/watchlist (named companies) in `docs/thesis.example.md`
- Theme description in the thesis for additional examples

**H. CRM existing pipeline** (reference implementation: Attio; swap for Airtable, Notion, or HubSpot)
- `search-records` for companies tagged with the theme's disease area or AI category
- Surface any internal pipeline that should have a card

**I. Accelerator and incubator directories (web search)**
- Startup accelerator company directories filtered by Health/Bio plus recent batches; accelerator indexing often lags private-market data providers, so this catches new entrants early
- Demo-day rosters and launch posts for each recent batch
- Biotech-focused accelerator cohorts
- General health-tech accelerator cohorts
- Region-focused accelerators and fellowship programs in the theme's target geographies
- For each: capture company name, batch, one-line description, founder names, founding location, accelerator URL with fetch date
- Acknowledged bias: accelerator coverage often skews toward high-income-country hubs even when companies target LMICs. Cross-reference each candidate against Gate 1 (LMIC positioning) before promoting to Real Opportunity. An accelerator graduate that passes Gate 2 but fails Gate 1 on stated evidence goes to `monitor_only` until LMIC commitment is verified.

### Step 2: Deduplicate and consolidate

- Build a working list of unique company names
- For each, capture the source(s) of discovery in front-matter (`source_of_discovery` field)
- Note when one company surfaces from multiple channels (a strong signal)

### Step 3: Triage

For each candidate, a 5-10 minute pass against the two gates from `docs/methodology.md`:

1. **Mission alignment** (gate): AI is a meaningful product driver AND LMIC global health impact orientation
2. **Investability potential** (gate): real company, identifiable founders, asset or trajectory

Plus the exclusions-list check (foundation-model lab, API wrapper, HIC-only, surveillance, consumer wellness, D2C-only telehealth).

Bucket into:

- **Real opportunity** → queue for full enrichment via `prompts/enrich_company.md`
- **Adjacent** → lighter enrichment, watchlist tag in front-matter
- **Monitor only** → one-line entry in `landscape/companies/_watchlist.md`
- **Out of scope** → log reason in the inbox file; no card

**Bias toward inclusion.** If you can't immediately exclude, default to Real opportunity or Adjacent. The positive-signals list items are not gates at this stage.

### Step 4: Write candidate inbox

Output goes to `private/_inbox-{YYYY-MM-DD}-{theme}.md` (gitignored). Use the format:

```markdown
# Discovery Run: {Theme Label}, {Date}

## Sources used
- Private-market data provider search: {one-line summary of query + result count}
- Foundation grant DBs: {summary}
- PubMed: {summary}
- ClinicalTrials.gov: {summary}
- News and conferences: {summary}
- Thesis references: {summary}
- CRM existing pipeline: {summary}

## Real opportunity ({count})

- **{Company Name}** (HQ: {country}, sources: private-market data provider + news + thesis anchors)
  - Private-market record ID: {pb_id} (private reference)
  - One-sentence description: a sentence describing the product.
  - Why it qualifies: mission aligned (AI-native dx for TB in Kenya, deployed), real company (Series A, named founders)
  - Multi-source signal: yes (3 sources)
  - Next: enrich via `prompts/enrich_company.md`

## Adjacent ({count})

- **{Company Name}**: borderline because {specific reason: stage too early; LMIC commitment thin; AI is enabling not core}
  - Private-market record ID: {pb_id}
  - Next: lighter card, watchlist tag in front-matter

## Monitor only ({count})

- **{Company Name}**: brief reason (academic spinout pre-formation; too early; wrong region; product not yet defined)

## Out of scope ({count})

- **{Company Name}**: exclusion reason (HIC-only roadmap; surveillance tech; foundation-model lab without applied product; consumer wellness)
```

The user reviews the inbox and approves which Real opportunity and Adjacent candidates move to enrichment.

## Citation requirements

- Private-market data provider candidates reference record IDs (private; kept in `private/` only)
- News candidates reference URL + fetch date
- PubMed candidates reference PMIDs
- ClinicalTrials.gov candidates reference NCT IDs
- Thesis references cite the thesis anchors or the adjacency/watchlist in `docs/thesis.example.md`

## Anti-patterns to avoid

- Filtering aggressively at this stage (the operating principle is false positives at discovery; see `docs/methodology.md`)
- Including "AI"-buzzword-only companies without product-level AI (the mission-alignment gate still applies)
- Skipping PubMed because "we know the companies"; PubMed surfaces academic-spinout pipeline that the private-market data provider misses
- Padding the Real opportunity bucket with marginal cases (Adjacent is what marginal cases go into)
- Committing the inbox file to the repo (it lives in `private/` only because it may contain private-market data provider content)

## Hand-off to enrichment

After user approval of Real opportunity and Adjacent candidates, run `prompts/enrich_company.md` for each. Adjacent gets lighter enrichment (focus on the gate-relevant questions); Real opportunity gets full enrichment.
