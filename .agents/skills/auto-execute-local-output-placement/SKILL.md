---
name: auto-execute-local-output-placement
description: Apply automatically when running repository tools that generate output files, intermediate files, logs, reports, or temporary working files, or when path restrictions affect their locations. Read before choosing or changing those locations. Follow existing project and tool conventions; prefer the current checkout for new locations and use the organized external fallback when needed. Covers primary and linked checkouts; linked Git worktree creation and placement follow the worktree skill.
---

# Local Working Files and Tool Outputs

Continue using the locations established by project documentation, scripts, or tools for local working files and tool outputs. When you choose a location yourself, select one suited to its purpose within the current checkout, whether a primary checkout or a linked worktree. Ensure that files not intended to be versioned are effectively ignored by Git; local exclusion rules are also suitable.

On Windows, when path restrictions prevent work at the intended location, use a short external path under `C:\.artifacts\<repo-name>\<checkout-id>\<purpose>` only for the affected locations. Preserve necessary subdivisions and reuse suitable existing directories there instead of creating additional scattered directories. Choose a short checkout ID that keeps concurrently used checkouts of the same repository separate.

Source-checkout placement is outside this skill. Naming, creation, and placement of linked Git worktrees follow `auto-execute-worktree-naming`.
