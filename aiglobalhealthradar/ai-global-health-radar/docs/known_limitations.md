# Known Limitations

What AI x Global Health Radar does not do, what it gets wrong, and what you should not rely on it for. These are method-level limitations that hold regardless of the thesis you load.

## Source biases

The sources AI x Global Health Radar draws from each carry a systematic skew. None of them is neutral.

- **Private-market databases skew to VC-backed companies.** A private-market data provider indexes priced rounds and venture activity. Bootstrapped, founder-funded, and grant-funded companies are underrepresented, so the visible universe tilts toward companies that have raised institutional capital.
- **English-language bias.** A private-market data provider, PubMed, and web search all skew toward English-language coverage. Companies and research covered mainly in other languages are systematically missed.
- **ClinicalTrials.gov registration skew.** The registry is dominated by US- and EU-sponsored trials. Trials sponsored in lower-resource settings, and trials that are never registered, are underrepresented even when they are the most operationally relevant.
- **Foundation and grant database openness varies.** Some funders publish grantee data openly; others publish little. Coverage across funders is uneven, so a discovery pass over foundation portfolios reflects who discloses rather than who funds.
- **Recency bias.** A recent fundraise or partnership inflates apparent relevance. Companies that have gone quiet may be undervalued simply because nothing recent has been published about them.
- **Survivorship bias.** Failed and shut-down companies are systematically harder to find than survivors. The visible landscape therefore skews toward winners, which can make a category look more successful than it has been.

## LLM overclaiming risk

- Despite mandatory citations, AI-generated card content can contain subtle overclaiming or interpretation errors.
- Watch specifically for fabricated citations: invented PubMed PMIDs, trial NCT IDs, and executive names.
- Random spot-checks of cards against their cited sources are required; full verification of every claim on every card is not practical at scale.
- Where data is genuinely uncertain, cards mark fields with `[uncertain]` rather than hedging in prose or guessing.

## Scoring subjectivity

- Both 1-5 scores require interpretation of evidence, so two reviewers can reach different scores from the same card.
- Scoring drift over time is a real risk; periodic recalibration against the rubric in `docs/scoring_rubric.md` is required.
- New reviewers should score a small sample of existing cards and compare against the rubric examples before adding new cards.
- The scores are heuristics, not a quantitative ranking or prediction system.

## Coverage gaps

- **Non-English-language sources** are underrepresented across every connector, so companies covered mainly in other languages may never surface.
- **Unregistered clinical work** is missed by registry-driven discovery.
- **Bootstrapped or grant-funded companies** that have never appeared in a private-market database are missed by company-discovery prompts unless a foundation portfolio or referral surfaces them.
- **Stealth-stage companies** with no public footprint will not appear until they fundraise or publish.
- **Accelerator-directory skew** tilts toward higher-income geographies even when the companies target lower-resource markets; apply the relevant gate critically before promoting an accelerator candidate.

## Data freshness and staleness

- Cards reflect data as of the `last_updated` date in their front-matter, not the present.
- Provider fields can lag real-world events by weeks or months.
- Card refresh is a manual process; cards past a staleness threshold should be flagged for refresh during periodic review.
- A score and a `fit_rating` are point-in-time judgments; both can be stale even when the underlying facts have moved.

## Entity-resolution duplicates

- The same company can appear under multiple names across sources, producing near-duplicate cards.
- Resolution depends on a canonical name plus an `aliases` field and a periodic near-duplicate scan; none of this is automatic, so duplicates can persist until a review catches them.
- Merges must retain all source IDs from both originals, or a later pull can re-create the duplicate.

## Bias toward investable companies

- The workbench is built for investing. Academic projects, NGO pilots, and non-profit deployments are visible only through the secondary landscape track (trials, papers, watchlist).
- Strong impact from non-investable actors is therefore systematically underweighted. The bias is intentional but should be acknowledged when sharing the workbench.

## What this is not

- Not a substitute for direct conversations with founders and operators.
- Not a quantitative ranking or prediction system; the scores are heuristics.
- Not a regulatory or compliance review; investment decisions require formal diligence beyond this workbench.
- Not a competitive-intelligence tool; the focus is on what is possible, not on what competitors are doing.
- Not a substitute for in-market relationships and operating knowledge.
