---
name: auto-execute-worktree-naming
description: "Apply automatically when preparing to name or create a worktree."
---

# Worktree Naming and Placement

Apply these rules before naming or creating a linked Git worktree within the authorized task.

**Check the need first.** Honor an explicit request to create a new worktree. Otherwise, continue in the current checkout when its branch, working state, and isolation fit the task; create a separate worktree when the task or active workflow requires one. Apply the naming and setup rules below when a new worktree is needed.

- **Choose a readable task name.** Derive the directory name from the task or the associated branch's meaningful task component. Use a short lowercase hyphenated name, such as `fix-login-redirect`, and honor explicit user names and identifiers required by the active workflow.
- **Use shared repository-local storage.** Identify the repository's primary checkout through Git's registered worktrees and use its root as the shared storage location. Place linked worktrees inside that checkout's `.worktrees/` directory, including when working from an existing linked checkout. For example, from `<repo>/.worktrees/a`, create a new worktree `b` at `<repo>/.worktrees/b`. The recommended simple pairing is branch `feature/<name>` with worktree `.worktrees/<name>`. Optional intermediate directories for groups, tags, or identifiers are allowed within this shared `.worktrees/` directory. Resolve the final path and verify that it stays inside that directory tree.
- **Initialize worktree storage once.** Check whether the primary checkout's `.worktrees/` directory already exists before creating it. An existing directory is treated as initialized, with local exclusion setup and verification already completed; reuse it directly. For first-time setup, resolve the repository-local exclusion file through Git from the primary checkout, for example with `git rev-parse --git-path info/exclude`. Preserve its existing entries and ensure an effective `/.worktrees/` rule covering the whole directory and all descendants. Verify effective exclusion from that checkout with `git check-ignore` for the intended destination and a nested entry, then create `.worktrees/` and the linked worktree. Subsequent creations use the existing-directory path above.
- **Choose a valid, available path.** Check registered worktrees and the destination path. Use filesystem-safe names. Resolve collisions with a meaningful distinction or a small sequential suffix consistent with the workflow, preserving existing worktrees and directories.
- **Keep existing names stable.** Retain the established worktree directory name when continuing existing work.
