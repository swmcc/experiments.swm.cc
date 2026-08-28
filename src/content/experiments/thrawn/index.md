---
title: "Thrawn"
tagline: "Plan deeply, execute in parallel."
description: "An experiment in agentic development: a CLI that deep-plans a GitHub/GitLab ticket or a markdown brief, executes it as parallel agents in isolated git worktrees, and refuses to ship anything until a human types the code. Tightly coupled to my herdr terminal setup."
status: "active"
started: 2026-08-05
amended: 2026-08-28
repo: "https://github.com/swmcc/agentic-development/tree/main/thrawn"
links:
  - label: "Essay: Execution Stopped Being the Bottleneck"
    url: "https://swm.cc/writing/execution-stopped-being-the-bottleneck/"
  - label: "Essay: Your Architecture Is the Bottleneck, Not the Model"
    url: "https://swm.cc/writing/your-architecture-is-the-bottleneck/"
  - label: "How it's built: one Python file, no dependencies"
    url: "https://swm.cc/notes/building-thrawn-one-python-file/"
  - label: "Runner trial: method, scores and raw data"
    url: "https://github.com/swmcc/agentic-development/blob/main/thrawn/docs/runner-trial-14.md"
  - label: "The economics thread (issue #8)"
    url: "https://github.com/swmcc/agentic-development/issues/8"
tags: ["agents", "claude-code", "orchestration", "python", "herdr"]
cover: "/thrawn.jpg"
---

![The Thrawn agentic development workflow: intake, plan, execute in parallel, integrate, verify, ship](/thrawn.jpg)

## Who is Thrawn?

Grand Admiral Thrawn (Mitth'raw'nuruodo) is the Star Wars villain from Timothy
Zahn's *Heir to the Empire*, later canonised in *Rebels* and *Ahsoka*. He is
the only Imperial commander worth fearing because he doesn't rely on brute
force. He studies his enemy first, famously through their art, until he
understands how they think. Then he commits to a precise battle plan and
delegates the execution to his fleet. He wins through preparation and
orchestration, not firepower.

That's the pitch for this tool. It studies the repository read-only before
committing to anything, writes a battle plan, delegates the work to a fleet of
agents, and nothing ships without the admiral's sign-off. Naming it after a
tactician who occasionally loses spectacularly when his subordinates improvise
is, I admit, part of the joke.

## What this experiment is

This is an experiment in changing my workflow to be more *agentic*. Not
autocomplete, not pair-programming, but handing an entire ticket to a system
and judging what comes back. Thrawn is the orchestrator: give it one or more
GitHub or GitLab tickets, or just a markdown brief, and it:

1. **Deep-thinks** a plan with a strong model that explores the repo read-only
2. **Splits** the work into parallel tasks, each routed to the right
   model for its complexity (opus for design work, haiku for mechanical edits,
   codex, pi or a local model where they fit)
3. **Spawns** one agent per task, each in an isolated git worktree
4. **Merges** the task branches, hands conflicts to an integrator agent, and
   runs the repo's real checks
5. **Gates** shipping behind a one-time code. Nothing is pushed until I've
   seen the green board and typed it

There is also a lightweight **swarm mode** (`thrawn swarm 36 37 38 39`): no
planner, no integrator, just one worktree and one agent per issue with a
human as the orchestrator. It has turned out to be the workhorse, and it is
what made the runner trial below possible.

It is tightly coupled to my [herdr](https://github.com/swmcc/agentic-development/tree/main/herdr)
setup, the terminal orchestration layer that gives every project a space and
every agent a home. When thrawn spawns tasks, **each task gets its own pane**,
so I can click through and watch exactly what each agent is doing rather than
trusting a black box: every file it reads, every command it runs, every excuse
it makes.

![herdr running my projects: spaces down the left, agents grouped below, and a tab per session across the top](/thrawn-herdr.png)

## Where the experiment has been

The [initial version of this page](/thrawn/2026-08-05-initial-page/) is
archived in full, including the original walkthrough and a deliberately
harsh self-assessment from three days in ("a parallel-agent orchestrator
whose median run spawns one agent is a very expensive way to run
`claude -p`"). That assessment produced the width gate, the approval gate
and the verdict ledger, and the first essay,
[Your Architecture Is the Bottleneck, Not the Model](https://swm.cc/writing/your-architecture-is-the-bottleneck/),
came out of what the ledger said next: roughly half my tickets don't
decompose at all, and the constraint is the shape of the codebase rather
than the model.

## What has happened since: the runner economics trial

A friend warned that headless Claude workers "will never benefit from
caching" and would blow the bank, and recommended
[pi](https://pi.dev/) driving a GPT model on subscription instead. That
became [issue #8](https://github.com/swmcc/agentic-development/issues/8),
an analysis with an experiment attached, which was then ticketed out
properly and run on 28 August. The write-up is
[Execution Stopped Being the Bottleneck](https://swm.cc/writing/execution-stopped-being-the-bottleneck/);
the numbers live in the
[trial document](https://github.com/swmcc/agentic-development/blob/main/thrawn/docs/runner-trial-14.md).

The short version. Before the trial could run, the machinery it needed was
built as its own tickets: a real pi runner
([#10](https://github.com/swmcc/agentic-development/issues/10)), pi event
parsing for the activity ticker and panes
([#11](https://github.com/swmcc/agentic-development/issues/11)) and
per-task token usage recorded in state.json
([#12](https://github.com/swmcc/agentic-development/issues/12)). Then the
same five issues on
[rails_love_letter](https://github.com/swmcc/rails_love_letter) were
dispatched twice with `thrawn swarm`, once per runner, and every branch
went up as a PR so CI could referee: codex arms
[#58](https://github.com/swmcc/rails_love_letter/pull/58),
[#59](https://github.com/swmcc/rails_love_letter/pull/59),
[#60](https://github.com/swmcc/rails_love_letter/pull/60),
[#61](https://github.com/swmcc/rails_love_letter/pull/61) and
[#62](https://github.com/swmcc/rails_love_letter/pull/62), pi arms
[#63](https://github.com/swmcc/rails_love_letter/pull/63) to
[#67](https://github.com/swmcc/rails_love_letter/pull/67).

Both harnesses shipped credible work on all five issues. codex ran the
checks unprompted and went five for five green; pi skipped linting on two
branches but produced the single best branch of the ten and was the only
harness whose usage thrawn could record automatically. 85 percent of pi's
token volume turned out to be server-side cache reads, which is the
original warning dissolving on contact. Four codex arms and one pi arm
were merged, all five issues closed, and the project's entire game engine
followed through the same machinery the next morning.

## Done

- Runner trial phase 1, scored and merged
  ([#14](https://github.com/swmcc/agentic-development/issues/14))
- pi as a first-class runner with readable panes and usage capture
  ([#10](https://github.com/swmcc/agentic-development/issues/10),
  [#11](https://github.com/swmcc/agentic-development/issues/11),
  [#12](https://github.com/swmcc/agentic-development/issues/12))
- Batch dispatch: `thrawn 42 43 45` becomes one run planned together
  ([#3](https://github.com/swmcc/agentic-development/issues/3))
- Warm retries: same-runner retries resume the failed attempt's session
  instead of starting cold
  ([#13](https://github.com/swmcc/agentic-development/issues/13))
- Abort keeps the evidence: per-task patches and head commits are
  snapshotted before branches are deleted, a lesson learned via `git fsck`
  ([#15](https://github.com/swmcc/agentic-development/issues/15))
- Integration liveness on the board, so a healthy run and a hung one look
  different ([#2](https://github.com/swmcc/agentic-development/issues/2))

## Doing

- **Phase 2 of the runner trial**: pi and codex both sit in the planner's
  rotation for a fortnight of ordinary ungroomed work, the usage ledger
  records every task, and the final routing verdict gets written from
  those numbers ([#14](https://github.com/swmcc/agentic-development/issues/14),
  decision record in [#8](https://github.com/swmcc/agentic-development/issues/8))
- An explicit run-the-checks-before-committing step in the executor
  prompt, so pi's lint discipline is fixed going into phase 2
- Still open and honest about it: swarm tab detection outside a herdr pane
  ([#5](https://github.com/swmcc/agentic-development/issues/5)) and
  interactive agent sessions
  ([#7](https://github.com/swmcc/agentic-development/issues/7))

## Status

Active. The 30-day ledger trial continues, now with per-task token and
cost data feeding it. The thesis has sharpened twice: first from "which
model" to "which architecture", and now from "what does it cost" to
"who grooms the tickets and who reviews the branches". Execution stopped
being the bottleneck; the next post will be about what replaced it.
