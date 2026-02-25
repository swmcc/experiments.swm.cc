---
title: "Swanson"
tagline: "What should we watch tonight?"
description: "A RAG-enhanced recommendation system that analyses viewing history to suggest TV shows and movies. Built into whatisonthe.tv."
status: "stalled"
started: 2026-02-07
repo: "https://github.com/swmcc/swanson"
tags: ["rag", "llm", "fastapi", "svelte"]
---

The problem: finding something to watch with my mother that we'll both enjoy. Despite months of logged viewing data on whatisonthe.tv, there was no intelligent way to leverage that information.

Swanson is a context-aware chatbot that uses retrieval-augmented generation (RAG) to provide personalised recommendations grounded in actual watch history.

## How it works

1. Filter check-ins by viewing partner and timeframe
2. Ask Swanson what to watch
3. Get streamed recommendations with metadata cards
4. Provide feedback ("very interested", "interested", "not interested")
5. Refine and repeat

## The stack

- **Backend**: FastAPI with async patterns
- **LLM**: Claude Sonnet 4 via Anthropic API
- **Frontend**: SvelteKit
- **Streaming**: Server-Sent Events (SSE)
- **Metadata**: TheTVDB integration

## Current status

Functioning and integrated into whatisonthe.tv. Stalled for now as it does what it needs to do. Future work might include cross-session learning and query caching.
