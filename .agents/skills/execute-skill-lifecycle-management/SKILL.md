---
name: execute-skill-lifecycle-management
description: Manage agent skills in the git-root .agents/skills directory by creating, updating, deleting, validating, checking basic cross-harness format compatibility, and cleaning up personal test-skill copies. Use when users ask to modify skills or check whether their packages are portable.
---

# Execute Skill Lifecycle Management

## Overview

Manage skill lifecycle operations with one Windows PowerShell 5.1 script.
Repository skill operations target `.agents/skills` resolved from git root. The separate `cleanup-personal` action targets only the fixed personal `.codex/skills/test-skill` path.

`SKILL.md` is the only required package file. Create harness-specific metadata only when explicitly requested; the default package has no `agents/openai.yaml`.

## Workflow

1. Create a skill
- Run:
  `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .agents/skills/execute-skill-lifecycle-management/scripts/manage_skill.ps1 -Action create -SkillName <skill-name>`
- Optional: `-Resources scripts,references,assets -Examples`
- Only when OpenAI interface metadata is requested: `-Interface display_name=My Skill,short_description=Short summary text`. Supplying `-Interface` creates `agents/openai.yaml`; omitting it leaves the package YAML-free.
- `-Interface` parsing is comma-separated `key=value`; avoid commas inside values.

2. Update an existing skill
- Run:
  `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .agents/skills/execute-skill-lifecycle-management/scripts/manage_skill.ps1 -Action update -SkillName <skill-name>`
- Optional: `-Description`, `-Title`, `-BodyFile`, `-Resources`, `-PruneResources`, `-Interface`
- `-PruneResources` recursively removes unlisted resource directories and therefore also requires `-ConfirmDestructive` after the exact target has been verified.
- Optional interface updates are field-level: unspecified `interface` fields and other top-level sections such as `dependencies` and `policy` must remain unchanged. Do not create or recreate this metadata during an ordinary update.

3. Validate a skill
- Run:
  `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .agents/skills/execute-skill-lifecycle-management/scripts/manage_skill.ps1 -Action validate -SkillName <skill-name>`

4. Check basic compatibility (read-only)
- All skills: `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .agents/skills/execute-skill-lifecycle-management/scripts/manage_skill.ps1 -Action compatibility-check`
- One skill: add `-SkillName <skill-name>`.
- Reuses the repository's metadata validation rules (which may be stricter than the shared Agent Skills specification) and checks optional Codex `agents/openai.yaml` metadata when present. Reports failures and returns a nonzero exit code if any package fails.
- Does not create files, modify skills, install adapters, or test harness discovery, model selection, or runtime behavior. It is a basic static check, not a guarantee of activation or complete YAML validation.

5. Delete a skill
- Run:
  `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .agents/skills/execute-skill-lifecycle-management/scripts/manage_skill.ps1 -Action delete -SkillName <skill-name> -ConfirmDestructive`
- Verify the exact normalized target path printed by the dry attempt before granting `-ConfirmDestructive`.

6. Cleanup personal test-skill copy
- Run:
  `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .agents/skills/execute-skill-lifecycle-management/scripts/manage_skill.ps1 -Action cleanup-personal -ConfirmDestructive`
- This action is limited to the fixed personal `.codex/skills/test-skill` directory and refuses other resolved targets.

## Constraints At A Glance

- `SkillName` is normalized to lowercase hyphen-case and must be at most 64 characters after normalization.
- Allowed `-Resources` values: `scripts,references,assets`.
- Allowed `-Interface` keys: `display_name,short_description,icon_small,icon_large,brand_color,default_prompt`.
- `display_name` must not include `$`.
- `short_description` must be 25-64 characters.
- `SKILL.md` frontmatter allows only: `name`, `description`, `license`, `compatibility`, `allowed-tools`, `metadata`.
- `SKILL.md` frontmatter requires: `name` and `description`.
- `description` must not contain `<` or `>` and must be at most 1024 characters.
- Optional `compatibility` must be between 1 and 500 characters.
- When explicitly requested, `agents/openai.yaml` includes `display_name`, `short_description`, and a `default_prompt` that names `$skill-name`. Validation checks these fields only when that file exists.
- `delete`, `cleanup-personal`, and `-PruneResources` require `-ConfirmDestructive`.

## Minimal Quality Checklist

- Replace all template TODO text in generated `SKILL.md`.
- Ensure all required behavior is defined in `SKILL.md` and its referenced resources, independently of optional harness metadata.
- When present, ensure `agents/openai.yaml` has meaningful `display_name` and `short_description`.
- Run `validate` after every `create` or `update`.
- Run only a safe, non-mutating smoke check unless the user separately authorizes the skill's real action.

## Troubleshooting

- `Skill directory already exists` -> choose a different `-SkillName` or delete the existing skill first.
- `Unknown resource type(s)` -> use only `scripts`, `references`, and/or `assets`.
- `short_description must be 25-64 characters` -> shorten or expand `short_description` into the valid range.
- `Unexpected key(s) in SKILL.md frontmatter` -> keep only allowed frontmatter keys.
- `-PruneResources requires -Resources` -> provide `-Resources` when using `-PruneResources`.
- `Re-run with -ConfirmDestructive` -> verify the exact target path, then add the flag only when the recursive removal is intended.
- `Unable to resolve git root` -> run the command inside a git repository.

## Scripts

### scripts/manage_skill.ps1

Single entrypoint for create, update, delete, validate, read-only compatibility-check, and cleanup-personal operations.

## References

### references/openai_yaml.md

Read only when creating or updating explicitly requested OpenAI metadata. Defines optional `agents/openai.yaml` fields and constraints, including `display_name` rules.
