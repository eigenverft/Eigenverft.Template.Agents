# Workspace Lifecycle — Isolated Evolution Branch and Temporary Worktree

This is a mandatory part of the shared Execution Protocol for autonomous product changes. It is **not** an optional evolution policy and does not alter the separately selected Discover, Assess, or Select & Bound strategy.

## Purpose and Ground Rules

The caller may be in any Git repository directory, on any checked-out branch, with modified files or another agent's work in progress. Treat that checkout as a source of read-only product context, **not** as the location to implement the selected increment.

- Never switch, reset, clean, or commit in the caller's existing worktree merely to prepare this cycle.
- Discovery and assessment remain read-only. Do not create speculative branches or worktrees before a viable increment exists.
- For implementation, use **one dedicated feature branch in one isolated temporary Git linked worktree**. If the repository cannot support a safe isolated worktree, stop Blocked rather than edit the caller's checkout.
- **Keep the temporary checkout within the accessible, mounted project workspace.** Never assume a global home directory, machine-specific parent path, or a host-only path is accessible to an isolated agent runner. Do not use environment-specific external directories such as `_tempWorkTrees/` as the universal default.
- Git permits linked worktrees in either a sibling directory or an ignored nested directory. Choose by actual mount/tool permissions and repository conventions; no path shape is intrinsically required by Git.

## Choose Base and Directory

1. Inspect `git status`, current branch, upstream, `git worktree list --porcelain`, available remote refs and repository instructions. Discover which integration target this repository really uses (for example `develop` or `main`); **the caller's checked-out branch is never the implicit target**.
2. Fetch/refresh target refs where supported and appropriate; respect dirty worktrees and branch-divergence rules. Never integrate unrelated uncommitted changes into the selected baseline. If the right target/base cannot be identified safely, stop and report.
3. First honor any safe established workspace/repository convention. Otherwise **prefer the ignored repository-local directory `.worktrees/<issue-topic>/`**, under an accessible checkout inside the mounted project workspace. This keeps the checkout visible and usable in sandboxes mounting only the repository folder. Identify the actual checkout root with Git; do not assume the invoking working directory is the root. If the caller is in a linked worktree, inspect all registered paths rather than blindly choosing a main worktree outside the accessible mount.
4. **Fallback:** If nested worktrees are incompatible with scanners/build tooling or repository layout, use a **sibling directory within the same accessible project workspace** when permissions and mount scope allow it. This is often the cleaner Git layout and needs no nested-directory ignore. Never escape the available workspace just to follow a home-directory convention. If neither a safe nested path nor an allowed workspace-local sibling exists, stop Blocked rather than violating the sandbox or user's workspace.
5. For a nested checkout, **verify that the entire generated directory is ignored by the enclosing checkout before creating it** (for example through `git check-ignore -v`). Respect existing ignore rules; when needed, add a local `.git/info/exclude` rule through the shared Git directory without replacing existing entries. Avoid automatically editing tracked `.gitignore` purely for this agent. Check for tracked path collisions, already registered worktrees, recursive file discovery/build tooling that ignores neither Git excludes nor skip directories, symlinks, and concurrent agents. Exclude nested worktrees explicitly from scanning, packaging, linting and deployment when those tools don't honor ignores. Never stage their contents with the product change.

Preferred layout where nesting is safe:

```text
mounted-project-workspace/
  MyProduct/
    .git/
    .worktrees/                     # locally ignored linked worktrees
      product-evolution-184-errors/ # temporary checkout of dedicated branch
```

Safe fallback if the mounted workspace also permits siblings:

```text
mounted-project-workspace/
  MyProduct/
  MyProduct-evolution-184-errors/   # linked worktree beside the checkout
```

Both layouts are valid linked Git worktrees, but only choose paths actually accessible and safely managed by the current agent environment.

Example branch: `feature/product-evolution-184-errors` (use the real issue ID when available). Sanitize and shorten topic labels, ensure branch/path uniqueness, and respect repository naming rules. A specific repository convention overrides this illustrative name.

## Create Only for a Selected, Recorded Increment

1. Complete Discover, Assess and Select & Bound first. **Record one real issue and its intended change before making product modifications.**
2. For an external issue tracker, create and verify the issue before creating the implementation worktree. If issues are repository files, prepare the isolated worktree first if needed, write and durably persist the initial issue record there, then start product changes. This is a setup exception, not permission to implement before the issue exists.
3. Create the feature branch from the confirmed integration baseline and check it out **only** in the new linked worktree. Confirm the branch, baseline, path, and initial clean state before implementation.
4. Work, run tests and make scoped commits **only** in the linked worktree. The caller's branch and files remain untouched. Record the actual baseline and branch/worktree references in the issue for traceability.

## Review Handoff and Cleanup

1. After verification, commit the scoped change and any required issue updates on the feature branch. Confirm the commit ID, the branch ref points to the intended commit, and all important generated work is committed or otherwise durably saved.
2. Push the feature branch / create a pull request or review handoff **when required and permitted** by the user's and repository's rules; do not claim publication or merge unless confirmed. The normal goal is **ready for review**, not an automatic merge.
3. **After a successful commit, remove the temporary linked worktree as a normal mandatory closing step**, but only after independently confirming the feature branch retains the changes **and** the worktree contains no valuable unsaved files. Check tracked changes, untracked files **and ignored contents** (local `.env` files, generated artifacts, build outputs, data, junctions/symlinks), since ignored files can be removed with a worktree even when ordinary Git status looks clean. If a push is part of the run, attempt it before cleanup where practical. If publication fails but the work is safely committed on a persistent local feature branch, cleanup remains possible; clearly report the branch is local-only and publication pending.
4. Use the ordinary non-forced `git worktree remove <exact-created-path>` and verify `git worktree list` no longer contains it. Do **not** use `--force`, delete arbitrary directories, or prune other agents' worktrees to achieve a green cleanup result.
5. Keep the feature branch after worktree removal, especially while review/integration is pending. Do not delete it automatically; deleting the worktree is **not** deleting the commit or branch.
6. If the worktree is dirty, contains valuable uncommitted, untracked **or ignored** work, holds an unverified commit, has unsafe symlinks/submodules, or removal fails, **preserve it and report the exact leftover location and blocker**. Do not force cleanup, delete valuable artifacts, or declare completion that did not occur.

The issue's final outcome includes the integration target, feature branch, real commit(s), review/PR reference if available, and worktree cleanup status. "Committed", "published", "ready for review", and "integrated" are distinct states.
