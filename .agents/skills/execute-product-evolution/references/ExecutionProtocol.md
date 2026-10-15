# Execution Protocol — Phases 4–7

All runs follow these gates after a single candidate has been selected and bounded. The agent works autonomously **within the selected increment**, subject to actual tool authority and repository instructions.

**Mandatory workspace rules:** Read and follow [WorkspaceLifecycle.md](WorkspaceLifecycle.md) before creating a branch/worktree or making product changes. The caller's arbitrary current checkout is read-only context; the implementation is isolated in a dedicated feature branch and temporary linked worktree inside the mounted project workspace: prefer ignored repo-local `.worktrees/` where compatible; otherwise choose a safe workspace-local sibling. Clean up only after committing and checking tracked, untracked, and ignored content, preserving the branch.

## Phase 4 — Record: Issue Before Product Changes

1. Inspect the repository's actual issue-tracking convention. Prefer the established durable tracker or repository-managed issue format. Do not create unrelated new tracking systems.
2. Before changing product files, create **one primary durable issue** following [IssueRecord.md](IssueRecord.md) with the original user assignment, selected change and why, baseline, effective phase policies and their provenance, contracts, boundaries, acceptance criteria and risk.
3. Record a real identifier or path and verify it exists durably. **For repository-versioned issues**, create the isolated feature worktree if required, write the initial issue containing the understood request, effective phase policies, selected scope and acceptance criteria, and make a **separate issue-only baseline commit before modifying any product files**. Verify that this commit actually exists and contains **no product changes**. It is a mandatory provenance checkpoint and remains part of the one cohesive review unit. **For external issues**, verify the tracker record before product modification; do not create an artificial duplicate file solely to produce a Git checkpoint.
4. If no permitted, functioning, durable issue mechanism is available, stop **Blocked** before product implementation. Do not claim a chat note or untracked scratch file is a durable issue.

## Phase 5 — Implement: Scoped, Tracked Work

1. Follow [WorkspaceLifecycle.md](WorkspaceLifecycle.md): inspect Git state and correct integration baseline, create a task-specific feature branch and a workspace-local linked worktree (prefer an ignored repository-local path; fall back to an accessible sibling where needed), verify its initial state, and **implement only there**. Preserve the user's original worktree, branch and uncommitted work. If issues are repo files, creating the isolation environment may precede persisting the issue, but not product implementation.
2. For versioned issues, confirm the **issue-only baseline commit precedes the first product edit**. For external issues, confirm that the issue is recorded and reachable. Break the increment into tasks only when helpful; do not turn each step into a new product objective.
3. **Checkpoint consequential decisions before implementing them:** when new evidence changes the agreed outcome, acceptance criteria, policy, or outer change boundary, stop the affected implementation, append the original-vs-revised decision and reason to the issue, then **stage only the issue file(s), verify the staged diff contains no product changes, and commit that decision separately before coding to the new decision** if the issue is versioned. For an external tracker, persist the change there before continuing and reference the issue in subsequent commits. Do not silently rewrite the initial decision.
4. Implement the **smallest complete** increment, including verified necessary indirect effects. Make **cohesive, meaningful implementation commits** when a verifiable piece is finished or an important recovery checkpoint is needed; explain what each commit implements and reference the issue. Do not require a commit for every edit, and do not mix unrelated scope into decision or implementation checkpoints. Track actual changes, deviations and relevant test evidence in the issue.
5. Additional attractive improvements are **future opportunities**, not automatic work inside this increment.
6. If a gate fails or essential new work would exceed the boundary, stop and return to Assess/Select, transparently amend the existing issue for genuinely same-outcome rescoping, or abandon the pick. Never hide the original scope.

## Phase 6 — Verify: Correctness, Compatibility, Outcome Evidence

1. Run relevant available tests and quality checks; assess consumer contract and behavioral invariants plus UX implications. Examine the actual change set for unintended consequences and unrelated modifications.
2. Compare results with the issue's acceptance criteria, including reviewability and change-budget claims.
3. Distinguish **verification** (code, tests, contracts) from **validation** (observed real consumer value). If consumer value remains unmeasured, say so and avoid asserting proven improvement.
4. Record the tests and their outcomes, regression evidence, any untested areas, residual risks, and explicit reasons if validation is limited.
5. If required checks fail, repair within scope and repeat verification. Otherwise report Blocked/Abandoned with evidence, not Done.

## Phase 7 — Package & Close: End-to-End Reviewability

1. Build **one clearly identifiable reviewable change set** linked to the issue; one product increment may use multiple technical commits where needed for durable issue history or repository conventions.
2. Review the complete diff and issue together: can a human understand **why**, **what**, **consumer impact**, **tests/evidence**, and **remaining uncertainties** without being present during the session?
3. **Prepare the pre-cleanup issue evidence first:** record delivered behavior, test/contract results and available review references. For **versioned repository issues**, write cleanup explicitly **pending** before the last issue-containing commit; do not invent a future worktree result or the commit's own SHA. For **external trackers**, record available evidence but defer the verified cleanup outcome and issue closure until step 5.
4. Keep unrelated changes out of commits. Observe repository commit/branch conventions. **Then create and verify** a descriptive commit (or necessary cohesive commits) **on the local feature branch**, including any versioned issue-file changes and a stable issue reference. Confirm the branch retains it. Push the committed feature branch and create a PR/review handoff only where permitted and required. For external issues, update the real commit/PR references after they exist. For versioned issues, use branch/PR references in the file and put the final exact SHA in the later handoff; do not auto-merge without actual authority.
5. **After successful commit and any required publication attempt, clean up the temporary linked worktree** according to [WorkspaceLifecycle.md](WorkspaceLifecycle.md): verify that all tracked, untracked and ignored valuable work is safe, remove the worktree without force, verify it is gone, and retain the feature branch. **For an external tracker**, now append the verified cleanup result and close/resolve the issue only when required criteria actually pass. **For a versioned issue file**, report the actual cleanup result and commit ID in the final handoff; do not reopen the caller's worktree merely to alter its issue file or claim pending meant completed. If removal is unsafe or fails, preserve the worktree and report its location; do not claim cleanup. If issue closure or remote publication fails, record the pending state. Never conflate committed, published, ready for review, and integrated.

## Controlled Returns and Stops

- Revisit Discover/Assess/Select when evidence undermines the selected assumptions; after issue creation, preserve original issue intent and append a transparent decision trail.
- No-change before selecting a viable increment is a legitimate terminal result; when an issue exists but cannot be completed, mark it accurately as Blocked or Abandoned rather than Done.
- Stop after this single increment. The next autonomous evolution cycle requires a new invocation.
