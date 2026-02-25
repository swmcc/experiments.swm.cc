---
title: "The Wire Graph"
tagline: "All the pieces matter"
description: "Mapping every connection in The Wire using AI-attributed transcripts and graph database analysis."
status: "active"
started: 2026-02-23
repo: "https://github.com/swmcc/the-board"
tags: ["graphs", "nlp", "tv"]
---

The Wire is one of the most intricate TV shows ever made. Characters weave in and out across five seasons, organisations rise and fall, and relationships shift in ways that are hard to track on a single viewing.

This experiment aims to map every connection - who talks to whom, who kills whom, who informs on whom - using a graph database. The challenge is that the raw transcripts don't have speaker labels, so the first phase uses AI to attribute every line to its speaker.

## The goal

Build a queryable graph of The Wire's social network. Answer questions like:

- What's the shortest path from Bubbles to Clay Davis?
- Who has the highest betweenness centrality (i.e., who connects different worlds)?
- How does the network evolve season by season?

## The approach

1. **Phase 1**: Scrape transcripts, use AI to attribute speakers
2. **Phase 2**: Design graph schema, load into Neo4j
3. **Phase 3**: Run network analysis queries
4. **Phase 4**: Visualise the results
