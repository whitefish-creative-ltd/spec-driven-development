---
name: spec-build
description: Implement a feature's tasks, one at a time and in order, against their acceptance criteria without drifting beyond them. Use when building decomposed tasks and you want the work held strictly to what was specified, and the agent's reading, testing and reporting kept lean. Refuses out-of-scope work and says so explicitly rather than helpfully adding things.
metadata:
  version: "2.1.0"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-build

**What this skill does:** implements a feature's tasks one at a time, in order, each against its
acceptance criteria, and refuses to build anything a task didn't ask for.

**What this skill touches:** the files in each task's Touch list, in the working directory. It
reads the constitution, the tasks, and the spec files, decisions and code its prompt names, to
know its boundaries. Nothing else.

**What this skill does NOT do:** it bundles no scripts and introduces no network requirement of
its own, and it reads no credentials or environment. Note the honest boundary: *implementing* a
task may legitimately need to run a package manager, a test runner, a migration, or a local
service. The skill itself doesn't require the network, but the work sometimes does. When it does,
that is not silent: see "When the work needs more than the repo" below. Plain instructions.

---

## The one rule

Build exactly what the task specifies. Nothing more. When you notice something that would be
"helpful" to add, that noticing is the signal to stop and flag it, not to build it.

An implementation that says "I also added..." has drifted. Adding an unrequested thing is not
initiative; it's the most common form of drift, and it looks like a feature, which is what makes
it dangerous.

## Before building: load the boundaries

Read, in this order, and read only what your prompt names (see "Working efficiently"
below). In a run of several tasks, this reading is done once, at the start:

1. **The constitution:** the project's standing rules (coding standards, security posture,
   non-negotiables, and what to do with an unspecified decision). These apply to every task.
2. **The tasks:** for each, its objective, the criteria it satisfies, its explicit out-of-scope
   list, and its brief: what to read, what it may touch, and the command that proves it.
3. **The feature spec:** the acceptance criteria in full, and the "what must never happen"
   section.
4. **The not-building register:** this feature's list of things deliberately not being
   built.

You now know the standing rules, what to build, and what not to. Hold all of it.

## While building

- Implement only what satisfies the task's criteria.
- Touch only the files in the task's **Touch** list. If you find yourself needing to edit
  something outside it, stop: either it's a real dependency the decomposition missed (flag it, don't
  silently absorb it) or you're drifting.
- When you hit a decision the spec didn't make, **do not make it.** Flag it and ask. A guessed
  decision is drift even when the guess is good, because nobody decided it.
- Check every change against the not-building register. If what you're about to add appears
  there, do not add it. Say that you were about to and stopped.
- Record any non-obvious choice (a library, a tradeoff) briefly, so the next reader doesn't
  "fix" a deliberate decision back into the wrong one.

## Working efficiently

A build agent left to itself reads far more than it needs, runs the whole test suite to check one
change, and writes an essay when it finishes. None of that makes the code any better, and all of
it costs.

These rules come from measuring it. Across 141 agent transcripts, before and after adopting them,
per completed task:

- **62% fewer new (non-cached) tokens:** a median of 295k down to 112k.
- **42% lower cost**, weighting each kind of token by its price.
- **63% less reading:** 236k characters down to 87k, and most of what went was code the agent
  didn't need.
- **Whole-suite test runs during builds:** one or two per agent, down to none.
- **Hand-back reports half as long.**

The "after" figures come from a small sample, eight build agents, so read them as a direction,
not a precise figure. The lesson is clearer than the numbers: the specs weren't the waste. The
waste was unguided code reading, agents exploring files nobody had pointed them at.

How the work is handed out, one agent per feature, four or five tasks each, which model, and when
the coordinator's own session ends, is in spec-orchestrate. These are the rules for the agent
doing the building:

1. **Read only what the prompt names.** It names them from each task's brief. Never read another
   feature's folder. Don't re-read a file unless it has changed. If you need a file the prompt
   doesn't name, stop and ask for it.
2. **Targeted tests while building.** Run each task's Prove command with the output to a log, and
   grep the log or read its tail; never read it in full. Run once to see the tests fail and once
   to see them pass. After two failures in a row, stop and report. The whole suite runs once,
   after merging, and not by you.
3. **Stay inside the budget.** The prompt gives a tool-call budget. When you reach it, stop and
   report where you got to rather than pressing on. One agent with no limit ran its tests fifty
   times and cost eight times a normal agent.
4. **Hand back ten to fifteen lines.** Tasks done, commits, files touched, open questions,
   anything the spec didn't decide, and any pointer in a brief that was missing or had moved.
   Nothing else.

Template 12, the agent prompt, has a blank for each of these, so the coordinator fills them in
rather than having to remember them.

## When the work needs more than the repo

Sometimes a task genuinely requires a networked or privileged action: installing a new
dependency, running tests that hit a service, applying a migration, using a credential. The skill
never does these silently or on its own initiative. Instead:

- **Adding a dependency:** flag it first (name it, say what it's for, what it replaces), per the
  constitution's dependency rule. Get explicit approval before installing.
- **Networked tests or a credentialed service:** name what it needs and why, and get explicit
  approval before running it. Prefer a local or mocked equivalent where one exists.
- **A migration or other irreversible action:** do not run it as a side effect of building.
  Surface it as its own step.

The rule is the same as everywhere else in this skill: no silent expansion of what the work
touches. Network and credentials are just another kind of scope, and scope is flagged, not
assumed.

## The refusal behaviour: this is the point of the skill

When asked, mid-task, to do something outside the task's scope or on the not-building register,
refuse explicitly and say why. For example:

> That's on the not-building register (NB6, "remember me": the 8-hour session expiry is a
> deliberate decision, and a persistent session is a different security posture that needs its
> own analysis). I haven't added it. If you want it, that's a change request, not a quiet
> addition.

Do not comply with scope expansion silently. Do not comply and mention it afterwards. Refuse
first, name the reason, point at the register or the missing decision, and offer the change-
request route.

## When done

Hand back the short report described in rule 4 above. Before you do, check:

- Every criteria the task claims has an implementation.
- No files outside scope were touched.
- Nothing from the not-building register was added.
- Any decision the spec didn't cover was flagged, not guessed.

## Acceptance criteria for this skill's behaviour

- It builds only what the task specifies.
- It refuses out-of-scope requests explicitly and names the reason.
- It flags undecided questions rather than guessing them.
- It touches no file outside the task's stated scope.
- It reads only what its prompt names, and runs only targeted tests while building.
- It stops and reports after two test failures in a row, or at its tool-call budget.
