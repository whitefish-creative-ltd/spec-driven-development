---
name: spec-audit
description: "Verify that what was built matches what was specified, adversarially and from outside the build. Use after a feature is built and tested, to produce a traceability matrix and drift report. Never verifies its own build output: run it as a separate pass with no build context."
metadata:
  version: "2.1.1"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-audit

**What this skill does:** compares what was specified against what was built and what was proven,
and reports every place they disagree.

**What this skill touches:** the spec, the feature specs, the not-building register, the code,
and the tests, source read-only, in the working directory, the templates named below, plus the audit
report it writes. If
it runs the test suite to check results, that can write caches, snapshots and coverage artifacts;
it treats source as read-only but does not pretend running tests is side-effect-free.

**What this skill does NOT do:** no scripts of its own, no network, no environment or credential
access, nothing outside the working directory. It does not modify source. Plain instructions.

**Operational precondition:** run this in a *new* agent session or as a genuinely separate agent,
against a clean checkout, see the one rule. A skill cannot enforce its own session isolation, so
this is on the operator: if you run it in the same context that built the feature, you have
defeated the point of it.

**What to give it.** The feature's spec files, the commit range the feature was built in, and the
whole-suite command from the constitution's operating rules. Not the builder's reading list: the
audit exists to find what the builder's model of the code missed, and starting from the builder's
pointers hands it that model. The commit range is the pointer nobody chose. Read the diff first;
open other code only to trace a criteria or to follow something the diff touches. Stop and report
at the tool-call budget, as a build agent would.

---

## Templates

For each template below, use the project's copy at `docs/spec/templates/<file>` if there is one,
because the team may have adapted it. If there isn't, use the copy in this skill's own folder,
`templates/<file>`. Never write one of these documents from memory: the template is the format
the other skills, and the next person to read it, expect.

- `08-ac-traceability-matrix.md` → `docs/spec/features/NNN-name/traceability.md`, the report
- `07-change-and-drift-register.md` → the format for each drift finding and its recommended
  verdict. The audit reports them; it does not write them into the feature's
  `change-and-drift.md`, because deciding them is a person's job

## The one rule

The thing that built it cannot be the thing that verifies it. Run this as a separate pass, with
no build context. If you are the same agent session that implemented the feature, you are the
worst possible auditor of it, you'll confirm your own model of the code, fluently and uselessly.
A fresh pass with only the spec and the code is the whole mechanism. Do not skip it.

Approach the work adversarially. Your job is not to confirm it's good. It's to find where the
agreement and the reality have come apart, and to assume they have somewhere, because they
usually have.

## Process: three comparisons

### Part 1: Specified vs. proven (the traceability matrix)

List every acceptance criteria. For each, find the test that proves it, and **read what the
test actually asserts.** Do not trust the test's name. A test named for a criteria that doesn't
assert that criteria is the finding this part exists to catch.

For each criteria record: the test, whether it's automated, whether it passes, and whether its
assertions actually cover the criteria including its awkward paths. A criteria with no test, or
with a test that doesn't really assert it, is **unmapped**, that's agreed behaviour nothing
verifies. Report it.

### Part 2: Built vs. specified (the drift catch)

Walk the diff for the commit range, everything that was built. Check it against each task's Touch
list first: a file changed outside every Touch list is a finding in its own right. Then, for each
piece, ask which criteria it traces back to.
Anything tracing to nothing gets a verdict:

- **Revert:** it's on the not-building register, or it's unwanted. It's drift.
- **Change request:** it's a good idea; the spec should adopt it deliberately.
- **Ratify:** the build's guess was better than the spec; update the spec to match, on the
  record.

Report the ratify-to-revert ratio. If most drift is being ratified, the specs are too thin, not
the agent too clever, say so.

### Part 3: Specified vs. absent

Find every criteria with no implementation. Separate the legitimately deferred (marked Should/
Could, with a decision behind it) from the **missed** (agreed, tasked, never built, nobody
noticed). A missed criteria is evidence the task-to-done gate isn't working. Report the pattern,
not just the instances.

## Output

A report in the shape of `08-ac-traceability-matrix.md`, written to the feature's
`traceability.md`: the three parts above, a summary (criteria specified, criteria with a real
asserting test, unmapped criteria, untraced builds, missed criteria), and a verdict: Clean,
Findings, or Fail. Findings or Fail blocks release until resolved.

## Division of labour

You find the disagreements. A human decides what they mean, revert, adopt, or defer is a
judgement about the product, and it stays with a person. Present the findings; recommend
verdicts; don't enact them.

## Acceptance criteria for this skill's output

- Every criteria appears in the matrix with its test read, not just named.
- Every untraced build has a verdict.
- Missed criteria are separated from deferred ones.
- The report states a clear overall verdict.
- The audit was run without build context (new session/agent, clean checkout).
