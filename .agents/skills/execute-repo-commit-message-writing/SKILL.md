---
name: execute-repo-commit-message-writing
description: Use when carrying out a user's Git commit request to write clear, descriptive, developer-oriented messages for the actual changes in each commit. Apply these rules directly to every created commit, including multi-commit requests, without requiring explicit skill invocation or a separate draft-approval step. This skill defines commit-message content only, not change grouping or a Git execution or publication workflow.
---

# Execute Repo Commit Message Writing

## Purpose and Activation

Write clear, descriptive commit messages from a developer perspective and use them directly for user-authorized commits. For multiple commits, write a separate message for each group's actual changes, not the entire working diff.

This skill defines message content only. Do not regroup changes or independently authorize Git actions. A message-draft request alone does not authorize a commit.

## Commit Messages

Base each message on the exact diff being committed and verified context. Refresh it if that diff changes. Unless requested, do not introduce a separate draft-approval step.

Use a clear subject and the following sections in the commit body whenever practical:

### Changes

Summarize the concrete technical modifications, not just their overall theme. Identify affected paths, components, or symbols where they help locate and understand the changes, and state relevant additions, removals, changed conditions, or interfaces. Group repetitive modifications into a compact summary rather than listing every touched file.

### Description

Explain how those modifications affect the implementation, behavior, structure, or workflow. Keep it reasonably concise, with enough concrete technical context to understand the change without inspecting the diff, rather than merely repeating Changes.

### Intent

When the user's intent, requested outcome, or relevant background is supported by explicit instructions, repository context, or other verified information, briefly explain why the change was made. Otherwise omit Intent entirely; do not invent or speculate about missing context.

Prefer informative commit messages over overly short summaries. Avoid repeating the same explanation in each section.

When practical, prefix the commit subject with the current local date:

`[YYYY-MM-DD] Implementation-focused subject`

Follow any explicit user requirements for message language or format. Do not add unperformed verification or unrelated changes to the message.
