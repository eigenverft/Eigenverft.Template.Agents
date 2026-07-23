# Run-once instructions

`AGENTS/RUNONCE/` contains repository instructions that must be applied exactly once.

On the first read of `AGENTS.md` for a task, inspect every Markdown file in `AGENTS/RUNONCE/`. Use each filename as its stable instruction identifier and check `AGENTS/RUNBOOK/RUNONCE.md` for a matching completed entry.

If an instruction has no completed entry, read it fully and apply it before doing other work. Do not repeat completed instructions. Do not mark completion by modifying, moving, or deleting the instruction file.

Keep instruction filenames stable after distribution. Renaming an instruction changes its identifier and causes it to be treated as pending.

After an instruction has completed successfully, create or update `AGENTS/RUNBOOK/RUNONCE.md` with its filename, the completion date, and a short outcome. A verified no-op or permanently inapplicable instruction may be recorded as completed with the reason. Do not record temporary skips, failed attempts, or incomplete work as completed.

Run-once instructions do not override higher-priority instructions, required approvals, or safety constraints. Stop and ask the user before destructive, externally visible, or unclear actions unless the instruction or current request already provides the necessary authority.
