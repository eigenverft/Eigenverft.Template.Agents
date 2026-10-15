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
2. **Before creating the feature branch**, where network access and permissions allow it, run a remote refresh such as `git fetch --prune origin` and confirm the current integration baseline (prefer the confirmed `origin/<target>` tracking ref, recording its SHA). Fetch updates remote-tracking refs; it **does not** mean checking out, resetting or fast-forwarding the caller's branch. Respect existing worktrees and any divergent local integration branches. If fetch fails or is unavailable, do not silently assume the remote state is current: use a known local baseline only when repository/user policy explicitly allows that offline mode, otherwise stop Blocked with the limitation. Never integrate unrelated uncommitted changes into the selected baseline.
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

**Default autonomous branch name:** `agent/product-evolution/<area>-<topic>-<issue-id>` (for example `agent/product-evolution/login-error-messages-184`). The root `agent/` deliberately distinguishes autonomous agent work from ordinary human-created `feature/` branches; `product-evolution/` identifies the workflow. The short product **area** (such as `login` or `onboarding`) comes first in the final slug for quick filtering; the topic describes the particular improvement without repeating the area. Use a real issue ID when available, otherwise a stable short unique token. Use lowercase hyphen-separated slugs; sanitize, shorten and verify the complete ref is valid and does not exist or conflict with local/remote parent-prefix refs. The name aids the lightweight overlap screen but **does not establish authorship, imply approval, prove duplication, or reserve an entire category**; continue checking relevant human `feature/` branches and existing issues. Respect an existing required repository branch convention instead; never rename others' branches or use a generic tool prefix such as `codex/` merely because of the host. **The branch is created locally and published only at authorized checkpoints or final handoff.**

## Create Only for a Selected, Recorded Increment

1. Complete Discover, Assess and Select & Bound first. **Record one real issue and its intended change before making product modifications.**
2. **Create the isolation environment before any repository-file issue commit or product edit.** For an external tracker, create and verify the primary issue first. Then create a **new local** feature branch from the confirmed, refreshed integration baseline and check it out **only** in the new linked worktree (for example `git worktree add -b agent/product-evolution/login-error-messages-184 <workspace-local-path> origin/develop` when that is the verified target). Confirm branch, base SHA, path and initial clean state; do not create the remote branch, rebase the caller's branch or reuse an arbitrary `codex` branch.
3. **If issues are versioned repository files**, now write the original issue inside the new worktree and **commit that issue alone on its local feature branch**. Verify the issue-only checkpoint before any product modification. Later material decision changes require a distinct versioned issue commit before implementing the changed decision. For external issues, the already verified tracker record supplies this first decision checkpoint without adding a duplicate repository file.
4. Work, run tests and make **meaningful, scoped implementation commits only in the linked worktree**, distinct from versioned issue decision checkpoints. Do not make a commit per trivial edit or let a long autonomous run rely only on an unsaved working tree. Keep the original baseline commit and subsequent decision/implementation history reviewable, without amending them away just to conceal how scope evolved. The caller's branch and files remain untouched. Record actual checkpoint commit and branch/worktree references for traceability.

## Final Closure Commit, Remote Publication, and Cleanup

1. **Finish product changes first.** Once verification succeeds, commit all intended product changes and evidence on the local feature branch. Confirm the branch retains the commits and the complete diff is reviewable. Keep the earlier issue-baseline and material-decision checkpoints intact.
2. **Make the issue closure the last local commit.** For repository-versioned issues, record the verified implementation outcome, tests, deviations and status `Done` in the original issue and **move that file to the established `done/` destination in the same dedicated final commit** (using `git mv` where applicable; create `done/` under the existing issue root if no completed-issue directory exists). Preserve its identifier, do not leave a duplicate under `open/`, and stage only that closure/move plus directly related issue metadata—**no product code changes**. Verify the staged diff and actual final commit. For external trackers no file move applies; close the tracker issue only after successful publication/cleanup. Do not mark unsuccessful work Done or move it to `done/`.
3. **Publish the feature branch as the default successful handoff.** A previous authorized checkpoint push may have preserved the issue baseline or a coherent implementation commit, but it does not finish the cycle. After the final closure commit, push the **complete dedicated feature branch only** to the repository's existing remote (normally `origin`; use `git push -u origin <feature-branch>` on first publication). Verify the remote ref exists and resolves to the exact final local commit. **Do not automatically create a PR, merge into `develop`/`main`, reset the caller's worktree, or delete the branch.** If authorization or push fails, preserve the original linked worktree and local branch and report Blocked / Publication pending; the work is not successfully handed off remotely.
4. **Only after confirmed remote publication, remove the temporary linked worktree.** Verify that all important work is committed and remotely retained; examine tracked changes, untracked and **ignored** contents (`.env`, build artifacts, data, symlinks/junctions). Use ordinary non-forced `git worktree remove <exact-created-path>` and verify via `git worktree list` that the linked path is gone. Never use `--force`, delete arbitrary directories, or prune others' worktrees.
5. **Keep both feature refs.** Preserve the local and remote feature branch for the user to inspect, fetch, merge or open a PR later. Removing the worktree is **not** a branch deletion or integration. If removal is unsafe or fails, preserve the worktree and report the exact path and blocker; do not claim successful cleanup.
6. **Report actual state.** For versioned issues, the final closure commit precedes remote push and cleanup, so it can truthfully say implementation Done while publication, integration and cleanup remain pending; report verified remote branch, closure commit SHA and cleanup outcome afterward in the final handoff. For external issues, update the tracker with verified outcomes and close when its criteria are satisfied. Distinguish **implemented**, **committed**, **published/Ready for Review**, and **integrated**; only the last requires a separately authorized merge.
