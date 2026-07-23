# Refresh remote state before work

Before making the first change for a task, fetch all configured remotes so the repository's ahead/behind state is current.
If the current branch has an upstream and is only behind, update it with a non-interactive fast-forward (`git pull --ff-only`). If the branch has no upstream and a clearly matching remote branch exists, configure it as the upstream.
If the branch has diverged, sync it with a normal merge without rewriting history. Resolve small, unambiguous conflicts yourself, including version metadata, generated metadata, and straightforward text or description changes. Stop and ask the user only when a conflict affects code behavior, local work could be lost, or the correct resolution is unclear. Skip remote synchronization when no remote is available, the repository is intentionally offline, or the user forbids Git network access.
