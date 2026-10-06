# Feature Spec: [feature name]

**ID:**
**Parent spec:**
**Status:** Draft | Ready | Built | Verified
**Owner:**

## User story

As a [specific role]
I want [capability]
So that [outcome that would be observable if you removed the feature]

> If the "so that" is "so that we have the feature", stop. You don't have a reason yet.

## Acceptance criteria

Given / When / Then. Each one must be independently checkable by someone who wasn't in the room.
Number them, tests reference these IDs, and so does the traceability matrix.

**AC1**
- **Given** [starting state]
- **When** [action]
- **Then** [observable result]

**AC2**
- **Given**
- **When**
- **Then**

### AC quality bar

Delete any criteria that can't survive these:

- Could two reasonable people disagree about whether it passed? Rewrite.
- Does it describe *how* rather than *what*? Rewrite. ACs constrain behaviour, not
  implementation.
- Is it checkable without asking the author? If no, rewrite.
- Words to remove on sight: fast, intuitive, robust, seamless, secure, properly, gracefully,
  simple, clean, appropriate.

## Edge cases

Each needs its own AC or an explicit note that it's out of scope. Silence here is an instruction
to guess.

| Scenario | Behaviour | AC |
|---|---|---|
| | | |

## What must never happen

Prohibitions specific to this feature.

## Out of scope

Explicit. Things a reasonable person might assume are included and aren't. Add to Template 04 as
well if it's a project-level decision rather than a this-feature one.

- [ ]

## Dependencies

Other features, tasks, or external things that must exist first.

## Notes for whoever builds this

Anything that isn't a requirement but would stop someone making a predictable mistake. Prior
art, a trap in the existing code, a reason the obvious approach doesn't work here.
