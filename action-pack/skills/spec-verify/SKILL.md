---
name: spec-verify
description: Write tests that assert acceptance criteria rather than exercise implementation. Use after a task is built, to prove each criteria holds. Tests behaviour not mechanism, includes negative cases for prohibitions, and checks that each test would fail if the behaviour broke.
metadata:
  version: "1.0.0"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-verify

**What this skill does:** writes tests that assert the acceptance criteria, including the
negative cases for things that must never happen.

**What this skill touches:** the test files it writes, in the working directory, and, in Phase 4
only, and only in a clean disposable checkout, it *temporarily* mutates source code to confirm a
test fails, then restores it. It reads the feature spec to know the criteria. It changes no source
permanently.

**What this skill does NOT do:** no scripts beyond the tests it writes, no network, no
environment or credential access, nothing outside the working directory. It does not mutate code
outside a clean, disposable, non-shared checkout, and it does not leave any mutation unreverted.
Plain instructions. Read them.

---

## The one rule

Test the criteria, not the code. You are not proving the function does what it does, that's
trivially true. You are proving the system exhibits the behaviour that was agreed.

## Process

### Phase 1: One test per criteria

For each acceptance criteria in the feature spec, write a test that asserts the behaviour it
describes. Given the starting state, when the action, then assert the observable result. Include
the awkward corners the criteria names (the correct password during a lockout; the concurrent
case; the empty input), those are usually where the criteria earns its keep.

### Phase 2: Behaviour, not implementation

Write each test so it would pass against any correct implementation and fail against any
incorrect one. If a legitimate refactor would break the test, the test is coupled to mechanism,
rewrite it to assert the outcome instead. A test that knows which library hashes the password is
testing the wrong thing.

### Phase 3: The negative cases

For every item in the spec's "what must never happen" section, write a test that would go red if
the forbidden thing occurred, on the paths where it could actually occur, including exception
and error paths. These are the tests nobody writes, because they protect against things that
haven't happened yet. Write them anyway. They are the ones that matter most.

### Phase 4: Make each test fail on purpose (safely)

A test you've never seen fail is a test you don't know works. So confirm each one by temporarily
breaking the behaviour it checks and watching it go red, but this step **modifies source code**,
so it has preconditions that are not optional:

- **Clean worktree first.** Do not start until version control shows no uncommitted changes, so
  every edit is visible as a diff and nothing of the author's is at risk.
- **Never against a live, shared, or production environment**, or against a working copy you can't
  cheaply throw away. Mutate in a local disposable checkout only.
- **One mutation at a time, captured.** Record the exact edit (the diff) before making it: invert
  the condition, remove the guard, whatever isolates the behaviour. Run the test, confirm it goes
  red.
- **Restore and verify.** Revert the edit and confirm the working tree is byte-for-byte back to
  where it started (`git status` clean, `git diff` empty) before moving to the next test. A
  mutation you forget to revert is a bug you just wrote.
- Prefer a real mutation-testing tool, or applying and reverting a tracked patch, over casual
  hand-edits, both make the restore automatic and auditable.

Report any test that stayed green when you broke its behaviour, that test is theatre and must be
rewritten. And report any mutation you could not cleanly restore, loudly, as a problem to fix
before proceeding.

## Refuse to rely on names

A test's name is a claim, not evidence. Never treat a passing test named `test_no_password_in_logs`
as proof that no password reaches the logs, read what it actually asserts, and on which paths.
If the assertions don't cover the criteria, the test is incomplete regardless of its name.

## Acceptance criteria for this skill's output

- Every criteria has a test that asserts it.
- Tests assert behaviour, not implementation.
- Every prohibition has a negative test on the paths where it could occur.
- Every test has been seen to fail when its behaviour is broken.
- Every mutation made to prove a test was reverted, with the working tree confirmed clean
  afterwards.
