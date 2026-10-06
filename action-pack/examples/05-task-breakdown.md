# Task Breakdown: Password login

**Parent spec:** Kestrel first-party login v1.0
**Feature spec:** LOGIN
**Owner:** J. Studdart

## Tasks

### LOGIN-01: Credential storage

- **Objective:** a password can be stored against a user and verified, with nothing else changed.
- **Implements:** FR1 (partial), NFR1
- **Satisfies:** none yet *(no user-facing AC; verified by unit tests on the module)*
- **Depends on:** nothing
- **Effort:** S
- **Risk:** Low
- **Needs a human:** No
- **Out of scope for this task:** the login endpoint, sessions, rate limiting, the UI.

**Done when:**
- [x] Argon2id at NFR1 parameters, verified against known vectors.
- [x] `password_hash` nullable, where null means "no password credential", not "not set yet".
- [x] Verify function is constant-time and hashes a dummy on the not-found path.
- [x] Decision log updated if parameters deviate from NFR1. *(They didn't.)*

---

### LOGIN-02: Login endpoint

- **Objective:** POST /auth/login exchanges correct credentials for a session.
- **Implements:** FR1
- **Satisfies:** AC1, AC2, AC3, AC5, AC7, AC9
- **Depends on:** LOGIN-01
- **Effort:** M
- **Risk:** **High.** AC3 (timing) and AC9 (logging) are the two most likely things to be
  quietly wrong here, and both are invisible in a passing test suite unless the test is written
  to look for them specifically.
- **Needs a human:** No
- **Out of scope for this task:** rate limiting (LOGIN-03), tenant toggle (LOGIN-04), the UI
  (LOGIN-06). **Do not add a "remember me" option. See NB6.**

**Done when:**
- [x] Every listed AC has a test that asserts it.
- [x] AC3's timing test runs 1,000 iterations and asserts means within 50ms.
- [x] AC9 asserted by capturing logs at debug and grepping the fixture password.
- [x] No files touched outside `auth/`.

---

### LOGIN-03: Rate limiting

- **Objective:** five failures locks an account for fifteen minutes.
- **Implements:** FR5
- **Satisfies:** AC6
- **Depends on:** LOGIN-02
- **Effort:** S
- **Risk:** Medium. The lock must not become an enumeration oracle. A locked account and a
  non-existent one must be indistinguishable.
- **Needs a human:** No
- **Out of scope for this task:** IP-based limiting. Per-account only, per FR5.

**Done when:**
- [x] AC6 tested including the correct-password-while-locked case.
- [x] Lock state failure is fail-closed. If Redis can't be read, the attempt fails.

---

### LOGIN-04: Tenant toggle

- **Objective:** an admin can turn password auth on or off for their tenant.
- **Implements:** FR2
- **Satisfies:** AC4
- **Depends on:** LOGIN-02
- **Effort:** S
- **Risk:** Medium. The disabled path must be checked on every route into a session, including
  password reset. A toggle that's honoured by login but not by reset is not a toggle.
- **Needs a human:** **Yes.** Default value for existing tenants. Turning it on by default
  changes the security posture of every account without asking. *(Resolved: default off. D005.)*

**Done when:**
- [x] AC4 tested.
- [x] Reset flow also honours the toggle.

---

### LOGIN-05: Session creation and failure modes

- **Objective:** sessions are created correctly and login fails closed when Redis is gone.
- **Implements:** FR1 (completion)
- **Satisfies:** AC7, AC8
- **Depends on:** LOGIN-02
- **Effort:** S
- **Risk:** Low
- **Needs a human:** No

**Done when:**
- [x] AC8 tested with Redis actually stopped, not mocked. A mocked outage tests the mock.

---

### LOGIN-06: Login UI

- **Objective:** a form that submits to LOGIN-02 and shows the generic error.
- **Implements:** FR1 (UI)
- **Satisfies:** AC1, AC2 (at UI level)
- **Depends on:** LOGIN-02
- **Effort:** S
- **Risk:** Low
- **Needs a human:** No
- **Out of scope for this task:** **No strength meter (NB8). No remember-me checkbox (NB6).**
  Both are on the Not Building register. If the form looks bare next to every other login form
  on the internet, that is the intended appearance.

**Done when:**
- [x] Error text is identical for every failure mode.
- [x] No client-side validation that reveals anything the server wouldn't.

---

## Dependency order

```
LOGIN-01
   |
   v
LOGIN-02 ---+---> LOGIN-03
   |        |
   |        +---> LOGIN-04
   |        |
   |        +---> LOGIN-05
   |
   v
LOGIN-06
```

## Sizing note

LOGIN-02 was originally a single task covering the endpoint, rate limiting, and the toggle. It
was an L. It's now three tasks, because "L" isn't a size, it's a warning that nobody has
thought about it yet.
