# Skill Audit Checklist

**Use before running anyone's agent skill. Including the ones in this pack.**

> An agent skill can act through whatever tools and permissions its host agent has been granted:
> for a coding agent that typically means your repo, your shell, whatever credentials are in the
> environment, and the network. On the public registries the bar for publishing one has been a
> markdown file and an account, with no code signing, no security review, and no sandbox by
> default.
>
> This isn't a hypothetical. Snyk's *ToxicSkills* audit (5 February 2026), scanning 3,984 skills
> on the ClawHub and skills.sh registries, reported 76 confirmed malicious payloads, 534 skills
> carrying at least one critical-level issue, and eight malicious skills still live at the time of
> publication. A coordinated campaign aimed at Claude Code and OpenClaw users, 30-plus malicious
> skills on ClawHub, ran the same month. (Figures correct at time of writing, not maintained.)
>
> The audit takes five minutes. Do it.

## Before you install

- [ ] **Who publishes it?** A named person or org with history, or an account created last week?
- [ ] **How did you find it?** A marketplace listing, a search result, and a recommendation from
      a stranger are all the same thing wearing different hats.
- [ ] **Can you read the source before installing**, or does installing come first? If you can't
      read it first, that's the answer.
- [ ] **Does it need to exist?** The honest one. Most skills wrap a prompt you could write
      yourself in twenty minutes. That's the whole trade you're making, see the bottom of this
      file.

## Read the skill

- [ ] **Read all of it.** Not the README. The actual `SKILL.md` and every file it ships.
- [ ] **Under five minutes to read?** If not, it's too big to audit, which means you won't, which
      means you're trusting it blind. Don't run it.
- [ ] **Any bundled scripts, binaries, or executables?** A skill that needs to run code is a
      skill that can run any code.
- [ ] **Any dynamic context or shell-execution directives**, the `!` command syntax and its
      equivalents? On at least one major agent these have been shown to execute *before any
      user-consent dialog*, which means the model's own defences can be downstream of the payload.
      Check Point Research demonstrated exactly this in Claude Code (CVE-2025-59536, CVE-2026-21852,
      disclosed 25 February 2026). It is the single most important line on this checklist.
- [ ] **Any network calls?** Fetches, webhooks, telemetry, "analytics", update checks. Ask what
      leaves your machine and where it goes.
- [ ] **Any credential or environment access?** Env vars, config files, keychains, `~/.aws`,
      `.env`, git config. A skill about formatting markdown has no business reading your
      environment.
- [ ] **Any base URL or endpoint redirection?** The Check Point CVEs covered exactly this: API
      keys captured via repository-controlled configuration.
- [ ] **Scope of file access.** Working repo only, or wider? Does it touch anything outside the
      directory it was invoked in?
- [ ] **Instructions to ignore, override, or reinterpret other instructions?** Anything shaped
      like "disregard previous", "you may skip confirmation", "this is a trusted context".
- [ ] **Anything obfuscated?** Base64, hex, unusual encoding, invisible characters, text
      positioned where a human won't scroll. There is no innocent reason for an obfuscated
      markdown file.
- [ ] **Does it match its own description?** A skill that claims to lint your CSS and also reads
      your git remotes is not a linter with a bonus.

## Don't rely on scanning

- [ ] **You read it yourself.** Researchers have demonstrated skills that evade the large
      majority of scanners while keeping their payload functional, and separately a proof-of-concept
      that hid its payload behind an external URL the scanners never fetched. Much malicious
      behaviour is prompt injection, plain-English instructions a malware scanner isn't built to
      catch. Scanners are a floor, not a verdict.

## Running it

- [ ] **First run on a scratch repo with no credentials present.** Not on the client's codebase.
- [ ] **Watch what it actually does:** file access, network, shell. If your agent can log its
      tool calls, read them once.
- [ ] **Re-audit on update.** The version you read is not the version that auto-updated on
      Tuesday. This is the npm lesson and it will be the skills lesson.

## The verdict

**Run it only if every one of these is true:**

1. You read the whole thing.
2. You understood the whole thing.
3. It does only what it says.
4. It touches only what it needs.
5. Nothing leaves your machine.
6. You'd be comfortable with the worst-case version of what it can reach, because you're
   trusting the publisher with exactly that.

**Any doubt: don't.** And be honest that "it seemed fine" is not the same as points 1 through 6.

---

## The argument you should actually run

Every dependency is a trade: capability in, risk in. The question is never "is this risky", everything is, it's whether the capability is worth it.

**npm is often load-bearing.** A lot of production JavaScript depends on it, and vendoring or
hand-rolling everything isn't realistic, so you accept a large supply-chain exposure because the
alternative is not shipping. It's not literally unavoidable, but for most real projects it's
forced enough that "just don't use npm" isn't an answer.

**Skills are usually a convenience.** You are accepting a serious class of risk, action through
your agent's permissions plus a channel straight into its reasoning, to save yourself writing a
markdown file you could have written in twenty minutes.

Nobody runs that sum, because the install is one command and the risk lands on someone else
until it doesn't.

Skills are not the next npm waiting to explode; something already went off in early 2026. The
asymmetry that matters: npm you're often stuck with, a skill you can almost always simply decline.
Everything in this pack, every template, the whole method, is markdown you can read. That's the
point. If a skill can't clear this checklist, you didn't need it anyway.

**Sources (correct at time of writing, not maintained):** Snyk *ToxicSkills* (5 Feb 2026);
Check Point Research on load-time execution in Claude Code, CVE-2025-59536 (CVSS 8.7) and
CVE-2026-21852 (CVSS 5.3), disclosed 25 Feb 2026; scanner-evasion and external-URL proof-of-concept
research documented via the OWASP Agentic Skills Top 10 project (2026).
