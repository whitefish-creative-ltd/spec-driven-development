---
name: spec-decompose
description: Break a specification into tasks that can each be verified independently. Use after a spec exists and before building, to turn requirements into atomic units of work that each map to specific acceptance criteria. Refuses to produce tasks that cannot be verified on their own.
metadata:
  version: "1.0.0"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-decompose

**What this skill does:** turns a specification into a task list where every task can be
verified on its own and maps to the criteria it satisfies.

**What this skill touches:** the spec and its feature specs (read), and the task file it's asked
to write, in the working directory. Nothing else.

**What this skill does NOT do:** no scripts, no network, no environment or credential access,
nothing outside the working directory. Plain instructions.

---

## The one rule

If a task cannot be verified on its own, it is not a task. It is two tasks, or it is drawn
wrong. Redraw it.

Every other consideration here is subordinate to that. Do not decompose by size, by component,
or by convenience. Decompose by verifiability.

## Process

### Phase 1: Map criteria to work

Read the spec and its feature specs. List every acceptance criteria. For each, ask: what work
satisfies this, and could that work be confirmed finished without reference to any other
unfinished task?

### Phase 2: Draw the tasks

For each task, produce:

- **Objective:** one sentence. What is true when this is done that wasn't before. If the
  sentence needs an "and", split it into two tasks.
- **Satisfies:** the criteria IDs this task exists to meet. Every task points at criteria;
  every criteria is pointed at by some task. Anything unpointed-at is a finding, flag it.
- **Dependencies:** what must exist first. Draw the graph.
- **Out of scope for this task:** what belongs to a sibling task and must not be built here
  opportunistically.
- **Needs a human:** flag any decision requiring judgement, taste, or authority the task can't
  have (e.g. a default that changes a security posture).
- **Size:** Small (one sitting) or Medium (about a day). If you're tempted to write Large,
  that's not a size, it's a signal you haven't decomposed it yet. Break it down.

### Phase 3: Check the decomposition

- Does every criteria trace to at least one task?
- Does every task trace to at least one criteria, or is it flagged as legitimate scaffolding?
- Can each task be verified by someone who wasn't present?
- Is the dependency graph drawn?

If any answer is no, the decomposition isn't done.

## Traps to refuse

- A task with "and" in its objective: split it.
- A task with no criteria: question why it exists; it may belong on the not-building list.
- A task only its author could verify: the criteria are too vague; go back to the spec.
- A "Large" task: break it down before proceeding.

## Acceptance criteria for this skill's output

- Every task has a one-sentence, single-objective statement.
- Every task lists the criteria it satisfies.
- Every criteria is satisfied by at least one task.
- Dependencies are drawn.
- No task is sized Large.
