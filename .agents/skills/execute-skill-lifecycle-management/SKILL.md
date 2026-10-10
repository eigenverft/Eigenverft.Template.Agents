---
name: execute-skill-lifecycle-management
description: Use when the user requests creation, updates, deletion, or validation of agent skill packages; author portable SKILL.md instructions from requirements, maintain resources and optional harness metadata, and run read-only compatibility checks. Use for skill creation, revisions, technical lifecycle maintenance, and validation, rather than independent quality reviews.
---

# Execute Skill Lifecycle Management

## Overview

Design and maintain portable agent skill content, and manage skill lifecycle operations with one Windows PowerShell 5.1 script.
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

## Skill Authoring and Quality

Use this same skill for both the content of portable agent skills and their technical lifecycle. A user may supply only a short description; turn it into a complete, actionable `SKILL.md` without requiring a separate authoring skill.

### When to Apply

- Create a skill from a description, requirements, or an existing workflow.
- Revise the instructions, triggers, or resource files of an existing skill.
- Validate packages, inspect basic portability, or perform the other lifecycle actions above.
- Do not initiate skill creation or changes during unrelated application work or conceptual brainstorming without an editing request.

### Authoring From Requirements

1. Confirm the goal, triggers, scope, and important exclusions; derive a meaningful lowercase hyphen-case name and check for collisions.
2. Plan the smallest useful package under the Git-root `.agents/skills` directory. Use the lifecycle script to scaffold packages and for routine metadata or resource changes.
3. Write complete `SKILL.md` frontmatter and an actionable body explaining behavior, boundaries, and expected outputs. The description must convey both purpose and **when** the skill should activate.
4. Keep all necessary behavior in `SKILL.md` and any referenced resources. `SKILL.md` is the only required package file; do not require `agents/openai.yaml` or another harness-specific file.
5. Add scripts, references, or assets only when they materially help. Favor a small, reusable skill over extra scaffolding.
6. Validate after creating or updating a package; review its final content for completeness, portability, accuracy, and unresolved placeholders.

Direct edits to instructions and resources are appropriate when the lifecycle script cannot express a targeted change. They must remain small, reviewable, and consistent with the package's existing conventions.

### Portable Softskill Defaults

For softskills, prefer generic language and workflows unless the user specifically requests a repository- or technology-bound skill.

- Avoid hardcoding languages, frameworks, particular manifest names, or repository layouts without a task-specific reason.
- When paths or environments matter, describe how to discover the relevant root or files instead of assuming a fixed location.
- Keep terminology and behavior reusable across repositories and technology stacks where practical.
- If an existing softskill is made generic, revise the original rather than duplicating it.
- When a skill intentionally remains project-specific, make that scope clear in its trigger description or body.
- Prefer the least-coupled design that accomplishes the requested task.

### Preserving Existing Packages

Before editing an existing skill, inventory the selected package and read every behavior-changing text resource.

- Preserve existing optional harness metadata, scripts, references, assets, and user-authored content unless explicitly in scope.
- Never create or recreate optional harness metadata during an ordinary update.
- Make minimal, focused edits. Keep `name`, `description`, invocation language, and constraints aligned.
- If an update would overwrite or delete an existing resource, identify the exact target and obtain authorization before destructive changes.
- Prefer deterministic results and preserve useful knowledge rather than replacing an existing package with an oversimplified rewrite.

### Authoring Quality and Delivery

- Check that `name` is distinctive, invocable, and consistent with the directory name.
- Check frontmatter fields and limits, meaningful trigger conditions, behavior, scope boundaries, and expected outputs.
- Preserve any required quoted strings and other constraints when optional harness metadata was explicitly requested.
- Remove template TODOs, example placeholders, and inconsistent instructions.
- For substantial authoring or editing requests, report in a clear sequence: objective; constraints or assumptions; file plan; applied changes; validation and remaining risks.
- Provide a useful **Skill Brief**, **File Change Set**, and **Validation Notes** in the response, at a level of detail appropriate to the task.

Use `references/softskill_checklists.md` for the concise naming, authoring, metadata, and creation checklists.

## Constraints At A Glance

- `SkillName` is normalized to lowercase hyphen-case and must be at most 64 characters after normalization.
- Allowed `-Resources` values: `scripts,references,assets`.
- Allowed `-Interface` keys: `display_name,short_description,icon_small,icon_large,brand_color,default_prompt`.
- `display_name` must not include `$`.
- `short_description` must be 25-64 characters.
- `SKILL.md` frontmatter allows only: `name`, `description`, `license`, `compatibility`, `allowed-tools`, `metadata`.
- `SKILL.md` frontmatter requires: `name` and `description`.
- `description` must not contain `<` or `>` and must be at most 1024 characters.
- Repository-local, case-sensitive description starts: `auto-execute-*` requires `Apply automatically when `; `execute-*` requires `Use when the user requests `; `review-*` requires `Use for a read-only review when `.
- `validate` and `compatibility-check` reject mismatched starts. Names without these prefixes remain valid but produce a non-failing `[WARN]` because their activation and side-effect intent is not classified by name.
- These checks enforce only the written convention; semantic compliance with read-only or execution boundaries must be assessed separately, and automatic harness activation is not guaranteed.
- Description length assessment: `normal` = 0-511 characters, `medium` = 512-767, `long` = 768-1024 (`[WARN]` without failing validation); above 1024 remains a validation error.
- Both `validate` and `compatibility-check` report the category and length. Compatibility checks additionally summarize the length categories; unknown name categories and long descriptions count as non-failing warnings.
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

### references/softskill_checklists.md

Use when creating or revising skills, especially portable softskills. Contains concise naming, package authoring, optional metadata, and delivery checklists inherited from the former lightweight skill.
