# Change & Drift Register: [feature]

**Status:** Living document, append only
**Owner:**

> Two different things live here and they must not be confused.
>
> **A change request** is someone deciding, deliberately, that the spec was wrong or the world
> moved. That's legitimate. It's how a spec stays honest.
>
> **Drift** is the spec changing without anyone deciding. That's a defect. It gets logged, and
> then it gets reverted or ratified, not quietly absorbed.

## Part 1: Change requests

### CR001: [what's being asked for]

- **Raised by:**
- **Date:**
- **Status:** Proposed | Accepted | Rejected | Deferred

**What:** the change, specifically. Not "improve the login", the actual delta.

**Why now:** what changed. If nothing changed, this is a preference, and preferences go to the
back of the queue.

**Affects:** FR2, AC4, task LOGIN-03, decision D002.

**Cost:** effort, plus anything that has to be redone.

**What it displaces:** *the important line.* Scope is conserved. If this goes in and the date
doesn't move, something else comes out. Name it here, or you're pretending.

**Non-goals affected:** does this overturn anything on the Not Building register? If so, that
register gets updated too, in the Overturned section, referencing this CR.

**Decision:**
**Decided by:**
**Date:**

---

## Part 2: Drift log

Things that got built that nobody asked for, or built differently from the spec without a CR.
Found by review, by the audit (Template 08), or by someone noticing.

| # | What drifted | Spec said | Reality is | Found by | Ratify or revert | Date |
|---|---|---|---|---|---|---|
| DR1 | | | | | | |

### Drift is a gate failure, not an agent failure

An agent that adds an unrequested feature hasn't malfunctioned, it's done exactly what a
literal, capable thing does with an underspecified brief and no constraint. Blaming the model is
comfortable and useless. The question is always: what should have caught this, and why didn't
it?

Every drift entry should end with an answer to that. If the answer is "nothing, we don't have
that gate", then you've learned something more valuable than the drift cost you.

### The ratify trap

Ratifying drift is sometimes right, occasionally the machine's guess was better than the spec.
But ratifying by default means the spec is now a description of whatever happened, which is to
say it's documentation, which is to say you've stopped doing this. Watch the ratify-to-revert
ratio. If it's high, your specs are too weak, not your agent too clever.
