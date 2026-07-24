---
name: subagent-implementation-handoff-softskill
description: Use this orchestration softskill when the main agent should delegate source-based investigation or implementation preparation to one or more subagents without flooding or biasing the main context. It tells the main agent how to brief each subagent with minimal sufficient context, assign a unique short filename-safe hash token, create ordered repository-local Markdown handoffs only for concrete and worthwhile implementation concerns, and accept either created file paths or an explicit no-handoff result.
---

# Subagent Implementation Handoff Softskill

## Purpose

Use this softskill as the **main agent or orchestrator**.

Its purpose is to help the main agent delegate detailed repository investigation to subagents while keeping the main context small and preserving each subagent's complete useful result.

The main agent must not ask subagents to paste long reports back into the parent conversation. It must instruct each subagent to write every concrete, worthwhile implementation concern into repository-local Markdown files called **Subagent Implementation Handoffs** and return only the created file paths.

A subagent is not required to find a handoff. When the investigation does not support a meaningful later implementation task, it must create no file and return only `NO_HANDOFFS_CREATED`.

A Subagent Implementation Handoff is:

- grounded in the actual repository source
- more concrete than a general review or recommendation
- close enough to implementation that a later planning agent can turn it into an implementation plan
- organized around one coherent, meaningful chunk of work
- explicit about likely code areas, contracts, dependencies, constraints, and unresolved decisions
- not itself a coding-agent implementation plan

The workflow is complete when every justified finding is safely written to local handoff files and the main agent has received only their paths, or when the subagent has correctly returned `NO_HANDOFFS_CREATED` because no justified handoff exists.

## Main-Agent Responsibility

This skill controls the main agent, not the subagent directly.

The main agent must:

1. Decide whether delegation is useful.
2. Define a bounded objective for each subagent.
3. Brief each subagent with the minimum sufficient context.
4. Determine whether this delegation launches more than one subagent for the work set.
5. When more than one subagent runs, explicitly instruct every subagent to ignore repository-local `AGENTS.md` instructions for this assignment.
6. Generate and assign each subagent run a unique short filename-safe hash token.
7. Include the required eligibility, file-writing, no-handoff, and return contracts in every subagent prompt.
8. Require the subagent to inspect the repository and derive its own findings.
9. Require the subagent not to manufacture a finding or file merely to complete the assignment.
10. Require the subagent to explain technically how a justified change could be realized, compare credible options, and recommend a direction without implementing it.
11. Require the subagent to write in simple, direct, easy-to-understand language without unnecessary meta terminology.
12. Require the subagent to split broad justified findings into coherent, ordered handoffs.
13. Require the subagent to write the complete useful result for each justified finding into local Markdown files.
14. Require the subagent to return only created file paths, or exactly `NO_HANDOFFS_CREATED` when no justified handoff exists.
15. Avoid copying the complete handoff contents back into the main conversation.

The main agent must not silently perform the subagent's requested investigation itself as a substitute for delegation when this skill is being used.

## When To Use

Use this softskill when:

- several subagents will review or investigate repository concerns
- one or more expert subagents are likely to produce very detailed answers
- direct subagent replies would overwhelm the main agent's context
- the findings should survive beyond the individual subagent call
- a later agent will convert the handoffs into implementation plans
- the work should be divided into independently plannable implementation concerns
- the user wants concrete preparation but not implementation yet
- an independent result is more valuable than confirmation of the main agent's current theory

## When Not To Use

Do not use this softskill when:

- the delegated answer will be short and can safely return directly
- the user requested immediate implementation rather than preparation
- the task is a simple factual lookup with no repository-specific handoff value
- subagents cannot write to the repository and no durable output channel exists
- the requested artifact is already an implementation plan, issue set, patch, or code change
- repository-local analysis would expose secrets or sensitive data

## Minimal Independent Briefing Rule

The main agent must brief subagents with **minimum sufficient context**.

Less context is usually better when the goal is an independent result. The main agent should provide enough information to make the assignment safe and correctly scoped, but should avoid steering the subagent toward the main agent's own diagnosis or preferred answer.

The main agent should normally provide only:

- the objective or concrete question
- the repository or source the subagent may inspect
- the relevant scope
- explicit exclusions
- hard compatibility requirements
- safety, environment, and policy constraints
- the assigned short subagent hash token
- the output location
- the filename contract
- the required handoff characteristics
- the required response contract

The main agent should normally omit:

- its own suspected root cause
- the exact point where it is currently stuck
- its preferred architecture or solution
- conclusions from its own investigation
- long conversation history that can be rediscovered from the repository
- leading wording that asks the subagent to confirm a theory
- other subagents' findings

Do not hide essential requirements. Minimal briefing means removing bias and irrelevant context, not withholding the actual objective or mandatory constraints.

The main agent must phrase the assignment so the subagent derives its own current-state model, concrete direction, and implementation boundaries from repository evidence.

## Multi-Subagent AGENTS.md Isolation Contract

The main agent knows whether the work set uses one subagent or several. It must apply this rule based on the number of subagents it launches for that work set.

When more than one subagent runs, the main agent must include an explicit instruction equivalent to:

```text
For this assignment, ignore repository-local AGENTS.md instructions. Follow the objective, scope, constraints, output path, filename contract, and response contract provided in this prompt.
```

This instruction applies to every subagent in that multi-subagent work set, including subagents launched sequentially rather than simultaneously when their results are intended to be independent or compared later.

The purpose is to keep independently tasked subagents from being shaped by repository-local agent guidance that may steer all of them toward the same process, assumptions, or preferred solution.

When exactly one subagent runs, the main agent must not add an `AGENTS.md` override. Normal harness and repository behavior remains the default.

The override is limited to repository-local files named `AGENTS.md`. It does not override system instructions, harness policy, explicit user requirements, security boundaries, tool permissions, or the no-implementation and no-publication rules of this skill.

For multi-subagent work sets, the main agent must not rely on `AGENTS.md` to communicate essential task constraints. It must place the required objective, scope, exclusions, compatibility constraints, safety constraints, output path, filename rules, and response contract directly in each subagent prompt.

## Assignment Framing

The main agent must make each assignment close to the implementation surface without turning it into an implementation plan.

Good assignment framing includes concrete repository questions such as:

- identify the current request path and the exact boundaries that would need to change
- compare existing implementations and recommend one concrete consolidation direction
- inspect the storage model and define the target data and migration constraints
- review the authentication flow and identify enforcement and compatibility points
- determine which modules, interfaces, configuration keys, workflows, and tests are affected
- turn an observed failure mode into an implementation-near change handoff

Avoid vague assignments such as:

- think deeply about the architecture
- give general best practices
- brainstorm improvements
- describe the problem metaphorically
- provide high-level thoughts

The main agent must instruct the subagent to prefer actual repository paths, symbols, responsibilities, dependencies, and behavior over metaphors or generic advice.

## Handoff Eligibility Gate

A Subagent Implementation Handoff is justified only when repository evidence supports a concrete implementation concern that is worth preserving for a later planning or implementation step.

Before creating a file, the subagent must be able to answer all of these questions:

1. What current behavior, defect, gap, duplication, risk, or required change creates real implementation work?
2. What concrete target direction is supported by the repository evidence?
3. Is the concern substantial enough for a later planning agent to act on?
4. Would creating and later processing this handoff add more value than simply leaving the current state unchanged?

If any answer is no, uncertain, purely speculative, or only a matter of taste, do not create that handoff.

The following are not sufficient reasons to create a handoff:

- the subagent was asked to review an area
- an alternative exists but is not recommended
- the current implementation is already appropriate
- the only result is **keep as is**, **no action**, or **insufficient evidence**
- a cleanup could be done opportunistically but is not worth planning now
- a possible future requirement might make a change useful later
- the subagent wants to demonstrate that it inspected the repository
- the output format appears to expect at least one file

Finding nothing is a valid result. Quality and usefulness take precedence over file production.

When no concern passes this gate, the subagent must:

- create no handoff files
- leave existing handoff files unchanged
- return exactly `NO_HANDOFFS_CREATED`
- add no explanation, summary, reviewed-area list, or fallback report

## Subagent Hash Contract

Before starting a subagent, the main agent must generate and assign a unique short filename-safe hash token for that subagent run.

Use a lowercase hexadecimal token with 8 to 12 characters. It does not need to be cryptographically derived or globally unique; it only needs enough practical uniqueness to distinguish concurrent and logically separate runs in the local workspace.

Good examples:

```text
7f3a91c2
c84d2e6b
91af07d4c3e2
```

Do not use visibly artificial repeated-character placeholders, sequential tokens, agent numbers, model names, timestamps alone, or long globally unique identifiers when a short hash is sufficient.

The main agent must:

- generate the token before launching the subagent
- use a different token for every concurrent or logically separate subagent run
- include the exact token in the subagent prompt
- instruct the subagent not to invent, replace, shorten, expand, or normalize the token
- instruct the subagent to use that exact token in every handoff filename created by that run

The short hash token provides the collision boundary when several subagents work on the same or similar topics.


## Output Location Contract

The main agent must instruct each subagent where justified handoff files would be written. The path contract applies only when one or more concerns pass the Handoff Eligibility Gate.

For a single-subagent run, prefer an existing repository-local location explicitly designated for local agent work. For a multi-subagent work set, the main agent must choose and state the output location directly rather than relying on `AGENTS.md`. Unless another safe path is explicitly supplied, instruct the subagent to use:

```text
AGENTS/HANDOFF/
```

The main agent must include these output rules in the assignment:

- resolve the repository root before writing
- in a single-subagent run, respect repository guidance that specifies another local agent-work location
- in a multi-subagent work set, use the output location explicitly supplied by the main agent and do not derive it from `AGENTS.md`
- prefer a path that is already ignored or intentionally local-only
- do not stage, commit, or push generated handoffs
- do not modify `.gitignore` merely to support this workflow
- do not write to an arbitrary external directory
- if a concern qualifies but no safe repository-local output location can be determined, return the blocker instead of claiming success
- if no concern qualifies, return `NO_HANDOFFS_CREATED` even when no output directory exists

## Filename Contract

The main agent must require this exact filename pattern:

```text
subagent-<subagenthash>-NN-<topic>.md
```

Example using the short hash token `7f3a91c2`:

```text
subagent-7f3a91c2-01-domain-contracts.md
subagent-7f3a91c2-02-storage-transition.md
subagent-7f3a91c2-03-api-compatibility.md
```

The main agent must instruct the subagent that:

- `<subagenthash>` is the exact short hash token supplied by the main agent
- `NN` is a two-digit order number such as `01`, `02`, or `03`
- the order number appears immediately after the hash so normal filesystem sorting preserves the intended sequence within that run
- `<topic>` is a short lowercase hyphen-case name for the actual implementation concern
- numbering starts at `01` for that hash-scoped run
- ordering follows dependency or implementation-preparation order
- every file from the same run uses the same short hash token
- an existing file must never be overwritten
- a filename collision must be returned as a blocker

Bad names include:

```text
handoff-01-domain-contracts.md
handoff-agent1-01-domain-contracts.md
agent-7-answer.md
research.md
thoughts-final-final.md
preparation.md
```

## Complete-Result Persistence Contract

The main agent must explicitly instruct each subagent to place its **complete useful result for every concern that passes the Handoff Eligibility Gate** in the handoff files.

When one or more handoffs are justified, the main agent must treat the handoff files as the complete result and the subagent response only as a file handoff. When none are justified, `NO_HANDOFFS_CREATED` is the complete successful response.

The main agent must require the subagent to:

- preserve all useful source-based findings that pass the Handoff Eligibility Gate in the files
- avoid shortening the result merely to keep the response small
- move supporting detail into the appropriate handoff or a concise appendix inside that handoff
- avoid leaving important reasoning only in the subagent response
- avoid returning the complete report after the files were written successfully

## Topic Splitting Contract

After at least one concern passes the Handoff Eligibility Gate, the main agent must instruct the subagent to create multiple handoffs when the justified result contains:

- materially different implementation concerns
- independent subsystems or ownership boundaries
- a foundation followed by dependent work
- separate data, API, UI, infrastructure, migration, or rollout concerns
- more detail than one planning agent should process as one coherent work package

The main agent must instruct the subagent to split by implementation boundary or dependency, not by arbitrary text length.

Each handoff should be:

- large enough to represent a meaningful chunk of future implementation work
- small enough for one planning session to understand and convert into a plan
- internally coherent
- independently nameable
- ordered relative to the other handoffs from the same hash-scoped run

The main agent must also instruct the subagent:

- do not create one file for every minor observation
- merge closely related findings that would naturally be planned and implemented together
- do not leave one extremely large file merely because all findings came from one assignment

## Default Handoff Ordering

When applicable, the main agent should tell the subagent to order handoffs using the repository's real dependency graph.

A useful default order is:

1. shared concepts, contracts, and compatibility decisions
2. data model, persistence, or state foundations
3. core application or domain behavior
4. external interfaces and integrations
5. UI, presentation, or consumer adaptation
6. migration, rollout, observability, and cleanup

The repository's actual dependency order takes precedence over this heuristic.

## Handoff Size Standard

The main agent must request **medium to near-long** handoffs rather than tiny notes or exhaustive unbounded reports.

The main agent should instruct the subagent to include:

- enough source evidence to establish the current state
- enough concrete detail to define the implementation concern
- enough boundaries and constraints to prevent a later planning agent from repeating the full investigation
- enough dependency and risk information to order the work

The main agent must instruct the subagent to split a handoff when it contains multiple independently plannable outcomes or becomes difficult to navigate.

The main agent must instruct the subagent to merge a handoff when it contains only a few shallow observations without a substantial implementation boundary.

## Source-First Contract

The main agent must require the subagent to inspect the actual repository before writing conclusions.

The prompt should authorize inspection of relevant evidence such as:

- source files
- project and package manifests
- entrypoints and composition roots
- configuration
- tests
- schemas and migrations
- workflows and deployment files
- existing runbooks and project notes other than an ignored `AGENTS.md` in multi-subagent mode
- public contracts and interfaces
- current Git state when relevant

The main agent must instruct the subagent:

- do not fill handoffs with generic practice disconnected from the repository
- make supporting source locations or observed behavior identifiable
- use repository-relative paths and symbol names whenever practical
- reduce confidence when source access is incomplete
- do not fill missing evidence with assumptions

## Required Handoff Structure

The main agent must instruct the subagent to use this structure unless the assignment clearly requires a small variation:

```markdown
# Subagent Implementation Handoff <subagenthash> NN: Topic

## Assignment
What the subagent was asked to determine.

## Intended outcome
The concrete implementation outcome this handoff prepares for.

## Scope
What is covered and what is intentionally excluded.

## Source inspected
Repository-relative files, symbols, configuration, tests, and other evidence.

## Current state
How the relevant code currently works and where responsibility lives.

## Concrete direction
The recommended target direction, stated in implementation-near terms.

## Technical approach
How the change could be realized technically: likely responsibility shifts, affected symbols and contracts, data or control flow, configuration or persistence changes, integration seams, error handling, and compatibility mechanics. Describe the implementation shape without writing the implementation or a step-by-step execution plan.

## Alternatives and recommendation
When more than one credible approach exists, compare the realistic options, explain their repository-specific trade-offs, recommend one, and state when another option would be preferable.

## Affected boundaries
Files, modules, APIs, schemas, configuration, tests, integrations, or ownership boundaries likely to matter.

## Compatibility and constraints
Behavior, contracts, environments, data, or operational properties that must be preserved.

## Dependencies and ordering
What must happen before this topic and what it enables afterward.

## Planning inputs
Concrete decisions, acceptance concerns, and verification surfaces the later planning agent must include.

## Risks and unresolved questions
Only genuine risks or decisions not safely derivable from the source.
```

Optional sections may include:

- `## Data and migration considerations`
- `## Interface examples`
- `## Candidate test surfaces`
- `## Rejected directions`
- `## Supporting evidence`

The main agent must instruct the subagent not to add empty sections.

## Concreteness Contract

The main agent must require handoffs to be concrete enough that a later planning agent can begin without repeating the entire investigation.

Good content resembles:

- `src/Orders/OrderController.cs` currently owns request mapping and payment orchestration; move orchestration behind an application-level boundary while preserving the controller contract.
- `PackageResolver` and `DepotResolver` duplicate version selection; consolidate the selection rule before changing acquisition behavior.
- The production route is configured in `ReverseProxySettings.Production.json`; development settings are outside the intended deployment change.

The main agent must tell the subagent to avoid content such as:

- improve separation of concerns
- make the architecture cleaner
- use a more scalable approach
- the system is like a complex machine
- consider modern best practices

The prompt must require actual files, symbols, responsibilities, data flows, contracts, and observed behavior whenever possible.

## Technical Direction Contract

The main agent must require the subagent to go beyond identifying affected areas and provide useful technical guidance about how the change could be realized.

The handoff should describe, when supported by repository evidence:

- where responsibilities should remain, move, split, or consolidate
- which existing types, interfaces, methods, modules, configuration keys, schemas, or workflows are likely to change
- which new boundary or contract may be needed and why
- how request, control, event, state, or data flow should pass through the affected components
- how compatibility, error handling, migration, rollout, or operational behavior could be preserved
- which tests or verification surfaces would prove the intended behavior

When multiple credible approaches exist, the main agent must instruct the subagent to:

1. name the realistic options
2. explain the repository-specific advantages and disadvantages of each
3. recommend one concrete direction
4. explain why that direction best fits the observed code and constraints
5. state the conditions under which another option would be preferable

Prefer decisive guidance such as "use approach X here because the existing boundary already owns Y" over noncommittal language such as "consider X or Y."

This technical guidance must still stop before implementation. The subagent must not write production code, patches, complete method bodies, exact file-by-file edit instructions, shell commands, or a full ordered execution plan.

## No-Metaphor Contract

The main agent must instruct the subagent not to use metaphor, narrative framing, or motivational language as a substitute for technical specificity.

The main agent may allow the subagent to explain why a change matters, but must require that explanation to use behavior, maintainability, dependency direction, operability, compatibility, or implementation cost rather than metaphor.

## Plain-Language Contract

The main agent must instruct the subagent to use simple, direct, easy-to-understand language throughout every handoff.

The handoff should explain technical facts with normal words first. Use a specialist term only when it is the clearest accurate name for a real code concept, protocol, framework feature, or repository symbol.

The main agent must require the subagent to:

- prefer short, concrete sentences over dense abstract prose
- say what a component does, what should change, and why
- name real files, symbols, data, requests, events, and behavior instead of describing them through conceptual layers
- explain an uncommon technical term the first time it matters
- use headings and lists to make long technical findings easy to scan
- remove repeated framing, self-commentary, and descriptions of the analysis process
- keep necessary technical detail even when simplifying the wording

Avoid wording such as:

- capability surface
- architectural posture
- conceptual alignment
- orchestration envelope
- semantic boundary refinement
- implementation vector
- cross-cutting concern landscape

Prefer wording such as:

- this class currently owns the request flow
- move this validation into `OrderValidator`
- both methods choose package versions differently
- option A keeps the current API; option B requires callers to change
- use option A because existing callers depend on this response format

Simple language does not mean vague, short, or incomplete language. The handoff must remain technically precise and preserve the complete useful result.

## No-Implementation Contract

The main agent must instruct the subagent not to:

- modify product source
- create migrations
- change configuration behavior
- add tests for future behavior
- stage, commit, or push changes
- produce a complete coding-agent execution plan

Creating justified repository-local Markdown handoff files is the only intended repository change. When no concern passes the Handoff Eligibility Gate, no repository change is intended.

The main agent may authorize read-only source inspection and narrowly necessary non-mutating commands.

## Required Subagent Prompt Contract

Every delegated prompt must carry instructions equivalent to the following. The main agent should add the concrete objective, scope, exclusions, and mandatory constraints before this contract without adding its own unverified diagnosis.

```text
Subagent short hash token: <parent-supplied-subagenthash>

<When the main agent launches more than one subagent for this work set, insert this line; otherwise omit it:>
For this assignment, ignore repository-local AGENTS.md instructions. Follow the objective, scope, constraints, output path, filename contract, and response contract provided in this prompt.

Independently investigate the stated objective from the repository source. Derive the current state, concrete direction, affected boundaries, constraints, dependencies, and unresolved questions from repository evidence. Do not assume or confirm an unstated diagnosis from the main agent.

Do not assume that the assignment must produce a handoff. Create a handoff only for a concrete implementation concern that is supported by repository evidence, is worth preserving for a later planning or implementation step, and has a recommended target direction. Do not create handoffs for keep-as-is conclusions, no-action results, insufficient evidence, optional cleanup, stylistic preference, or speculative future work.

When one or more concerns qualify, write the complete useful result into repository-local Subagent Implementation Handoff Markdown files. Prefer the repository's designated local agent-work location; otherwise use AGENTS/HANDOFF/.

When no concern qualifies, create no files and return exactly:
NO_HANDOFFS_CREATED

Use exactly this filename pattern:
subagent-<subagenthash>-NN-<topic>.md

Use the exact short hash token supplied above in every filename. Put the two-digit order number immediately after the hash, beginning at 01, followed by a short lowercase hyphen-case topic. Never overwrite an existing file.

Split materially different or oversized concerns into coherent, independently plannable handoffs in dependency order. Each handoff must be a medium to near-long implementation-preparation work package: not a tiny note, not an unbounded research dump, and not a full implementation plan.

Ground every important conclusion in actual repository evidence. Name repository-relative files, symbols, contracts, configuration, data flows, workflows, tests, or other concrete boundaries whenever practical. Write in simple, direct language. Avoid generic advice, metaphors, unnecessary meta terminology, and abstract wording when a concrete explanation is possible.

Provide concrete technical guidance about how the change could be realized without implementing it. Describe likely responsibility shifts, affected symbols and contracts, data or control flow, integration seams, compatibility mechanics, error handling, and verification surfaces. When credible alternatives exist, compare them, explain their repository-specific trade-offs, recommend one direction, and state when another option would be preferable. Do not write production code, patches, exact edit instructions, shell commands, or a full ordered execution plan.

Do not modify product code, configuration behavior, migrations, or future tests. Do not stage, commit, or push the generated handoffs.

After successfully writing one or more files, return only their repository-relative paths, one path per line. When no handoff qualifies, return only `NO_HANDOFFS_CREATED`. In either case, do not return summaries, topic descriptions, ordering commentary, excerpts, reviewed-area lists, or a report in your response.
```

## Subagent Response Contract

The main agent must accept either of these successful response shapes.

### One or more handoffs created

The response contains only the created repository-relative paths, one per line:

```text
AGENTS/HANDOFF/subagent-7f3a91c2-01-domain-contracts.md
AGENTS/HANDOFF/subagent-7f3a91c2-02-storage-transition.md
AGENTS/HANDOFF/subagent-7f3a91c2-03-api-adaptation.md
```

### No justified handoff

The response contains exactly:

`NO_HANDOFFS_CREATED`

This is a successful result, not a failure or blocker. The main agent must not ask the subagent to invent a topic, broaden the review, or create a confirmation file.

A successful response in either shape must not add:

- file summaries
- topic descriptions
- dependency explanations
- planning-order commentary
- blocker sections
- excerpts from the handoffs
- reviewed-area inventories
- reasons why nothing was found
- duplicate report content

The main agent must not ask a successful subagent to repeat its investigation in chat.

## Main-Agent Return Contract

After all requested subagents have completed successfully:

- when at least one handoff path exists, return only all created repository-relative paths, one per line; omit `NO_HANDOFFS_CREATED` responses from individual subagents
- when no subagent created a handoff, return only `NO_HANDOFFS_CREATED`

Do not paste the complete contents of the handoffs or no-finding explanations into the main conversation unless the user explicitly asks to read them there.

## Failure Handling

The main agent must instruct the subagent that, if a handoff cannot be written, it must:

- not claim that the file was saved
- return the intended path and exact blocker
- include only the minimum fallback detail needed to avoid losing all useful work

When a subagent reports a write failure, the main agent may provide another safe repository-local path or perform the file write itself using the subagent's returned fallback content.

When source access is incomplete, the main agent must require the subagent to:

- state the missing source inside the handoff when a handoff can still be written
- reduce confidence
- avoid filling gaps with generic assumptions

When an assignment produces justified findings that are too broad for one handoff, the main agent must require the subagent to split those findings into coherent handoff files rather than returning one oversized response. A broad review with no justified finding still returns `NO_HANDOFFS_CREATED`.

## Security and Privacy Contract

The main agent must instruct every subagent:

- never place secrets, credentials, private keys, tokens, cookies, private customer data, or sensitive personal data into a handoff
- document secret sources and configuration key names without copying secret values
- do not include large raw logs or data dumps
- summarize technically relevant evidence and point to the safe source location

## Main-Agent Quality Checklist

Before launching a subagent, verify:

- the assignment is bounded and concrete
- the prompt contains only minimum sufficient context
- essential requirements and constraints are present
- when more than one subagent runs, the prompt explicitly tells the subagent to ignore repository-local `AGENTS.md` instructions
- when exactly one subagent runs, no `AGENTS.md` override was added
- the prompt does not embed the main agent's unverified diagnosis or preferred solution
- a unique short filename-safe subagent hash token was generated and assigned
- the exact filename pattern is included
- the local output location is explicitly specified for multi-subagent work sets and specified or safely discoverable for a single-subagent run
- the Handoff Eligibility Gate and `NO_HANDOFFS_CREATED` contract are included
- the full-result persistence contract applies only to justified findings
- the topic-splitting and handoff-size rules are included
- source-first, concreteness, technical-direction, plain-language, no-metaphor, and no-implementation rules are included
- the prompt requires simple, direct wording without unnecessary meta terminology
- the response contract requires only created file paths or exactly `NO_HANDOFFS_CREATED`

After the subagent returns, verify:

- the response contains only created file paths or exactly `NO_HANDOFFS_CREATED` when successful
- when `NO_HANDOFFS_CREATED` was returned, no new handoff file exists for that run
- every returned filename contains the exact assigned short hash token
- every filename follows `subagent-<subagenthash>-NN-<topic>.md`
- no path indicates that another hash-scoped run was overwritten
- the files exist before claiming success when the harness can verify them
- generated handoffs were not staged, committed, or pushed

## Typical Invocation Phrases

- `Use the subagent implementation handoff softskill to delegate these reviews.`
- `Brief the subagents independently and have them persist their complete justified findings in hash-scoped local handoffs.`
- `Keep the main context small and return only handoff file paths, or NO_HANDOFFS_CREATED when no useful handoff exists.`
- `Create implementation-near subagent handoffs that I can later turn into plans.`
- `Use separate short hash tokens and the required subagent-hash-order-topic filename pattern.`
