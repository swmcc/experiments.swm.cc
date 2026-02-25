---
title: "Teaching Local LLMs to See Family Photos"
pubDate: 2026-02-22
pr: "https://github.com/swmcc/indexatron/pull/2"
tags: ["python", "ollama", "llava"]
---

The first proper test run. Three family photos through LLaVA:7b running locally on Ollama.

## Results

| Metric | Result |
|--------|--------|
| Images Processed | 3/3 |
| Failed | 0 |
| Total Time | 40.82 seconds |
| Average per Image | ~13.6 seconds |

## What it got right

- Identified a tan Labrador on a wooden floor, mood: calm
- Recognised a Kingfisher beer bottle in a restaurant setting
- Detected a wedding reception, estimated era: 2010s

## What needs work

- LLaVA produces inconsistent JSON requiring repair logic
- Some hallucinations (mentioning non-existent items)
- Real-time analysis impractical without GPU acceleration

## Full write-up

[Read the full post on swm.cc](https://swm.cc/writing/indexatron-local-llm-photo-analysis/) for the complete methodology, code samples, and conclusions.
