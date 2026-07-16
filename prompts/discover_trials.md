# Discover Trials (ClinicalTrials.gov)

Secondary track. Use this prompt to discover and triage AI-relevant clinical trials with LMIC sites or sponsors.

## When to use this

You want to populate `landscape/trials/` with notable trials, especially as forward signals on what disease areas or modalities are gaining traction in LMIC settings.

## Inputs to provide

- **Disease area or AI modality** (required)
- **Country filter** (optional; defaults to LMICs per `taxonomy/lmic.yaml`)
- **Date range** (optional; defaults to trials registered in the last 24 months)

## Tools

- ClinicalTrials.gov MCP:
  - `search_trials`: keyword search
  - `search_by_sponsor`: by named sponsor org
  - `search_investigators`: by named PI
  - `get_trial_details`: full record for a given NCT ID

## Process

1. Search trials matching the disease area or modality. Filter for AI-relevant keywords in title, condition, intervention, or detailed description ("artificial intelligence," "machine learning," "deep learning," "computer vision," "predictive model," named modality-specific terms)
2. Filter by country (sponsor location or site countries) against `taxonomy/lmic.yaml`
3. Apply triage:
   - **Notable**: peer-reviewed protocol, multi-site or large single-site, named sponsor, AI clearly central to the intervention → create a trial card
   - **Watch**: AI mentioned but secondary, single-site, or thin protocol → log in a watchlist
   - **Skip**: AI is incidental or trial is post-marketing observational with weak design

## Output

For notable trials: create `landscape/trials/{NCT-id}.md` matching the trial card schema in `docs/card_schema.md`.

## Linking

If the trial's sponsor or PI appears in `landscape/companies/` or `landscape/people/`, set the front-matter `sponsor_org_slugs` and `pi_slugs` fields. If they don't yet, consider whether the PI is worth a `landscape/people/` entry via `prompts/enrich_person.md`.
