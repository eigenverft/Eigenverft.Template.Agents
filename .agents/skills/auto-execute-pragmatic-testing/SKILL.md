---
name: auto-execute-pragmatic-testing
description: Apply automatically when dealing with software testing, including test analysis, planning, review, creation, execution, debugging, maintenance, and verification of software changes. Guide proportionate test depth, deliberate retention of durable tests, clear test organization, and compact output with useful failure diagnostics. Match the applied guidance and actions to the current task's scope and permissions.
---

# Auto Execute Pragmatic Testing

## Activation and Scope

Apply these rules automatically whenever the current task involves software testing, including reasoning about tests and verifying software changes. Use the relevant guidance within the current task's scope and permissions. For read-only assignments, contribute inspection, reasoning, and recommendations; carry out test execution and changes under the permissions of the assigned work.

## Purpose and Priorities

Optimize the **entire software testing lifecycle**, not just the writing of individual test cases. Tests should reliably support development and protect the product over time without unnecessary maintenance, confusing test collections, or excessive routine output.

**Use these priorities to guide decisions:**

1. **Development:** Test as deeply and thoroughly as useful for understanding and progress in the current work.
2. **Durable protection:** Deliberately assess the long-term value of newly created or substantially changed checks instead of retaining everything by default.
3. **Test organization:** Keep the lasting test suite clear, discoverable, and explicitly associated with the product areas and purposes it protects.
4. **Test output:** Present routine successes briefly; investigate current development questions and failures with the necessary detail.
5. **Proportionality:** Balance defect protection, development time, test runtime, maintenance, and additional checking effort.

Treat these priorities as connected decision rules. Other testing methods and general best practices support them rather than replace them. Follow established project conventions and explicit requirements.

## 1. Investigate Selectively and Deeply During Development

Distinguish the **current investigation** from a test's later routine use.

- Identify the behavior being developed, changed, or investigated and the uncertainties involved.
- Use detailed, exploratory, or short-lived diagnostic checks where useful. Investigate relevant edge cases, states, transitions, and failure causes as thoroughly as the task requires.
- Run the directly relevant checks first and expand the scope when risks or interactions warrant it.
- Use detailed information for the current investigation. Avoid repeatedly printing full success logs from other, unchanged product areas.
- Remember that a detailed check that helps now is not automatically a useful permanent regression test.

A deep development check may temporarily focus on a specific hypothesis. Even then, check genuine expectations rather than merely confirming the current implementation.

## 2. Deliberately Transition to Durable Tests

**Do not retain development checks permanently merely because they were written.** At the end of the relevant work, assess newly created or substantially changed tests. This reassessment concerns the tests worked on, not automatically the entire suite.

Answer these questions when deciding what to retain:

1. **Protective value:** Which domain expectation, interface, or relevant failure mode does the check protect?
2. **Additional value:** What understanding or protection does it add beyond existing tests?
3. **Stability:** Will it remain meaningful through legitimate internal changes rather than breaking unnecessarily?
4. **Reliability:** Is the check reproducible and understandable when it fails?
5. **Cost:** Does its protective value justify execution, diagnosis, and maintenance costs?

Then make a reasoned choice: **retain, develop into a durable regression test, simplify, consolidate, keep specifically for diagnosis, or remove**.

Tests that matter over time need clearer expectations, reliability, maintainability, organization, and useful failure diagnosis. Additional specific tests may also remain necessary when they protect distinct risks.

Never delete a test merely because it has been green for a long time, looks similar to another, or covers the same lines. Before consolidation, check whether unique inputs, states, failure modes, or regressions would be lost. Do not weaken assertions merely to obtain a green run.

This distinction concerns **different purposes and lifecycle stages**, not necessarily two fixed test types, folders, or technical systems.

## 3. Organize Tests Clearly as Product Protection

**Test organization is a quality requirement in its own right.** A developer or agent should be able to identify **where relevant product tests are located, which behavior they protect, and which tests run in a given context**.

- Discover the existing organization of test files, suites, commands, and CI runs. Use it as the starting point.
- Associate durable tests clearly with product capabilities, modules, interfaces, or behavior areas. Choose a consistent structure in which affected tests can be found when changes occur.
- Keep it clear which checks provide regular product protection and which currently serve exploratory, local, or diagnostic purposes. Use existing folders, conventions, markers, or groups where suitable.
- Ensure important regression tests are reliably included in their intended runs. A test file's existence alone does not establish protection.
- Where useful, distinguish a test's **logical association** from its **execution groups**, such as a focused local run, smoke test, regression run, or full suite. Do not duplicate test code merely to run the same check in several groups.
- Avoid scattered one-off tests, unclear names, parallel test copies, and extra structures without a clear benefit.

If the existing organization is confusing, propose or implement an appropriate improvement **only within a corresponding assignment**, such as clearer grouping, tags, an understandable suite entry point, or a lightweight overview of protected areas.

A central test registry or additional documentation is **one possible solution, not a requirement**. Discoverability, clear purpose, reliable execution, and low maintenance cost are what matter.

Maintain these associations when relevant changes occur. Do not conduct a complete organizational audit for every small task.

## 4. Adjust Test Output to the Situation and Purpose

**Compact by default, selectively detailed for current development, and diagnostically sufficient on failure.**

Distinguish explicitly:

- **Execution scope:** Which tests actually ran?
- **Investigation depth:** How thoroughly was behavior examined?
- **Output volume:** How much information is shown?

A brief report must never substitute for sufficient testing.

### Routine and Established Checks

- Use existing runners' quiet or summary features where available.
- Show the overall status, passed and failed counts, and relevant skipped or unexecuted checks compactly.
- Keep routinely successful tests, especially those outside the current product area, brief in the standard output.
- Highlight new, relevant, or unusual failures. Distinguish checks that did not run from successful checks.

### Current Development and Failure Diagnosis

- Provide more detailed intermediate results for the area being worked on when useful.
- On failure, first show the affected test, its expected result, and the essential difference.
- Use additional logs, stack traces, test data, and environment information for that check as needed. Keep relevant detail available rather than mixing every successful log into the main output.
- Investigate whether the cause lies in the product, the test, the expectation, or the environment before correcting it.

Use existing runner, CI, and reporting capabilities. Do not introduce new dashboard or reporting infrastructure when simple configuration suffices.

## 5. Balance Testing Effort and Lasting Value

**Optimize for meaningful protection at an appropriate total cost, not for the largest or smallest number of tests.**

- Assess new tests by risk, additional defect-detection value, maintenance, runtime, and diagnostic quality.
- Examine existing tests before generating more. Add missing protection rather than merely increasing test counts or coverage.
- Choose test types and execution times to suit the task and existing infrastructure. Start focused; expand checks for higher risks or larger changes.
- Consider the long-term cost of unnecessarily strict, implementation-coupled, and repetitive tests.
- Keep important protection even when removing it would speed up execution. Explain substantial changes to the durable test suite.
- Keep test optimization itself proportionate. Avoid routine complete audits, extensive metrics systems, or forced refactoring without cause.

Fixed coverage percentages, test-pyramid ratios, TDD, and mutation testing are **not universal requirements**. Use them when project requirements, risks, and clear additional value justify them.

Follow explicit user and project tooling preferences. For new tests, prefer suitable built-in or first-party testing facilities of the product's technology; for supporting automation, prefer native tools of the intended build and execution environments. Apply this preference in mixed-tooling projects as well; choose alternatives when required capabilities or a clear overall benefit justify their setup and maintenance costs. Preserve existing test protection and keep tooling migration within the assigned scope.

## 6. Supporting Test Quality Rules

Apply these foundations without automatically creating additional test work:

- Prefer testing observable behavior, contracts, and justified expectations over incidental implementation details.
- Give tests meaningful names and focus assertions on relevant outcomes.
- Consider positive, negative, boundary, and state cases according to their actual significance rather than generating them mechanically.
- Keep tests as independent, reproducible, and understandable as practical. Use shared helpers or parameterized tests when they improve maintainability.
- Mock dependencies only where sensible; use suitable controlled integrations when the interaction itself is under test.
- Particularly for newly generated AI tests, check whether assertions would detect the intended defect. A green test alone does not prove quality.
- Use a targeted contrasting case or mutation where useful, not automatically for every new check.
- Protect a corrected defect with a suitable regression test when it represents a relevant recurring failure mode and can reasonably be checked automatically.

## 7. Application and Completion

Apply the rules **according to the situation** when creating, changing, running, debugging, reviewing, and maintaining tests. This skill provides ongoing guidance for the current testing work; keep suite-wide reorganization or reviews within an explicitly assigned scope.

As applicable to testing-related work within the current task:

1. Clarify the immediate testing purpose and use the existing project structure as a guide.
2. Use the depth and diagnosis needed during the work.
3. Assess newly created or substantially changed tests for durable protection and organize them appropriately.
4. Run appropriate checks within the task's permissions and report compactly; investigate failures in detail where needed.
5. Identify relevant remaining uncertainties and substantial changes to the durable suite.

Report checks as executed only when they actually ran. A green subset is not a complete product test. Explain decisions in more detail when changing or removing tests that provide important lasting protection.

When relevant checks cannot run, briefly state what was not run, why, and the resulting uncertainty. Address missing test infrastructure according to the task's scope, risk, and permissions.

**Guiding principle:** Development checks should enable understanding and progress. Durable tests should protect the product reliably, remain clearly organized, and generate little routine noise. Every additional testing activity must justify its value against its cost.
