# Definition of Done: [team / project]

**Version:**
**Agreed by:**
**Date:**

> **The rule for every line on this list: it must be checkable by someone who wasn't in the
> room.**
>
> If a line needs its author present to adjudicate, it isn't a definition of done. It's a
> feeling with a checkbox next to it, and it will be ticked.

## The list

### Built
- [ ] Every AC on the feature spec has a test that asserts it.
- [ ] The traceability matrix (Template 08) has no unmapped ACs.
- [ ] Nothing shipped that doesn't trace to an AC, or the exceptions are logged in Template 07.
- [ ] No files touched outside the task's stated scope.

### Proven
- [ ] Tests assert behaviour, not implementation.
- [ ] Edge cases from the spec §8 have tests, not just the happy path.
- [ ] The "must never happen" list from spec §9 has tests. *(Negative cases. The ones nobody
      writes.)*
- [ ] Tests fail when the behaviour breaks. Verified by breaking it.

### Recorded
- [ ] Decision log updated for anything non-obvious.
- [ ] Spec updated if reality argued back, via a CR, not quietly.
- [ ] Not Building register unchanged, or changes logged as overturns.

### Operable
- [ ] It can be deployed by someone who didn't write it.
- [ ] It can be rolled back.
- [ ] When it breaks at 3am, there's enough in the logs to know why.

### Reviewed
- [ ] Read by someone who didn't write it, including anything an agent wrote.

## Banned words

Any line containing these gets rewritten or deleted:

**Done, working, tested, clean, refactored, robust, secure, performant, documented, handled,
covered, sorted.**

Each of them means "I have a feeling about this" and none of them can be checked. "Tested" is
the worst offender, because it sounds like evidence. Tested how? Asserting what? Failing when?

## Rewriting examples

| Tall tale | Actually checkable |
|---|---|
| Code is tested | Every AC has a test that fails when the behaviour breaks |
| Errors are handled | Every scenario in spec §8 has a test asserting the stated behaviour |
| It's secure | Every prohibition in spec §9 has a negative test |
| It's documented | The decision log has an entry for every non-obvious choice |
| It's performant | p95 under 200ms at 100rps, asserted in the load test |
| Code is clean | Reviewed and approved by someone who didn't write it |

## How this list dies

Watch for these, because it will happen quietly:

- **Lines get added and never removed.** A DoD nobody can complete gets ignored wholesale, and
  then you have no DoD at all. Prune it.
- **Ticks become ritual.** If every box is ticked on every ticket including the ones that
  shipped broken, the list is decorative. Audit the ticks occasionally, not just the code.
- **"We'll come back to it."** You won't. Either the line matters and blocks, or it doesn't and
  it goes.
