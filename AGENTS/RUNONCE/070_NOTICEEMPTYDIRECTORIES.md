# Notice empty directories

During the run-once phase, inspect only the current repository worktree once for empty directory trees.

A directory tree is empty when it contains no files anywhere below it. Report only the highest empty directory in each tree so nested empty directories are not listed repeatedly.

Recommend an empty directory tree only when an ordinary file inside it would be eligible for version control under the repository's effective ignore rules. Ignored, generated, build, test, cache, runtime, dependency, vendored, or otherwise repository-classified local paths are not recommendations.

After all run-once instructions are complete, append the following block to the next user-facing response only when at least one qualifying empty directory tree is recommended. Number the entries so the user can refer to `A1`, `A2`, and so on. This is a recommendation only; do not remove anything unless the user asks.

```markdown
##RemoveEmptyDirs

Git does not track empty directories. This check recommends removing the following empty directory trees.

A) Recommended removals
1. `path/to/directory`
```
