# Agent Prompt: 001 Kestrel login, tasks LOGIN-03 to LOGIN-05

**Coordinator:** J. Studdart
**Date:** 2026-03-18
**Model:** mid *(three S tasks. LOGIN-02, the M task, went to the top model on its own)*

```markdown
You are building feature 001 (Kestrel first-party login) under the spec-driven method. Use the
spec-build skill if you have it.

## Your tasks

Build these in order, one at a time. Each is held to its own scope in `tasks.md`.

- LOGIN-03: five failures locks an account for fifteen minutes.
- LOGIN-04: an admin can turn password auth on or off for their tenant.
- LOGIN-05: sessions are created correctly and login fails closed when Redis is gone.

LOGIN-01 and LOGIN-02 are done. The previous agent's report:

    Done: LOGIN-01, LOGIN-02
    Commits: 4e1c9a2 credential storage, argon2id at NFR1; b07d3f5 POST /auth/login
    Open questions: none
    Not decided by the spec: dummy hash on the unknown-email path uses the same parameters
    as a real one, so AC3 timing holds. Logged as a note on LOGIN-02, not a decision.

## Read these, and only these

Standing rules:
- `docs/spec/constitution.md`
- Operating rules: `docs/spec/constitution.md` §9. Don't retype them here.

Spec files for this feature, picked from `docs/spec/INDEX.md`:
- `docs/spec/features/001-user-login/tasks.md`, LOGIN-03 to LOGIN-05
- `docs/spec/features/001-user-login/feature-spec.md`, criteria AC4, AC6, AC7, AC8
- `docs/spec/features/001-user-login/not-building.md`

Decisions that bind this work, picked from `docs/spec/decision-log.md`:
- D003 session expiry, `docs/spec/features/001-user-login/decision-log.md`
- D004 toggle not enforced mid-session, same file
- D005 password auth defaults to off for existing tenants, same file

Code, from the briefs of LOGIN-03 to LOGIN-05:
- `auth/login.py`, `login()` only
- `auth/limiter.py`
- `auth/session_service.py`
- `auth/reset.py`, `request_reset()` only. The toggle has to be honoured here too
- `tenants/settings.py`

Do not read any other feature's folder. Do not open code files that are not listed here; if you
need one, stop and ask for it. Read each file once, and only read it again if it has changed.

## Tests

While building, run only these, with output to a log you grep rather than read in full:

    pytest tests/auth/test_limiter.py tests/auth/test_tenant_toggle.py tests/auth/test_sessions.py \
      > .agent-logs/login-03-05.log 2>&1; grep -E "passed|failed|error" .agent-logs/login-03-05.log

Run them once to see them fail and once to see them pass. Do not run the whole suite; that
happens once, after merging.

## Stop and report when

- the tasks above are done;
- the tests have failed twice in a row;
- you have made 120 tool calls;
- you meet a decision the spec didn't make, or you would need a file not listed here;
- anything you are about to add appears in `not-building.md`. NB6, "remember me", is the one
  that keeps coming up.

## Report

About 10 to 15 lines. Nothing else.

- Done: [task IDs]
- Commits: [hash, one line each]
- Open questions: [one line each]
- Not decided by the spec: [what you met, and what you did instead of deciding it]
- Files touched: [paths]
- Wrong pointers: [any brief entry that was missing or had moved, or "none"]
```

What came back:

```
Done: LOGIN-03, LOGIN-04, LOGIN-05
Commits:
  9a41e07 LOGIN-03 per-account lockout, fail closed on Redis read error
  c2d8b11 LOGIN-04 tenant toggle on login and reset
  e5f0a93 LOGIN-05 session creation scoped to tenant, 503 on Redis down
Open questions:
  - AC8 is tested with Redis stopped in the test container. Is that acceptable in CI, or
    does CI need its own Redis it can stop?
Not decided by the spec:
  - Whether a password reset clears an active lockout. Nothing says so. I left the lock in
    place and did not add a clear. Needs a decision.
Files touched: auth/limiter.py, auth/login.py, auth/reset.py, auth/session_service.py,
  tenants/settings.py, and their three test files
Wrong pointers: none
```

Fourteen lines. Both questions went to the coordinator to decide, and the whole suite ran once,
after the merge.
