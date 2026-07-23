# Agent instructions

Read `AGENTS/CODING_AGENT.md` before making changes in this repository.

Project-specific operational guidance lives in `AGENTS/RUNBOOK/`.

Maintain `AGENTS/EFFICIENCY.md` as a minimal, always-current record of reusable efficiency observations and improvements. Keep it short, practical, and focused on reducing unnecessary token, tool, context, console output, logging output, test output, and churn waste without reducing correctness.

Maintain `AGENTS/WORKHISTORY.md` as a minimal, always-current trace of user requests and delivered outcomes. Prefix each new entry with **today's calendar date** in ISO form `yyyy-MM-dd` (e.g. `2026-06-17`), then a space, then `#` and the next sequence number for that day (`#1`, `#2`, …). Do **not** paste the literal text `yyyy-mm-dd` — substitute the real date. Keep each entry very short, preferably one line. Briefly state what the user requested, what was delivered, and only include interpretation notes when they are essential.

Maintain `AGENTS/RELEASENOTESLOCATIONS.md` as a short, up-to-date list of all places in the repository that contain release notes, changelogs, release history, or similar documentation.
Find these locations by searching the repository. Do not rely only on paths already listed in the file. Update the list when a release-note location is added, removed, renamed, or moved.
Use repository-relative paths. Add a short description only when the purpose of a location is not clear from its path.
Before pushing changes to a remote, review the list and decide whether the changes being pushed require release-note updates under the repository’s existing conventions. Update only the relevant release-note locations, and make sure those updates are committed before the push.
Do not add release notes for every commit or for routine internal changes unless the repository’s release-note rules require it.

If a commit is requested, use a multiline commit message: a short summary line, a blank line, and a longer body explaining what changed and why.
