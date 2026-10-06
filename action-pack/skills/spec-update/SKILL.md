---
name: spec-update
description: Check whether the installed spec-driven development skills are the latest version, and say what changed if they aren't. Use when someone asks to check for, compare or install updates to the spec-* skills or the SDD action pack. Makes one read-only request to the pack's public GitHub releases, and only when asked; never updates anything without explicit approval.
metadata:
  version: "2.0.0"
  publisher: WhiteFish Creative
  source: https://github.com/whitefish-creative-ltd/spec-driven-development
---

# spec-update

**What this skill does:** finds the spec-driven skills installed on this machine, reads the
version each one states, checks the latest published release, and tells you which are out of
date and what changed.

**What this skill touches:** the `SKILL.md` files in your skills directories, read-only. With
your explicit approval, and only then, it downloads the release zip to a temporary folder and
replaces skill folders you name.

**What this skill does NOT do:** it is the one skill in the pack that makes a network call, so
here is exactly what that call is. One read-only request to
`https://api.github.com/repos/whitefish-creative-ltd/spec-driven-development/releases/latest`,
made when you run this skill and at no other time. No credentials, no tokens, nothing about you
or your code is sent. It never runs on its own, it never installs without asking, and it bundles
no scripts. Plain instructions. Read them.

---

## The one rule

Report, then ask. Finding a newer version is information, not permission. A skill you haven't
read is a skill you don't run, and that is as true of our next version as it is of anyone else's.

## Process

### Step 1: Find what is installed

Look for skill folders whose `SKILL.md` frontmatter has
`metadata.source: https://github.com/whitefish-creative-ltd/spec-driven-development`, in these
places, project first:

- `.claude/skills/`, `.agents/skills/`, `.cursor/skills/` in the working directory
- `~/.claude/skills/`, `~/.agents/skills/`, `~/.cursor/skills/`

For each, record the folder, the skill name and `metadata.version`. A `spec-*` folder with no
`metadata.version` is a copy from before the pack was versioned: report it as "1.0.0 or earlier".

### Step 2: Check the latest release

Say which URL you are about to read, then read it, using whichever of these you have: a web
fetch tool, `gh release view --repo whitefish-creative-ltd/spec-driven-development --json
tagName,url,body`, or `curl -s` on the URL above. Take the version from the tag (`v2.0.0` is
`2.0.0`), and keep the release notes and the release's web address.

If the request fails, say so and stop. Do not guess the latest version.

### Step 3: Report

A table: skill, where it is installed, installed version, latest version. Then one line:
"All up to date", or how many are behind.

When any are behind, show the release notes for every version between the oldest installed one
and the latest, from the release page or `CHANGELOG.md` in the repository. Say plainly when the
first number of the version changes: that means the method's rules changed, not just its wording.

Finish with the manual route, so nobody needs this skill to update:

```bash
curl -L -o sdd-action-pack.zip https://github.com/whitefish-creative-ltd/spec-driven-development/releases/latest/download/sdd-action-pack.zip
unzip sdd-action-pack.zip
cp -R sdd-action-pack/skills/spec-* [the skills directory from step 1]
```

And the reminder that belongs with it: put the new version through Template 10 before running
it. The version you read is the version you run.

### Step 4: Update, only when asked

Only if the user asks you to update, in this conversation:

1. Download the release zip into a new temporary folder and unzip it there.
2. For each skill being updated, show the diff between the installed `SKILL.md` and the new one.
3. Ask which to replace. Replace only those folders, and only in the directory where each was
   found. Never touch a skill folder from any other publisher.
4. Report what was replaced, from which version to which, and delete the temporary folder.

If an installed `SKILL.md` has been edited locally, the diff will show it. Point that out before
replacing it, because replacing it throws those edits away.

## Acceptance criteria for this skill's behaviour

- It makes no network request until it has said which URL it will read.
- It makes no request other than that one, plus the zip download in step 4 when asked.
- It reports every installed copy, with its location and version, before suggesting anything.
- It changes nothing without explicit approval, and shows the diff before replacing a file.
- It never sends anything about the user, the machine or the code.
