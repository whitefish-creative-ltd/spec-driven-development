---
name: spec-orchestrate
description: Coordinate the building of a feature's decomposed tasks. Hands each batch of tasks to a fresh agent with a prompt built from the task briefs and the constitution's operating rules, on the model the tasks call for, takes back a short report, and keeps the state in the repository so a new session can pick it up. Use after spec-decompose, when agents will do the building. Never reads or writes code itself.
metadata:
  version: "2.1.1"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-orchestrate

**What this skill does:** coordinates the building of decomposed tasks. It decides who builds
what, on which model, with which prompt, and records where things stand.

**What this skill touches:** it reads `docs/spec/coordinator-notes.md`, the constitution's
operating rules, the `tasks.md` of the feature it is running, and, when a prompt needs them,
`docs/spec/INDEX.md` and the decision log overview, and the templates named below. It writes `coordinator-notes.md`, the Status
fields in `tasks.md`, and the prompts it hands out. It does not open source code or test output.

**What this skill does NOT do:** it bundles no scripts, makes no network calls of its own, and
reads no credentials or environment. Handing a prompt to an agent, and merging, are done with
whatever your tool provides and under the constitution's operating rules; this skill doesn't do
either on its own authority. Plain instructions. Read them.

---

## Templates

For each template below, use the project's copy at `docs/spec/templates/<file>` if there is one,
because the team may have adapted it. If there isn't, use the copy in this skill's own folder,
`templates/<file>`. Never write one of these documents from memory: the template is the format
the other skills, and the next person to read it, expect.

- `12-agent-prompt.md` → the prompt for each build agent. It is handed over, not saved
- `11-the-constitution.md`, §9 → what the operating rules look like. If the project's
  constitution has no operating rules, stop and show the user this section to fill in; do not
  guess a test command or a model name

## The one rule

The coordinator reads pointers, never code. Every file the coordinator opens is context it carries
for the rest of the session, and it pays for that context again on every turn. If you need to
know something about the code, that is a task for an agent with a brief, not a look you take
yourself.

What the coordinator does edit itself: `coordinator-notes.md`, task Status, the index, decision
lines, and a person's answers recorded into a spec file. Those are small, and already in its
context. A one-line code fix is not small here: the file it would open stays in the session. It
goes to a small-model agent with a brief.

## Start of session

Read these, and nothing else:

1. `docs/spec/coordinator-notes.md`: what is in flight, what is waiting on a person, what is next.
2. `docs/spec/constitution.md`, the Operating rules section only.
3. The feature's `tasks.md`.
4. `docs/spec/INDEX.md` and `docs/spec/decision-log.md`, only when filling a prompt needs them.

If a task has no brief, or its brief names "the module" rather than files and functions, stop.
Send it back to spec-decompose. Do not fill the gap by reading code: that is the exploring the
brief exists to prevent, moved into the most expensive session there is.

## Handing out work

1. **One agent per feature, four or five tasks per agent.** Take the next tasks in dependency
   order. The prompt's reading list is the union of their Read lists, so the set-up reading is
   paid once, not once per task. After a long fix-up loop, hand the rest to a fresh agent with the
   last one's report.
2. **Build the prompt from `12-agent-prompt.md`.** The reading comes from the briefs, the tests from each
   Prove, the standing rules from the operating rules. Don't retype project rules into the prompt;
   point at them.
3. **The model comes from the briefs.** The largest task decides: small for bookkeeping, indexes
   and recording answers; mid for S tasks and fix-ups; top for M tasks and audits. The operating
   rules map small, mid and top to real model names; this skill doesn't.
4. **Every prompt carries a budget.** The tool-call budget from the operating rules. An agent that
   reaches it stops and reports where it got to.
5. **Set Status to In flight**, and add a line to the notes, before the agent starts.

If your tool can't start a separate agent, a fresh session with the prompt pasted in is the same
thing. The point is that the builder starts clean, and the coordinator never holds the build.

## Taking a report back

A report is ten to fifteen lines. If one comes back longer, take its Done, Commits and question
lines and leave the rest; don't read it twice.

- Set each finished task to Done, with its commit.
- Put every open question and every "not decided by the spec" line in the notes, under "Waiting
  on a person". Do not decide them. A coordinator answering spec questions is spec-forge without
  the interview.
- If the report says a brief was wrong (a function moved, a file was missing), correct the briefs
  of the tasks still to come before the next prompt goes out.
- Merge as the operating rules say, then run the whole suite once, reading only the tail of its
  log. If it fails, the failure is a fix-up task with its own brief, on the mid model. Do not
  debug it here.

## What does not happen in this session

- **Writing specs.** That is spec-forge, interactively, in its own session.
- **Debugging.** That is a fix-up agent with a brief.
- **Looking and adjusting**: visual, layout, audio or feel work, anything where a person looks at
  the result and asks for another pass. Run it in its own short session with only the files it
  needs, and bring one line back to the notes. Every round of looking costs a full turn of
  whatever context the session holds, so keep that context small.
- **Audits.** spec-audit, in a fresh session, per its own precondition.

## End of session

End the session at a boundary, never in the middle of handing out a batch:

- when a feature's tasks are all Done or Blocked;
- when the session's context passes the coordinator budget in the operating rules;
- at the end of the working day.

Before ending, rewrite `coordinator-notes.md`. It describes now; it is not a history. Which tasks
are done is in `tasks.md`, not here, because two lists of the same thing drift apart.

```markdown
# Coordinator notes

## In flight
- 007-03 to 007-05, agent started 2026-10-11, mid model

## Waiting on a person
- 007: does a reset clear an active lockout? (from the 007-03 report)

## Next
- 007-06 once 007-05 merges; then audit 007 in a fresh session
```

Commit it with `tasks.md`. The next session starts from those two files and nothing else. If it
can't, the notes were incomplete.

## Acceptance criteria for this skill's behaviour

- It opens no source code and no full test output.
- Every prompt it hands out names its reading, its tests, its model, its budget and its stop
  conditions.
- It decides no spec question; each goes to the notes for a person.
- Every Status in `tasks.md` matches the reports it has received.
- A fresh session can resume from `coordinator-notes.md` and `tasks.md` alone.
