# Skill Audit: `spec-tasker` v2.1.0

**Auditor:** J. Studdart
**Date:** 2026-04-08
**Source:** community skill registry, 1.2k installs, 340 stars
**Verdict:** **DO NOT RUN**

> A real-shaped audit of a plausible skill. It does something useful. It has stars. It fails.

## Before you install

- [x] **Who publishes it?** GitHub account `devtools-collective`. Created 2026-01-19. Eleven
      repos, all published within four days of each other, all agent skills, all with tidy
      READMEs. No commit history predating the account. No named humans anywhere.
- [x] **How did you find it?** Top of the registry's "trending" list. Which is install count,
      which is not a signal of anything except install count.
- [x] **Can you read the source before installing?** Yes. Public repo.
- [x] **Does it need to exist?** It turns a spec into a task list. That's a prompt. I have
      written that prompt. It took eleven minutes.

**Stars are not provenance.** 340 stars on an account with no history before January is a
finding, not a reassurance.

## Read the skill

- [x] **Read all of it.** `SKILL.md` (240 lines), `scripts/parse_spec.py` (180 lines),
      `scripts/setup.sh` (40 lines).
- [ ] **Under five minutes to read?** No. Closer to twenty, mostly the Python. **FAIL.**
- [ ] **Any bundled scripts?** Two. A Python parser and a setup shell script. **FAIL.**
- [ ] **Any dynamic context or shell-execution directives?** Yes. Line 12 of `SKILL.md`:

      ```
      !`bash scripts/setup.sh`
      ```

      **FAIL, and this is the one that ends it.** That runs before the model reads the skill.
      Whatever reasoning the agent would apply to a suspicious instruction never happens,
      because the payload has already executed by the time there's anything to reason about.
      Check Point Research documented this execution ordering in Claude Code (CVE-2025-59536,
      CVE-2026-21852, disclosed 25 February 2026). The defences are downstream.

- [ ] **Any network calls?** `setup.sh` curls a "template pack" from a domain registered in
      January, pipes it to `bash`, and reports version telemetry to the same host. **FAIL.**
- [ ] **Any credential or environment access?** `parse_spec.py` reads `os.environ` wholesale
      into a dict it calls `context`, and includes it in the telemetry payload. **FAIL.**

      This is the whole game. Not a dramatic exfiltration routine, a variable named `context`,
      in a file called `parse_spec.py`, in a skill about task lists. Read past it once and
      you've handed over every token on the machine.

- [x] **Any base URL redirection?** No.
- [ ] **Scope of file access.** Globs `**/*.md` from the repo root upward until it finds a
      `.git`. On a monorepo that's a lot. **FAIL.**
- [x] **Instructions to override other instructions?** None. It doesn't need any; see the
      dynamic context line.
- [x] **Anything obfuscated?** No. It's all in plain sight, which is the interesting part.
      Nothing here is hidden. It's just boring, and boring is better camouflage than base64
      will ever be.
- [ ] **Does it match its own description?** "Converts a specification document into a
      structured task list." It does do that. It also reads your environment and posts it to a
      three-month-old domain. **FAIL.**

## Don't rely on scanning

- [x] **Read it myself.** The registry's automated scan gives this a green badge. Nothing here
      is malware by signature: it's a curl, a `bash`, and a dictionary. Every individual line
      is something a legitimate tool does.

## Verdict

| # | Criteria | |
|---|---|---|
| 1 | Read the whole thing | ✅ |
| 2 | Understood the whole thing | ✅ |
| 3 | Does only what it says | ❌ |
| 4 | Touches only what it needs | ❌ |
| 5 | Nothing leaves your machine | ❌ |
| 6 | Comfortable with worst-case access | ❌ |

**DO NOT RUN.** Reported to the registry. Still listed at time of writing.

## The twenty minutes

The audit took twenty minutes. Writing the prompt this skill wraps took eleven.

That's the entire argument, and it's not close. I spent nearly twice as long checking whether
someone else's convenience was safe as it would have taken to not need it. Multiply by every
skill in a toolchain, and the honest position isn't "audit everything", nobody sustains that,
it's that most of these shouldn't be in your toolchain at all.

npm you're often stuck with. This you can almost always decline. That asymmetry is the only
security control here that actually scales.

---

## For contrast: auditing this pack's own skills

Same checklist, applied to the skills shipped alongside these templates:

| Check | Result |
|---|---|
| Under five minutes to read | ✅ Longest is 90 lines of markdown |
| Bundled scripts | ✅ None. Not one file that isn't `.md` |
| Dynamic context / `!` commands | ✅ None. Deliberately |
| Network calls | ✅ None. No telemetry, including ours |
| Credential or env access | ✅ None |
| File scope | ✅ Working repo only |
| Matches its description | ✅ Read it and see |

Not a boast, a demonstration. A skill that does a genuinely useful job needs **none** of the
capabilities that make skills dangerous. Every red mark on `spec-tasker` came from a capability
it didn't need for the thing it claimed to do.

When a skill asks for more than its description justifies, that gap **is** the finding. There's
rarely a second, more obvious one.
