---
name: spec-forge
description: Turn a vague feature request into a specification by interrogation, not transcription. Use when someone describes something they want built in loose terms and you need to surface the decisions hidden inside it before any code is written. Produces a spec document and a standalone not-building register. Challenges vague answers rather than recording them.
metadata:
  version: "2.1.1"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-forge

**What this skill does:** guides an interview that turns a loose request into a written
specification and a separate list of things you're deliberately not building.

**What this skill touches:** the files it's explicitly asked to create or read in the working
directory, the templates named below, and, when the feature changes existing code, that code,
read-only, for the inventory (Phase 0). Nothing else.

**What this skill does NOT do:** it runs no scripts, makes no network calls, reads no
environment variables or credentials, and touches nothing outside the working directory. It is
plain instructions. Read them.

---

## Templates

For each template below, use the project's copy at `docs/spec/templates/<file>` if there is one,
because the team may have adapted it. If there isn't, use the copy in this skill's own folder,
`templates/<file>`. Never write one of these documents from memory: the template is the format
the other skills, and the next person to read it, expect.

- `01-problem-brief.md` → `docs/spec/features/NNN-name/problem-brief.md`
- `03-feature-spec.md` → `feature-spec.md` in the same folder
- `04-not-building-register.md` → `not-building.md` in the same folder
- `06-decision-log.md` → each decision the interview takes: its full entry in the feature's
  `decision-log.md`, and its one line in `docs/spec/decision-log.md`, under the next free number
  there
- `02-the-spec.md` → `docs/spec/epics/NNN-name/spec.md`, only when several features share one
  contract and the user asks for a parent spec

`inventory.md` has no template; its shape is in Phase 0.

## The one rule

Do not transcribe. Interrogate.

When the user describes what they want, your job is not to write it down neatly. Your job is to
find the decisions hidden inside their description and drag each one into the open by asking
about it. A request like "build me a login" contains dozens of unmade decisions. Surface them.

If you catch yourself recording an answer that is vague, stop and ask a sharper question
instead. "It should be secure" is not an answer you write down, it's a prompt to ask "secure
against what, specifically? What must never happen?"

## Process

### Phase 0: Inventory, only if the feature changes existing code

Skip this for new code in a new place. Otherwise, before the interview, find where the behaviour
the request touches lives now. Hand this to a separate agent on the mid model, read-only, so the
interview session never holds the code.

It drafts `inventory.md` in the feature folder: one row per existing behaviour the request could
change, move, replace or must keep.

| # | Behaviour | `file::function` | Moves to | Notes |
|---|---|---|---|---|
| 4 | Discount applied before tax | `billing/invoice.py::apply_discount` | *(decided in the interview)* | |

Rules for the inventory:

- Pointers, not prose. A row says where something is, not how it works.
- Read only to locate: trace from entry points and the names the request uses, and stop at the
  function that owns the behaviour.
- Say which commit it was read at. It is true of that commit, and nothing later.
- Function names, never line numbers.

The interview then fills "Moves to" one row at a time. Each answer is a decision, and goes in the
decision log like any other. A row whose answer is "stays as it is" needs a criteria that says so
("existing saves still load"), because behaviour nobody wrote down is behaviour a refactor is free
to drop.

This is the most expensive reading in the feature. It is done once, here, instead of by every
build agent: spec-decompose cites the rows in each task's brief, so builders start from them.

### Phase 1: Problem before solution

Before discussing any feature, establish the problem. Ask:

- What is happening that shouldn't be, or not happening that should? (Get them to answer without
  naming a solution. If they can only describe it as "we need X", ask what breaks if they don't
  have X.)
- Who specifically has this problem? Not "users", which people, in which role, doing what.
- What does it cost them today?
- What happens if nothing is built?

If the problem can't be stated without describing software, the user doesn't understand the
problem yet. Keep asking until it can.

### Phase 2: Interrogate the request

For the feature itself, work through these, challenging vague answers every time:

- **Identity and inputs.** What identifies the actors? What are the valid inputs, and the
  invalid ones?
- **The happy path.** What is the normal, successful sequence? State it concretely.
- **Every branch.** For each step, ask: what else could happen here? What if it's empty, wrong,
  duplicated, too large, concurrent, unauthorised?
- **Failure modes.** What happens when a dependency is down? When the input is hostile? When two
  people do it at once?
- **The prohibitions.** What must never happen? This is the question nobody volunteers. Ask it
  directly. Never log the what? Never allow the what? Never reveal the what?
- **What must survive.** If there is an inventory, walk its "stays" rows. Each is a criteria, or
  it is on the not-building register with a reason.
- **Done.** How would someone who wasn't in this conversation know it works?

### Phase 3: Produce the artefacts

Write three files, each from its template (see Templates above).

**The problem brief** (`01-problem-brief.md`): what Phase 1 established, in the brief's sections.

**The feature spec** (`03-feature-spec.md`): the user story, then acceptance criteria as Given /
When / Then, numbered, each checkable by someone who wasn't in the room. Edge cases, an explicit
"what must never happen" section, and dependencies. A non-functional need is an acceptance criteria
with a measure, not an adjective.

**The not-building register** (`04-not-building-register.md`, separate file, deliberately): every
thing considered and rejected, with a reason on each line. Not "out of scope", an actual reason.
This file is standalone because non-goals buried inside a spec get quietly overturned.

### Phase 4: Challenge your own output

Before finishing, re-read the spec and find every place you wrote a word from this list: fast,
secure, intuitive, robust, seamless, graceful, clean, simple, appropriate, properly. Each one is
a decision you failed to extract. Go back and ask the question that replaces it with something
checkable.

## Acceptance criteria for this skill's output

- The problem brief, feature spec and not-building register each follow their template.
- Every acceptance criteria is numbered, in Given / When / Then form, and checkable by someone
  who wasn't in the room.
- Every non-functional need is a criteria with a measure, not an adjective.
- The not-building register exists as a separate file with a reason per line.
- There is an explicit "what must never happen" section.
- No banned vague words survive in any acceptance criteria.
- If the feature changes existing code, `inventory.md` exists, every row has a "Moves to", and
  every "stays" row is a criteria or a not-building entry.
