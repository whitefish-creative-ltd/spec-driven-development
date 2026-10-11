# Spec: [project / epic name]

**Version:** 0.1
**Status:** DRAFT | LOCKED | SUPERSEDED
**Owner:**
**Last updated:**

> A spec is a contract, not a wish list. It is version-controlled, diffed, and reviewed like
> code. Changes go through Template 07, not through a conversation.

## Changelog

| Version | Date | Change | Why |
|---|---|---|---|
| 0.1 | | Initial | |

## 1. Problem

One paragraph. Link to the Problem Brief (Template 01) rather than repeating it.

## 2. Goal

What this build achieves. One or two sentences. If you need more, you have two projects.

## 3. Context

What already exists that this must live inside. Systems, data, teams, conventions. The things a
competent stranger would need to know and would otherwise have to guess.

## 4. Constraints

Hard limits. Distinguish between:

- **Immovable:** regulatory, contractual, physical.
- **Expensive to move:** existing architecture, team skills, deadlines.
- **Assumed:** things we've treated as fixed but nobody has actually confirmed. Flag these.
  Assumed constraints that turn out to be soft are where the good options were hiding.

## 5. Functional requirements

What the system must do. Numbered, so they can be referenced from tasks and tests.

| ID | Requirement | Priority |
|---|---|---|
| FR1 | | Must / Should / Could |

## 6. Non-functional requirements

Performance, security, availability, accessibility, compliance, operability. Each one needs a
number or a check, or it's decoration.

| ID | Requirement | Measure | Priority |
|---|---|---|---|
| NFR1 | | | |

## 7. Non-goals

Summary only. The register (Template 04) is the source of truth. This section exists so a
reader of the spec alone can't miss them.

## 8. Edge cases and failure modes

What happens when the network's gone, the input is hostile, the queue is full, the third party
is down, two users do it at once, the data's already wrong. This section is where specs earn
their money, it's the part a literal machine will otherwise invent for you.

| Scenario | Expected behaviour |
|---|---|
| | |

## 9. What must never happen

Distinct from §8, and worth its own heading. Not "handle errors gracefully" but: never log the
password, never charge twice, never let tenant A see tenant B, never delete without a soft
window. Prohibitions are the cheapest safety you will ever write.

## 10. Dependencies

What this needs that we don't control. Who owns it. What we do if it's late.

## 11. Open questions

Blocking questions with owners. A spec with unowned open questions is not ready to lock.

| Question | Blocks | Owner | Status |
|---|---|---|---|
| | | | |

## 12. Lock

- [ ] Every open question closed or explicitly deferred with a reason.
- [ ] Non-goals register exists and is referenced.
- [ ] Every NFR has a measure.
- [ ] Reviewed by someone who didn't write it.

**Locked by:**
**Date:**

Once locked, this document changes only via Template 07.
