---
title: "Image Analysis with LLaVA"
pubDate: 2026-02-22T10:55:33Z
pr: "https://github.com/swmcc/indexatron/pull/2"
snapshot: "https://github.com/swmcc/indexatron/tree/03-image-analysis"
tags: ["python", "ollama", "llava"]
---

LLaVA-powered photo analysis with structured output.

## Changes

- PhotoAnalyzer class using llava:7b
- Pydantic models for structured analysis
- Single image analysis script
- Test images from Rails gallery

## Results

LLaVA successfully analyses photos and extracts:
- Description
- Location
- People count
- Categories
- Era estimation
- Mood

**Sample output:**

> "A tan-colored Labrador Retriever sitting on wooden floor indoors"
> Categories: ["dog"], Mood: calm

JSON output with robust parsing handles LLM quirks nicely.
