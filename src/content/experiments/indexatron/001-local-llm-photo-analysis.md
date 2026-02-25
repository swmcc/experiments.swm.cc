---
title: "Initial Setup: Local LLM Photo Analysis"
pubDate: 2025-11-20
tags: ["llm", "setup"]
---

First steps into local LLM-powered photo analysis. The goal: describe what's in a photo using AI running entirely on my own hardware.

## The stack

- **Model**: LLaVA (Large Language and Vision Assistant)
- **Hardware**: M1 Mac with 16GB RAM
- **Framework**: Ollama for easy model management

## First results

Surprisingly good. Fed it a random photo from my library:

> "A golden retriever sitting on a sandy beach at sunset. The dog appears happy and relaxed, with waves visible in the background. The lighting suggests late afternoon."

That's searchable. That's useful.

## Challenges discovered

1. **Speed**: About 5-10 seconds per image. For thousands of photos, this adds up.
2. **Memory**: Larger models give better descriptions but need more RAM.
3. **Consistency**: Same image can get slightly different descriptions on repeat runs.

## Next steps

- Batch processing pipeline
- SQLite for storing descriptions
- Simple search interface
