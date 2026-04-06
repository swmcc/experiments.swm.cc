---
title: "Indexatron"
tagline: "What's in my photos?"
description: "Teaching local LLMs to analyse family photos while preserving privacy. No cloud uploads, just Ollama and curiosity."
status: "active"
started: 2026-02-22
repo: "https://github.com/swmcc/indexatron"
writeup: "https://swm.cc/writing/indexatron-local-llm-photo-analysis/"
writeup2: "https://swm.cc/writing/indexatron-context-aware-analysis/"
note: "https://swm.cc/notes/the-llm-is-the-new-parser/"
tags: ["llm", "python", "ollama", "privacy"]
---

I have thousands of family photos. Finding specific ones is a nightmare. "That photo from the wedding with Uncle Dave" - good luck.

Cloud services can do this, but uploading family photos to third parties feels wrong. This experiment proves that locally-run LLMs can analyse photos with useful metadata extraction - no cloud required.

## The hypothesis

Local LLMs can analyse family photos with useful metadata extraction.

**Status: Confirmed.** Now integrated with [the-mcculloughs.org](https://github.com/swmcc/the-mcculloughs.org) for automated photo analysis.

## Current state

The service fetches pending uploads from the Rails app, analyses them with LLaVA, generates embeddings, and posts results back. Key learnings:

- **Context matters**: Injecting photo metadata (title, caption, date, gallery) into prompts dramatically improves results
- **LLaVA > Llama 3.2 Vision**: For structured JSON extraction, the smaller model is more reliable (no repetition loops)
- **Override when you know better**: Use actual `date_taken` instead of AI guessing from visual cues
- **Defensive parsing**: Vision models produce unexpected outputs; robust JSON repair is essential

## The stack

- **Runtime**: Ollama
- **Vision Model**: LLaVA:7b (~4.7GB)
- **Embeddings**: nomic-embed-text (~274MB)
- **Language**: Python 3.11+ with pydantic, httpx, Pillow, Rich

## What it does

Feed it a photo, get back:
- Subject identification (people, objects, brands)
- Scene categorisation
- Era estimation (or override with actual date)
- Family nickname resolution ("Mamie" -> "Isobel McCullough")
- 768-dimensional semantic embeddings
- Context-aware analysis using photo metadata

## Next

- Make this a proper background service (systemd/launchd)
- [Search API](https://github.com/swmcc/the-mcculloughs.org/issues/99) - query by person, category, decade
- Semantic search using embeddings - find similar photos
