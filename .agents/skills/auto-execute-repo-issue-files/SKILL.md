---
name: auto-execute-repo-issue-files
description: Apply automatically when working with repository-local issue directories or issue files.
---

# Repository Issue Files

Apply these rules when creating, updating, or closing repository-local issue files within the authorized task.

- **Directory structure.** Keep the issue root as a container for subdirectories only. Store open issues in `open/` and completed issues in `done/`. Use additional subdirectories only when explicitly requested.
- **Open issues.** Store open issue files in the issue directory's `open/` subdirectory.
- **Completed issues.** Once an issue's work is complete, move the same file from `open/` to `done/` under the same issue directory, preserving its filename and history.
- **Closing commit and push.** When commits are authorized, prefer a focused closing commit containing the issue move and any necessary completion update. Push it to the task branch when publication is authorized and a suitable writable remote is available.
