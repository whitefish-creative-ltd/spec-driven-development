# The Constitution: [project]

**Status:** Living document, the standing rules the build runs under
**Owner:**
**Last updated:**

> This is the one file every agent reads before it does anything, and it is deliberately **not**
> `CLAUDE.md`, `.cursorrules`, `GEMINI.md`, or any single tool's config. It's plain markdown that
> you point whatever agent you're using at, and that you hand to a human on their first day too.
> One source of truth for how work is done here, that outlives whichever tool you're using this
> quarter.
>
> The spec says what to build. The constitution says how anything gets built, always, regardless
> of the task. If a rule only applies to one feature, it belongs in that feature's spec, not
> here. This file is for the things that are true every time.
>
> Keep it short enough that someone will actually read it. A constitution nobody reads governs
> nothing. If it grows past a couple of pages, you're putting spec-level detail in it, take it
> out.

## How to use this file

- **With an agent:** reference it at the top of every session, or wire it into whatever
  standing-instructions mechanism your tool has, but keep the canonical copy here, in the repo,
  tool-agnostic. The tool-specific file, if you need one, should be one line: "follow
  `constitution.md`."
- **With a human:** it's the onboarding document. Everything a new starter needs to not annoy
  everyone in their first week.
- **In review:** it's the thing a pull request is checked against, alongside the spec. "Does this
  follow the constitution" is a review question.

---

## 1. Non-negotiables

The rules that are never worth breaking, that an agent must never decide to override for
convenience, and that a human should escalate rather than quietly ignore. Keep this list short,
everything on it should be something you'd genuinely block a merge over.

- Never commit secrets, keys, or credentials. Not even temporarily. Not even in a branch.
- Never touch [directories / systems that are off-limits] without explicit sign-off.
- Never weaken a security control to make a test pass.
- Never add a dependency without flagging it (see §4).
- [your own]

## 2. When you hit a decision that isn't specified

The single most important behaviour, so it goes near the top.

**If the spec doesn't cover it, do not decide it silently.** Stop and flag it. A guessed decision
is drift even when the guess is good, because nobody chose it and nobody recorded it. This
applies to agents and humans equally. The right move is: surface the gap, get it decided, write
the decision in the decision log, continue.

The wrong move is to pick the plausible option and keep going. That's how a spec quietly becomes
whatever happened to get built.

## 3. Coding standards

Keep this to what's genuinely standard here and not obvious from the code itself. Don't restate
your linter's rules, point at the linter.

- **Language(s) and versions:**
- **Formatter / linter:** [tool + config location]. It is authoritative; don't argue with it in
  review.
- **Naming:** [conventions that aren't enforced by tooling]
- **File / module structure:** [where things go, and why]
- **Error handling:** [the house pattern: how errors are raised, wrapped, surfaced]
- **Logging:** [what gets logged, at what level, and, critically, what must never be logged]
- **Comments:** [when a comment is expected vs. noise]
- **Anything the obvious approach gets wrong here:** [the local traps]

## 4. Dependencies

- New dependencies are flagged before they're added, not after. State what it's for and what it
  replaces.
- [Approval process, if any]
- [Banned or discouraged libraries, and why]
- Every dependency is a trade: capability in, risk in. Small, well-understood, and actually
  needed beats large, popular, and convenient.

## 5. Testing

The constitution-level testing rules. The per-feature detail lives in the feature spec and the
Definition of Done.

- Tests assert behaviour, not implementation.
- Every acceptance criteria has a test that asserts it.
- Every prohibition ("must never happen") has a negative test, including on error paths.
- A test is confirmed by watching it fail when the behaviour breaks, before it's trusted.
- [Coverage floor, if you set one, and the note that coverage is a floor, not a verdict]

## 6. Git and change hygiene

- **Branching:** [model]
- **Commits:** [format / conventions]
- **Pull requests:** [what a PR must include: link to the spec, the criteria it satisfies, a
  note on anything touching the not-building register]
- **The scope check:** every PR is read against the not-building register, not just for
  correctness. "Did we agree to this" is a separate question from "is this good code", and both
  get asked.

## 7. Security posture

- [Authentication / authorisation rules that apply across the project]
- [Data handling: what's sensitive, how it's treated, what must never be exposed or logged]
- [Input handling defaults]
- Secrets management: [where secrets live, how they're accessed, never in code or logs]
- [Anything specific to your compliance context]

## 8. Working with agents specifically

- The canonical rules are in this file, not in any tool's config. Tool config points here.
- An agent that adds something unrequested has drifted, however helpful it looks. See the scope
  check in §6.
- Skills and extensions are audited before use (see the Skill Audit Checklist). Nothing that
  can't be read in five minutes gets run.
- An agent verifying its own output is marking its own homework. Verification is a separate pass.

## 9. What this file is not

- Not the spec. It doesn't say what to build.
- Not documentation of the system. It doesn't describe what exists.
- Not a style guide your linter already enforces. Point at the linter instead.
- Not a place for feature-specific rules. Those go in the feature spec.

It's the standing rules, tool-agnostic, short enough to read, that govern how anything here gets
built, by anyone, human or machine, this quarter or next, whatever tool they're holding.
