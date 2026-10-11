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
  <strong>Twelve markdown templates, twelve worked examples and seven portable agent skills.</strong><br>
  Write down what the thing is supposed to do, precisely enough that two people could disagree about whether it does it.
</p>

<p align="center">
  <a href="https://github.com/whitefish-creative-ltd/spec-driven-development/releases/latest"><img alt="Version 2.1.1" src="https://img.shields.io/badge/version-2.1.1-0A4E75"></a>
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
worked feature, and seven optional agent skills that automate the repetitive parts.

The method is written up in full on the WhiteFish Creative site:
**[Spec-Driven Development: what it is, what it isn't, and why your last build went sideways](https://whitefishcreative.co.uk/spec-driven-development/)**.

## What's in the pack

```
sdd-action-pack/
├── README.md      <- the layout, the loop, and how to wire it to your agent
├── templates/     <- the twelve blanks. This is the method. Copy these into your repo
├── examples/      <- the same twelve, filled in for one worked feature, to read not to copy
└── skills/        <- seven optional agent skills, an update checker, and a README about trusting them
```

In this repository the pack lives in [`action-pack/`](action-pack/). Start with
[`action-pack/README.md`](action-pack/README.md).

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

## Get it

**Download the latest release:**
[`sdd-action-pack.zip`](https://github.com/whitefish-creative-ltd/spec-driven-development/releases/latest/download/sdd-action-pack.zip).
Every version is on the [releases page](https://github.com/whitefish-creative-ltd/spec-driven-development/releases).

Or clone the repository:

```bash
git clone https://github.com/whitefish-creative-ltd/spec-driven-development.git
```

Then, from your project's root, copy the templates into `docs/spec/templates/`, and, if you want
them, the skills into whichever skills directory your agent reads. Each skill carries the
templates it fills in, and uses the project's copy instead when there is one:

```bash
mkdir -p docs/spec/templates
cp path/to/spec-driven-development/action-pack/templates/*.md docs/spec/templates/
cp -R path/to/spec-driven-development/action-pack/skills/spec-* .claude/skills/     # or .agents/skills/, or .cursor/skills/
```

The pack's README has the rest of the layout: which templates become which files, and where.

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

## Versions and updates

The pack and the skills are versioned together. Each `SKILL.md` states its version under
`metadata.version`, and every version is a tagged release with the zip attached. What changed is
in [CHANGELOG.md](CHANGELOG.md).

To check whether yours are current, ask your agent to use `spec-update`. It finds the installed
skills, makes one read-only request to this repository's latest release, and tells you which are
behind and what changed. It updates nothing unless you ask, and shows you the diff first. It is
the only skill in the pack that touches the network; leave it out if you'd rather check the
[releases page](https://github.com/whitefish-creative-ltd/spec-driven-development/releases)
yourself.

A skill you've changed or updated is a skill you re-audit: the version you read is the version
you run.

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
