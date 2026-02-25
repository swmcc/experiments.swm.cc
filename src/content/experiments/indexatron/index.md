---
title: "Indexatron"
tagline: "What's in my photos?"
description: "Teaching local LLMs to analyse family photos while preserving privacy. No cloud uploads, just Ollama and curiosity."
status: "active"
started: 2026-02-01
repo: "https://github.com/swmcc/indexatron"
writeup: "https://swm.cc/writing/indexatron-local-llm-photo-analysis/"
note: "https://swm.cc/notes/the-llm-is-the-new-parser/"
tags: ["llm", "python", "ollama", "privacy"]
---

I have thousands of family photos. Finding specific ones is a nightmare. "That photo from the wedding with Uncle Dave" - good luck.

Cloud services can do this, but uploading family photos to third parties feels wrong. This experiment proves that locally-run LLMs can analyse photos with useful metadata extraction - no cloud required.

## The hypothesis

Local LLMs can analyse family photos with useful metadata extraction.

**Status: Confirmed.**

## The stack

- **Runtime**: Ollama
- **Vision Model**: LLaVA:7b (~4.7GB)
- **Embeddings**: nomic-embed-text (~274MB)
- **Language**: Python 3.11+ with pydantic, Pillow, Rich

## What it does

Feed it a photo, get back:
- Subject identification (people, objects, brands)
- Scene categorisation
- Era estimation from visual cues
- 768-dimensional semantic embeddings for similarity search
