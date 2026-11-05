# SoftSkill Checklists

## Naming Checklist

- Use lowercase hyphen-case for the skill `name`.
- Keep the name specific to capability and easy to invoke.
- Avoid collisions with existing names under `.agents/skills`.
- Confirm the spoken prompt phrasing maps naturally to the skill name.

## SKILL.md Authoring Checklist

- Frontmatter includes `name` and `description`.
- `SKILL.md` is the only required package file; supporting resources are added only when needed.
- Frontmatter uses only allowed keys.
- Description states purpose and clear trigger conditions.
- Write `description` as a single plain YAML line without outer quotation marks. Keep internal quotation marks when useful and rephrase colon-space or whitespace-hash sequences to preserve the complete string.
- Use the exact description opening for the name family: `Apply automatically when ` for `auto-execute-*`; `Use when the user requests ` for `execute-*`; `Use for a read-only review when ` for `review-*`, `analyze-*`, and `view-*`.
- Body sections define behavior, scope boundaries, and outputs.
- No placeholder text remains.

## Optional Harness Metadata Checklist

Create `agents/openai.yaml` only when explicitly requested. Its absence is valid; required behavior belongs in `SKILL.md` and its referenced resources.

When the file is requested:

- `display_name` is user-facing and does not contain `$`.
- `short_description` is meaningful and 25-64 characters long.
- `default_prompt` explicitly references `$skill-name` usage.
- Quote all string values and keep keys unquoted.

## Direct Creation Template

Use this template when creating a skill from description:

```markdown
Skill Brief
- Goal: <goal>
- Scope: <in-scope>
- Out of scope: <out-of-scope>

Planned Files
- .agents/skills/<skill-name>/SKILL.md
- .agents/skills/<skill-name>/references/<optional-file>.md

Validation Notes
- Frontmatter keys validated
- Description validated
- Optional harness metadata checked only when present
- Placeholder scan clean
```


