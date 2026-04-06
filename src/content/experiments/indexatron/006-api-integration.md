---
title: "API Integration"
pubDate: 2026-04-06T00:00:00Z
pr: "https://github.com/swmcc/indexatron/pull/6"
snapshot: "https://github.com/swmcc/indexatron/tree/feature/api-service"
tags: ["python", "api", "production"]
---

Production integration with the-mcculloughs.org Rails app.

## Changes

- API client for fetching pending uploads and posting results
- Context-aware prompting with metadata injection
- Family nickname resolution (aliases to real names)
- Era override from actual `date_taken`
- Safety filters for inappropriate terms
- Category limits to prevent repetition loops
- CLI with `--shortcode` for reprocessing
- Image resizing and WebP to JPG conversion

## Model Comparison

Tested LLaVA 7b vs Llama 3.2 Vision:

| Aspect | LLaVA 7b | Llama 3.2 Vision |
|--------|----------|------------------|
| Speed | ~27s/image | ~60s+/image |
| JSON Output | Mostly valid | Often malformed |
| Schema Adherence | Reliable | Repetition loops |
| Context Following | Good | Variable |

LLaVA 7b proved more reliable for structured extraction.

## Results

The service is now in production, automatically processing photos uploaded to the-mcculloughs.org.

See the [full write-up](https://swm.cc/writing/indexatron-context-aware-analysis/) for details on context-aware prompting.
