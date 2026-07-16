# Write a Thematic Memo

Use this prompt to synthesize multiple opportunity cards, trial cards, and paper cards into a thematic deep-dive on a disease area, AI modality, or sub-sector.

## When to use this

- You want to share your view of an AI-for-health sub-sector with the team
- You want a public-facing artifact for the README or external sharing
- You've accumulated enough cards in a theme that synthesis is now possible (typically 8+ cards)

## Inputs to provide

- **Theme** (required): a theme ID from `taxonomy/themes.yaml` (theme_1 through theme_7) OR a sub-thread within a theme (e.g., "TB chest X-ray" within Theme 1) OR a disease area / AI modality if the cut is orthogonal to themes
- **Audience** (default: internal team; specify if external-ready)
- **Length target** (default: 800-1500 words)

## Recommended first thematic memos (in priority order)

Aligned to the lean-in themes from `docs/themes_overview.md`:

1. **Theme 1: AI-native diagnostics for LMIC primary care** (example anchor: `composite-tb-cxr`)
2. **Theme 2: African genomic and health data infrastructure** (example anchor: `composite-genomics-registry`)
3. **Theme 3: Manufacturing intelligence and cloud-lab infrastructure**

Selective and monitor themes come later, after the core cards are built out.

## Process

### Step 1: Collect

- Pull all company cards tagged with the theme (via front-matter `disease_areas` or `ai_modalities`)
- Pull all trial cards and paper cards tagged with the theme
- Note the count and date range covered

### Step 2: Cluster into threads

Identify three to five threads or sub-themes within the area. Examples for `tuberculosis`:

- AI for chest X-ray screening at scale
- Cough audio analysis for community screening
- Risk-stratification ML for active case finding
- AI-driven adherence and DOTS optimization

### Step 3: For each thread

- Name 3-5 representative companies (link to cards via relative paths)
- Summarize what's working: deployments, outcomes, customers
- Summarize what's risky: regulatory, technical, business model
- Identify gaps: what doesn't yet exist that should

### Step 4: Close with "What we'd back"

Profile of the kind of company that would be highest-priority for the fund. Stage, modality, market characteristic, founder profile. This is a forward-looking section, not a list of company names.

## Output

A markdown memo at `memos/{YYYY-MM-DD}-{theme-slug}.md`. Structure:

```markdown
# {Theme}: A View of the Space, {Date}

## What the space is

One paragraph framing the disease area or modality and why it matters in LMIC
context. Numbers where possible (burden of disease, current gaps, market size if
defensibly cited).

## What we've seen

Three to five sub-thematic sections. Each names representative companies with
one-sentence descriptions and links to underlying cards.

### Thread 1

- [Company A](../landscape/companies/company-a.md): one-sentence description
- [Company B](../landscape/companies/company-b.md): one-sentence description

### Thread 2

(...)

## What's working

Where we see real product-market fit, real deployments, real outcomes. Be specific
about which threads are gaining traction and what the evidence is.

## What's not (yet)

What's overhyped, what's stalled in academic mode, what's not finding LMIC fit.
Direct and candid; this is the most useful section.

## What we'd back

Profile of the kind of company that would be most attractive at our stage. Not
a wishlist of names.

## Open questions

What we don't know that would change our view. Things worth a conversation, a
diligence pass, or an expert call.

## Linked cards

- [Company slug](../landscape/companies/{slug}.md)
- [Trial NCT-ID](../landscape/trials/{nct-id}.md)
- [Paper PMID](../landscape/papers/{pmid}.md)
```

## Writing rules

- Zero em dashes
- Specific anchors throughout (companies, deployments, trial NCT IDs, paper PMIDs)
- Direct, candid register
- No "it's not just X, it's Y" constructions
- No hedge stacking

## Anti-patterns to avoid

- Generic "the market is large and growing" framing
- Listing companies without saying why they matter
- Hedging every observation
- Drawing conclusions from one or two data points
- Using private-market-provider proprietary content in a memo intended for external sharing (proprietary content stays in `private/` only)
