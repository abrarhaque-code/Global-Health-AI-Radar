# Draft Outreach Email

Use this prompt to draft a personalized, research-informed outreach email to a target at a company in the landscape.

## When to use this

A card has scored well (typically both scores 4+), you have decided to reach out, and you want a draft email that demonstrates genuine research without being either generic or fawning.

## Inputs to provide

- **Card slug** (required): the company you're reaching out to
- **Target person** (default: CEO; specify if reaching a different role like CTO, Chief Medical Officer, or a clinical lead)
- **Warm-path context** (optional): mutual connections, prior conversations, mutual investors, recent press the target produced, mutual portfolio companies

## Tool sequence

1. Read the target card at `landscape/companies/{slug}.md`
2. Read `outreach/log.md` to confirm this target has not been contacted in the last 90 days
3. CRM (reference implementation: Attio; swap for Airtable, Notion, or HubSpot) via `search-records`: check for a prior relationship with the target or company; if a prior conversation exists, surface it for context
4. Optional: web search for a recent post, talk, paper, or interview by the target person to use as an anchor

## Drafting process

### Step 1: Pick two specific anchors

Identify two specific elements to reference:

- **One anchor about the company's work**: a deployment, an outcome, a specific product feature, a partnership
- **One anchor about the target's background or recent activity**: a paper, a talk, a prior role, a recent post or interview

Both anchors must be verifiable from the card or a real source. No invented anchors.

### Step 2: Draft three short paragraphs

**Paragraph 1: Who you are and why now**
- Name, role, fund name (one-line firm description, e.g., "an investor in global public health"; replace with your own)
- One sentence anchor for why you're reaching out, specific to this company

**Paragraph 2: What caught your attention**
- The two specific anchors from Step 1
- Genuine curiosity, not flattery
- One question or observation that signals you read carefully

**Paragraph 3: Clear ask and low-friction CTA**
- A 20-30 minute conversation, framed as a learning conversation, not a pitch
- Offer two or three specific times or a scheduling link
- Brief sign-off

### Step 3: Strip the slop

Before producing the draft, remove:

- All em dashes (replace with commas, periods, semicolons)
- "It's not just X, it's Y" constructions
- "Transformative," "game-changing," "revolutionary," "cutting-edge," "innovative," "disruptive"
- "Just wanted to," "hope this finds you well," "circling back," "synergies"
- Any sentence over 30 words
- Adjective stacking ("incredible, impressive, fascinating work")

## Output

The draft email body only. No subject line in the draft (user writes the subject). Format ready to paste into email client. Total length: 120-180 words across three or four short paragraphs.

## Writing rules

- Zero em dashes
- No exclamation marks
- Average sentence length under 25 words
- Direct, peer-to-peer register
- Every claim about the company anchored to a specific element from the card or a verifiable source

## Anti-patterns to avoid

- Generic openers ("I came across your company and was impressed")
- Praising metrics that aren't actually impressive at this stage (e.g., "Congratulations on the seed round" reads as patronizing from an investor)
- Asking for a meeting before earning attention
- Mentioning the fund's portfolio companies as social proof (reads as flexing)
- Sending the same draft to multiple people at the same company
- Asking softball questions ("how can we help?")
- Closing with passive lines ("looking forward to hearing from you"); replace with specific availability

## After sending

Log the outreach in Attio:
1. Create or update a Person record for the target
2. Add a note linked to the record with the date, message summary (paraphrased, not the full email), and any warm-path context used
3. Update the card's `outreach_status` to `contacted`
4. Update the aggregate count in `outreach/log.md` at week's end (no individual names)

If the target replies:
- Log the reply in Attio as a note
- Update the card's `outreach_status` to `in_dialog`
- Schedule the follow-up

If no reply within 14 days:
- Decide on a single follow-up nudge (one paragraph, refer to the original)
- Or move on; do not loop

If the conversation leads to a meeting:
- Update `outreach_status` to `meeting_held` after the meeting
- Add a meeting note in Attio with key takeaways
- Decide on next action and reflect in card front-matter and notes
