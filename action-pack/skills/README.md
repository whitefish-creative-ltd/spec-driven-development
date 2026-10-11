# The spec-driven skills

Five skills, one per stage of the loop, plus `spec-orchestrate`, which hands the build stage out
to agents, and `spec-recover`, which brings an existing codebase *into* the loop. They compose,
and each is useful alone. An eighth, `spec-update`, is not part of the method: it checks whether
the other seven are the latest version.

| Skill | Does |
|---|---|
| `spec-forge` | Interview a vague request into a spec plus a not-building register |
| `spec-decompose` | Break the spec into independently verifiable tasks |
| `spec-orchestrate` | Hand tasks to build agents from their briefs, and keep the state in the repo |
| `spec-build` | Implement a feature's tasks one at a time, refusing out-of-scope work |
| `spec-verify` | Write tests that assert the criteria, including negative cases |
| `spec-audit` | Compare specified versus built versus proven, adversarially |
| `spec-recover` | Recover a spec-shaped account of an existing codebase, then validate it against the code |
| `spec-update` | Check the installed skills against the latest release, and say what changed |

The first five drive the forward loop: spec, decompose, build, verify, audit. `spec-recover` runs
the same discipline backward: for a brownfield or inherited system that never had a spec, it
recovers one from the code so you can start speccing changes against something real.

## Installing them

Each skill is a folder with a `SKILL.md` in it, which is the open Agent Skills format, so they are
not Claude-only. Copy the folders into whichever skills directory your agent reads. At the
time of writing that is `.claude/skills/` for Claude Code, `.agents/skills/` for Codex, and
`.cursor/skills/` for Cursor, which also reads the other two. Those paths move, so check your
tool's current docs.

```
cp -R skills/spec-* .claude/skills/     # or .agents/skills/, or .cursor/skills/
```

## How to invoke one

Every agent that supports skills will pick one up on its own when your request matches its
description. You can also call one explicitly, and the key differs by tool:

| Agent | Explicit call |
|---|---|
| Claude Code | `/spec-build ...` |
| Cursor | `/spec-build ...`, or type `/` and search the list |
| Codex | `$spec-build ...` (`/skills` lists them) |

The slash form is not a Claude-only convention, Cursor uses the same key. Codex is the odd one out
with `$`. Correct at August 2026 and not maintained: check your tool's docs, because this is
exactly the sort of thing vendors change.

None of that is the part that matters, though. What matters is that **you have to tell it which
files it is working on**, because every skill in here operates on artefacts in your repository
rather than on the conversation. Whatever you type after the skill name is still your prompt, so
the paths go there:

> `/spec-build` task 001-03 in `docs/spec/features/001-user-login/tasks.md`

Or, in the form that works on every tool including plain automatic activation:

> Use spec-build for task 001-03 in `docs/spec/features/001-user-login/tasks.md`.

That is the whole trick. The folder layout in the pack's main README exists so those paths are
predictable, and the skills stop needing to guess what you meant by "the spec".

## A route through, one feature end to end

This is the Kestrel login feature from `examples/`, run the way you would run your own. Each step
is a real prompt.

**0. Only if the code already exists.** Skip this on a new project.

> Use spec-recover on this repository and write the result to `docs/spec/recovered-spec.md`.

Now you have something to spec changes against, instead of guessing at a system nobody documented.

**1. Turn the request into a spec.** Make the feature folder first,
`docs/spec/features/001-user-login/`. Login is new code, so there is nothing to map. Had it changed
code that already exists, spec-forge would first have a separate read-only agent draft
`inventory.md`, every existing behaviour and its `file::function`, and the interview would decide
where each one goes.

> Use spec-forge. I want first-party login for Kestrel. Write the problem brief to
> `docs/spec/features/001-user-login/problem-brief.md`, the spec to `feature-spec.md` in the same
> folder, and the not-building register to `not-building.md` beside it.

Expect to be interrogated rather than transcribed. When it asks what must never happen, that is
the question that produces the negative tests four steps from here, so answer it properly.

**2. Cut it into tasks.**

> Use spec-decompose on `docs/spec/features/001-user-login/feature-spec.md`. Write the tasks to
> `tasks.md` in the same folder.

It will refuse to write a task that cannot be verified on its own, and it will flag any criteria
no task points at. Both refusals are the skill working, not the skill being awkward. Every task
also gets a brief: the functions to read, the files it may touch, and the command that proves it.
That brief is what lets a build agent start without exploring.

**3. Build, one task at a time.** This is the step people get wrong by handing over the whole
feature as one job. One agent takes the feature, but it builds the tasks one at a time, in order,
each held to its own scope, and no more than four or five of them before a fresh agent takes over.
Run the coordinating in its own session:

> Use spec-orchestrate on `docs/spec/features/001-user-login/tasks.md`.

It fills in Template 12 from the briefs and hands each batch to a fresh build agent, on the model
the tasks call for. Without the skill, fill in Template 12 yourself and hand it over:

> Use spec-build for tasks 001-01 to 001-04 in `docs/spec/features/001-user-login/tasks.md`.
> Read only the files listed in this prompt: [the reading list from Template 12].

It reads the constitution, the tasks, the feature spec and the not-building register before it
writes anything, which is how it knows where the edges are, and it reads only what the prompt
names. If you then ask it mid-task for a "remember me" box that is on the not-building register,
it is supposed to refuse and name the register entry. When it hands back, the next tasks go to a
fresh agent along with its report.

How to run build agents without burning through tokens is in `spec-orchestrate/SKILL.md`, and
the measurements behind it are in `spec-build/SKILL.md` under "Working efficiently". Read both
before your first build.

**4. Prove it.**

> Use spec-verify on `docs/spec/features/001-user-login/feature-spec.md`. One test per criteria,
> and the negative cases for the "must never happen" list.

Phase 4 of that skill deliberately breaks the code to confirm each test fails when it should. Give
it a clean, disposable checkout to do that in, never your working tree.

**5. Audit it, in a new session.** This one has a hard precondition and it is the step most worth
getting right.

> Use spec-audit on `docs/spec/features/001-user-login/`. Write the matrix to `traceability.md` in
> that folder.

**Start a fresh session, or use a different agent entirely.** A skill cannot enforce its own
isolation, so this is on you. Run the audit in the same session that built the feature and it will
confirm its own model of the code, fluently, and tell you nothing. That defeats the point of the
whole pack, and it is the easiest mistake in it to make.

## What each one needs, and what it leaves behind

| Skill | Reads | Writes | Run it |
|---|---|---|---|
| `spec-recover` | the repository, read-only | a recovered spec document | Once, on inherited code |
| `spec-forge` | you, in an interview; existing code, read-only, through a separate agent, if the feature changes it | problem brief, feature spec, not-building register, and an inventory if needed | Once per feature |
| `spec-decompose` | the feature spec and inventory | the task breakdown, each task with a brief | Once per feature |
| `spec-orchestrate` | coordinator notes, `tasks.md`, the constitution's operating rules | agent prompts, task status, coordinator notes | In its own session, ended at a boundary |
| `spec-build` | constitution, and the tasks, spec files, decisions and code its prompt names | the code for those tasks, and a short hand-back report | Once per feature, four or five tasks per agent |
| `spec-verify` | the feature spec | the tests | Once per feature, on a disposable checkout |
| `spec-audit` | spec, code, tests | the traceability matrix | Once per feature, **in a fresh session** |

## Provenance

Template 10's first question is "who publishes it?", so these answer it, rather than being copied
`SKILL.md` files with no author. All eight are:

- **Published by** WhiteFish Creative (James Studdart), as part of the SDD Action Pack.
- **Version** 2.1.0, stated in each `SKILL.md` under `metadata.version`. What changed between
  versions is in `CHANGELOG.md` in the repository.
- **Canonical source:** the GitHub repository at
  `github.com/whitefish-creative-ltd/spec-driven-development`, where every version is a tagged
  release. The method itself is written up at `whitefishcreative.co.uk/spec-driven-development/`.
  They ship inside the pack; there is no separate registry listing to trust or mistrust.
- **Licence:** MIT, in `LICENSE` in the repository and the pack.
- **Update policy:** versioned with the pack. Run `spec-update`, or look at the releases page, to
  see whether yours are current. Re-audit against Template 10 on any change, the version you
  read is the version you run.

That's the provenance a reader needs to make the trust decision the checklist asks for. It doesn't
substitute for reading them.

## Read them before you run them

Every one of these is a single markdown file. That's deliberate, and it's the whole argument of
[Spoke 6](https://whitefishcreative.co.uk/spec-driven-development/the-untold-truth/). Before you run any skill, these or anyone
else's, put it through the Skill Audit Checklist (`templates/10-skill-audit-checklist.md`). These
are built to pass it:

- **Pure markdown.** No bundled scripts, no executables, nothing to compile.
- **No load-time command execution.** None of the `!`-style dynamic context that runs before the
  agent's own reasoning engages.
- **No network calls.** Nothing phones home. No telemetry, including ours. The one exception is
  `spec-update`, whose whole job is to make one: a single read-only request to the pack's public
  GitHub releases, only when you run it, stated at the top of the file. If you don't want it,
  don't install it; the other seven never touch the network.
- **No credential or environment access.** Nothing outside the working repository. `spec-recover`
  reads the repo you point it at, read-only, skips secret files, and its orientation step uses
  standard read-only file listing, it writes nothing to the code and sends nothing off the machine.
- **Readable in under five minutes each**, and each opens by stating what it touches.

If you can confirm all of that by reading them, and you can, in about half an hour for the set,
run them. If you couldn't confirm it for someone else's skill, that's your answer about that
skill.

## What passing the checklist does and doesn't mean

These eight clear the *static* packaging checks: one markdown file each, no bundled executables, no
`!`-style load-time execution, no network calls beyond `spec-update`'s one, no credential or
environment access, each readable in a few minutes. That is necessary, not sufficient. Template 10
also asks for a scratch-repo run with the tool calls watched, and a re-audit on update, and, above
all, it asks you to *read them yourself*. A markdown-only skill can still contain a prompt injection
or steer an agent into destructive tool use through the agent's own legitimate permissions; removing
scripts and network directives shrinks the attack surface, it does not make instructions
trustworthy. So: read them, and ideally have someone who didn't write them read them too. As of now
that non-author read has not happened, the skills pass the static checks by the author's own scan,
which by the pack's own argument is not the same as passing.

## They are not required

You can run the entire method with the templates and no skills at all. The skills automate the
repetitive parts; they don't confer the discipline. If you're unsure whether to trust them, the
honest answer is you don't need to, the templates are the method, and they're just files.
