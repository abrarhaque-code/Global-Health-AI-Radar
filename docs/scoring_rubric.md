# Scoring Rubric

Two 1-5 scores plus a `fit_rating` are required on every active opportunity card. Scores are evidence-driven. If the card does not cite evidence supporting a level, the score does not reach that level.

## LMIC impact score

**The question:** how directly and durably does this company drive measurable improvement in LMIC health outcomes?

**5: Exceptional**

- Multi-country LMIC deployment with documented patient outcomes
- LMIC patient population is the primary user base
- Partnerships with national health systems or major multilaterals (WHO, Global Fund, Gavi)
- Published outcome data showing real-world impact

Example: a tuberculosis screening AI deployed across 12 African countries via WHO partnership, with peer-reviewed outcome data showing a 40% increase in case detection.

**4: Strong**

- Active LMIC deployments in two or more countries with traction signals
- Either published outcomes or large pilot footprints
- Clear product-market fit indicator for LMIC users (retention, LMIC customer revenue, government adoption)

Example: a maternal-health AI in pilot deployment in three countries with positive interim data and a growing user base of frontline community health workers.

**3: Real but early**

- Documented LMIC pilots or partnerships
- Limited deployment scale or thin outcome evidence
- Credible go-to-market plan for LMIC focus, not just aspiration

Example: a Series A company with two country pilots and a signed national MOU; no published outcomes yet.

**2: Limited evidence**

- Stated LMIC focus with limited concrete deployment evidence
- HIC-headquartered with aspirational LMIC roadmap
- Or LMIC-headquartered but focused on HIC export markets

**1: Out of scope**

- No real LMIC operations
- Self-described "global" without evidence
- HIC-only despite stated intentions

## Investability score

**The question:** is this stage-appropriate, capital-efficient, and a credible fit for the fund's mandate?

**5: Strong fit, lean-in candidate**

- Stage-appropriate (Seed through Series C primary; pre-revenue acceptable if other signals are strong)
- Strong team with prior LMIC operating experience or deep clinical credentials
- Defensible moat (proprietary data, distribution channels, regulatory approvals, network effects, scientifically de-risked asset)
- Capital-efficient unit economics OR credible path to them OR validated scientific asset (for biotech)
- Clear fund fit (mandate, check size, geography)

**4: Strong fit, worth deep diligence**

- Most of the above with one or two open questions
- Worth a meeting and a follow-up diligence pass

**3: Interesting, needs more diligence**

- Real but unclear team, traction, or moat
- Worth a first conversation to learn more
- Specific risks that need to be addressed before further engagement

**2: Watchlist**

- Too early, wrong stage, weak moat, or unclear fit
- Track for future rounds

**1: Pass**

- Stage misfit, sector misfit, or clear fundamental weakness
- Document the pass reason

## On sparse evidence

Sparse evidence in a card does NOT automatically lower the score. A pre-revenue biotech with credible scientific founders and an NIH-funded preclinical asset can score 4 on investability if the rubric's evidence requirements are met at that level. The rubric requires evidence; it does not require a long card.

Sparse cards typically reflect:
- Companies that are genuinely early-stage with limited public footprint
- Companies in non-English-language markets with limited PubMed and news coverage
- Pre-product companies with strong scientific, operational, or partnership signals

In those cases: score what the cited evidence supports, mark unknown fields with `[uncertain]` in front-matter, and proceed. Confidence in the score scales with evidence depth.

## Fit rating

After applying both scores, set the `fit_rating` in front-matter:

| LMIC impact | Investability | Suggested rating |
|-------------|---------------|------------------|
| 4 or 5 | 4 or 5 | `likely_fit` (priority outreach) |
| 4 or 5 | 3 | `likely_fit` (with diligence first) |
| 3 | 4 or 5 | `likely_fit` or `adjacent` (judgment call) |
| 3 | 3 | `adjacent` |
| 2 | any | `monitor_only` |
| any | 2 | `monitor_only` |
| 1 | any | `out_of_scope` |

Definitions:

- **`likely_fit`**: meets both gates from `docs/methodology.md`; combined scoring is favorable; this is an active outreach candidate or near-term diligence target
- **`adjacent`**: meets one gate clearly; the other is borderline or scoring is middling; worth tracking
- **`monitor_only`**: meets gates but stage, geography, or sub-sector makes direct investment unlikely in this fund cycle
- **`out_of_scope`**: fails one or both gates per `docs/methodology.md`

## Anti-patterns

- Scoring 4 on LMIC impact for a company that "plans to expand into Africa" with no current operations
- Scoring 5 on investability for a strong company without checking that the round size and stage match the fund's typical entry
- Padding evidence to justify a higher score (refine the card, not the score)
- Auto-lowering the score because the card is short (sparse cards can be high-quality at their evidence level)
- Letting a strong personal impression of a founder override the rubric (score on evidence)
- Setting `fit_rating` to `likely_fit` for a sub-3 score on either dimension (the rating is bounded by the scores)
