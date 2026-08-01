# Notice source layout

During the run-once phase, inspect the current repository once for clear deviations from this preferred source layout:

```text
src/
├── <solution/workspace files>  definitions that bind project and workspace content
├── prj/                        independent project roots
└── wrk/                        non-project resources scoped to repository workspaces
```

`src/` may contain multiple independent solution or workspace definitions. Each may bind any relevant subset of project roots under `src/prj/` and workspace resources under `src/wrk/`. Place material under `src/wrk/` when its scope belongs to a repository workspace rather than one project.

Apply this instruction only when one or more concrete software products are clearly identifiable. Skip archive, template, and data-only repositories, as well as repositories without an explicit product structure; this check identifies migrations of an existing layout and must not invent one.

Classify paths from their actual scope and repository references, not from names alone. Ignore paths that the repository's effective ignore rules or established conventions classify as generated or local-only; do not exclude tracked authoritative source, project, solution, or workspace content merely because a tool can regenerate it. Report only clear migrations for existing content; do not propose empty directories or speculative regrouping. Do not move anything during the run-once phase.

When a migration is later requested, preserve contents and history, find and update every repository-owned reference affected by moved paths, and verify that no stale references remain.

After all run-once instructions are complete, append the following block to the next user-facing response only when at least one clear migration was identified:

```markdown
##SourceLayout

The following source-layout migrations are recommended.

Recommended migrations

1. `<current-path>` → `<target-path>`
```

## Suggested follow-up actions

When this instruction reports at least one finding, contribute one or more suitable suggested follow-up actions to the response. Use the following as the standard example, adapting, replacing, or extending its actions when the actual findings justify a different or additional follow-up:

```markdown
<letter>) Source: `080_NOTICESOURCELAYOUT.md`

1. Migrate the reported source layout and update all affected repository references.
```
