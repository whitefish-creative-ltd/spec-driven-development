# The Spec-Driven Development Action Pack

Twelve templates. Every one is a markdown file. That is the entire toolchain.

You do not need a CLI, a subscription, or a skill to work this way. If a vendor has told you
otherwise, they were selling something. Copy the blanks, fill them in, keep them in the repo next
to the code they govern.

**This is not a Claude thing.** The worked examples show Claude Code because that is what we build
with. Nothing in the pack is tied to it. All twelve templates are plain markdown with no tool in
them at all, so the method works exactly the same on Codex, Cursor, Copilot, Gemini CLI, Windsurf,
or whatever your team has settled on this quarter, and it works with no agent whatsoever on a
codebase written entirely by people. The six skills are portable too: they are `SKILL.md` files
following the open Agent Skills standard, which Claude Code, Codex and Cursor all read, so they are
not the Claude-only part either. The one place your tool shows up is the file you point it at, and
those filenames are listed further down.

## What's in the download

```
sdd-action-pack/
├── README.md      <- this file. The layout, the loop, and how to wire it to your agent
├── templates/     <- the twelve blanks. This is the method. Copy these into your repo
├── examples/      <- the same twelve, filled in for one worked feature, to read not to copy
└── skills/        <- six optional agent skills, an update checker, and a README about trusting them
```

`templates/` is the pack. Everything else exists to explain it. If you only ever open one folder,
open that one, and use the numbered order below to decide what goes where.

## Where the files go

Loose templates are useless. They only start working when they live in the repository, in a
layout that makes it obvious which document governs what. This is that layout.

```
your-project/
├── CLAUDE.md                            <- or AGENTS.md, .cursorrules, etc. Points at 11
├── docs/
│   └── spec/
│       ├── constitution.md              <- 11  the standing rules everything is built under
│       ├── definition-of-done.md        <- 09  the gate, agreed once, applied to every feature
│       ├── decision-log.md              <- 06  the overview: every decision, one line each
│       ├── INDEX.md                     <- the map: every feature, with its folder
│       ├── coordinator-notes.md         <- where the next coordinator picks up
│       │
│       ├── features/
│       │   ├── 001-user-login/
│       │   │   ├── problem-brief.md     <- 01  the problem this feature exists to solve
│       │   │   ├── feature-spec.md      <- 03  the criteria, checkable by a stranger
│       │   │   ├── not-building.md      <- 04  what this feature deliberately excludes
│       │   │   ├── tasks.md             <- 05  criteria cut into verifiable work
│       │   │   ├── decision-log.md      <- 06  the decisions taken building this feature
│       │   │   ├── change-and-drift.md  <- 07  append only, decided change vs silent drift
│       │   │   └── traceability.md      <- 08  filled in by someone who didn't build it
│       │   │
│       │   └── 002-password-reset/
│       │       └── ... the same seven
│       │
│       └── audits/
│           └── 2026-02-11-spec-tasker.md  <- 10  one per skill, before you run it
│
├── src/
└── ...
```

Four things about that layout are deliberate.

**The feature folder is the unit, not the project.** Everything needed to specify, build, verify
and audit one piece of work sits in one directory, and nothing about the system as a whole has to
be settled before you open the first one. That is the difference between this and waterfall. A
big spec at the root, written once, is exactly the artefact this method is trying to replace. You
can start at `001` on a Tuesday knowing nothing about `007`.

**Three files sit above the features, and none of them is a spec.** The constitution is the
standing rules the work runs under: coding standards, security posture, how anything gets built.
The definition of done is the standard every feature is measured against, agreed once by the team,
because a gate you restate per feature is a gate you renegotiate every time you approach it. The
decision log is an overview, described below. All three are the same on Tuesday as they are for
feature 007, which is exactly why they are not in a feature folder. What is *not* up there is any
description of the system you are building. Two working files sit beside them, the index and the
coordinator's notes, and neither of those is a spec either; both are described below.

**Two logs, and they answer different questions.** The decision log records *why* a choice was
made. The change and drift register records *what moved* in the spec. Drift only means anything
measured against a particular set of criteria, so the register is always per feature: a change is
a change to this feature's spec, and drift is this feature's build wandering off it.

Decisions are the other way round, because their whole value is that someone else finds them. The
copy in the feature folder is the working log, written as you build. The copy at the top is the
overview: one line per decision across the project, with the date, the decision in a sentence, and
the feature folder holding the full entry. Anything that belongs to no single feature, the
password hashing algorithm, the error format, gets written out in full up there instead.

**Decision numbers are project-wide, and the overview hands them out.** Every decision takes the
next free number in `docs/spec/decision-log.md`, and gets its line there when it is taken, even
when the full entry lives in a feature folder. So D004 means one decision wherever it is
mentioned, in a spec, a task, a drift entry or an agent prompt, and the overview is the one place
to look for every decision the project has made. The constitution points at it for that reason.
If you cannot be bothered to add the line, the decision was probably not worth logging.

**`INDEX.md` is the map, and it holds nothing else.** One line per feature, with its folder. It
exists so that whoever hands out the work, a person or a coordinating agent, can pick the exact
spec files a build agent needs without opening every folder to find them. Agents that are told
what to read read less, and most of the cost of an agent is reading. Decisions are not in it:
they already have their list, the overview decision log, and two lists of the same thing drift
apart. The decision numbers for an agent prompt come from there. It is short enough not to need a
numbered template:

```markdown
# Spec index

One line per feature, with its folder. Pointers only: the content lives in the files they
point at. Decisions are in `decision-log.md`, not here.

| ID | Feature, one line | Folder |
|---|---|---|
| 001 | User login: first-party email and password | `features/001-user-login/` |
| 002 | Password reset | `features/002-password-reset/` |
```

Keeping it current is part of the work it points at, not a tidy-up for later. When you make a
feature folder, add the feature's line in the same commit. When a feature is retired or merged
into another, its line says so rather than disappearing, so an old reference still leads
somewhere.

**`coordinator-notes.md` is for when things go sideways.** A coordinating session that dies, or is
replaced by a fresh one, leaves the next one nothing but the repository. `tasks.md` says which
tasks are done. This note says the rest: which agents are out and on what, which questions are
waiting on a person, and what comes next. A handful of lines that describe now, not a history.

**It is `docs/spec/`, not `spec/`.** A top-level `spec/` is already the test directory in Ruby,
JavaScript and a dozen other ecosystems, and you do not want your contract fighting your test
runner for a folder name. If your project has no `docs/`, make one.

**The number on the folder is the feature's ID.** Template 03 has an `ID` field: use `001`.
Template 05 numbers its tasks `[ID]-01`, so the work for that feature is `001-01`, `001-02`, and
so on, and the traceability matrix in the same folder can point at a criteria and a task without
anyone having to guess which feature is meant.

**Template 02 is optional, and often skipped.** The Spec is for when several features share one
contract and you need a parent for them to point at. If you are not there, skip it, the feature
spec is the contract. When you do need one, give it its own folder beside the features,
`docs/spec/epics/001-accounts/spec.md`, and fill in the `Parent spec` field on each feature spec
that answers to it. What it should never become is one document at the root describing the whole
system, agreed up front, before anyone has built anything.

## Wiring the constitution into your agent

Writing a constitution the agent never reads is worse than not writing one, because you will
believe the rules are in force.

Every coding agent looks for its own instructions file, and the obvious move is to paste the
rules into it. Do not. You will end up with two versions, they will drift apart within a
fortnight, and the one the agent obeys will be the stale one. Make the tool's file a pointer and
keep the content in the constitution, so there is exactly one copy to change and one file to
review when it changes.

`CLAUDE.md` in the repository root, in full:

```markdown
# How work is done here

Read `docs/spec/constitution.md` before doing anything. It is the source of truth for the
standing rules of this repository and it overrides anything in this file.

When working on a feature, read the files in that feature's folder under
`docs/spec/features/` that you have been pointed at, or every file in it if you were not
given a list, and no other feature's folder. The feature spec is the contract and
`not-building.md` is binding. If a request conflicts with either, stop and say so rather
than deciding for yourself.
```

That last sentence is the one that earns its place. Left to itself an agent resolves a conflict
silently and plausibly, and you find out three hundred commits later. Told to stop and ask, it
behaves like the junior developer who walked over to your desk.

Same three lines, different filename, depending on what you run:

| Agent | File |
|---|---|
| Claude Code | `CLAUDE.md` |
| Codex, Amp, Jules and anything else following the AGENTS.md convention | `AGENTS.md` |
| Cursor | `.cursor/rules/constitution.mdc`, or `.cursorrules` on older versions |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Gemini CLI | `GEMINI.md` |
| Windsurf | `.windsurfrules` |

These filenames move about as vendors change their minds, so check your tool's current docs. The
principle survives the renaming: one canonical constitution in the repo, every tool pointed at
it, nothing important living only inside a vendor's config file. Run several agents and they all
point at the same file, which is the entire reason the constitution is tool-agnostic.

## The twelve templates

| # | Template | Where it lives | Use it when |
|---|---|---|---|
| 01 | Problem Brief | `features/NNN-name/problem-brief.md` | Before anyone proposes a solution to this feature. |
| 02 | The Spec | `epics/NNN-name/spec.md`, optional | Several features share one contract and need a parent. |
| 03 | Feature Spec | `features/NNN-name/feature-spec.md` | One feature, with acceptance criteria that can actually be checked. |
| 04 | Not Building Register | `features/NNN-name/not-building.md` | Always. This is the one that saves you. |
| 05 | Task Breakdown | `features/NNN-name/tasks.md` | Turning a spec into work an agent or a human can pick up. |
| 06 | Decision Log | `docs/spec/decision-log.md` for the overview, `features/NNN-name/decision-log.md` for the working log | Someone asks "why is it like this" six months later. |
| 07 | Change & Drift Register | `features/NNN-name/change-and-drift.md` | The scope moved. Prove it, price it, or refuse it. |
| 08 | AC Traceability Matrix | `features/NNN-name/traceability.md` | Proving what's built matches what was specified. |
| 09 | Definition of Done | `docs/spec/definition-of-done.md` | Before you say the word "done". Agreed once, applied to every feature. |
| 10 | Skill Audit Checklist | `docs/spec/audits/[skill].md` | Before you run anyone's skill. Including these ones. |
| 11 | The Constitution | `docs/spec/constitution.md` | Once per project. The standing rules everything else is built under. |
| 12 | Agent Prompt | Nowhere: it is what you hand a build agent | Every time an agent builds. Names exactly what it reads, runs and reports. |

## How to actually use it

**Once, at the start.** Copy template 11 to `docs/spec/constitution.md` and fill it in, then wire
it into your agent's instructions file as above. Copy template 09 to
`docs/spec/definition-of-done.md` and agree it as a team, once, so nobody is negotiating the bar
at the point they most want it lowered. Create `docs/spec/decision-log.md` from template 06 and
leave it empty; it wants to exist before the first decision worth recording happens.

That is the whole project-level setup: two documents to write and one to open. There is no system
spec to agree, no up-front design phase to sit through, and nothing else to do before you start on
the first feature.

**Per feature, before any code.** Make `docs/spec/features/NNN-name/`. Work down the folder in
order: the problem brief first, because it is the one that stops you building the wrong thing
well; then the feature spec, with criteria a stranger could check; then the not-building register,
with a reason on every line, because "out of scope" is a restatement of the heading and not a
reason; then the task breakdown. If a task cannot be verified on its own, it is two tasks.

**While building.** Point the agent at the constitution and at this feature's folder. Every
decision nobody had already made goes in the feature's `decision-log.md` as it is taken, not
reconstructed afterwards, under the next free number from the overview at
`docs/spec/decision-log.md`, which gets the decision's line at the same time. Anything that moves
the spec goes in `change-and-drift.md`, which keeps decided change and silent drift apart, and
that separation is the whole point of the document.

If agents do the building, give one agent one feature: its tasks in order, four or five at most,
with template 12 filled in. That names the exact spec files, decisions and code it reads, the
tests it runs, when it stops, and the ten-to-fifteen-line report it hands back. The reasons, and
what they saved when measured, are in `skills/spec-build/SKILL.md` under "Running build agents
efficiently". They hold whether or not you use the skill.

**Before you call it done.** Someone who did not build it fills in `traceability.md`, mapping
every criteria to the test that proves it. Unmapped criteria is the finding. Then run the feature
against `docs/spec/definition-of-done.md`. Both are gates, and a gate you skip when you are busy is not
a gate.

**Before you run anyone's agent skill.** Copy template 10 into `docs/spec/audits/` with the
skill's name and the date, and work through it. That includes the skills in this pack.

## How they fit together

```
01 Problem Brief
      |
      v
02 The Spec  <--->  04 Not Building Register     (02 only if several
      |                     ^                     features share a contract)
      v                     |
03 Feature Spec       07 Change & Drift Register
      |                     ^
      v                     |
05 Task Breakdown ----------+
      |
      v
12 Agent Prompt     (one per build agent, four or five tasks each)
      |
      v
   [ build ]  ------>  06 Decision Log
      |    ^
      |    |  governed throughout by
      |   11 The Constitution  (standing rules, read by every agent + human)
      v
08 AC Traceability Matrix
      |
      v
09 Definition of Done
```

11 and 09 happen once per project: the standing rules, and the standard everything is measured
against. 01, 03, 04, 05 and 08 happen once per feature. 07 is a living document inside the feature
folder. 06 is living too, and lives in both places, the working log with the feature and the
overview at the top. 08 and 09 are gates. 12 is written each time an agent builds. 02 is for
the occasional epic. 10 you reach for before running anyone's skill.

## Rules

1. **These live in the repo.** In git, next to the code, reviewed in pull requests. A spec in
   Confluence is a document. A spec in the repo is a contract.
2. **Non-goals are a first-class artefact.** Template 04 is standalone for a reason. Non-goals
   buried inside a spec get quietly overturned by whoever's tired at 4pm on a Friday.
3. **If an acceptance criteria can't be checked by someone who wasn't in the room, it isn't one.**
   Rewrite it or delete it.
4. **Nothing here is mandatory on every task.** The overhead is real. If you'd be annoyed at
   someone interpreting it differently than you meant, spec it. If you'd fix it in one follow-up,
   don't. Ceremony applied indiscriminately is how this becomes waterfall.
5. **The constitution is tool-agnostic on purpose.** Keep the canonical copy in the repo, not in
   `CLAUDE.md` or `.cursorrules`; let those point at it, as above. The tool you use will change.
   The rules shouldn't have to move house when it does.

## The worked examples

Every template ships with a filled-in example in `examples/`. Eleven of them describe the same
feature, user login for a product called Kestrel, carried the whole way through: specced,
decomposed, built, drifted, verified, audited. Read those eleven in order and you have the entire
method. The odd one out, the Skill Audit Checklist example, necessarily uses a different fixture: it
audits a fictional third-party skill (`spec-tasker`) rather than the login feature, because you
can't demonstrate auditing someone else's skill on a feature you built yourself.

It's a deliberately boring feature. Every method looks good on something interesting.

To see the layout above with the words filled in: put `examples/11` at `docs/spec/constitution.md`
and `examples/09` at `docs/spec/definition-of-done.md`, drop `examples/01`, `03`, `04`, `05`, `06`,
`07` and `08` into `docs/spec/features/001-user-login/` under the filenames in the tree, and
`examples/10` into `docs/spec/audits/`. That is a finished feature, start to audit, in the shape
your own repo should take. `examples/12` lives nowhere, because a prompt is not a file in the
repo: it is what the coordinator handed the agent that built LOGIN-03 to LOGIN-05, and what came
back.

## The skills

`skills/` holds six optional skills, one per stage of the loop plus one for bringing an existing
codebase into it, and `spec-update`, which checks whether they are the latest version. Each is a
folder containing a `SKILL.md`, which is the open Agent Skills standard, so they are not
Claude-only: copy the folders into whichever skills directory your agent reads. At the time of
writing that is `.claude/skills/` for Claude Code, `.agents/skills/` for Codex, and Cursor reads
`.cursor/skills/` as well as both of those. Those paths move as often as the instruction filenames
do, so check your tool's current docs.

They automate the repetitive parts. They do not confer the discipline, and you can run the whole
method without them. Read `skills/README.md` before you run any of them, and put them through
template 10 first.
