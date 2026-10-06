# AC Traceability Matrix: [feature / release]

**Spec version:**
**Date:**
**Audited by:** *(must not be whoever built it)*

> This is the document that decides whether any of the rest of it was worth doing.
>
> Everyone writes specs. Almost nobody checks. A spec you never trace against is a spec you
> wrote to feel organised.

## Part 1: Specified vs. proven

Every acceptance criteria, the test that proves it, and the result. Nothing else.

| AC | Requirement | Test | Automated | Result | Notes |
|---|---|---|---|---|---|
| AC1 | FR1 | `test_name` | Yes | Pass | |
| AC2 | FR1 | none | none | **UNMAPPED** | |

**An unmapped AC is the finding.** Not a gap in the paperwork, a piece of agreed behaviour that
nothing checks. It's either untested, or it wasn't built, and the matrix doesn't care which
because both are the same risk.

## Part 2: Built but not specified

Walk the diff. Everything shipped that doesn't trace back to an AC goes here.

| What | Where | Traces to | Verdict |
|---|---|---|---|
| | | Nothing | Revert / Raise CR / Ratify |

This is the drift catch. Anything with "Nothing" in the third column got built because someone,
or something, decided on your behalf. It might be fine. It might be an authentication bypass
someone added to make the tests pass. You don't know until you look, and nobody looks unless
there's a table with an empty cell in it.

Log everything here in Template 07.

## Part 3: Specified but absent

| AC | Requirement | Status | Why |
|---|---|---|---|
| | | Not built | Deferred / Missed / Blocked |

"Missed" is the interesting row. If an AC was agreed, tasked, and simply didn't happen, and
nobody noticed until the audit, then the gate between task and done isn't working.

## Part 4: Summary

- ACs specified: __
- ACs with a passing test: __
- ACs unmapped: __
- Shipped behaviour with no AC: __
- **Verdict:** Clean | Findings | Fail

## Rules

1. **The auditor didn't build it.** Self-verification is a model marking its own homework, and
   it's no better when a human does it. If you use an agent for this, it must be a separate one
   without the build context; the same session that wrote the code is the worst possible
   witness to whether the code is right.
2. **A test that passes but doesn't assert the AC is worse than no test**, because it buys
   false confidence at full price. Read the assertion, not the green tick.
3. **Coverage is not this document.** Coverage tells you which lines ran. This tells you which
   agreements hold. A codebase can have 95% coverage and zero traced ACs, and that combination
   is common enough to be a genre.
