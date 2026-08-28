---
title: "The initial page, archived"
pubDate: 2026-08-05T00:00:00.000Z
snapshot: "https://github.com/swmcc/experiments.swm.cc/blob/main/src/content/experiments/thrawn/2026-08-05-initial-page.md"
tags: ["archive"]
---

*This is the thrawn experiment page exactly as it stood before the 28 August 2026 amendment, kept so the initial framing, the walkthrough and the harsh assessment stay on the record. The [live page](/thrawn/) has since moved on.*

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
and judging what comes back. Thrawn is the orchestrator: give it a GitHub or
GitLab ticket, or just a markdown brief, and it:

1. **Deep-thinks** a plan with a strong model that explores the repo read-only
2. **Splits** the work into parallel tasks, each routed to the right
   model for its complexity (opus for design work, haiku for mechanical edits,
   codex or a local model where they fit)
3. **Spawns** one agent per task, each in an isolated git worktree
4. **Merges** the task branches, hands conflicts to an integrator agent, and
   runs the repo's real checks
5. **Gates** shipping behind a one-time code. Nothing is pushed until I've
   seen the green board and typed it

It is tightly coupled to my [herdr](https://github.com/swmcc/agentic-development/tree/main/herdr)
setup, the terminal orchestration layer that gives every project a space and
every agent a home. When thrawn spawns tasks, **each task gets its own tab**,
so I can click through and watch exactly what each agent is doing rather than
trusting a black box: every file it reads, every command it runs, every excuse
it makes.

![herdr running my projects: spaces down the left, agents grouped below, and a tab per session across the top](/thrawn-herdr.png)

That screenshot is the point of the coupling. The left rail is every project
with its current branch, the agents panel shows what's running where, and the
tab strip is one tab per working session. A thrawn run adds a tab per task:
five parallel agents means five tabs I can audit live.

## A full walkthrough

From ticket to PR. Issue #42 is "Add CSV export to reports".

**Step 0: recon** (once per repo). Caches a codebase brief so the planner
doesn't re-explore the repo on every run.

```
$ thrawn recon
thrawn surveying the terrain with fable-plan …
thrawn recon cached: .thrawn/recon.md
```

**Step 1: dispatch.** The deep-think is the slow part. The plan is rendered
in full and thrawn judges whether the ticket even deserves parallel execution
before asking for my approval:

```
$ thrawn 42
thrawn run gh-42: Add CSV export to reports
thrawn deep thinking with fable-plan … (this is the slow part)
thrawn plan: 3 task(s) → t1[opus], t2[haiku], t3[codex]

⚔ plan gh-42  Add filtered CSV export to reports
  branch: thrawn/gh-42-csv-export
  parallelism: 3 task(s) · critical path 2 · width 1.5
  t1  Export endpoint + CSV serializer   opus   high
  t2  Download button on report page     haiku  low
  t3  Endpoint tests incl. filters       codex  medium  (after t1)
  integration checks: make test · make lint
  pr: Add filtered CSV export to reports
  full plan: .thrawn/runs/gh-42/plan.json

thrawn happy with this plan — execute it? [y/N] y
```

Two gates fire here. The **width gate** computes tasks divided by critical
path: if the plan is really a to-do list in a trench coat (width below 2.0),
thrawn refuses to execute it and tells me to feed `plan.json` to a plain
Claude Code session instead. The deep-think isn't wasted, it just becomes a
very good brief. Then the **approval gate**: the full plan, laid out, and a
y/N before a single agent spawns.

**Step 2: execution.** Three worktrees, three agents, three herdr tabs. My
pane becomes the board:

```
⚔ thrawn — gh-42  Add filtered CSV export to reports
phase: working   base: main @ 3f9a21c8

  ◐ t1   Export endpoint + CSV serializer   opus    running   2m 10s
  ◐ t2   Download button on report page     haiku   running   2m 10s
  ○ t3   Endpoint tests incl. filters       codex   pending (after t1)
```

t1 and t2 run in parallel; t3 waits because the plan said so. Clicking a tab
shows that agent's live stream. This is where the herdr coupling pays for
itself, because "watch the agent work" is the difference between delegation
and abdication.

**Step 3: integrate.** When every task lands, thrawn merges the branches
into an integration worktree, hands any conflicts to an integrator agent, and
runs the repo's actual checks:

```
  ✔ t1   done   4m 02s   3 files
  ✔ t2   done   2m 41s   2 files
  ✔ t3   done   3m 15s   2 files

thrawn merging 3 branches → thrawn/gh-42-csv-export
thrawn checks: make test ✔ · make lint ✔

ALL GREEN   ship code: 482913
```

**Step 4: ship.** The one-time code is the hard gate. No agent can push;
only I can, by proving I looked:

```
$ thrawn ship gh-42 --code 482913
thrawn pushed thrawn/gh-42-csv-export
thrawn PR opened: Add filtered CSV export to reports (Closes #42)
```

When it goes wrong, and it does, `thrawn retry` reruns failed tasks,
`thrawn adopt` accepts work an agent did but forgot to commit, and
`thrawn abort` kills everything and deletes the worktrees.

## The harsh bit

I asked Claude for a brutal assessment of whether this tool is worth keeping.
It pulled the run ledger and the numbers don't flatter me:

- **Three days of real use: 11 runs, 8 shipped, 3 aborted.** It works. But
  **five of the eight shipped runs had exactly one task**. A parallel-agent
  orchestrator whose median run spawns one agent is a very expensive way to
  run `claude -p`. On those runs the deep-think, the worktree, the integrator
  and the merge machinery were pure overhead.
- **One ticket took four runs to ship**: three aborts, one of which had
  already spawned five agents before being scrapped. Parallel agents on one
  codebase fail at exactly the hard part, semantic conflicts the merge doesn't
  catch. Thrawn hands that hardest problem to its least reliable component,
  an "integrator agent".
- **The security posture is the worst thing about it.** Every runner bypasses
  its sandbox, because worktrees and sandboxes don't mix. The worktree
  isolates the *diff*, not the *blast radius*: five unsupervised agents with
  full access to my machine, network and credentials.
- **It's on a vendor treadmill.** Claude Code natively grows plan mode,
  subagents, worktree isolation and orchestration on someone else's payroll.
  A chunk of thrawn is a bespoke shadow of the vendor roadmap, devalued a
  little with every release.
- **And the pattern risk:** this is my third piece of agent tooling while the
  actual products sit in other repos. Tool-building is the most seductive form
  of procrastination available to a developer.

The gates in the walkthrough exist *because* of that assessment. The width
gate is the tool learning to say "you don't need me for this one". The
planner prompt now says a single-task plan is a legitimate, welcome outcome,
because inventing parallelism by splitting one coherent change across tasks
that touch the same files costs more than no split at all. Every verdict is
logged to `state.json`, so in 30 days the ledger (shipped-without-retry rate,
width per run) decides whether this survives, not my fondness for it.

## Why it might still be worth keeping

Here's the counter-argument, and it's the one I keep coming back to:
**thrawn's premise is that work decomposes into independent pieces, and
whether that's true is a property of the system, not the tool.**

My personal projects are mostly monoliths: Rails apps, Phoenix apps, static
sites. A ticket against a monolith usually *is* one coherent change; my own
data says roughly half my tickets don't decompose, and the width gate now
catches those. But **distributed systems decompose by construction**. Service
boundaries are task boundaries. Change an API contract and the producer, the
consumer, the contract tests and the infra config are genuinely independent,
independently testable pieces of work. Width of 2 or more isn't the lucky
case there, it's the default. Separate services also mean separate repos and
separate blast radii, which softens both the merge problem and the security
problem in one move.

I don't really have that in my personal projects. I do at work. So the honest
version of this experiment might be that the personal repos are the training
ground, where I calibrate the thresholds and burn the failure modes into
memory cheaply, and the real trial belongs on a distributed system, where the
tool's core bet is actually true. That's worth exploring too (policies
permitting).

## Status

Active, scope frozen. It gets 30 days of ledger data across my repos, then
the numbers decide. The plan approval gate, the width gate and the verdict
logging landed this week; the next post will be the verdict.
