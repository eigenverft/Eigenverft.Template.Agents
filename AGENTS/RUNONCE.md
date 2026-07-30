# Run-once instructions

`AGENTS/RUNONCE/` contains repository instructions that must be applied once at the start of each new chat session.

On the first read of `AGENTS.md` in a chat session, first read every Markdown file in `AGENTS/RUNONCE/` fully. Then apply the instructions once in ascending filename order before doing other work. The three-digit filename prefixes define the execution order.

Do not repeat an instruction after it has completed successfully in the same chat session. Process every instruction again when a new chat session starts.

A failed, blocked, or incomplete instruction is not completed for the current chat session. Retry it if the blocker is resolved, but do not claim completion without verifying the intended outcome.

Run-once instructions do not override higher-priority instructions, required approvals, or safety constraints. Stop and ask the user before destructive, externally visible, or unclear actions unless the instruction or current request already provides the necessary authority.
