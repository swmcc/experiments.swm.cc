---
title: "Phase 1: Transcript Attribution Pipeline"
pubDate: 2026-02-25
pr: "https://github.com/swmcc/the-board/pull/1"
tags: ["python", "ai"]
---

The first challenge: raw transcripts from subtitle sites have no speaker labels. Every line is just text with a timestamp. To build a social graph, I need to know who said what.

## The pipeline

Built two Python scripts:

1. **scrape.py** - Pulls raw transcripts from subslikescript.com
2. **attribute.py** - Uses AI to attribute each line to a speaker

The attribution works surprisingly well because:

- The AI knows The Wire extremely well from training data
- Speech patterns are distinctive per character (Omar's poetic threats vs Bunk's exasperated sighs)
- Episode context helps disambiguate similar-sounding characters

## Sample output

```json
{
  "episode": "S01E01",
  "title": "The Target",
  "total_lines": 571,
  "attributed": 568,
  "attribution_rate": "99.5%",
  "lines": [
    {"line_num": 1, "speaker": "McNulty", "text": "So, your boy's name is what?"},
    {"line_num": 2, "speaker": "Witness", "text": "Snot."},
    {"line_num": 3, "speaker": "McNulty", "text": "You called the guy Snot?"}
  ]
}
```

## Cost

Running Sonnet on all 60 episodes would cost around $15-25. Haiku brings that down to $2-3.

## Next steps

- Batch process all 60 episodes
- Design the Neo4j schema
- Start loading data
