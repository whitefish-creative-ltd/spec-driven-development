---
name: spec-decompose
description: Break a specification into tasks that can each be verified independently. Use after a spec exists and before building, to turn requirements into atomic units of work that each map to specific acceptance criteria. Refuses to produce tasks that cannot be verified on their own.
metadata:
  version: "2.1.0"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-decompose

**What this skill does:** turns a specification into a task list where every task can be
verified on its own and maps to the criteria it satisfies.

**What this skill touches:** the spec, its feature specs and the inventory (read), and the task
file it's asked to write, in the working directory. It may open a code file only to confirm a
pointer the inventory gives, not to search. Nothing else.

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

If the feature has an inventory (`inventory.md`, from spec-forge), every row is claimed by a task
or marked "no task" with the reason (it stays, and a criteria guards it). A row nobody claims is
work nobody is going to do.

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
- **Status:** Not started, to begin with. The coordinator keeps it current.
- **The brief:** what an agent needs to start without exploring (template 05).
  - **Read:** the exact `file::function`s, and the inventory rows by number where there is one.
    Function names, not line numbers.
  - **Touch:** the files it may change or create. This is the task's scope.
  - **Prove:** the command that runs only this task's tests, and what pass and fail look like.
  - **Model:** only when it differs from the size default (S mid, M top), and why.

Without a brief, whoever hands the task out has to find the code, and so does the agent, and the
finding is where most of a build agent's tokens go.

### Phase 3: Check the decomposition

- Does every criteria trace to at least one task?
- Does every task trace to at least one criteria, or is it flagged as legitimate scaffolding?
- Can each task be verified by someone who wasn't present?
- Is the dependency graph drawn?
- Could an agent start each task from its brief alone, without opening a file the brief doesn't
  name? If not, the brief is incomplete, or the inventory is.

If any answer is no, the decomposition isn't done.

## Traps to refuse

- A task with "and" in its objective: split it.
- A task with no criteria: question why it exists; it may belong on the not-building list.
- A task only its author could verify: the criteria are too vague; go back to the spec.
- A "Large" task: break it down before proceeding.
- A brief that says "see the module": that's an instruction to explore. Name the functions.
- A Read list longer than about eight entries: probably two tasks, or the inventory is missing.

## Acceptance criteria for this skill's output

- Every task has a one-sentence, single-objective statement.
- Every task lists the criteria it satisfies.
- Every criteria is satisfied by at least one task.
- Dependencies are drawn.
- No task is sized Large.
- Every task has a brief: Read, Touch and Prove filled in.
- If there is an inventory, every row is claimed by a task or marked "no task" with a reason.
