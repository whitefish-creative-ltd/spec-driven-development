---
name: spec-recover
description: Recover a spec-shaped account of an existing codebase, then validate it against the code. Use when inheriting, documenting, mapping, auditing, or handing over a system that was built without a spec, "what does this codebase do", "how is this built". Produces one comprehensive Markdown document with every claim traced to a file, then re-reads the code to check it. Documents what exists; does not propose rebuilds.
metadata:
  version: "1.0.0"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-recover

**What this skill does:** turns an existing codebase into one comprehensive Markdown document,
the spec nobody wrote, covering purpose, stack, architecture, data model, features (as user
stories with rules and edge cases), integrations, cross-cutting concerns, tests, operations and
technical debt. Then it re-reads the code and validates the document against it. It's the
brownfield on-ramp to the rest of the pack: recover the intent, then spec changes against it.

**What this skill touches:** the files in the repository it's pointed at, read-only, plus the
document it writes. It reads the code and interviews you; it changes no source.

**What this skill does NOT do:** it bundles no scripts, binaries or executables, nothing to
compile or run. It makes no network calls and touches nothing outside the repository. It reads the
repo to document it, but it does **not** read secrets: it skips `.env` and other real credential
files, private keys, and credential stores (see Phase 0), and it never copies secret values into
its output. The orientation step uses standard read-only file listing; it writes nothing outside
its own output document and sends nothing. It is plain instructions. Read them.

---

## The one rule

The code is the authority. Where the document and the code disagree, the code is right and the
document is corrected. Every substantive claim is traced to a file, or it is tagged as unproven.
Never launder an inference into a fact.

Tag each substantive claim `[CONFIRMED]` (read it), `[INFERRED]` (deduced), or `[UNKNOWN]` (needs
the human, or not yet found). These tags are the work-list for the interview and for validation.

## The shape: two steps

1. **Document.** Work the whole system out and write it up, every claim traced.
2. **Validate.** Re-read the code and check the document against it, claim by claim. Correct
   anything the code contradicts; append a validation report. Step 2 is not a formality, a
   first-pass reading of a large system will contain mistakes, and this catches them against
   ground truth before handover.

## Step 1: Document

**Phase 0 · Orient.** Confirm the repo root (ask if it's a monorepo or one service of several).
Get a fast lay of the land by listing the tree, ignoring dependency/build/VCS noise, skip:
`.git node_modules vendor dist build out target .next __pycache__ .venv venv coverage .terraform`
then surfacing the signal files that reveal the stack: manifests (`package.json`,
`pyproject.toml`, `go.mod`, `Cargo.toml`, `pom.xml`, etc.), **lockfiles** (exact versions,
ground truth), IaC (`Dockerfile`, compose, Terraform, k8s), CI config, and any `README`/`docs`/ADRs.
Read the human-written docs first. Produce a provisional stack fingerprint and a one-line purpose
hypothesis.

**Do not read secrets.** Skip `.env` and any real credential files, `*.pem`/`*.key`/private keys,
cloud credential files (`~/.aws`, service-account JSON), and anything under a secrets directory.
Treat `.env.example`, `.env.sample` and the like as *potentially* sensitive too, they are
supposed to hold placeholders, but often don't: read only the variable *names* to understand what
config the system needs, and never copy a value that looks real into the output. If a file that
should be a template contains what looks like a live secret, note that as a finding ("committed
secret in `.env.example`") without reproducing the value. Keep a running list of every file read;
it becomes the file-access manifest in the output.

**Phase 1 · Map.** Module responsibilities, entry points (routes, CLI, jobs, queue consumers,
`main`), the primary flow(s) to deep-read. Note what looks generated, vendored, or dead.

**Phase 2 · Interview (intent).** Before deep reading, ask the human about purpose, users,
history, constraints, and the "so that…" behind each feature, the *why* the code can't tell you.

**Phase 3 · Deep read.** Trace the primary flow(s) end to end with file references. Get the
auth/authz path precisely. Extract the data model (read the migration history, it encodes how
the model evolved). Enumerate features; for each, capture rules, edge cases, and state. Read the
integrations, cross-cutting concerns, tests, and ops. Tag confidence as you go.

**Phase 4 · Interview (gaps).** Take your `[UNKNOWN]`s and `[INFERRED]`s back to the human. Route
each answer into the right section.

**Phase 5 · Write.** Produce the document with these sections: purpose & domain; scope &
boundaries; tech stack (exact versions from lockfiles); architecture (components + primary flows,
Mermaid where it helps); data model; **features & business logic** (the centrepiece, per feature:
user stories `As a <actor>, I want <capability>, so that <outcome>`, business rules each traced to
a file, edge cases, state, data touched); integrations & contracts; cross-cutting concerns;
quality & tests (real coverage vs. claimed); operations; technical debt & risks (current-state
facts, not advice); open questions. Surface the draft and open questions before Step 2.

## Step 2: Validate

Go through the document section by section, claim by claim, re-verifying each against the source.
**Holds** → confirm, and upgrade `[INFERRED]` to `[CONFIRMED]` where the code now proves it.
**Wrong** → the code wins; correct it and note what changed. **Unverifiable** → downgrade and add
to open questions; never leave an unprovable claim asserted as fact. **Coverage** → check every
entry point, feature, integration and data entity from Step 1 actually appears; add anything
missed. Then write the validation report: claims checked, corrections made (before/after for
material ones), coverage confirmed, residual uncertainty, and an honest overall-confidence line.

## Acceptance criteria for this skill's output

- Every substantive claim is either traced to a file or tagged `[INFERRED]`/`[UNKNOWN]`.
- Every non-trivial feature has at least one user story and its business rules, each traced.
- The data model is drawn from the schema and migration history, not guessed.
- A validation report exists, produced by re-reading the code, with corrections recorded.
- No secret value appears anywhere in the output; committed secrets are flagged, not reproduced.
- The output includes a file-access manifest: the set of files read to produce the document.
- Nothing in the document is prescriptive: it records what exists, not what to change.
