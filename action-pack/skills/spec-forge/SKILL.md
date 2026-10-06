---
name: spec-forge
description: Turn a vague feature request into a specification by interrogation, not transcription. Use when someone describes something they want built in loose terms and you need to surface the decisions hidden inside it before any code is written. Produces a spec document and a standalone not-building register. Challenges vague answers rather than recording them.
metadata:
  version: "2.0.0"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-forge

**What this skill does:** guides an interview that turns a loose request into a written
specification and a separate list of things you're deliberately not building.

**What this skill touches:** the files it's explicitly asked to create or read in the working
directory. Nothing else.

**What this skill does NOT do:** it runs no scripts, makes no network calls, reads no
environment variables or credentials, and touches nothing outside the working directory. It is
plain instructions. Read them.

---

## The one rule

Do not transcribe. Interrogate.

When the user describes what they want, your job is not to write it down neatly. Your job is to
find the decisions hidden inside their description and drag each one into the open by asking
about it. A request like "build me a login" contains dozens of unmade decisions. Surface them.

If you catch yourself recording an answer that is vague, stop and ask a sharper question
instead. "It should be secure" is not an answer you write down, it's a prompt to ask "secure
against what, specifically? What must never happen?"

## Process

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
- **Done.** How would someone who wasn't in this conversation know it works?

### Phase 3: Produce the artefacts

Write two files.

**The spec** (use the Spec template structure): problem, goal, context, constraints, functional
requirements (numbered), non-functional requirements (each with a measure), a summary of
non-goals, edge cases, and an explicit "what must never happen" section.

**The not-building register** (separate file, deliberately): every thing considered and
rejected, with a reason on each line. Not "out of scope", an actual reason. This file is
standalone because non-goals buried inside a spec get quietly overturned.

### Phase 4: Challenge your own output

Before finishing, re-read the spec and find every place you wrote a word from this list: fast,
secure, intuitive, robust, seamless, graceful, clean, simple, appropriate, properly. Each one is
a decision you failed to extract. Go back and ask the question that replaces it with something
checkable.

## Acceptance criteria for this skill's output

- Every functional requirement is numbered and specific.
- Every non-functional requirement has a measure, not an adjective.
- The not-building register exists as a separate file with a reason per line.
- There is an explicit "what must never happen" section.
- No banned vague words survive in any acceptance criteria.
