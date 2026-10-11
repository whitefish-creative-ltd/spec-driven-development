# Not Building Register: [feature]

**Status:** Living document, append only
**Owner:**
**Last updated:**

> This is a standalone document on purpose. Non-goals buried inside a spec get quietly
> overturned by whoever is tired on a Friday afternoon. Kept separate, they have to be argued
> against in the open.
>
> Every line needs a reason. "Out of scope" is not a reason, it's a restatement of the heading.

## Not building

| # | Thing | Why not | Decided | Revisit when |
|---|---|---|---|---|
| NB1 | | | | |
| NB2 | | | | |

**Revisit when** is optional but valuable. "Never" is a legitimate answer. So is "if we pass
1,000 tenants". A non-goal with a trigger is a decision; one without is sometimes just a
flinch.

## Overturned

When something moves off the register and into scope, it moves here. It does not get deleted.
Requires a change request (Template 07).

| # | Thing | Why now | CR | Date |
|---|---|---|---|---|
| | | | | |

## Why this exists

Three failure modes this prevents:

1. **The helpful agent.** Told to build X, it also builds Y, because Y seemed related and it had
   the context window spare. If Y is on the register, the register is the answer.
2. **The reasonable-sounding ask.** Every individual scope addition sounds fine. It's only the
   fortieth one, in aggregate, that killed the project, and by then nobody can reconstruct how
   you got there. This document is that reconstruction, written in advance.
3. **The assumed inclusion.** The client thought it was obviously included. You thought it was
   obviously not. Neither of you said. This is where you say.
