<p align="center">
  <a href="https://whitefishcreative.co.uk/">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="assets/wfc-logo-white.svg">
      <img src="assets/wfc-logo.svg" alt="WhiteFish Creative" width="160">
    </picture>
  </a>
</p>

<h1 align="center">Spec-Driven Development Action Pack</h1>

<p align="center">
  <strong>Eleven markdown templates, eleven worked examples and six portable agent skills.</strong><br>
  Write down what the thing is supposed to do, precisely enough that two people could disagree about whether it does it.
</p>

<p align="center">
  <a href="https://github.com/whitefish-creative-ltd/spec-driven-development/releases/latest"><img alt="Version 1.0.0" src="https://img.shields.io/badge/version-1.0.0-0A4E75"></a>
  <img alt="Markdown only" src="https://img.shields.io/badge/format-markdown%20only-569CBE">
  <img alt="Works with any agent" src="https://img.shields.io/badge/agents-Claude%20Code%20%7C%20Codex%20%7C%20Cursor%20%7C%20Copilot-808285">
  <a href="LICENSE"><img alt="Licence: MIT" src="https://img.shields.io/badge/licence-MIT-0A4E75"></a>
</p>

<p align="center">
  <a href="https://github.com/whitefish-creative-ltd/spec-driven-development/releases/latest/download/sdd-action-pack.zip"><strong>Download the pack</strong></a>
  ·
  <a href="https://whitefishcreative.co.uk/spec-driven-development/"><strong>Read the series</strong></a>
  ·
  <a href="https://whitefishcreative.co.uk/spec-driven-development/action-pack/"><strong>How to use it</strong></a>
</p>

---

## Why

Most projects that go sideways don't fail on engineering. They fail because nobody wrote down what
the thing was supposed to do, so the last ten percent turns out to be four people's private
assumptions that were never compared.

Spec-driven development fixes that with a small set of documents that live in the repository, next
to the code they govern: a problem brief, a feature spec, a not-building register, a task
breakdown, a decision log, and the traceability and audits that prove what was built matches what
was agreed. This pack is those documents as blank templates, the same templates filled in for one
worked feature, and six optional agent skills that automate the repetitive parts.

The method is written up in full on the WhiteFish Creative site:
**[Spec-Driven Development: what it is, what it isn't, and why your last build went sideways](https://whitefishcreative.co.uk/spec-driven-development/)**.

## What's in the pack

```
sdd-action-pack/
├── README.md      <- the layout, the loop, and how to wire it to your agent
├── templates/     <- the eleven blanks. This is the method. Copy these into your repo
├── examples/      <- the same eleven, filled in for one worked feature, to read not to copy
└── skills/        <- six optional agent skills, SKILL.md, and a README about trusting them
```

In this repository the pack lives in [`action-pack/`](action-pack/). Start with
[`action-pack/README.md`](action-pack/README.md).

| Skill | Does |
|---|---|
| `spec-forge` | Interview a vague request into a spec plus a not-building register |
| `spec-decompose` | Break the spec into independently verifiable tasks |
| `spec-build` | Implement one task, refusing out-of-scope work |
| `spec-verify` | Write tests that assert the criteria, including negative cases |
| `spec-audit` | Compare specified versus built versus proven, adversarially |
| `spec-recover` | Recover a spec-shaped account of an existing codebase, then validate it against the code |

## Get it

**Download the latest release:**
[`sdd-action-pack.zip`](https://github.com/whitefish-creative-ltd/spec-driven-development/releases/latest/download/sdd-action-pack.zip).
Every version is on the [releases page](https://github.com/whitefish-creative-ltd/spec-driven-development/releases).

Or clone the repository:

```bash
git clone https://github.com/whitefish-creative-ltd/spec-driven-development.git
```

Then copy the templates into `docs/spec/` in your project, following the layout in the pack's
README, and, if you want them, copy the skills into whichever skills directory your agent reads:

```bash
cp -R action-pack/skills/spec-* .claude/skills/     # or .agents/skills/, or .cursor/skills/
```

**This is not a Claude thing.** Every template is plain markdown with no tool in it, and the skills
follow the open Agent Skills standard, so they work in Claude Code, Codex, Cursor and anything else
that reads `SKILL.md`. Read [`action-pack/skills/README.md`](action-pack/skills/README.md) and put
the skills through Template 10 before you run them. That includes these ones.

## The series

1. [Spec-Driven Development: the pillar](https://whitefishcreative.co.uk/spec-driven-development/)
2. [Forming the Spec](https://whitefishcreative.co.uk/spec-driven-development/forming-the-spec/)
3. [Decomposing It](https://whitefishcreative.co.uk/spec-driven-development/decomposing-it/)
4. [Building Without Drift](https://whitefishcreative.co.uk/spec-driven-development/building-without-drift/)
5. [Proving It](https://whitefishcreative.co.uk/spec-driven-development/proving-it/)
6. [The Audit](https://whitefishcreative.co.uk/spec-driven-development/the-audit/)
7. [The Untold Truth](https://whitefishcreative.co.uk/spec-driven-development/the-untold-truth/)
8. [The Action Pack](https://whitefishcreative.co.uk/spec-driven-development/action-pack/)

## Versions

The pack and the skills are versioned together. Each `SKILL.md` states its version under
`metadata.version`, and every version is a tagged release with the zip attached. What changed is
in [CHANGELOG.md](CHANGELOG.md). A skill you've changed or updated is a skill you re-audit: the
version you read is the version you run.

## Licence

[MIT](LICENSE). Copy the templates, adapt them, use them at work. The WhiteFish Creative name and
logo aren't covered by the licence; see [TRADEMARKS.md](TRADEMARKS.md).

---

<p align="center">
  <a href="https://whitefishcreative.co.uk/">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="assets/wfc-logo-white.svg">
      <img src="assets/wfc-logo.svg" alt="WhiteFish Creative" width="64">
    </picture>
  </a><br>
  Designed and written by <a href="https://whitefishcreative.co.uk/"><strong>WhiteFish Creative Limited</strong></a>
</p>
