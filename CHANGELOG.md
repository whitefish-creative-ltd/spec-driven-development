# Changelog

The action pack and its skills are versioned together. Each `SKILL.md` states its version under `metadata.version`.

## 2.1.0 — 2026-10-11

- **Task briefs.** Every task in template 05 now says what to read (`file::function`), which files it may touch, and the command that proves it, plus its model when that differs from its size. spec-decompose checks that an agent could start each task without exploring, because unguided exploring is where build agents spend most of their tokens
- **Inventory.** For a feature that changes existing code, spec-forge has a separate read-only agent draft `inventory.md` (each existing behaviour and its `file::function`), and the interview decides where each one goes. Behaviour that stays gets a criteria. spec-decompose cites the inventory's rows in each brief, so the code is located once instead of by every build agent
- **spec-orchestrate**, a new skill for the coordinator. It hands out tasks from their briefs, never reads code, keeps the state in `tasks.md` and `coordinator-notes.md`, and ends its session at a boundary. The coordinator rules move there from spec-build, which keeps the agent's rules and the measurements
- **Operating rules**, a new §9 in the constitution: build and test commands, paths never to touch, merging, model tiers, budgets. Prompts point at it instead of retyping it
- A tool-call budget for build and audit agents: stop and report rather than run on. Reports now list the files touched and any pointer in a brief that was wrong
- spec-audit starts from the commit range, not the builder's reading list, and treats a file changed outside every task's Touch list as a finding
- `coordinator-notes.md` has a shape, and holds nothing `tasks.md` already holds; tasks now have a Status
- spec-update says when a release adds a skill you don't have
- Fixed: template 05's "Done when" checked a scope that no task ever stated
- Fixed: the recommended `CLAUDE.md` told agents to read the whole feature folder when they weren't given a list. It now tells them to ask

## 2.0.0 — 2026-10-06

- **Running build agents efficiently**, a new section in `spec-build`: one agent per feature, four or five tasks per agent, the coordinator names the reading, targeted tests while building and the whole suite once after merging, the model matched to the task size, a 10–15 line hand-back report, and fresh coordinator sessions. Measured across 141 agent transcripts: 62% fewer new tokens and 42% lower cost per completed task
- `spec-build` now builds a feature's tasks one at a time, in order, and reads only what its prompt names
- Template 12, the agent prompt, with a worked example for the Kestrel login feature
- `docs/spec/INDEX.md`, the spec index, added to the layout with a short template: one line per feature, with its folder
- Decision numbers are now project-wide: every decision takes the next free number in `docs/spec/decision-log.md` and gets its line there, so a number means one decision everywhere. The constitution template now points at the decision log
- `docs/spec/coordinator-notes.md` added to the layout: a few lines a fresh coordinator picks up from
- `spec-update`, an optional skill that checks the installed skills against the latest release
- `spec-audit`'s description is now quoted, so strict YAML parsers can read its frontmatter

## 1.0.0 — 2026-08-18

- First release: eleven templates, eleven worked examples (the Kestrel login feature, plus a skill audit), and six skills: `spec-forge`, `spec-decompose`, `spec-build`, `spec-verify`, `spec-audit` and `spec-recover`
- Published on GitHub on 2026-10-06 under the MIT licence, with each skill's version in its frontmatter
