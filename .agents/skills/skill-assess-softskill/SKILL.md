---
name: skill-assess-softskill
description: Assess one skill, a skill collection, or multiple skill versions for semantic quality, internal consistency, metadata alignment, safety, interoperability, maintainability, portability, and cross-repository generality. Use for first-party, copied, legacy, or third-party skills. Read each selected skill package completely before rating it, distinguish defects from intentional or still-useful divergence, report separate repository-structure and repository-content generality scores, provide evidence-based quality scores and confidence with reasons, and make no repository changes unless the user separately requests edits.
---

# Skill Assess Softskill

## Purpose

Use this skill to evaluate whether agent skills are clear, coherent, safe, usable, and compatible with their intended environment.

This is a semantic assessment skill. It complements structural validators that check filenames, frontmatter, YAML syntax, or directory shape.

The assessment may target:

- one standalone skill
- several related skills that form a workflow
- every skill in a repository or selected directory
- copied or legacy skills in a target repository
- two or more versions of the same skill
- third-party skills imported for evaluation

The assessment must not assume:

- newer is automatically better
- local is automatically better than third-party
- longer is more complete
- shorter is clearer
- different wording means incompatibility
- a copied skill is obsolete merely because another repository has a newer version
- every advisory deserves a change

A useful older or divergent skill may receive a strong score with a compatibility advisory.

## Default Behavior

This skill is read-only by default.

The assessing agent must:

1. Resolve the selected skill package or packages.
2. Read each selected `SKILL.md` completely.
3. Read each selected `agents/openai.yaml` completely when present.
4. Inspect referenced scripts, references, assets, or neighboring skills only when they materially affect behavior or the requested assessment.
5. Build a whole-skill or whole-collection model before assigning scores.
6. Report evidence-based findings, ratings, confidence, and recommendations.
7. Make no edits, moves, deletions, generated replacement skills, commits, or pushes.

Do not silently turn an assessment request into a rewrite.

## Assessment Modes

### Single-skill assessment

Assess one skill as a standalone package and in its declared environment.

Use this mode for requests such as:

- assess this skill
- review the quality of this skill
- is this third-party skill safe and useful here
- rate this copied skill

### Collection assessment

Assess several skills both individually and as a system.

In addition to each skill's standalone quality, inspect:

- overlapping activation descriptions
- contradictory authority or safety rules
- incompatible file or lifecycle contracts
- mismatched terminology for shared states
- workflow gaps between producer, transformer, and consumer skills
- duplicated skills with different names
- same-name skills with materially different behavior
- assumptions that only hold in one repository
- dead workflow branches or unreachable states

Do not force related skills into one design. Independent skills may intentionally use different contracts.

### Version comparison

Compare two or more versions without presuming chronological superiority.

Identify:

- behavior added, removed, or narrowed
- safety boundary changes
- lifecycle changes
- metadata and default-prompt drift
- compatibility with the target repository
- useful local customizations
- regressions and improvements
- migration impact

A valid conclusion may be that both versions are useful in different environments.

## Selection Contract

Use explicitly named paths when the user supplies them.

When the user names a skill, resolve the most relevant accessible directory containing its `SKILL.md`.

When the user requests all skills in a repository, inspect the repository's actual skill locations rather than assuming only `.agents/skills/` exists.

Third-party skills may live in a dedicated import, vendor, evaluation, or staging directory. Do not relocate them merely to assess them.

Exclude generated copies, archive directories, examples, fixtures, and test skills only when repository guidance or the user clearly identifies them as non-targets. Otherwise report the scope decision.

If the complete requested selection cannot be read, do not claim a complete collection assessment. State the missing scope and lower confidence.

## Complete-Read-First Contract

Do not assess a skill from search matches, excerpts, headings, metadata, or the default prompt alone.

For every selected skill:

- read `SKILL.md` from beginning to end
- read `agents/openai.yaml` from beginning to end when present
- identify every referenced resource that changes execution behavior
- inspect those resources before rating the affected dimension
- reread the full skill when local details appear contradictory

For a collection:

1. Inventory all selected skills and resources.
2. Read each selected package completely.
3. Build a cross-skill model.
4. Only then assign collection-level findings and scores.

A local wording issue may make sense in the full document. A local fix may also create a global contradiction. Whole-document and whole-workflow understanding takes precedence over snippet-level impressions.

## Repository Context Contract

Skills are evaluated in context, not in isolation from their operating environment.

Inspect the smallest sufficient repository context needed to understand:

- expected skill discovery paths
- repository guidance and agent instructions
- available tools and permissions
- lifecycle directories and naming conventions
- whether outputs are local, tracked, ignored, archived, or published
- neighboring skills that explicitly produce or consume the same artifacts
- platform-specific assumptions

Separate these conclusions:

- **intrinsic issue** — the skill is internally defective regardless of repository
- **context mismatch** — the skill is coherent but does not fit the target repository
- **intentional coupling** — the skill deliberately targets a specific environment
- **unknown** — evidence is insufficient

Repository coupling is not automatically a defect. It becomes a portability concern when the skill presents itself as generic or is being considered for reuse elsewhere.

## Assessment Dimensions

Score every applicable dimension from `0.0` to `10.0`.

### 1. Purpose and activation clarity

Assess whether the skill clearly explains:

- what it does
- when to use it
- when not to use it
- its default behavior
- its terminal result

### 2. Internal consistency

Assess whether the skill's rules can be followed together.

Look for:

- direct contradictions
- incompatible defaults and exceptions
- impossible completion criteria
- circular instructions
- terminology that changes meaning within the skill
- unreachable or dead rules

### 3. Scope and authority boundaries

Assess whether the skill clearly distinguishes:

- analysis, planning, implementation, and publication
- permitted and forbidden repository changes
- user decisions versus agent decisions
- normal decisions versus genuine blockers
- direct execution versus delegation

### 4. Safety and preservation

Assess handling of:

- existing local work
- destructive commands
- secrets and sensitive data
- overwrites and collisions
- external or irreversible actions
- Git operations and publication
- third-party code or instructions

### 5. Metadata and interface alignment

Compare the full behavior with:

- frontmatter name and description
- `display_name`
- `short_description`
- `default_prompt`
- declared tools or metadata when present

The default prompt may be shorter, but it must not change core semantics or omit a critical safety or lifecycle rule.

### 6. Workflow and lifecycle consistency

Assess states, transitions, and ownership such as:

- active, pending, blocked, done, superseded, archived, or deleted
- producer and consumer expectations
- file naming and location
- selection and ordering
- terminal states
- recovery from malformed or stale inputs

For collection mode, verify that neighboring skills agree on shared lifecycle meanings.

### 7. Completeness and executability

Assess whether a capable agent can actually follow the skill without inventing essential behavior.

Look for:

- missing selection rules
- missing no-result behavior
- missing failure handling
- ambiguous output contracts
- incomplete sequencing
- undefined inputs or destinations
- assumptions about unavailable tools

### 8. Portability and declared environmental coupling

Assess whether the skill accurately declares and safely handles:

- repository-specific paths
- operating-system assumptions
- tool or harness assumptions
- hardcoded organization conventions
- dependency on neighboring skills
- behavior when copied elsewhere
- suitability for first-party and third-party use

This quality dimension evaluates whether coupling is explicit, coherent, and appropriate for the declared purpose. It does not measure how broad the skill's reuse range is; breadth is reported separately in the Generality Profile.

A repository-specific skill can score well when its coupling is explicit and appropriate.

### 9. Maintainability and signal quality

Assess whether the skill is:

- structured coherently
- specific without unnecessary repetition
- understandable without hidden context
- consistent in terminology
- free of obsolete branches and accidental churn
- maintainable when workflows evolve

Do not penalize necessary repetition that protects a critical contract across distant sections or a default prompt.

### 10. Interoperability

Apply when the skill participates in a workflow or collection.

Assess whether it composes safely with:

- producer and consumer skills
- validators or managers
- artifact writers
- planners and executors
- repository guidance
- imported third-party skills

For a truly standalone skill, mark this dimension `N/A` rather than inventing dependencies.

## Generality Profile

Report generality separately from semantic quality. A specialized skill can be excellent for its declared purpose while having a deliberately narrow reuse range.

Provide two independent scores from `0.0` to `10.0`:

### Repository-structure generality

Measure how well the skill can operate across different repository and project layouts, including:

- single-project repositories, monorepos, and repositories containing several unrelated projects
- nested source, test, documentation, infrastructure, tooling, package, and generated-output directories
- different programming languages, build systems, package managers, and project types
- repositories with no conventional `src/`, `test/`, or application entrypoint
- mixed operating systems and path conventions when relevant
- repository-local guidance in different locations
- absent optional directories or files
- custom artifact, archive, or work-output locations
- discovery by evidence rather than hardcoded organization assumptions

A high score means the skill discovers the relevant repository shape and adapts without requiring one expected layout. A low score means correct behavior depends on a narrow or hardcoded tree structure.

### Repository-content generality

Measure how well the skill applies across different kinds of repository content, including:

- application and library source code
- tests and fixtures
- configuration and schemas
- infrastructure, deployment, and workflow definitions
- documentation and runbooks
- data-oriented, model, prompt, policy, or specification repositories
- mixed repositories containing code and non-code artifacts
- repositories dominated by assets, generated files, vendored content, or binaries
- domain-specific versus domain-neutral assumptions

A high score means the skill can identify which content is relevant to its purpose and behave safely across many content mixes. A low score means it assumes a particular content domain, such as conventional application source code, even when that limitation is not declared.

### Generality scoring anchors

Use these anchors for both generality scores:

- `9.0–10.0` — adapts safely across highly varied or initially unknown repositories
- `7.5–8.9` — broadly reusable with a small number of explicit assumptions
- `6.0–7.4` — works across several common repository or content types but needs adaptation outside them
- `4.0–5.9` — useful in a narrow family of layouts or content domains
- `2.0–3.9` — tightly bound to one repository style, ecosystem, or content type
- `0.0–1.9` — effectively specific to one exact environment or unusable outside it

Do not interpret a low generality score as a defect by itself. State whether the narrowness is:

- intentional and correctly declared
- acceptable for the target repository
- a reuse limitation worth noting
- or misleading because the skill claims broader applicability than it actually supports

### Relationship to the overall quality score

By default, do **not** average either generality score into the overall quality score. The overall score measures fitness for the skill's declared purpose and intended environment.

Generality should affect the overall score only when at least one of these conditions applies:

- the skill claims to be generic, universal, repository-agnostic, or suitable for arbitrary repositories
- the user explicitly asks whether the skill can be reused across varied repositories or content types
- the target environment is intentionally unknown or heterogeneous
- undeclared assumptions cause incorrect or unsafe behavior outside one narrow repository shape or content domain

When generality affects the overall score, explain exactly which claim or requested use makes it relevant and how it was weighted.

Examples:

- A Windows-only PowerShell skill that clearly targets one Windows repository may score `9.0` for quality and `3.0` for repository-structure generality.
- A skill claiming to review any repository but assuming `src/`, application code, and one test layout should lose quality points for misleading scope as well as receive lower generality scores.
- A content-specific database-migration skill may have low repository-content generality but still merit `Keep as-is` when its activation and limitations are clear.

## Scoring Anchors

Use these anchors consistently:

- `9.0–10.0` — exceptionally clear, coherent, safe, and ready for intended use
- `7.5–8.9` — strong and useful; only targeted advisories or low-risk corrections
- `6.0–7.4` — usable, but meaningful ambiguity, coupling, drift, or maintenance debt exists
- `4.0–5.9` — fragile; important corrections are recommended before broad use
- `2.0–3.9` — seriously inconsistent, unsafe, misleading, or incomplete
- `0.0–1.9` — unusable for the stated purpose or actively dangerous

Use one decimal place when evidence supports it. Do not imply false precision when evidence is limited.

## Overall Score Contract

Provide an overall score from `0.0` to `10.0`, but do not use a blind arithmetic average.

Weight dimensions according to the skill's purpose and risk.

Keep the two Generality Profile scores separate unless the Generality Profile contract explicitly makes them relevant to the claimed or requested use.

Critical defects must cap the overall score:

- a credible destructive or security-critical contradiction normally caps the score at `3.9`
- an impossible core lifecycle or completion contract normally caps the score at `5.9`
- metadata drift alone normally does not cap the score unless the default prompt activates unsafe or materially different behavior

Explain every cap or major weighting decision.

When comparing versions or assessing a collection, provide:

- per-skill scores
- a collection or compatibility score
- the reason the collection score differs from individual scores

## Visual Rating

Provide an optional five-star visual derived from the overall score:

- `0.0–1.9` → `☆☆☆☆☆`
- `2.0–3.9` → `★☆☆☆☆`
- `4.0–5.9` → `★★☆☆☆`
- `6.0–7.4` → `★★★☆☆`
- `7.5–8.9` → `★★★★☆`
- `9.0–10.0` → `★★★★★`

The numeric score and reasoning are authoritative. Stars are only a quick visual summary.

## Confidence Contract

Report assessment confidence from `0.00` to `1.00`.

Confidence should reflect:

- completeness of the selected files
- access to referenced resources
- understanding of repository context
- availability of neighboring workflow skills
- whether the behavior can be validated structurally or by safe smoke inspection

Do not raise confidence merely because the assessor wrote a detailed report.

Use broad interpretations:

- `0.85–1.00` — complete package and relevant context were inspected
- `0.65–0.84` — minor context or resource gaps remain
- `0.40–0.64` — material environment or intent is uncertain
- below `0.40` — assessment is preliminary

## Finding Taxonomy

Classify each finding by type and severity.

Useful finding types include:

- **Contradiction** — two active rules cannot both be satisfied
- **Ambiguity** — materially different executions are plausible
- **Metadata drift** — interface metadata changes or omits core behavior
- **Lifecycle mismatch** — states or transitions conflict within or across skills
- **Unsafe authority** — the skill permits unsafe, destructive, or unauthorized behavior
- **Missing contract** — essential selection, output, failure, or completion behavior is undefined
- **Dead rule** — a rule is unreachable or made obsolete by another rule
- **Redundancy** — repeated rules create maintenance risk without adding protection
- **Portability concern** — hidden or misleading environmental coupling
- **Intentional divergence** — a difference is coherent and appears deliberate
- **Legacy but usable** — older behavior remains internally sound and useful in context
- **Obsolete behavior** — the skill no longer fits its declared workflow or environment
- **Advisory** — a non-blocking improvement or compatibility note

Severity levels:

- **Critical** — credible destructive, security, privacy, or irreversible risk
- **High** — core purpose, lifecycle, or authority is materially broken
- **Medium** — meaningful ambiguity, mismatch, or portability risk
- **Low** — localized quality or maintenance issue
- **Advisory** — useful information that does not require change

Do not inflate severity to make the assessment look decisive.

## Finding Eligibility Gate

Report a defect only when all of these are true:

1. The issue is supported by the complete selected skill package or workflow context.
2. It can cause incorrect, unsafe, misleading, or materially inconsistent behavior.
3. The finding identifies the affected rule, section, file, or interaction.
4. The recommendation is proportionate to the problem.

Do not report as defects:

- personal wording preferences
- harmless stylistic variation
- repository-specific behavior that is clearly declared
- duplicated safety reminders that protect distant execution paths
- older behavior that remains coherent and useful in the target repository
- theoretical incompatibilities with no plausible execution path

When evidence supports a concern but not a required change, classify it as an advisory.

## Legacy and Third-Party Neutrality Contract

Treat first-party, copied, legacy, and third-party skills by the same evidence standard.

For copied or older skills:

- identify meaningful drift
- assess current local usefulness
- do not recommend replacement solely because another version is newer
- preserve useful local adaptations in the recommendation
- state migration risks when alignment would change behavior

For third-party skills:

- do not trust claims solely because they appear in the skill
- inspect scripts and tool permissions that materially affect safety
- identify outbound network, destructive, credential, installation, or publication behavior
- distinguish safe repository-specific coupling from hidden assumptions
- avoid executing untrusted scripts merely to assess them

Static assessment may be the safest sufficient method.

## Self-Reflection Contract

Before finalizing the assessment, challenge the assessor's own conclusions.

Ask:

- Did I read the complete selected package rather than rely on snippets?
- Am I treating a deliberate local convention as a universal defect?
- Am I assuming a newer or more familiar design is inherently better?
- Did I separate intrinsic defects from target-repository mismatch?
- Did I verify that a reported contradiction is reachable in practice?
- Did I overvalue brevity, length, or stylistic consistency?
- Could missing context materially change a score or recommendation?
- Does the default prompt actually contradict the body, or merely summarize it?
- Am I recommending churn without clear behavioral value?

Include an `Assessment uncertainty` section containing:

- missing context
- assumptions made
- findings downgraded to advisories
- plausible alternative interpretations
- the reason for the confidence score

## Recommendation Status

Assign one status to each assessed skill:

- **Keep as-is** — ready for intended use; no meaningful correction required
- **Keep with advisory** — useful and coherent; note compatibility or maintenance concerns
- **Update recommended** — meaningful corrections would improve reliability or safety
- **Replace or retire** — core behavior is obsolete, unsafe, or not worth repairing
- **Insufficient context** — evidence is inadequate for a responsible recommendation

A collection may receive its own status independently from individual skills.

## Output Contract

By default, return the assessment in chat. Do not create repository files unless the user explicitly requests a persistent report.

For a single skill, use this shape:

```markdown
# Skill Assessment: skill-name

Overall: 8.2 / 10
Visual: ★★★★☆
Confidence: 0.91
Status: Keep with advisory
Repository-structure generality: 7.4 / 10
Repository-content generality: 6.8 / 10
Generality impact on overall: Not weighted — the skill is intentionally scoped

## Executive assessment
A concise explanation of the skill's current fitness.

## Scorecard
- Purpose and activation clarity: 8.5 / 10 — reason
- Internal consistency: 7.5 / 10 — reason
- ...

## Generality profile
- Repository-structure generality: 7.4 / 10 — supported layouts and limiting assumptions
- Repository-content generality: 6.8 / 10 — supported content types and limiting assumptions
- Declared-scope fit: intentional specialization, acceptable limitation, or misleading generality claim
- Overall-score treatment: not weighted, advisory only, or weighted with reason

## Findings
### High — Lifecycle mismatch
- Evidence: exact files, sections, and conflicting behavior
- Impact: what can go wrong
- Recommendation: proportionate correction

## Strengths
Concrete qualities worth preserving.

## Assessment uncertainty
Missing context, alternative interpretations, and confidence reasoning.
```

For a collection, add:

- an inventory of assessed skills
- per-skill score and status
- collection compatibility score
- cross-skill findings
- workflow-state and terminology map when relevant
- legacy or third-party compatibility advisories
- a repository-structure and repository-content generality matrix
- explicit identification of skills whose low generality is intentional versus misleading

For a version comparison, add:

- behavior-drift summary
- changes by dimension
- target-environment fit
- preserve, migrate, or retire recommendation

Do not produce a long report merely to justify a high score. When no meaningful issue exists, keep findings concise and explain why the skill is sound.

## No-Change Contract

This skill does not authorize modifications.

Do not:

- edit assessed skills
- create replacement skills
- move, rename, or delete skill directories
- update metadata
- execute untrusted third-party scripts merely for scoring
- install dependencies
- stage, commit, or push

Read-only inspection and narrowly necessary safe validation are allowed.

When the user separately asks for corrections after reviewing the assessment, treat that as a new editing task and preserve the assessment's evidence and uncertainty.

## Quality Checklist

Before returning:

- every selected `SKILL.md` was read completely
- every present `agents/openai.yaml` was read completely
- behavior-changing resources were inspected or explicitly listed as missing
- intrinsic defects were separated from context mismatch
- intentional divergence and legacy usefulness were considered
- each score has a concrete reason
- repository-structure and repository-content generality were scored separately
- the report states whether and why generality affected the overall quality score
- critical issues affected the overall score appropriately
- stars match the numeric score
- confidence reflects evidence completeness
- recommendations avoid unnecessary churn
- no assessed file was modified

## Typical Invocation Phrases

- `Use $skill-assess-softskill to assess this skill and rate it from 0 to 10.`
- `Assess all skills in this repository for internal and cross-skill consistency.`
- `Compare these two versions of the skill without assuming the newer version is better.`
- `Review the imported third-party skills for safety, portability, and usefulness in this repository.`
- `Assess copied legacy skills and distinguish required updates from optional alignment.`
- `Assess how generically these skills work across repository layouts and repository content types without penalizing intentional specialization.`
