#!/usr/bin/env bash
# Copies each template a skill fills in or reads into that skill's own templates/ folder, so an
# installed skill always has its templates. action-pack/templates/ is the only copy anyone edits.
#
#   scripts/sync-skill-templates.sh          copy the templates into the skills
#   scripts/sync-skill-templates.sh --check  fail if any skill's copy is missing or out of date
#
# This is repository tooling. It is not in the pack, and the pack ships no scripts.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
templates="$root/action-pack/templates"
skills="$root/action-pack/skills"

# skill: the templates it uses. Keep in step with each SKILL.md's "Templates" section.
map=(
  "spec-forge:01-problem-brief.md 02-the-spec.md 03-feature-spec.md 04-not-building-register.md 06-decision-log.md"
  "spec-decompose:05-task-breakdown.md"
  "spec-build:06-decision-log.md 07-change-and-drift-register.md"
  "spec-audit:07-change-and-drift-register.md 08-ac-traceability-matrix.md"
  "spec-orchestrate:11-the-constitution.md 12-agent-prompt.md"
  "spec-update:10-skill-audit-checklist.md"
)

check=false
[[ "${1:-}" == "--check" ]] && check=true
stale=0

for entry in "${map[@]}"; do
  skill="${entry%%:*}"
  dir="$skills/$skill/templates"
  wanted=" ${entry#*:} "

  for file in ${entry#*:}; do
    if $check; then
      if ! cmp -s "$templates/$file" "$dir/$file"; then
        echo "out of date: $skill/templates/$file"
        stale=1
      fi
    else
      mkdir -p "$dir"
      cp "$templates/$file" "$dir/$file"
    fi
  done

  # A template the skill no longer uses must not linger in its folder.
  if [[ -d "$dir" ]]; then
    for present in "$dir"/*.md; do
      [[ -e "$present" ]] || continue
      name="$(basename "$present")"
      if [[ "$wanted" != *" $name "* ]]; then
        if $check; then
          echo "not in the map: $skill/templates/$name"
          stale=1
        else
          rm "$present"
        fi
      fi
    done
  fi
done

if $check; then
  if [[ $stale -ne 0 ]]; then
    echo "Run scripts/sync-skill-templates.sh and commit the result."
    exit 1
  fi
  echo "Skill templates are in step with action-pack/templates/."
fi
