# Agent Prompt: [feature ID] [feature name], tasks [ID]-[NN] to [ID]-[NN]

**Coordinator:**
**Date:**
**Model:** small | mid | top *(small for bookkeeping, indexes and recording answers; mid for S
tasks and fix-ups; top for M tasks and audits)*

> The coordinator names the reading. The agent reads what is on this page and nothing else. Every
> blank left empty is a file the agent will go looking for, and that looking is where the money
> goes.

Fill in the blanks, delete the guidance in italics, and hand the agent everything inside the
fence.

```markdown
You are building feature [ID] ([feature name]) under the spec-driven method. Use the spec-build
skill if you have it.

## Your tasks

Build these in order, one at a time. Each is held to its own scope in `tasks.md`.

- [ID]-[NN]: [objective, one line]
- [ID]-[NN]: [objective, one line]

*(Four or five at most. More than that goes to a fresh agent, which starts from your report.)*

## Read these, and only these

Standing rules:
- `docs/spec/constitution.md`

Spec files for this feature, picked from `docs/spec/INDEX.md`:
- `docs/spec/features/[NNN-name]/tasks.md`
- `docs/spec/features/[NNN-name]/feature-spec.md`, criteria [AC numbers]
- `docs/spec/features/[NNN-name]/not-building.md`

Decisions that bind this work, picked from `docs/spec/decision-log.md`: [D numbers, each with
the file holding its full entry]

Code:
- `[path/to/file]`, [function or class, if the file is large]
- `[path/to/file]`

Do not read any other feature's folder. Do not open code files that are not listed here; if you
need one, stop and ask for it. Read each file once, and only read it again if it has changed.

## Tests

While building, run only these, with output to a log you grep rather than read in full:

    [targeted test command] > [log file] 2>&1; grep -E "[pass/fail pattern]" [log file]

Run them once to see them fail and once to see them pass. Do not run the whole suite; that
happens once, after merging.

## Stop and report when

- the tasks above are done;
- the tests have failed twice in a row;
- [the fix-up loop on any one task has gone past N attempts];
- you meet a decision the spec didn't make, or you would need a file not listed here;
- [anything else specific to this work].

## Report

About 10 to 15 lines. Nothing else.

- Done: [task IDs]
- Commits: [hash, one line each]
- Open questions: [one line each]
- Not decided by the spec: [what you met, and what you did instead of deciding it]
```

## Before you send it

- [ ] Every spec file, decision number and code file is named. No "see the feature folder".
- [ ] The tasks are in dependency order, and there are no more than five.
- [ ] The test command runs only the tests for these tasks.
- [ ] The model fits the size of the largest task.
- [ ] If this continues from an earlier agent, its report is pasted under "Your tasks".

## Traps

- "Read the codebase to understand it" is not a reading list. It is an invitation to read all of it.
- An agent told to run "the tests" will run all of them, every time it changes a line.
- A report with no length limit becomes a second copy of the diff, written in prose.
- A blank for stop conditions left empty means the agent stops when it runs out of ideas, which
  is later than you'd like.
