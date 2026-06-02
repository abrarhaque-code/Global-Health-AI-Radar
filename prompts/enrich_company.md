# Enrich Company into a Full Opportunity Card (v2 Schema)

Use this prompt to take a company name (and ideally a private-market record ID) and produce a full opportunity card matching the v2 schema in `docs/card_schema.md`.

## When to use this

- A candidate from `discover_by_theme.md` was approved for enrichment
- You learned about a company from another channel (founder intro, news, peer fund)
- You're refreshing an existing card (older than 60 days per the methodology cadence)
- You're enriching one of the named anchor companies from the thesis anchors in `docs/thesis.example.md`

## Inputs to provide

- **Company name** (required)
- **Private-market record ID** (optional; the prompt searches if not provided)
- **Theme** (required for new cards): from `taxonomy/themes.yaml`
- **Existing context** (optional): warm intro available, prior conversation, source of discovery, recent news event that prompted this

## Tool sequence

### 1. Private-market data provider (reference implementation: PitchBook; swap for Crunchbase, Dealroom, or manual entry). Private; raw data stays in `private/` if cached.

- `pitchbook_search` if no record ID; pick the canonical match
- `pitchbook_get_profile`: description, HQ, sector, operating status
- `pitchbook_get_company_deals`: full priced-round history
- `pitchbook_get_team_members`: founders, executives, board, prior experience
- `pitchbook_get_company_investors`: lead and notable investors

### 2. Web search (public)

- Last 24 months of news, partnerships, regulatory progress
- Company website for product details, deployments, founders
- Local-language press for regional companies (AllAfrica, Reuters Africa, regional outlets)

### 3. PubMed

- `search_articles` by company name
- `search_articles` by founders and clinical advisors
- Pull validation studies and outcome data
- `find_related_articles` for the disease + AI modality combination

### 4. ClinicalTrials.gov

- `search_by_sponsor` for trials sponsored by the company
- `search_investigators` for trials by named clinical leads
- Note phase, status, sites, primary endpoint

### 5. Foundation grant databases (web)

- Search major global-health funder grant databases by company name (e.g., large philanthropic foundations, Wellcome Trust)
- Same for disease-specific and pandemic-preparedness funders (e.g., CEPI awardee lists)
- If a grant is found, log it as a signal in `recent_signals`

### 6. CRM (reference implementation: Attio; swap for Airtable, Notion, or HubSpot)

- `search-records` for any prior relationship
- If found, reference CRM record IDs (private) and incorporate context into "Outreach notes"

## Output

A markdown file at `landscape/companies/{slug}.md` matching the v2 schema in `docs/card_schema.md`.

### Required components

- Complete v2 YAML front-matter with all required fields, including the extended schema fields: `ai_category`, `technical_archetype`, `themes`, `proprietary_data_asset`, `clinical_validation_status`, `regulatory_status_by_market`, `source_of_discovery`, `discovery_date`, `revenue_signal`, `fit_rating`
- All body sections in order (including new sections: "Proprietary data or distribution asset," "Recent signals")
- Citations on every factual claim
- LMIC impact score (1-5) with paragraph defending the score
- Investability score (1-5) with paragraph defending the score
- `fit_rating` (`likely_fit` / `adjacent` / `monitor_only` / `out_of_scope`)
- `[uncertain]` markers where data is thin

## Quality bar

- No claim without a citation
- No "industry-leading," "transformative," "groundbreaking," or other adjective-heavy language without quantitative support
- No fabricated executive names, trial NCT IDs, or PubMed PMIDs; verify against actual sources
- If a required field cannot be determined from sources, mark `[uncertain]` (not guessing)
- Private-market-provider content does not enter the committed card; only opaque record IDs as private references

## Theme and category assignment

- Map to `ai_category` from `taxonomy/ai_categories.yaml` based on the company's primary value driver
- Assign `technical_archetype` (`ai_native` vs `ai_enabled`) based on whether AI is the product itself or a workflow overlay
- Tag `themes` from `taxonomy/themes.yaml`; a company can fit multiple themes
- If category or archetype assignment is ambiguous, choose the closest fit and add an entry to `docs/decisions.md` flagging the judgment call

## Fit rating

- **`likely_fit`**: meets both gates from `docs/methodology.md`; scoring suggests strong investment alignment
- **`adjacent`**: meets one gate clearly; the other is borderline; worth tracking
- **`monitor_only`**: meets gates but stage, geography, or sub-sector makes direct investment unlikely
- **`out_of_scope`**: fails one or both gates; document in `recent_signals` if surfacing in discovery scans

## Writing rules

- No em dashes (use commas, periods, semicolons, or parens)
- No ellipses
- No "It's not just X, it's Y" constructions
- Every claim about the company anchored to a specific source ID
- Direct, candid register

## Anti-patterns to avoid

- Copying private-market-provider description text verbatim into the public card (synthesize)
- Scoring above 3 on LMIC impact without specific deployment, partnership, or outcome evidence
- Inventing traction; sparse traction sections are accurate, not failures
- Padding the "Fit assessment" section (one honest paragraph beats three speculative ones)
- Including speculation about future fundraises or strategic moves (flag as open questions instead)

## Pre-Attio readiness check

Before handing the card off, walk it through the validation gate at `prompts/validate_attio_readiness.md`. The export prompt enforces this gate; running it once during enrichment catches the common gaps:

- Every extended-schema front-matter field is present (or marked `[uncertain]`).
- `lmic_impact_score` and `investability_score` each have a defending paragraph in the corresponding body section.
- `fit_rating` is one of the four valid values; same for `ai_category`, `technical_archetype`, `org_type`, `themes`, `funding_stage`, `ai_modalities`, `disease_areas`.
- `sources[]` is non-empty and every source id referenced in front-matter also appears in the body.
- Every `notable_investors` id resolves in `taxonomy/capital_partners.yaml`.
- No em dashes, ellipses, or banned tokens ("It's not just", "transformative", "industry-leading", "groundbreaking", "synergize") outside of quoted citations.
- A clean web source exists for the `domains` derivation rule in `docs/attio_mapping.md` (the first `sources[]` entry whose URL host token-matches the company name).

If the card is yellow, decide whether to ship as-is or fix; if red, fix before export. The validate prompt is a report, not an auto-fixer; remediation happens here.

## Hand-off

After the card is drafted:
- Optionally run `prompts/score_relevance.md` to validate scores against the rubric.
- Run `prompts/validate_attio_readiness.md` for this card; resolve any red findings.
- Run `prompts/export_to_attio.md --dry_run` to preview the CRM writes, then `--live`.
- If `fit_rating` is `likely_fit` and scores are 4+, queue for outreach drafting via `prompts/draft_outreach.md`.
- Regenerate the master table via `prompts/render_master_table.md` so `landscape/INDEX.md` reflects the new card.
