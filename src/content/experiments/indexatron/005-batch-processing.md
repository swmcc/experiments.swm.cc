---
title: "Batch Processing"
pubDate: 2026-02-22T11:28:00Z
pr: "https://github.com/swmcc/indexatron/pull/4"
snapshot: "https://github.com/swmcc/indexatron/tree/05-batch-processing"
tags: ["python", "batch"]
---

Processing multiple images with progress tracking.

## Changes

- BatchProcessor class
- process_batch.py script
- Combined JSON output with timing metrics
- Skip existing functionality

## Results

| Metric | Result |
|--------|--------|
| Images Processed | 3/3 |
| Failed | 0 |
| Total Time | 40.82s |
| Average per Image | ~13.6s |

| Image | Detection | Time |
|-------|-----------|------|
| family_photo_03.jpg | Labrador Retriever | 14.7s |
| family_photo_02.jpg | Beer at restaurant (Kingfisher) | 14.2s |
| family_photo_01.jpg | Man at wedding, 2010s | 11.9s |

The hypothesis is confirmed: local LLMs can analyse family photos with useful metadata extraction.
