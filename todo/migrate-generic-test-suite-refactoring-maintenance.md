---
name: migrated-generic-test-suite-refactoring-maintenance
description: Use only when explicitly invoked by the user for testing or comparing this migrated test-suite maintenance skill.
---

# Generic Test Suite Refactoring and Maintenance

Guide the whole lifecycle of automated tests: use sufficient depth for current development, deliberately decide which checks deserve permanent product protection, organize that protection clearly, keep routine output compact, and balance assurance against total effort. Use existing test infrastructure to support these goals. Apply the guidance to the current task; a suite-wide review or reorganization is a separate, explicit scope.

Five priorities govern decisions throughout the phases below:

1. Investigate current development questions with the depth and diagnostic detail they need.
2. Reassess new or substantially changed checks before treating them as permanent regression protection.
3. Keep the permanent test inventory coherently structured, consistently grouped, and maintainable, with clear responsibilities and reliable inclusion in intended runs.
4. Keep established successful tests compact by default; show individual diagnostic details on failure. Use additional targeted detail for active development only when needed for its current question.
5. Balance risk reduction against development, execution, diagnosis, maintenance, and optimization effort.

Grouping, selection, orchestration, and general testing techniques serve these priorities; they do not replace them. The five phases separate responsibilities, not a requirement to audit the whole suite during every coding task.

**Guardrails against unstructured test growth:** test organization, output and failure diagnosis, and proportionality are mandatory quality dimensions of the relevant test work, not optional polish after adding tests. A recommendation for a new or expanded permanent test must identify the protection gap it closes, how it fits the existing logical structure and responsibility boundaries, its actual execution path, its compact normal-success output and failure diagnostics, and why its total cost is justified. Use existing evidence and conventions proportionately; this does not require a new registry, numeric score system, or repeated full-suite audit. More tests or a higher coverage number alone are not an improvement.

Test groups, stages, execution order, selection, change-to-test mapping, fail-fast behavior, risk classification, targeted execution, output detail, and full regression are logical concepts. They do not prescribe a framework, configuration format, file layout, or orchestration layer.

This is a standalone migration candidate for explicit testing and comparison. Its substantive applicability is defined below. Adoption under a productive skill name requires restoring a normal activation description.

## 01 – Skill Selection

### Identity

This skill supports the development and maintenance of useful tests over their lifecycle. Its central question is: which checks help resolve the current uncertainty, which should protect the product permanently, and how should that protection be organized, executed, and summarized at reasonable total cost?

### Applicability

Use when explicitly testing this candidate during the creation, modification, execution, debugging, review, or maintenance of tests. Apply the guidance within the established task. It supports focused coding work, lifecycle decisions for affected tests, and explicitly requested wider reviews or maintenance. A current production change is not a prerequisite.

Preserve the tests' intended protection and existing project conventions. Refine test content, organization, and execution only as the task warrants. Broad production refactoring, replacing the testing framework, repairing unrelated defects, reorganizing the whole suite, and building a parallel test platform require their own task scope.

For an analysis-only or planning request, investigate and report without editing files or executing tests unless separately authorized. Invoking this candidate for comparison does not itself authorize running its maintenance actions against an arbitrary project.

## 02 – Task Setup

### Request Resolution

Resolve the user's actual request, established project, relevant changes, constraints, and expected deliverable from the conversation and available repository context.

- Distinguish read-only review or strategy analysis, infrastructure maintenance, and applying the strategy to a current change. Combine them only as needed for the authorized outcome. A review request produces analysis and improvement actions without applying them.
- For ordinary development, execution, or debugging, use the affected behavior and tests as the working scope. Consult existing conventions and necessary dependencies without starting a complete suite audit.
- For an explicitly requested suite-wide review or maintenance task with no narrower target, use the established project's relevant tests and infrastructure. Do not silently choose one convenient test directory as the entire subject.
- If the current change is unclear, inspect available change context. Do not invent production changes for a standalone maintenance task; establish reusable selection rules from the existing infrastructure instead.
- Make a safe, disclosed assumption when it allows useful progress. Ask only when an unresolved ambiguity prevents a responsible next action.

Decide execution breadth, investigation depth, and displayed output separately. More verbose output does not establish deeper testing, and a compact summary does not justify a smaller execution scope.

### Objective

Provide useful development feedback and durable product protection with clear organization, reproducible execution, compact routine output, and proportionate total effort. Retain the existing infrastructure wherever it can provide equivalent assurance.

Success means the current testing purpose is addressed, new or substantially changed checks have a reasoned lifecycle decision, and retained product tests fit a coherent structure with clear responsibilities and reliable execution paths. Established successes should yield compact summaries, with useful individual diagnostics on failure. Explain relevant output and verification limits. For a wider assessment, also evaluate suite organization, execution, and improvement opportunities across the agreed scope. For authorized maintenance, verify usable behavior through concrete existing entry points as far as the environment permits; explanation alone does not close a confirmed implementation gap. A successful outcome may require no infrastructure changes or additional tests.

### Target / Scope

Identify the project, current behavior or change, affected tests, development uncertainty, and any explicit wider review or maintenance target. Consult the relevant runner configuration, build mechanisms, scripts, CI jobs, and documentation.

Keep modifications within the requested development or testing work. Reassess the new or substantially changed tests at completion rather than automatically reviewing all existing tests. Follow production dependencies, consumers, shared fixtures, and related components as evidence when needed to understand direct and indirect effects. Supporting evidence does not automatically become an editing target.

### Context / Revision

Establish the relevant working state, change baseline when applicable, supported test entry points, environment prerequisites, and known failures. Distinguish existing configuration, documented intentions, proposed rules, and observed execution results.

Do not attribute a pre-existing failure to the current change without evidence. If a baseline or required environment is unavailable, retain that uncertainty in the result.

### Authority

- Within authorized coding or maintenance work, make necessary changes to affected tests and their selection, grouping, execution, configuration, or documentation. Explain material changes to permanent protection; justified consolidation or removal must preserve uniquely important cases and remain within scope.
- Execute relevant tests and checks when authorized by the task and compatible with their actual effects. Inspect unfamiliar commands before running them where their effects are unclear. Use established isolated test environments; do not infer authority to alter live services or external data from a test label.
- Preserve unrelated working changes and existing mandatory test and CI requirements. A local targeted run does not waive a required CI or release check.
- Do not weaken assertions, disable tests, alter production behavior, or remove required gates merely to reduce runtime or obtain a passing result.
- Keep recommendations outside the authorized scope as recommendations. Commit, push, or publish only when separately authorized.

### Evaluation Lens / Decision Basis

Use the five primary priorities above as the evaluation lens. Assess protection value, additional fault-detection value, resilience to legitimate internal changes, reproducibility, diagnostic quality, organization, and total effort against actual project requirements and behavior. Existing mechanisms are preferred, but their existence alone does not demonstrate that they express the required strategy well.

Use existing contracts, dependency relationships, runner capabilities, test metadata, relevant coverage data, CI requirements, and trustworthy execution evidence. Names and directory placement alone do not establish what a test covers. Coverage and history can support a selection decision but do not independently prove that omitted tests are irrelevant.

### Method Contract

Resolve the immediate test purpose, investigate the relevant behavior and existing checks, use the depth needed during development, then reassess affected checks for permanent use. Refine concrete concerns and validate useful options before changing the test inventory or infrastructure. Scale breadth to the task; prefer the smallest complete improvement that provides the required protection. Return to investigation when missing relationships could change the decision.

For a review, the deliverable is supported, severity-rated findings and their concrete improvement actions, not merely a description of the test inventory or advice to apply these rules. Assess the five primary lenses below across the selected review scope. Supporting infrastructure questions supply evidence for these lenses rather than replacing them with a generic runner or CI review.

Treat all group names and infrastructure examples in this skill as semantic illustrations. Translate them into the project's architecture and terminology rather than implementing them literally.

### Output Contract

During setup, account for the task-proportional Markdown output template in Phase 05. Gather conclusions for the affected lifecycle decisions and applicable focus areas, including protection preserved, material changes, evidence limits, and useful improvement actions. Also gather selection rationale, execution evidence, omissions, and the actions' impact and urgency. The default deliverable is explanatory prose in chat followed by a final action overview table when actions remain, not a separate report file. Test-run output reduction is a separate requirement from this final chat format.

## 03 – Investigation

### Evidence and Existing Mechanisms

Within the working scope, determine how the project already defines, groups, names, marks, filters, starts, orchestrates, parallelizes, caches, and runs the relevant tests in CI. Reuse established project knowledge where reliable; do not rediscover the entire infrastructure for every small test change.

Inspect the relevant existing suites, test projects, build targets, tasks, tags, labels, markers, categories, filters, directories, naming conventions, runner features, CI jobs, dependency graphs, and selection mechanisms. Determine which mechanisms are actually used and what guarantees they provide.

Prefer existing affected-test, related-test, or equivalent selection capabilities. Verify what they include and where they are incomplete before relying on them.

### Suite Assessment Focus Areas

For an explicitly suite-wide review or suite-wide maintenance task, investigate these focus areas independently. A workable selection for one change does not establish that the suite's structure and operation are satisfactory. Honor a user-narrowed focus, and explain material areas that could not be assessed.

1. **Development purpose and depth.** Establish the behavior and uncertainty being investigated, the useful existing checks, and the depth needed for meaningful progress. Consider relevant states, boundaries, transitions, and error causes without generating cases mechanically. A hypothesis-focused diagnostic check must still test a genuine expectation.
2. **Transition to permanent protection.** Examine new or substantially changed checks for protection value, unique contribution, stability under legitimate internal changes, reproducibility, diagnostic quality, and ongoing cost. Distinguish current investigative usefulness from lasting regression value.
3. **Test structure and grouping.** Assess whether the test inventory has a sensible, consistent structure: related behavior belongs in coherent suites, modules, or product areas; responsibilities and boundaries are clear; and files, groups, and shared helpers follow a maintainable organizing principle. Examine contents and relationships, not just paths or successful file searches. Identify fragmentation, unrelated concerns mixed together, competing parallel structures, or misplaced shared responsibilities where these cause concrete maintenance friction. Preserve justified project conventions; do not demand extra folders or one universal layout. Distinguish logical product organization from execution-group membership, avoid copying tests for multiple runs, and retain reliable inclusion of important tests in intended runs.
4. **Stages and orchestration.** Assess actual execution order, prerequisites, mandatory and conditional groups, multi-group invocations, and fail-fast behavior. Determine whether the progression from fast focused feedback to broader assurance is reproducible rather than merely described.
5. **Selection, risk, and regression.** Assess reusable change-to-test mapping, indirect effects, uncertainty, and escalation to broader checks or full regression. Examine an actual change when available; otherwise reason from existing dependency and selection mechanisms without inventing a diff.
6. **Local execution and CI.** Trace how developers and CI invoke the same test roles, where parallelism and caching are used, and whether those mechanisms preserve required checks and trustworthy results. Seek concrete friction or inconsistencies relevant to the strategy rather than demanding identical local and CI execution.
7. **Test-run output.** Assess the default behavior: established successful tests produce compact summaries; failures expose the affected test, expectation, significant difference, and relevant diagnostics. Trace test, fixture, helper, invoked-code, and subprocess output through capture, reporting, and CI to verify this behavior. Passing established tests should not stream individual diagnostic details. Keep skips and empty selections visible. Reporter configuration alone does not establish that the success/failure behavior is appropriate.
8. **Persistent strategy and maintainability.** Assess where grouping, execution, selection, and output rules are maintained, whether that guidance matches executable behavior, and whether existing configuration and documentation can express necessary improvements without a parallel layer. Include the cost of optimization itself; avoid new registries, metrics systems, or refactorings without a concrete benefit.

For each applicable area, establish how it currently works, assess whether it serves the intended strategy, and retain evidence-supported improvements or a justified no-change conclusion. Listing available mechanisms is not itself an assessment.

For ordinary coding work, use only the parts relevant to the immediate purpose and affected tests. These focus areas do not impose a recurring suite-wide audit.

### Five Primary Review Lenses

For a review covering the five priorities, investigate and evaluate each lens explicitly. Use existing tests, expectations, affected behavior, relevant change history, configuration, and available execution or diagnostic evidence. The signals below are starting questions, not findings by themselves.

In an explicitly selected review scope, assess the relevant existing permanent tests as well as new or changed ones. The affected-test-only rule limits routine coding work; it does not exempt established tests from a requested review of their present protection value, organization, diagnosis, or cost.

| Primary lens | Questions that drive the assessment | Candidate signals to validate |
| --- | --- | --- |
| Development checks | Do checks test genuine expectations and investigate the relevant uncertainty deeply enough? Would assertions detect the intended failure, including material states, boundaries, or transitions? Is targeted diagnosis available for current work? | Assertions that cannot distinguish the relevant wrong result; a consequential path left unexamined despite a supported requirement; diagnostics that do not expose the current failure. |
| Permanent test protection | Which checks deserve permanent protection, and which warrant refinement, consolidation, diagnostic-only use, or removal? Do their distinct protection value, reliability, stability, and cost support that decision? | Hypothesis-specific checks retained as fragile permanent obligations; overlap with demonstrated cost and no additional protection; a proposed removal that loses a unique regression case. |
| Test organization | Is the test inventory coherently and consistently structured? Are related tests grouped sensibly, responsibilities and boundaries clear, and shared helpers placed appropriately for maintainable additions and changes? Are the resulting groups actually included in intended runs? | Related behavior fragmented across competing structures; unrelated responsibilities mixed into suites or shared helpers; parallel test arrangements requiring duplicate maintenance; important tests excluded from their intended run. File searchability alone does not establish good organization. |
| Test output and failure diagnosis | Are established successful tests compact by default, with individual diagnostic detail shown on failure? Do failures identify the test, expectation, significant difference, and needed diagnostic context? | Passing established tests list case-by-case details or dump data; shared setup prints repeatedly on success; failures lack relevant details; a supposedly quiet reporter still passes routine diagnostic output through; non-execution presented as success. |
| Proportionality and optimization | Does the combined protection and fault-detection value justify development, runtime, diagnosis, maintenance, and optimization effort? Would a simpler existing approach preserve sufficient assurance? | Expensive duplication with no distinct protection; implementation-coupled assertions causing avoidable repair work; broad repeated runs or new machinery without corresponding assurance; speedups that remove important protection. |

Do not infer an absent development investigation or retention decision solely from its lack of written documentation. Use available artifacts to assess the present protection and costs; report inaccessible historical reasoning as a limitation where it matters. An unusual structure, a detailed test, or a long-green test is not itself a defect. Validate the actual consequence and credible reasons to retain the current arrangement.

For organization, reconstruct the actual grouping principle from test contents, suite boundaries, and shared dependencies. Trace how an ordinary related case or behavior change would fit that structure and which responsibilities would need changing. Explain supported cohesion or boundary problems and their maintenance effects. Being able to locate every file through search does not answer this structural question.

### Broad Discovery

Identify the existing test roles and their meaningful dependencies, costs, prerequisites, and execution paths. Example roles include fast local checks, unit, component, integration, contract, database, smoke, end-to-end, and full regression tests. Do not introduce these names or groups when the project's existing structure already expresses the needed roles.

For a current change, determine before execution:

1. Which production code changed, and whether test, fixture, configuration, build, dependency, or orchestration changes also affect the required selection.
2. Which components and consumers may be affected directly or indirectly.
3. Which existing tests exercise those relationships.
4. Which existing groups or entry points contain those tests.
5. Which broader checks are required by risk, uncertainty, or existing project rules.

Trace the relationship:

`changed code or test infrastructure → affected components and paths → relevant tests → existing groups or execution entry points`

Use available dependency graphs, build targets, coverage data, imports and module relationships, test metadata, CI dependencies, and test history. Investigate relevant alternate paths and shared dependencies rather than assuming a nearby test is sufficient.

### Test Output and Diagnostic Context

Distinguish tests currently being developed, modified, or deliberately investigated from established tests whose normal role is regression assurance. Use the task context and available result history or project knowledge; an unchanged test is not automatically stable, and selecting a test for a run does not automatically make it active work.

The target behavior for established tests is a compact summary on success and individual diagnostic details on failure. Inspect existing runner reporters, capture and verbosity controls, filtering, CI summaries, and retained result artifacts to establish whether that behavior holds. Detail for an active development question is a targeted exception, not a reason to make established successful runs verbose. This is a temporary diagnostic distinction, not a requirement for new permanent test groups, registries, or configuration files.

When reviewing output and diagnosis, perform the investigation below even if no output change has yet been proposed:

1. Find the relevant output producers in tests, shared setup/teardown and fixtures, helpers, data generators, invoked product code, and subprocesses. Trace relevant logger, standard-output, and standard-error paths through capture, reporter settings, and CI presentation. A print call alone is not a defect: it may be captured, shown only on failure, or be the product output the test correctly verifies.
2. Examine normal successful execution paths across the material groups and distinct output mechanisms in scope, especially shared and repeated producers. Prefer existing successful logs; use a small representative authorized run when needed and available. Do not require a full-suite run or a fixed sample count merely to assess output.
3. Attribute unnecessary visible output to the responsible test, fixture, helper, or invoked process and its triggering conditions. Establish what repeats and what useful information it adds. Use available log size, line counts, excerpts, or repeated patterns when they help; distinguish observed volume from a static inference or estimate. Do not build a metrics system for this check.
4. Compare the established-success and failure paths explicitly: successful cases should remain summarized without individual diagnostic dumps, while failures expose the test, expectation, significant difference, and relevant diagnostics. Include mixed runs and material CI truncation/capture differences when relevant. Preserve mandatory machine-readable result artifacts and output that is itself a tested product contract without unnecessarily streaming it into the console on success.
5. Conclude from the producer-to-visible-output chain and the evidence actually inspected. Quiet-mode support alone is not a completed output assessment. If successful-run evidence is unavailable, report the supported static conclusions and the unverified runtime scope explicitly rather than declaring the output compact or optimal.

### Candidate Refinement

Turn broad concerns into concrete questions: whether existing suites express useful test roles, whether naming and markers make group membership clear, whether a filter selects the intended tests, whether indirect consumers are included, whether orchestration enforces the intended stages, or whether output buries current failures beneath established passing tests.

Split a question only when distinct behavior, relationships, or execution conditions warrant separate investigation. Discard duplicates and irrelevant directions. Retain material uncertainty as a reason to investigate rather than treating it as proof that no additional tests are needed.

### Candidate Shortlist

Retain the structural, grouping, selection, orchestration, output, and persistence questions worth validating. Revisit the applicable focus areas before accepting the first plausible solution or reporting only one kind of improvement. No printed tree, fixed candidate count, or new tracking artifact is required.

If the existing infrastructure already supplies the needed behavior, proceed with it and avoid manufacturing a refactoring task.

## 04 – Evaluation and Implementation

### Validation

Check candidate conclusions and changes against actual suite structure, runner semantics, dependency paths, test membership, output behavior, prerequisites, and required checks. Where available, use existing listing, discovery, or dry-run capabilities to confirm grouping and selection before expensive execution.

Check counterevidence: excluded indirect consumers, overlapping groups, stale coverage, changed shared fixtures, unsupported filter combinations, or cache behavior that could invalidate the expected assurance. Use only the checks relevant to the actual project.

If no trustworthy narrow mapping exists, broaden the selection to the next defensible existing group. Explain the remaining uncertainty; do not describe an unverified subset as sufficient.

### Assessment and Selection

Assess proposed suite and infrastructure improvements against the focus areas: what concrete problem they solve, what existing mechanism can express them, what benefit and maintenance cost they have, and whether preserving the current arrangement is preferable. For review tasks, turn supported improvements into actions instead of implementing them. For maintenance tasks, implement only the necessary authorized changes.

Inspect existing protection before adding tests. Optimize neither test count nor coverage numbers in isolation: assess fault-detection value, development time, execution, diagnosis, maintenance, and the cost of optimization itself. Strict implementation coupling, repetition, or additional infrastructure must earn their cost. Do not remove important protection merely to speed up execution.

Fixed coverage percentages, test-pyramid ratios, TDD, mutation testing, comprehensive metrics systems, and recurring full-suite audits are not universal requirements. Use additional methods when project requirements, realistic risks, and their concrete benefit justify them.

Choose the smallest sufficiently safe set of existing tests and groups. Do not run the full suite automatically, and do not let runtime savings override required assurance.

Use evidence-based risk distinctions appropriate to the project. Consider the reach of the change, dependency coupling, behavior and contract effects, infrastructure changes, existing requirements, and uncertainty in selection. No new risk registry or fixed classification format is required.

Require full regression when project rules demand it or narrower selections cannot provide sufficient assurance. Typical reasons to investigate broader coverage include cross-cutting changes, shared test infrastructure changes, broad dependency changes, or an unreliable change-to-test mapping. These are prompts for a project-specific decision, not unconditional new gates for every project.

### Finding Qualification and Severity

For each promising review candidate:

1. Name the primary review lens and the expected protection or useful operating property supported by the task, product behavior, or project requirements.
2. Establish the actual mismatch with concrete locations, tests, configuration, relevant history, or observed results. Distinguish source-based reasoning from behavior actually executed.
3. Explain the practical consequence: a missed failure, lost protection, unreliable execution, incoherent structure or responsibility boundaries that impede maintenance, unnecessary successful-run detail, inadequate failure diagnosis, or material avoidable effort. State the affected situation and reach rather than declaring a general best-practice violation.
4. Examine counterevidence, existing compensating checks, legitimate specialist purposes, and the cost or protection trade-offs of changing the current arrangement.
5. Qualify a finding only when the supported consequence makes a change worthwhile. Assign `Critical`, `High`, `Medium`, or `Low` using the definitions in Phase 05 and explain why that level fits the actual impact.
6. Give a concrete improvement direction, what important protection it preserves, and how successful completion could be verified. Keep implementation urgency separate from severity.

Group manifestations of one cause into one finding. Assign one primary lens and mention secondary effects when useful; do not duplicate a finding to populate several categories. Continue checking meaningful concerns in the remaining review scope after early findings, including worthwhile Low-severity issues. No minimum number or severity distribution is required.

For each reviewed primary lens, conclude with supported findings, no supported finding, or a concrete evidence limitation. An unresolved suspicion is not a confirmed finding; identify the missing evidence and a focused investigation action where useful. For routine coding work, apply this qualification only to material concerns encountered within scope rather than starting a separate review.

For the three test-growth guardrails, support the assessment with concrete relationships: related product behaviors to coherent test groupings, responsibility boundaries, shared helpers, and actual run membership for organization; producer and capture to compact established-success output and detailed failures for diagnosis; additional fault protection to execution, diagnosis, and maintenance cost for proportionality. File searchability, folder inventories, quiet flags, or test counts do not establish that these dimensions are satisfactory.

### Development Checks and Permanent Test Decisions

During development, use detailed, exploratory, or temporary diagnostic checks when they resolve meaningful uncertainty. Explore relevant boundaries, states, transitions, and failure causes to the depth the task needs. A check useful for one hypothesis does not automatically deserve permanent regression status.

Before finishing work on new or substantially changed tests, evaluate each meaningful check or coherent set against:

1. **Protection value:** the product expectation, contract, or relevant failure class it protects.
2. **Additional value:** what it detects beyond existing tests.
3. **Stability:** whether it remains meaningful through legitimate internal changes.
4. **Reliability:** whether execution is reproducible and a failure is understandable.
5. **Cost:** whether protection justifies execution, diagnosis, and maintenance effort.

Make a reasoned decision: retain it, develop it into a durable regression test, simplify it, merge it with existing protection, retain it for targeted diagnosis, or remove it. Apply changes only within the actual task authority. A review recommends the decision and its verification instead of changing the inventory. Explain significant additions, consolidation, and proposed or applied removals.

Never remove a test solely because it has been green for a long time, resembles another test, or covers the same code lines. Before consolidation or removal, check for unique inputs, states, failure classes, or historical regressions. Preserve meaningful unique protection; additional specific permanent tests can be justified by independent risks. Do not weaken assertions to obtain a passing run. Development and permanent use are purposes and lifecycle stages, not a mandate for two separate technical test systems.

### Supporting Test Quality

Use these criteria for affected tests without turning them into an automatic expansion of work:

- Prefer observable behavior, contracts, and justified expectations over incidental implementation details. Use meaningful names and assertions focused on relevant outcomes.
- Choose positive, negative, boundary, and state cases by significance rather than a mechanical quota.
- Keep tests independent, reproducible, and understandable. Use shared helpers or parametrization when they improve maintenance; avoid parallel copies of the same protection.
- Mock dependencies only as appropriate. When the interaction itself is under test, use a suitable controlled integration.
- Especially for generated tests, examine whether the assertions would detect the intended error. A green run is not a quality proof. Use a focused contrasting check or mutation when worthwhile, not automatically for every test.
- After fixing a defect, add or adapt a suitable regression test when the failure class is relevant, recurring, and reasonably automatable.

### Execution Order and Fail-Fast

Arrange the selected checks using the general progression:

`fast and specific → broader → more integration-intensive → expensive → full regression when required`

Respect actual prerequisites and useful existing parallelism. Do not serialize independent checks solely to mimic this illustration.

Make the following determinable through the existing execution mechanisms:

- Which tests or groups run first and which follow.
- Which groups are mandatory and which depend on stated conditions.
- Which evidence or failures require broader coverage or full regression.
- Whether and when execution should stop after a failure.

For the relevant groups, identify concrete existing selectors, tasks, targets, or invocation patterns, their prerequisites, and the conditions for advancing to another stage. Check that these mechanisms express the intended strategy. In a review, report a supported mismatch as an improvement action; in authorized maintenance, close necessary gaps and verify the resulting behavior.

Use one runner invocation when it supports the necessary selection, ordering, and failure behavior. Use separate invocations when needed. Do not assume that specifying multiple filters establishes execution order.

Fail fast when a failure makes later work unnecessary or invalid under the strategy. Distinguish independent checks that may still provide useful evidence. Preserve required project behavior, propagate failure status, and report skipped or blocked stages explicitly. An interrupted sequence is not a successful validation of the complete selection.

### Test-Run Output and Failure Diagnostics

Keep execution breadth, investigation depth, and output volume separate: a short summary says how results are presented, not how many tests ran or how thoroughly behavior was examined. Compact output never substitutes for sufficient testing.

Keep test feedback useful by adapting detail to the diagnostic context:

- **Established tests that pass:** emit only a concise run or group summary by default. Do not list individual passing cases, diagnostic details, payload dumps, or repetitive successful setup logs. Include the available result counts, skips, and timing needed to interpret the run without inventing metrics the runner does not provide. Retain useful diagnostic data through existing capture mechanisms for failures rather than streaming it on success.
- **Tests currently developed, changed, or investigated:** show the details needed for the current question, such as the selected cases, assertion differences, relevant diagnostic messages, or failure location. This is targeted detail, not unconditional maximum verbosity.
- **An established test that fails or behaves unexpectedly:** first surface the affected test, its expected result, and the significant actual difference. Add relevant logs, stack traces, test data, or environment details as needed. It becomes part of the current investigation; its established status must not hide a regression, unexpected skip, or execution problem.
- **Mixed runs:** prefer a compact overall or per-group summary with targeted details for current work and failures. Do not make all successful established tests verbose because one active test shares the invocation. Do not introduce mandatory extra executions solely to separate output.

Use existing runner and CI output mechanisms first. Where the available controls are coarse, choose the least noisy mode that retains required diagnostics and explain any material limitation. Output reduction must not change test selection, omit required tests or result artifacts, suppress failure status, or turn a zero-test, interrupted, blocked, or unexpectedly skipped run into success. Distinguish executed tests from cached results and tests not run where the tooling exposes that information.

Keep detailed logs in existing diagnostic artifacts when useful and available; surface the relevant evidence rather than copying entire logs into chat. Do not build a new logging or orchestration layer merely to implement this distinction.

### Implementation and Persistence

When changes are needed and authorized, first use existing configuration and extension points. Prefer existing suites, targets, tasks, runner functions, CI jobs, and selection features over new infrastructure.

Persist reusable structure, grouping, selection, ordering, escalation, or output knowledge only where useful. First inspect suitable existing test, build, runner, or CI configuration, project documentation, and agent instructions. Keep executable behavior and its explanation consistent with their respective roles.

Create a new file or configuration layer only when no equivalent existing mechanism can provide the needed behavior and the addition has clear value within scope. JSON, YAML, custom manifests, wrappers, and standalone orchestrators are not required outputs of this skill.

### Verification and Completion

Verify implemented behavior using proportionate selection checks and authorized test execution. Where the changes affect conditional stages or fail-fast behavior, check the relevant contrasting cases through supported inspection, dry runs, or safe execution. Do not introduce deliberate product failures merely to demonstrate stopping behavior.

For output reviews as well as output changes, check established successes, relevant active-test detail, failure diagnostics, and mixed or empty selections through available evidence or safe checks. Trace the relevant producers, not only reporter settings. Verify that quieter output preserves execution results and required artifacts when changes are made. A static review can support a limited or source-grounded finding; do not claim observed runner volume, measured savings, or optimal normal output without corresponding execution or log evidence.

After a failed check, investigate whether the cause lies in the product, test, expected behavior, or environment before applying a correction. Keep that investigation within scope. Do not silently retry until green, suppress the failure, or broaden into unrelated repairs. Report unresolved failures and their effect on assurance.

Before finishing ordinary test work, revisit its immediate purpose, sufficient development depth, lifecycle decisions for new or substantially changed checks, their product organization and actual run membership, proportionate execution, and compact but truthful output. Do not impose an unrelated suite-wide audit.

Return to investigation when new evidence reveals an affected path or a material gap in an applicable focus area. For a wider requested review or maintenance task, revisit all agreed focus areas, including lifecycle decisions. Finish a review with supported conclusions and actionable improvements; finish maintenance when the requested behavior is usable and necessary changes are verified as far as available evidence permits. State remaining execution or environment limits. No infrastructure edit, extra test, or minimum number of issues is required.

## 05 – Chat Output and Improvement Actions

Respond directly in chat in the user's requested language unless the user explicitly requests another delivery format. Do not create a separate assessment report or action-list file by default. This output rule does not replace useful strategy persistence in existing project configuration or documentation under Phase 04.

Use the required Markdown template below. Lead with a short explanation of the actual outcome: strategy established or improved, verification result, or the concrete limitation preventing completion. Distinguish proposed work, implemented changes, and tests actually executed. Explain the result and improvement actions in connected prose, then end with a compact action overview table. Rate supported concerns using the severity convention below.

### Relevant Context

Briefly explain the information needed to understand the result and choose the next actions:

- The current development question, the depth used to investigate it, and what evidence resolved or left the uncertainty open.
- The lifecycle decisions for new or substantially changed tests: what is retained, promoted, simplified, combined, kept for diagnosis, or removed, and why important protection remains. Explain material permanent-inventory changes more fully.
- Whether the test inventory has a sensible, consistent structure: how related tests are grouped, responsibilities and shared helpers are separated, and ordinary additions or changes fit the arrangement. Explain concrete maintenance effects; finding files or listing directories alone does not assess structure.
- Whether stages and group orchestration are reproducible through concrete existing entry points, including prerequisites, mandatory steps, conditional steps, and stopping behavior.
- How change-to-test selection and risk-based escalation work, including any concrete current-change selection when applicable.
- How local execution, CI, parallelism, and caching support the strategy, including material mismatches or justified existing arrangements.
- Whether established tests actually have compact default success output and useful individual failure details. Briefly name the examined producer/capture paths and success/failure evidence, distinguishing observations from static conclusions and material unexamined paths. Reporter settings alone do not establish this behavior.
- Where reusable strategy knowledge is maintained and whether it agrees with executable behavior.
- The selected tests, their rationale, ordering, mandatory steps, and escalation conditions.
- Expensive groups deliberately omitted, why omission is defensible, and when they must run later.
- When full regression is required and whether it was performed.
- Infrastructure or documentation changes and where the maintained strategy resides, if persisted.
- Actual verification evidence, unresolved failures, missing environments, mapping uncertainty, and any remaining required checks.

Use the project's own test group and entry-point names. Distinguish checks that passed, failed, were not run, were skipped, or were blocked. For a standalone strategy task without a concrete change, explain the reusable rules rather than inventing an execution selection.

For a suite-wide assessment, give a brief evidence-based conclusion for each applicable focus area, including areas where the existing approach should be retained. For ordinary coding or focused test work, explain only the applicable affected-test decisions and outcomes. Name material coverage limits. Do not replace a requested wider assessment with a list of commands or only the tests selected for a current diff. Do not manufacture an improvement in every area.

For a review of the five primary priorities, make each lens's assessment visible in the prose: relevant evidence, what it establishes, and the finding references or a no-finding/limited-evidence conclusion. Infrastructure details belong under the priority they explain. Keep strengths and context concise so the supported problems and improvement decisions remain easy to identify.

### Improvement Actions

Explain remaining worthwhile improvements or required follow-up actions in prose, ordered by practical importance and dependencies. Summarize them in the final table using the same stable references. For each action, cover:

- A stable reference and, for a supported concern, its severity: `Critical`, `High`, `Medium`, or `Low`.
- Its primary lens and, for a confirmed finding, the expected behavior or useful property, observed mismatch with evidence, practical consequence, and why the severity fits. A proposed action alone is not a finding. For an investigation or required verification action without a confirmed defect, state the evidence gap or outstanding requirement instead.
- What to improve or resolve and where to start, using an existing mechanism or concrete location when known.
- Why it matters, tied to observed evidence, a required check, or a material uncertainty.
- How urgently implementation is recommended and why. Distinguish required follow-up from optional improvement; mention a concrete deadline or triggering condition only when supported.
- How to verify completion, including prerequisites or an unresolved decision when relevant.

Use severity to describe the impact on test assurance, required checks, or maintenance:

- **Critical:** A demonstrated systemic failure permits consequential changes to be accepted without essential validation, with severe consequences supported by the project context.
- **High:** A significant gap in development checks, permanent protection, organization, execution, or diagnosis can miss consequential regressions or bypass an important required check on a realistic affected path. Severe recurring operational or maintenance consequences also require concrete evidence of their reach.
- **Medium:** A bounded problem in any of the five primary lenses materially reduces protection, reproducibility, structural coherence and maintainability, diagnostic usefulness, or development and maintenance efficiency and warrants correction.
- **Low:** A limited clarity, convenience, or maintenance problem has small practical impact and a worthwhile improvement.

Severity is not implementation effort, model confidence, or a deadline. Explain urgency separately when dependencies, current exposure, or upcoming required checks affect the recommended order. For an unresolved investigation action, state the potential impact and uncertainty; use a provisional severity only when justified and label it explicitly as provisional. Use `—` where no defensible severity can be assigned to a non-finding action. Do not present an unverified concern as confirmed or assign severity merely to fill a category.

Apply the same consequence-based scale across the five lenses. Do not automatically rate missing tests High, output noise Low, or a large possible runtime saving Medium. Explain the actual protection or cost impact. Hypothetical failure consequences and unmeasured savings must remain identifiable as such.

Keep each action concise and specific enough to pick up as a task. Separate optional improvements from required follow-up, and identify investigation actions as such when the evidence does not yet support implementation. Do not list delivered changes as pending or invent actions to fill the table. When nothing worthwhile remains, state that clearly and omit action paragraphs and the empty table.

Scale detail to the task. Use commands or file references when they help reproduce the strategy or act on a recommendation; do not claim a hypothetical command was executed. Explain a no-change outcome when existing mechanisms already suffice.

The improvement actions capture work that remains after fulfilling the authorized task; they are not a substitute for carrying out maintenance already requested. Keep recommendations distinct from work actually delivered and from permission to perform further actions.

### Required Markdown Output Template

Use this structure for the final chat response. Replace every placeholder with supported content; do not output the enclosing code fence or unfilled placeholders. Translate headings, column labels, and prose into the user's requested language while retaining the severity labels `Critical`, `High`, `Medium`, and `Low`.

```markdown
<Short outcome in connected prose: what was established or changed, what was verified, and what remains open.>

**Development checks.** <Assess whether the relevant expectations and uncertainties receive sufficient targeted depth and useful diagnosis. State the evidence, the conclusion, and finding references or a no-finding/evidence-limit conclusion.>

**Permanent test protection.** <Assess the selected permanent tests and any new or substantially changed checks for protection value, unique contribution, stability, reliability, and cost. Explain justified retention, refinement, consolidation, diagnostic use, or removal and preservation of unique protection. State finding references or a no-finding/evidence-limit conclusion.>

**Test organization.** <Assess whether the inventory is sensibly and consistently structured: coherent related-test groups, clear responsibilities and boundaries, appropriate shared helpers, and maintainable additions and changes. Support the conclusion with actual contents and relationships; file searchability alone is insufficient. Include intended-run membership where relevant. State finding references or a no-finding/evidence-limit conclusion.>

**Test output and failure diagnosis.** <Answer directly whether established tests are compact by default on success and provide useful individual diagnostic details on failure. Identify the relevant evidence and producer/capture paths, separating observations, static conclusions, and unexamined paths. Treat additional detail for an active development question as a targeted exception. State finding references or a no-finding/evidence-limit conclusion; do not reproduce full passing-test logs or treat quiet flags alone as proof.>

**Proportionality and optimization.** <Assess whether protection and fault-detection value justify development, runtime, diagnosis, maintenance, and optimization effort. Explain relevant selection, escalation, full-regression, parallelism, or caching decisions as supporting evidence. State finding references or a no-finding/evidence-limit conclusion.>

**A — <Severity> — <Primary lens>: <Concrete finding title>**

<Explain the supported expectation, actual mismatch and evidence or location, practical consequence, and why the severity fits. Describe the concrete improvement, protection to preserve, urgency, and how completion can be verified. Include material counterarguments, prerequisites, trade-offs, or uncertainty.>

<Material limitations or unresolved questions affecting the overall result, if any.>

## Improvement actions

| Ref | Severity | Primary lens | Finding / action | Recommendation / urgency | Completion check |
| --- | --- | --- | --- | --- | --- |
| A | <Supported severity> | <One of the five primary lenses> | <Concrete concern and next action> | <Required or optional; recommended timing or triggering condition> | <Observable completion criterion> |
```

For a review covering the five priorities, use all five named assessment paragraphs so their conclusions remain identifiable. Stage, selection, CI, and persistence details support those assessments rather than becoming competing primary categories. State agreed scope exclusions or material evidence gaps. For ordinary coding or focused test work, include only applicable content and combine it naturally into a compact response; do not initiate new investigations merely to fill placeholders. Repeat the finding paragraph and table row for each remaining action, assigning stable references `A`, `B`, and so on. Keep each table row short; the preceding prose supplies the reasoning and detail. The table must be the final element of the response, with all limitations and qualifications explained before it. For investigation actions based on unresolved concerns, label the action and any provisional severity explicitly in both prose and table so they cannot be mistaken for confirmed findings.

If no worthwhile action remains, keep the applicable outcome and context paragraphs, state that no further improvement is justified by the inspected evidence, and omit the action paragraphs, action heading, and table. If execution was blocked, explain that limit and any justified investigation action without presenting missing evidence as successful verification.
