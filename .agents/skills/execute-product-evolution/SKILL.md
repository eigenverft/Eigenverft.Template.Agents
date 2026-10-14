---
name: execute-product-evolution
description: "Use when the user requests an autonomous, bounded product-improvement cycle: discover opportunities, assess them, independently select one cohesive increment, document understood intent and effective policies in an issue before implementation, implement, verify, commit, and close with human reviewability. Supports conservative, balanced, and ambitious defaults plus natural-language specialization of each policy. Not for ordinary development requests."
---

# Execute Product Evolution

## Mission and Activation

Autonomously evolve a software product through **one cohesive, bounded, human-reviewable increment per invocation**. Discover, assess, select, record, implement, verify, and package an improvement without routine human approval gates. Accountability comes from respected contracts, limited change scope, an issue established before implementation, evidence, and a coherent final Git change set.

Invoke this skill explicitly, using the skill's name where supported (for example `$execute-product-evolution`), or through an unmistakable user request for autonomous product evolution. Actual skill invocation syntax is harness-dependent; this package does not create slash commands. Do not activate this workflow merely because an ordinary feature, bug fix, code review, or brainstorming request mentions improvement.

**One invocation = at most one selected product increment, one primary issue, and one coherent review unit.** Do not automatically begin another increment. A justified no-change outcome is valid.

## Mandatory Pre-Read Policy Selection Gate

**First read this SKILL.md; before opening or reading ANY policy references, determine the effective strategy for all three phases from the user's current request, applicable higher-priority instructions, and already-known conversation/project context.** This is a selection decision, **not** a request to inspect candidate strategy files. Do not preview, compare, search inside, or read unselected profile files to decide which one to use.

1. Resolve the user's actual product-development assignment and explicitly stated boundaries. Identify any clear natural-language refinements for **Discover**, **Assess**, and **Select & Bound** independently.
2. Check for an **explicitly named** Conservative/Default, Balanced, or Ambitious preset. A non-default profile can also be chosen for an individual phase when the task/context **unambiguously** establishes that intent. Do **not** infer Balanced or Ambitious merely from a vague request to improve the product, perceived task complexity, a promising opportunity, or the agent's own preference.
3. For each phase, settle the **one strategy source**: Default.md (= Conservative) when unspecified, Balanced.md or Ambitious.md only when clearly selected, a specific authorized specialization if available, or **fully user-specified** criteria with no profile strategy needed. Natural-language constraints can refine one phase without implicitly selecting another phase's more adventurous profile.
4. Record the planned three-phase selection and rationale **in working context** before opening any referenced policy file. Then, when reaching each phase, read its `Contract.md` and **only** the selected strategy file if one is needed. Never load other profile files for inspiration, comparisons, validation of one's choice, or supposed completeness.
5. Carry this selection and its provenance into the **primary issue created before implementation**. For each phase, record selected profile/file (or fully specified custom instructions), why it was selected, which assignment/context facts control it, and any overrides; record the effective rules, not merely three labels. If a later discovery necessitates re-selection, note the reason and policy transition in the issue *before* loading a different profile.

**Safety default:** If it is not clear that `Ambitious.md` applies, **do not read it**. The same rule applies to `Balanced.md` when not clearly selected. Unspecified phases use `Default.md`; higher-priority and explicit user/context requirements still override soft defaults. No profile selection overrides binding contract or safety invariants.

## Package Structure and Extension Points

This package defines **three independently selectable policy phases** and one shared execution protocol. The phase-specific strategy files are alternatives, **not cumulative layers**:

| Phase | Common contract | Default = Conservative | Balanced | Ambitious |
| --- | --- | --- | --- | --- |
| Discover | [Contract](references/PolicyDiscover/Contract.md) | [Default](references/PolicyDiscover/Default.md) | [Balanced](references/PolicyDiscover/Balanced.md) | [Ambitious](references/PolicyDiscover/Ambitious.md) |
| Assess | [Contract](references/PolicyAssess/Contract.md) | [Default](references/PolicyAssess/Default.md) | [Balanced](references/PolicyAssess/Balanced.md) | [Ambitious](references/PolicyAssess/Ambitious.md) |
| Select & Bound | [Contract](references/PolicySelectBound/Contract.md) | [Default](references/PolicySelectBound/Default.md) | [Balanced](references/PolicySelectBound/Balanced.md) | [Ambitious](references/PolicySelectBound/Ambitious.md) |

Shared execution references:
- [ExecutionProtocol.md](references/ExecutionProtocol.md): **Record, Implement, Verify, Package & Close**, plus controlled returns to earlier phases.
- [IssueRecord.md](references/IssueRecord.md): durable issue content, policy provenance, and outcome traceability.

Select the policy sources **before reading any references**, as required by the Mandatory Pre-Read Policy Selection Gate above. At execution time, read the current phase's `Contract.md` and only its preselected profile file, if applicable. Fully user-specified phases may need no profile file. Do not read unused variants. Phase contracts and Shared Invariants in this main skill always apply. Read ExecutionProtocol and IssueRecord before issue creation or product modification.

### Invocation: simple defaults, natural-language tailoring

Examples (invocation syntax depends on the agent host; this package does not register slash commands):

- `$execute-product-evolution` — use `Default.md` (Conservative) in **all three phases**, except where context or user instructions are more specific.
- `$execute-product-evolution balanced` — use `Balanced.md` in **all three phases**, except where tailored.
- `$execute-product-evolution ambitious` — use `Ambitious.md` in **all three phases**, except where tailored.
- “Use product evolution to improve onboarding UX, prioritize consumer value when assessing, and select only a small reversible change.” — specialize **Discover**, **Assess**, and **Select & Bound** individually using natural language.

Use ordinary natural-language instructions rather than inventing a phase-parameter DSL. A named profile is a coherent **default preset**, not a mandate overriding the understood assignment; no profile softens protected contracts. A single phase may be tailored while the other two retain the selected preset. Do not interpret multiple named profiles without an understandable relationship as an automatic merge.

### Resolve the effective policies independently

For each of Discover, Assess, and Select & Bound:

1. Respect higher-priority instructions, actual tool permissions, repository operating rules, and protected consumer contracts.
2. Resolve the user’s explicit instructions, scope, goals and reliably established conversation/project context, respecting later corrections. Do not let defaults erase an understood task.
3. Resolve an explicitly requested and available specialization for that phase, if any. Future independent policy files or callable skills may supply a strategy **only if they actually exist and their usage is supported**; do not assume inheritance or auto-import.
4. Resolve a phase's profile **without reading candidate profiles**. Choose Balanced or Ambitious only from an explicitly named preset or unmistakable task/context direction for that phase. Otherwise choose `Default.md` (= Conservative). If explicit user/context criteria fully specify a phase, use those with the phase contract without reading any preset strategy file.
5. Apply clear natural-language refinements on top of the chosen strategy when one is needed; never let the selected preset or a phase specialization silently alter the other phases. Preserve the selection and reason for IssueRecord.

If a consequential ambiguity cannot be resolved responsibly, clarify it; otherwise proceed autonomously without unnecessary approval gates.

### Extension mechanism

To add a new strategy for one phase, create a new descriptive Markdown policy file in that phase's folder (or explicitly supply a supported external specialized skill), following its `Contract.md`. No cross-product of all Discover × Assess × Select strategies is needed. The orchestrator resolves **one effective strategy per phase** and passes phase output into the next phase. Such files are modular instructions, not automatically discovered runnable skills.

### Record policy provenance in the issue

The primary issue must capture the **understood user assignment** and the **effective Discover, Assess, and Select & Bound policies**, including the selected strategy source file or specialization for each phase, any natural-language refinements, and the rationale for the selected increment. Distinguish user instructions, established context, profile defaults, and assumptions. This goes in the issue—not a mandatory separate configuration artifact—via [IssueRecord.md](references/IssueRecord.md).

## Shared Invariants

- **Contractual compatibility:** preserve relied-upon interfaces, APIs, data formats, product promises, and externally consumed contracts unless the user specifically authorizes a compatible migration or explicit contract change within actual authority.
- **Behavioral compatibility:** protect essential capabilities, semantics, and consumer workflows; include niche consumer groups and accessibility considerations. **Experience evolution** (user-facing design/interaction changes) may be allowed when essential promises remain intact. Novelty or momentary surprise is neither proof of benefit nor automatic breakage.
- Protected constraints are hard eligibility gates; high expected benefit cannot compensate for an impermissible break.
- **Review burden** and **product impact** are distinct limits. Prefer cohesive, comprehensible, verifiable and reversible change units; file counts and changed lines do not prove reviewability.
- Investigate indirect consequences, but only implement verified necessary effects of the selected increment. Capture unrelated discoveries as future candidates, not opportunistic scope expansion.
- Clearly separate **verification** (was the change implemented correctly?) from **validation** (did consumers actually benefit?). Never invent user feedback or claim an unmeasured improvement is proven.
- Preserve repository cleanliness and others' work. Follow applicable Git/branch practices, permissions, safety gates, deployment requirements, and durable documentation rules. No unlimited authority follows from autonomy.
- If a primary issue cannot be durably recorded **before** implementation, or the required final reviewable Git change set cannot be created, report the blocker; do not silently skip either commitment.

## Seven-Phase Cycle

| Phase | Stages | Gate / output |
| --- | --- | --- |
| **1. Discover** | Understand → Observe → Identify Opportunities | Evidence-backed candidates; no product modifications |
| **2. Assess** | Value → Compatibility → Risk → Feasibility | Comparable eligible candidates and exclusions |
| **3. Select & Bound** | Select → Define Intent → Bound Change | Exactly one cohesive increment with clear boundaries |
| **4. Record** | Baseline → Understood Assignment → Effective Policies → Acceptance Criteria → Issue | Durable issue created before implementation |
| **5. Implement** | Plan → Execute → Track → Adapt | Product change confined to selected increment; issue updated |
| **6. Verify** | Test → Contract Check → Impact/Outcome Assessment | Verified evidence, honest remaining validation uncertainties |
| **7. Package & Close** | Reviewable Change Set → Commit → Link Evidence → Resolve Issue | Traceable commit(s), closure only if criteria met |

Use the phase policies and shared execution rules, not the table alone. A newly discovered hard constraint, failed feasibility assumption, or scope expansion can require returning to Assess/Select, re-scoping transparently in the issue, or abandoning the pick. Never silently rewrite the original intention or mark a failed pick Done.

## Return to the User

Give the chosen product increment and rationale; affected consumer contracts and review boundary; issue reference; key evidence and tests; actual commit or review-unit reference; remaining uncertainties; and state **Done / Blocked / Abandoned / No change**. Never invent issue IDs, commits, test results, or approval.
