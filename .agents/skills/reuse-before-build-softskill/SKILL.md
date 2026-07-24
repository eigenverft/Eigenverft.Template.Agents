---
name: reuse-before-build-softskill
description: Review a repository for custom mechanisms that may duplicate existing project, platform, framework, standard-library, or established ecosystem solutions. Verify realistic reuse options, project health, maintenance status, and package-manager availability, then report source-based findings in chat without modifying the repository.
---

# Reuse Before Build Softskill

## Purpose

Use this softskill to review whether a repository builds technical mechanisms that should instead reuse an existing solution.

The review is not limited to command-line parsing or any specific technology. Apply it to any language, runtime, framework, application type, or infrastructure stack.

The core question is:

> Before this mechanism is built or expanded, is there already a suitable, established, maintained, and easy-to-consume solution?

This is a review-only softskill.

Produce findings and recommendations in chat. Do not change code, dependencies, manifests, configuration, documentation, lock files, generated files, or repository state.

## Core Principle

Reuse before building, but do not reuse blindly.

Prefer, in order of practical suitability:

1. a correct existing mechanism already used in the repository
2. a standard-library, runtime, operating-system, or platform capability
3. a feature already provided by the project’s framework
4. a suitable dependency already present in the project
5. an established and maintained ecosystem package
6. a small local implementation when the problem is genuinely small and external reuse would cost more than it saves
7. a new general-purpose subsystem only when current requirements justify it

This order is a review guide, not an automatic verdict. A poor existing mechanism does not become good merely because it already exists.

## Review Scope

Look for custom implementations of common technical capabilities, including but not limited to:

- command-line parsing
- configuration loading and precedence
- validation
- serialization and deserialization
- retry, timeout, and resilience behavior
- scheduling and background work
- caching
- dependency injection or service location
- logging and structured diagnostics
- object mapping
- event dispatch and messaging
- routing
- authentication and authorization plumbing
- cryptographic helpers
- identifiers and token generation
- file watching
- archive and compression handling
- templating
- data access helpers
- migrations
- state machines
- plugin loading
- process execution
- HTTP clients and protocol handling
- parsing of standard formats
- date, time, locale, and unit handling
- collection, graph, queue, and concurrency primitives
- test infrastructure and mocking helpers
- build, packaging, and release utilities

Do not assume that every local helper is unnecessary. Focus on mechanisms with meaningful implementation, maintenance, correctness, security, compatibility, or extension cost.

## When To Use

Use this softskill when:

- a feature appears to have introduced a complete subsystem for a small requirement
- the repository contains custom infrastructure for a common problem
- a review should check whether the project is reinventing an established solution
- a proposed implementation adds significant code, abstraction, or maintenance surface
- a dependency decision needs an evidence-based reuse review
- the user wants findings and alternatives without changing the repository

## When Not To Use

Do not use this softskill when:

- the user explicitly requested implementation rather than review
- the work is purely domain-specific and no general reusable mechanism is involved
- the question is only whether code style is clean
- the user asked for a dependency upgrade execution
- repository access is unavailable and source-based review is required

## Source-First Contract

Read the relevant source before recommending reuse.

Inspect, where applicable:

- the custom mechanism itself
- call sites and real usage patterns
- public and internal contracts
- tests
- dependency manifests and lock files
- framework and runtime versions
- repository-local utilities with similar responsibility
- documentation and comments that explain constraints
- deployment or portability requirements

Determine the actual required capability, not the capability implied by the abstraction’s size.

A large implementation may support only a small real use case. A small implementation may hide difficult compatibility or security requirements.

Do not recommend replacement from the class name, folder name, or package category alone.

## Existing Repository Reuse Check

Before searching externally, determine whether the repository already contains a suitable mechanism.

Check for:

- another implementation of the same concern
- an existing shared utility
- a framework service already configured elsewhere
- a dependency already used by another project or module
- a wrapper around an established package that could be reused
- an existing convention that the new mechanism bypasses

Report duplication inside the repository separately from external-library opportunities.

Do not propose a new dependency when the repository already has a suitable, maintained solution unless there is a concrete reason not to reuse it.

## External Research Contract

When a plausible established solution may exist and current external information would materially affect the recommendation, search the internet.

Do not rely only on remembered package names or historical popularity.

Research should verify:

- the official project or package source
- current maintenance status
- recent releases or meaningful maintenance activity
- compatibility with the project’s current technology versions
- supported platforms and deployment model
- package-manager availability
- documentation quality
- licensing at a useful summary level
- security advisories or clear abandonment signals when relevant
- migration and adoption cost

Prefer primary sources:

- official project documentation
- official package registries
- official source repositories
- official release notes
- language, runtime, framework, or platform documentation

Use third-party comparisons only as supporting evidence, not as the sole basis for a recommendation.

## Established-Solution Standard

Do not recommend obscure software merely because it technically matches the requirement.

A preferred external solution should normally show several of these qualities:

- recognized or widely used in its ecosystem
- maintained by a credible organization or stable maintainer group
- recent releases or active maintenance appropriate to its maturity
- clear documentation and examples
- stable package-manager distribution
- transparent license
- issue and security handling that does not appear abandoned
- compatibility with supported project versions
- a user base large enough that common problems are likely to be known
- an adoption path simpler than maintaining the custom solution

Do not use download counts or repository stars as proof by themselves.

A small focused package can be valid. An unknown, unmaintained, single-purpose package with unclear provenance should not replace a simple local implementation.

## Project Health Check

Classify each serious external candidate as one of:

1. **Healthy** — maintained, compatible, documented, and practical to adopt.
2. **Mature and stable** — low release frequency is reasonable because the problem and API are stable; no clear abandonment signs.
3. **Usable with caution** — useful but has maintenance, compatibility, governance, or adoption concerns.
4. **Outdated or unsuitable** — stale, incompatible, poorly maintained, risky, or too difficult to consume.
5. **Unverified** — evidence is insufficient for a responsible recommendation.

Do not label a project outdated only because its last release is old. Consider whether the domain is stable and whether maintenance activity, issue handling, compatibility, and ecosystem usage remain healthy.

Conversely, do not label a project healthy merely because it published a recent version.

## Consumption and Update Contract

Prefer the technology-appropriate package manager or official distribution mechanism.

Examples include package managers, module registries, operating-system package systems, framework package mechanisms, plugin registries, container registries, or official binary distribution channels.

The exact tool is technology-specific, but the principle is not.

Prefer solutions that can be:

- declared in the normal dependency manifest
- restored reproducibly
- versioned clearly
- updated through ordinary dependency-management workflows
- checked by existing security and dependency tooling
- removed without manual source cleanup

Treat these as strong warning signs unless clearly justified:

- downloading source archives manually
- copying third-party source files into the repository without a deliberate vendoring policy
- extracting individual files from another project
- building an external library from source only to consume normal functionality
- committing opaque binaries from unofficial sources
- maintaining custom update scripts for a dependency available through a normal package channel
- bypassing lock files or reproducible dependency resolution

Manual vendoring or source builds may be valid for offline, regulated, patched, unsupported-platform, reproducibility, or supply-chain reasons. Require concrete repository evidence before recommending them.

## Proportionality Check

Do not turn “reuse before build” into “always add a library.”

Compare the complete cost of each option:

- current required behavior
- likely near-term variation supported by evidence
- correctness difficulty
- security sensitivity
- compatibility surface
- maintenance burden
- dependency size and transitive dependencies
- upgrade effort
- operational impact
- API complexity
- testing burden
- portability requirements
- licensing constraints
- removal or migration cost

A small local implementation may be the best answer when:

- the requirement is genuinely narrow
- behavior is obvious and easy to test
- edge cases are limited and controlled
- the code is not security-sensitive
- the external dependency would be larger or harder to maintain
- the project would use only a trivial fraction of a large package

An established solution is more likely appropriate when:

- parsing or protocol rules have many edge cases
- compatibility must remain stable
- the feature is public or user-facing
- security or correctness failures are costly
- help, diagnostics, localization, completion, migration, or extensibility matter
- the custom code is already growing
- several modules need the same capability
- mature ecosystem behavior would otherwise need to be recreated

## No Speculative Architecture Rule

Judge against current requirements and evidence-backed near-term needs.

Do not justify a large subsystem with vague future possibilities such as:

- “we may need more options later”
- “this could become extensible”
- “other implementations might appear”
- “it is more enterprise-ready”

Future extensibility counts only when supported by product requirements, existing variation, a public compatibility commitment, or a clear repository direction.

## Replacement Judgment

For each finding, choose one clear judgment:

1. **Reuse existing repository mechanism**
2. **Use standard platform or framework capability**
3. **Use existing project dependency**
4. **Adopt an established external solution**
5. **Keep the local implementation**
6. **Reduce the local implementation instead of replacing it**
7. **Insufficient evidence**

Do not force a library recommendation when keeping or reducing the local implementation is better.

Do not recommend replacement solely to reduce line count. Account for migration risk, behavior compatibility, dependency policy, and long-term ownership.

## No-Change Contract

This softskill is analysis-only.

Do not:

- edit source files
- add, remove, or update dependencies
- modify manifests or lock files
- change configuration
- create issues, plans, handoffs, reports, or repository-local Markdown files
- run automatic upgrade or migration commands
- stage, commit, or push

Read-only inspection, dependency metadata inspection, and internet research are allowed.

Return all findings in chat.

## Required Output Shape

### 1. Review summary

State briefly:

- what area was reviewed
- whether significant unnecessary custom construction was found
- the strongest reuse opportunity
- whether the current solution is proportionate to the actual requirement

### 2. Findings

For each meaningful finding include:

- **Location** — relevant files, symbols, or subsystem
- **Current mechanism** — what was built
- **Actual requirement** — what the repository currently appears to need
- **Why review is warranted** — duplicated capability, excess scope, correctness risk, maintenance cost, or missed existing mechanism
- **Reuse candidates** — repository, standard, framework, existing dependency, or external options
- **Candidate health** — healthy, mature and stable, usable with caution, outdated or unsuitable, or unverified
- **Consumption path** — normal package manager or official distribution mechanism when external reuse is recommended
- **Judgment** — one clear replacement judgment
- **Reasoning** — concise source-based explanation

### 3. Keep-as-is findings

Mention important reviewed mechanisms that should remain local and explain why.

This prevents the review from becoming a one-sided library hunt.

### 4. Priority order

Rank recommended actions as:

- **High value** — substantial correctness, security, maintenance, or complexity benefit
- **Useful** — worthwhile but not urgent
- **No action** — current local solution is proportionate
- **Needs evidence** — cannot responsibly decide yet

### 5. Final recommendation

End with:

- the most important reuse decision
- the most important local implementation that should remain
- any external candidate that must not be adopted because it is outdated, obscure, incompatible, or difficult to maintain

## Output Style

Use simple, direct, technically concrete language.

Prefer real file names, symbols, behaviors, package names, maintenance facts, and adoption paths over abstract phrases.

Do not fill the response with general statements about avoiding reinvention. Every significant recommendation must connect to repository evidence.

Keep internet-derived facts clearly distinguishable from source-derived findings and cite them when the environment supports citations.

## Quality Bar

A successful review does not merely say “use a library.”

It determines:

- what the project actually needs
- what it already has
- what established alternatives exist
- whether those alternatives are healthy and compatible
- whether they can be consumed and updated normally
- whether reuse is genuinely simpler and safer than local ownership
- where local code remains the better choice

The best result reduces unnecessary custom infrastructure without replacing it with unnecessary dependency infrastructure.

## Typical Invocation Phrases

- `Use $reuse-before-build-softskill to review this repository for mechanisms that should reuse established solutions.`
- `Check whether this project is reinventing common infrastructure. Return findings only and make no changes.`
- `Review this subsystem for existing repository, platform, framework, or maintained-library alternatives.`
- `Find custom mechanisms that should be replaced by established packages, but reject obscure or outdated candidates.`
- `Check whether normal package-manager dependencies would be simpler than the custom implementation.`
