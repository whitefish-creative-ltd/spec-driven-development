# Changelog

The action pack and its skills are versioned together. Each `SKILL.md` states its version under `metadata.version`.

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
