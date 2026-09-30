---
name: execute-repo-commit-grouping
description: Use before a user-requested Git commit to inspect the actual repository changes and decide internally which changes belong in each coherent commit and in what order. Applies to ordinary commit requests, including requests to commit all suitable changes, without requiring explicit skill invocation. This is internal commit preparation, not a separate report or a staging, commit, or remote-operation workflow.
---

# Execute Repo Commit Grouping

## Purpose and Activation

Inspect and group the changes covered by the user's commit request. This skill defines grouping only; it does not independently authorize staging, commits, repository edits, tracking-policy changes, or remote operations.

## Inspect the Actual Changes

- Inspect repository status, staged and unstaged diffs, and relevant untracked file contents. Recognize deletions and renames, and read surrounding context where needed to understand the changes.
- Establish the requested commit scope and distinguish understood changes from excluded or uncertain work. Do not invent intent from filenames alone.
- Exclude secrets, ignored untracked files, local-only content, and transient outputs by default. Include generated content only when its intended versioning is established. A tracked file matching an ignore rule remains tracked; do not change its tracking state.
- Preserve existing work and staged selections. Do not clear the index, modify files, or absorb unrelated changes to make the grouping easier.

## Decide the Groups and Order

- Separate changes with different independently meaningful outcomes; sharing a repository, directory, or broad maintenance theme is not enough to combine them. Keep dependent parts of the same concrete change together.
- Keep implementation, its tests, and directly required documentation or configuration together. Avoid known broken intermediate states.
- Use one commit for a coherent change; do not manufacture extra commits. Order groups by their dependencies.
- Separate independent changes within one file only when safe and worthwhile; keep inseparable changes together.
- Leave excluded or unresolved work out of the groups.

## Continue the Commit Request

Use the groups as internal preparation for the normal authorized commit workflow. Recheck the remaining changes before each subsequent commit if repository state has changed.

Keep grouping internal by default. Show it when requested; otherwise mention only material exclusions or blockers and ask only when a genuine ambiguity prevents safe grouping.
