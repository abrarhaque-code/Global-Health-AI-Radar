# Discover Papers (PubMed and bioRxiv/medRxiv)

Secondary track. Use this prompt to discover and triage AI-relevant publications with LMIC author affiliations or LMIC patient populations.

## When to use this

You want to populate `landscape/papers/` with signal papers, especially as forward indicators of where research is moving and which PIs are worth tracking for potential spinouts.

## Inputs to provide

- **Disease area or AI modality** (required)
- **Date range** (optional; defaults to last 24 months)
- **Author affiliation country filter** (optional; defaults to "any LMIC")

## Tools

- PubMed MCP: `search_articles`, `find_related_articles`, `get_full_text_article`, `lookup_article_by_citation`
- bioRxiv/medRxiv MCP: `search_preprints`, `get_preprint`, `search_by_funder`

## Process

1. Search for AI-relevant papers in the disease area or modality
2. Filter for LMIC author affiliations or LMIC patient data
3. Triage:
   - **Notable**: original outcome data, large sample, LMIC population, AI central to the work → create a paper card
   - **Watch**: smaller-scale or AI-secondary → log in a watchlist
   - **Skip**: tangential, HIC-only, or methodology-only without primary data

## Output

For notable papers: create `landscape/papers/{slug}.md` matching the paper card schema in `docs/card_schema.md`. Slug format: `{first-author-lastname}-{year}-{short-topic}` (e.g., `kamau-2025-tb-screening`).

## Linking

If a paper's first or senior author appears in `landscape/people/`, set the `linked_people` field. If the author is at a notable institution doing repeated work in this area, consider creating a `landscape/people/` entry via `prompts/enrich_person.md`.

## Status

V1 stub. Expand in week 3-4.
