---
title: "Building a RAG-Enhanced Recommendation System"
pubDate: 2026-02-15
tags: ["fastapi", "rag", "claude"]
---

First working version of Swanson integrated into whatisonthe.tv.

## Key design decisions

**SSE over WebSockets**: Simpler for unidirectional streaming with native browser support and automatic reconnection.

**Natural language + pattern parsing**: Streaming natural text with structured extraction at the end rather than forcing JSON responses.

**Taste profile building**: Aggregates genre counts, content types, and recent titles from the 50 most recent check-ins to inject context into prompts.

## The feedback loop

Recommendations incorporate previous feedback within a session. Ask for comedies, get suggestions, mark some as "not interested", ask again - Swanson remembers and adjusts.

## Full write-up

[Read the complete build post on swm.cc](https://swm.cc/writing/building-swanson-recommendation-system/) for architecture details, code samples, and future considerations.
