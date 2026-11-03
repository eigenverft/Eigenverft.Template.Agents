---
name: auto-execute-git-branch-naming
description: "Apply automatically when preparing to name or create a git branch."
---

# Git Branch Naming

Apply these rules before naming or creating a Git branch within the authorized task.

**Check the need first.** Honor an explicit request to create a new branch. Otherwise, continue on the current branch when its purpose and role fit the work; create a separate branch when the task or active workflow requires one. Apply the naming rules below when a new branch is needed.

**Isolate a complete work task.** When a new branch is intended to carry a complete work task through to completion and the user or another agent may continue working on the current branch, create and check out the task branch in a separate linked worktree. Keep the current checkout, branch, and working changes available for that ongoing work. Use [Worktree Naming and Placement](../auto-execute-worktree-naming/SKILL.md) for its directory and setup rules.

| Channel | Branch names or families |
| --- | --- |
| Production | `main`, `master`, `hotfix`, `hotfix/*` |
| Staging | `release`, `release/*` |
| Development | `develop`, `bugfix`, `bugfix/*` |
| Preview | `feature`, `feature/*` |

- **Use the assigned branch role.** When a new branch is needed, its name defaults to the preview family `feature/<name>`. Optional intermediate segments for groups, tags, or identifiers are allowed between the branch-role prefix and the task name. Select another role from the table when the task explicitly assigns that role. Derive the branch prefix from this role and the meaningful name from the task.
- **Choose a readable task name.** Describe the concrete outcome in a short lowercase hyphenated name, such as `fix-login-redirect`. Honor explicit user names and include identifiers required by the active workflow.
- **Choose a valid, available name.** Check Git branch validity and existing branch names. Resolve collisions with a meaningful distinction or a small sequential suffix consistent with the workflow, preserving existing branches.
- **Keep existing names stable.** Retain the established branch name when continuing existing work.
