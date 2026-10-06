---
name: spec-build
description: Implement one task against its acceptance criteria without drifting beyond it. Use when building a single decomposed task and you want the work held strictly to what was specified. Refuses out-of-scope work and says so explicitly rather than helpfully adding things.
metadata:
  version: "1.0.0"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-build

**What this skill does:** implements a single task against its acceptance criteria, and refuses
to build anything the task didn't ask for.

**What this skill touches:** the files the task's scope covers, in the working directory. It
reads the spec, the feature spec, the task, and the not-building register to know its
boundaries.

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

Read, in this order:

1. **The constitution:** the project's standing rules (coding standards, security posture,
   non-negotiables, and what to do with an unspecified decision). These apply to every task.
2. **The task:** its objective, the criteria it satisfies, and its explicit out-of-scope list.
3. **The feature spec:** the acceptance criteria in full, and the "what must never happen"
   section.
4. **The not-building register:** this feature's list of things deliberately not being
   built.

You now know the standing rules, what to build, and what not to. Hold all of it.

## While building

- Implement only what satisfies the task's criteria.
- Touch only files within the task's scope. If you find yourself needing to edit something
  outside it, stop: either it's a real dependency the decomposition missed (flag it, don't
  silently absorb it) or you're drifting.
- When you hit a decision the spec didn't make, **do not make it.** Flag it and ask. A guessed
  decision is drift even when the guess is good, because nobody decided it.
- Check every change against the not-building register. If what you're about to add appears
  there, do not add it. Say that you were about to and stopped.
- Record any non-obvious choice (a library, a tradeoff) briefly, so the next reader doesn't
  "fix" a deliberate decision back into the wrong one.

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

- Every criteria the task claims has an implementation.
- No files outside scope were touched.
- Nothing from the not-building register was added.
- Any decision the spec didn't cover was flagged, not guessed.

## Acceptance criteria for this skill's behaviour

- It builds only what the task specifies.
- It refuses out-of-scope requests explicitly and names the reason.
- It flags undecided questions rather than guessing them.
- It touches no file outside the task's stated scope.
