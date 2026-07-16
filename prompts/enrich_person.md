# Enrich Person (Founder, PI, or Clinical Lead)

Secondary. Use this prompt to create a focused profile of a notable person in the landscape (founder, PI, or clinical leader worth tracking individually).

## When to use this

- You've identified a notable founder or PI through company or trial enrichment
- Their profile is worth understanding independently (e.g., for warm-path mapping, spinout potential, or future board recruitment)

## Inputs to provide

- **Person's name** (required)
- **Current org** (optional)
- **Context**: what made them notable (e.g., "named PI on three TB AI trials in Sub-Saharan Africa," "co-founder of two prior global-health AI companies")

## Tools

- Private-market data provider (reference implementation: PitchBook; swap for Crunchbase, Dealroom, or manual entry) `pitchbook_get_team_members` (if associated with a portfolio-candidate company)
- PubMed `search_articles` filtered by author name
- Web search for talks, interviews, recent activity
- CRM (reference implementation: Attio; swap for Airtable, Notion, or HubSpot) `search-records` for an existing relationship

## Process

1. Pull PitchBook executive and team data (if applicable)
2. Pull recent publications and presentations
3. Identify linked entities (companies, trials, papers in the landscape) by slug
4. Note prior LMIC experience and clinical credentials
5. Note any warm-path connections via Attio

## Output

A people card at `landscape/people/{slug}.md` matching the people card schema in `docs/card_schema.md`. Slug format: `firstname-lastname` (e.g., `jane-doe`). For name conflicts, append a discriminator (institution short code or country).

## Writing rules

Same as company enrichment: no em dashes, no adjective stacking, citations on every factual claim, direct register.

## Usage note

Use selectively. Most people are covered well enough by the "Key people" section of a company card; create a standalone person card only when the person is notable beyond their company context (repeat founder, field-defining researcher, or an operator who appears across multiple tracked companies).
