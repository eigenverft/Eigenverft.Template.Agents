---
name: auto-execute-repo-issue-files
description: Apply automatically when working with repository-local issue directories or issue files.
---

# Repository Issue Files

Apply these rules when creating, updating, closing, or deferring repository-local issue files within the authorized task.

- **Directory structure.** Keep the issue root as a container for subdirectories only. Store open issues in `open/`, completed issues in `done/`, and issues explicitly deferred by the user in `deferred/`. Use other subdirectories only when explicitly requested.
- **Open issues.** Store open issue files in the issue directory's `open/` subdirectory.
- **Completed issues.** Once an issue's work is complete, move the same file from `open/` to `done/` under the same issue directory, preserving its filename and history.
- **Deferred issues.** When the user explicitly asks to defer or postpone an issue, move the same file to `deferred/` under the same issue directory, preserving its filename and history. Record the deferral in the issue, including the reason when provided.
- **Status commit and push.** When commits are authorized, prefer a focused commit containing the issue move and its completion or deferral update. Push it to the task branch when publication is authorized and a suitable writable remote is available.

## Compact Issue Format

Use this structure as a starting point. Reuse established repository or task-specific formats that cover the same information, and keep detail proportionate to the issue.

When creating or refining an issue, compare the request with the relevant code and documentation early, before shaping implementation approaches. Ground the description and affected features in the actual concepts, behavior, and relationships found there.

Keep `Created` as the original creation date and update `Last edited` whenever the issue is edited. Use `YYYY-MM-DD` for both dates; initialize them to the same date when creating an issue.

In the clarification section, examine how the user's terms map to existing concepts. Consider whether a term may be imprecise, refer to a different existing feature, or be confused with a similar term that implies a materially different behavior or outcome. Preserve the user's intended goal while making competing interpretations and their consequences explicit. Ask the user when the available context cannot resolve a consequential difference in intended meaning.

Use the checked confirmation below only after this context check and when all identified ambiguities and possible misunderstandings are resolved. Otherwise, replace it with concrete unchecked task items describing what still needs clarification.

Keep open decisions separate from decisions already made. Record agreed decisions with their brief rationale; keep proposals distinguishable from accepted choices. Use `None` when a decision section has no entries, or `Not required` when the task is already clear and no decision is needed.

Outline practical implementation approaches at a level useful for discussing the issue. Include alternatives when they offer meaningful differences, with brief trade-offs. Keep these as proposals until a choice is agreed. Use `Not required` when the implementation approach is already clear.

Mark `Ready for implementation` only when the codebase context has been checked, consequential ambiguities are resolved, and the decisions needed to start are made or not required. Otherwise, replace the checked confirmation with concrete unchecked task items for what still needs clarification or a decision. Readiness describes the issue's preparation state; implementation proceeds within the user's authorization.

```markdown
# Short, concrete issue title

Created: YYYY-MM-DD
Last edited: YYYY-MM-DD

## Context and goal
Problem or request, relevant evidence, and the intended outcome.

## Ambiguities and possible misunderstandings
Check the request against the codebase's concepts and behavior. Could the user's terminology or a similar term imply a different intended outcome?
- [x] All identified ambiguities and possible misunderstandings are clarified.

## Open decisions
Choices that still need a decision. Use `None` when there are no open decisions.

## Decisions already made
Agreed choices and their brief rationale. Use `None` when none have been made, or `Not required` when the task is already clear and no decision is needed.

## Possible implementation approaches
How the change could be implemented, including meaningful alternatives and their brief trade-offs.
Reference agreed decisions where relevant. Use `Not required` when the approach is already clear.

## Affected features and existing functionality
Existing features or implemented behavior directly affected by or connected to the change.
Explain the connection or impact briefly. Use `None` when the change is isolated.

## Implementation readiness
- [x] Ready for implementation.
```

Distinguish existing functionality from the proposed change. Keep this focused on direct connections and effects.
