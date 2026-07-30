# Organize repository issues

Ensure the repository root contains `ISSUES/`. If it does not exist, create only the directory. Do not add a readme or placeholder file.

Search the repository for Markdown files whose primary purpose is to capture project-specific issues, plans, proposals, investigations, roadmaps, todos, or ideas. Classify files from their complete purpose and content, not from an isolated keyword.

Move every clear match into `ISSUES/`. Preserve meaningful filenames, do not overwrite name collisions, use Git-aware moves for tracked files, and update repository references affected by the move.

Do not move general or reusable Markdown that is not specific to the project. Also exclude agent instructions, runbooks, templates, generated or vendored content, dependency content, permanent product or reference documentation, release notes, licenses, readmes, contributing or security documents, code-of-conduct or support files, and GitHub issue or pull-request templates.

Do not leave a clear project-specific issue, plan, proposal, investigation, roadmap, todo, or idea file outside `ISSUES/`. If a tool or repository convention requires such a file at a fixed path and cannot be updated safely, stop and ask the user instead of silently exempting the file.
