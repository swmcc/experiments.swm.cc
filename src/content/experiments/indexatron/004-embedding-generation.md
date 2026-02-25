---
title: "Embedding Generation"
pubDate: 2026-02-22T10:31:00Z
pr: "https://github.com/swmcc/indexatron/pull/3"
snapshot: "https://github.com/swmcc/indexatron/tree/04-embedding-generation"
tags: ["python", "embeddings", "nomic"]
---

768-dimensional embeddings for similarity search.

## Changes

- EmbeddingGenerator using nomic-embed-text
- Embedding script for single images
- JSON array output format

## Results

- 768-dim embeddings generated from analysis descriptions
- Ready for pgvector integration
- Semantic similarity search enabled

**Sample embedding (first 5 dims):**

```json
[-0.00841117, 0.042269547, -0.17771065, -0.059619118, 0.024270566]
```
