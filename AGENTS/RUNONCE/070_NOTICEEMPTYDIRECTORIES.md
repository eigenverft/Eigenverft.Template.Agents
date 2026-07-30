# Notice empty directories

During the run-once phase, inspect the current repository worktree once for empty directory trees. Do not inspect `.git` or directories outside the current repository.

A directory tree is empty when it contains no files anywhere below it. Report only the highest empty directory in each tree so nested empty directories are not listed repeatedly.

After all run-once instructions are complete, append the following block to the next user-facing response only when at least one empty directory tree was found. Number the entries so the user can refer to `A1`, `A2`, and so on. This is a recommendation only; do not remove anything unless the user asks.

```markdown
##RemoveEmptyDirs

Git does not track empty directories. This check recommends removing the following empty directory trees.

A) Recommended removals
1. `path/to/directory`
```
