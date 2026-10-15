# Execution Protocol — Phases 4–7

All runs follow these gates after a single candidate has been selected and bounded. The agent works autonomously **within the selected increment**, subject to actual tool authority and repository instructions.

**Mandatory workspace rules:** Read and follow [WorkspaceLifecycle.md](WorkspaceLifecycle.md) before creating a branch/worktree or making product changes. The caller's arbitrary current checkout is read-only context; the implementation is isolated in a dedicated feature branch and temporary linked worktree inside the mounted project workspace: prefer ignored repo-local `.worktrees/` where compatible; otherwise choose a safe workspace-local sibling. Clean up only after committing and checking tracked, untracked, and ignored content, preserving the branch.

## Phase 4 — Record: Issue Before Product Changes

1. Inspect the repository's actual issue-tracking convention. Prefer the established durable tracker or repository-managed issue format. Do not create unrelated new tracking systems.
2. Before changing product files, create **one primary durable issue** following [IssueRecord.md](IssueRecord.md) with the original user assignment, selected change and why, baseline, effective phase policies and their provenance, contracts, boundaries, acceptance criteria and risk.
3. Record a real identifier or path and verify that it exists durably. If repository files represent issues, follow repository conventions and **persist the baseline issue before implementation**; if committing is required for durable history, create a traceable preliminary issue-record commit. That does **not** violate the one-review-unit principle.
4. If no permitted, functioning, durable issue mechanism is available, stop **Blocked** before product implementation. Do not claim a chat note or untracked scratch file is a durable issue.

## Phase 5 — Implement: Scoped, Tracked Work

1. Follow [WorkspaceLifecycle.md](WorkspaceLifecycle.md): inspect Git state and correct integration baseline, create a task-specific feature branch and a workspace-local linked worktree (prefer an ignored repository-local path; fall back to an accessible sibling where needed), verify its initial state, and **implement only there**. Preserve the user's original worktree, branch and uncommitted work. If issues are repo files, creating the isolation environment may precede persisting the issue, but not product implementation.
2. Break the increment into tasks only when helpful; record tasks/steps in the issue. Do not turn each implementation step into a separate independent product objective.
3. Make the **smallest complete** implementation, including direct and verified indirect consequences. Update the issue's implementation log with meaningful progress, deviations, decisions and resulting task statuses.
4. Additional attractive improvements are **future opportunities**, not automatic work inside this increment.
5. If a gate fails or essential new work would exceed the boundary, stop and return to Assess/Select, transparently amend the existing issue for genuinely same-outcome rescoping, or abandon the pick. Never hide the original scope.

## Phase 6 — Verify: Correctness, Compatibility, Outcome Evidence

1. Run relevant available tests and quality checks; assess consumer contract and behavioral invariants plus UX implications. Examine the actual change set for unintended consequences and unrelated modifications.
2. Compare results with the issue's acceptance criteria, including reviewability and change-budget claims.
3. Distinguish **verification** (code, tests, contracts) from **validation** (observed real consumer value). If consumer value remains unmeasured, say so and avoid asserting proven improvement.
4. Record the tests and their outcomes, regression evidence, any untested areas, residual risks, and explicit reasons if validation is limited.
5. If required checks fail, repair within scope and repeat verification. Otherwise report Blocked/Abandoned with evidence, not Done.

## Phase 7 — Package & Close: End-to-End Reviewability

1. Build **one clearly identifiable reviewable change set** linked to the issue; one product increment may use multiple technical commits where needed for durable issue history or repository conventions.
2. Review the complete diff and issue together: can a human understand **why**, **what**, **consumer impact**, **tests/evidence**, and **remaining uncertainties** without being present during the session?
3. Keep unrelated changes out of commits. Observe repository commit/branch conventions. Create a final descriptive Git commit **on the dedicated feature branch** for the completed product increment and issue documentation; include a stable issue reference. Verify the commit actually exists and is retained by the branch. Push and create a review handoff or PR where required/permitted; do not auto-merge without actual authority.
4. Update the issue with actual commit/change-set references and final test/evidence summary. Use Done/Closed **only** when acceptance criteria pass and traceable completion really exists; otherwise use an appropriate Blocked or Abandoned state. If repository-managed issue updates require another commit, perform it and include it in the same cohesive review history.
5. **After successful commit and any required publication attempt, clean up the temporary linked worktree** according to [WorkspaceLifecycle.md](WorkspaceLifecycle.md): verify it has no unsaved valuable work, remove it without force, verify it is gone, and retain the feature branch. If removal is unsafe or fails, keep it and report the exact remaining path; do not claim cleanup. If issue closure or remote publication fails, record the actual pending state. Never imply that creating a commit alone proved consumer value, completed external publication, or meant integration.

## Controlled Returns and Stops

- Revisit Discover/Assess/Select when evidence undermines the selected assumptions; after issue creation, preserve original issue intent and append a transparent decision trail.
- No-change before selecting a viable increment is a legitimate terminal result; when an issue exists but cannot be completed, mark it accurately as Blocked or Abandoned rather than Done.
- Stop after this single increment. The next autonomous evolution cycle requires a new invocation.
