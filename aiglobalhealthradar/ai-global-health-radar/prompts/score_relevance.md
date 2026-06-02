# Apply LMIC Impact and Investability Scoring (v2)

Use this prompt after enrichment to apply the formal scoring rubrics from `docs/scoring_rubric.md` and set `fit_rating`.

## When to use this

- You have a card with full body content but want to recheck or apply scores systematically
- You're auditing existing cards for scoring drift
- A reviewer disagrees with an existing score and you want a structured second pass

## Inputs to provide

- **Path to the card file** (required), e.g., `landscape/companies/exampledx.md`

## Process

### 1. Read the card body in full

Pay specific attention to:
- "Where the impact lands"
- "Recent traction"
- "Proprietary data or distribution asset"
- "LMIC impact reasoning"
- "Open questions and risks"
- "Recent signals"
- Citation density (how many claims are anchored to sources)

### 2. LMIC impact score

Walk through the rubric levels in `docs/scoring_rubric.md`:

- **5 (Exceptional)**: multi-country LMIC deployment with documented outcomes
- **4 (Strong)**: active deployments in 2+ LMIC countries with traction signals
- **3 (Real but early)**: documented LMIC pilots or partnerships; limited scale
- **2 (Limited evidence)**: stated focus, limited concrete evidence
- **1 (Out of scope)**: no real LMIC operations

For each candidate level, ask: does the card cite specific evidence supporting this level? If not, the score does not reach this level.

**Sparse evidence does not auto-lower the score.** Evaluate against the rubric's evidence requirements, not the card's length.

### 3. Investability score

Walk through the rubric levels:

- **5**: stage-appropriate, strong team, defensible moat, capital-efficient or scientifically de-risked, clear fund fit
- **4**: most of the above with 1-2 open questions
- **3**: real but unclear team, traction, or moat; worth a conversation
- **2**: too early, wrong stage, weak moat, or unclear fit
- **1**: clear pass with documented reason

A pre-revenue biotech with credible scientific founders and NIH or foundation funding can score 4 if the evidence supports that level. Score is not auto-low because revenue is absent.

### 4. Set fit_rating

Use the mapping table from `docs/scoring_rubric.md`:

| LMIC impact | Investability | Suggested rating |
|-------------|---------------|------------------|
| 4 or 5 | 4 or 5 | `likely_fit` |
| 4 or 5 | 3 | `likely_fit` (with diligence first) |
| 3 | 4 or 5 | `likely_fit` or `adjacent` |
| 3 | 3 | `adjacent` |
| 2 | any | `monitor_only` |
| any | 2 | `monitor_only` |
| 1 | any | `out_of_scope` |

### 5. Update or recommend

Either:
- Update the card's front-matter (`lmic_impact_score`, `investability_score`, `fit_rating`, `outreach_status` if changed) directly, OR
- Output a recommendation block if human review is preferred before changing the card.

Recommendation format:

```markdown
## Scoring recommendation for {slug}

- LMIC impact: {current} → {proposed}
  - Evidence supporting {proposed}: {bullet points with citation IDs from card body}
- Investability: {current} → {proposed}
  - Evidence supporting {proposed}: {bullet points with citation IDs}
- fit_rating: {current} -> {proposed}
- Treatment: priority outreach / outreach with diligence / monitor / out_of_scope
- Notes: {anything reviewer should know}
```

## Anti-patterns to avoid

- Scoring above 3 on a dimension without specific evidence cited in the card body
- Padding evidence to justify a higher score (if the card doesn't support it, the card needs more enrichment, not a higher score)
- Letting a strong impression of a founder, fundraise, or recent press release override the rubric
- Auto-lowering the score because the card is short (sparse cards can be high-quality at their evidence level; mark `[uncertain]` fields explicitly)
- Setting `fit_rating: likely_fit` for a sub-3 score on either dimension (the rating is bounded by the scores)
