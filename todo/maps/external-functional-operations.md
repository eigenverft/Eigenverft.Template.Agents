Analyze the codebase and create a compact three-view codebase comprehension map.

The result should contain three independently derived views of the same codebase:

**External Surface View**
What does the system expose to the outside world?

**Functional View**
What capabilities does the system provide and how do those capabilities relate functionally?

**Operations View**
How can the running system be administered, observed, maintained, controlled, and recovered?

The three views must remain conceptually separate.

Their definitions are isolated below so that any individual view can later be replaced by another kind of view without changing the logic of the remaining views or the relation layers.

The intended conceptual progression is:

**Outside → Meaning → Running System**

or:

**External Surface → Functional Capability → Operations**

This progression also defines the current left-to-right view order for Mermaid layout.

If a later version replaces, adds, removes, or reorders views, derive the Mermaid layout order from that version's configured conceptual progression. Do not hard-code the current view names or current number of views into the general layout-order logic.

Do not derive one view mechanically from another.

# View A Definition: External Surface View

The External Surface View answers:

**What can an external consumer observe, invoke, configure, provide, receive, depend on, or interact with without understanding the internal implementation?**

"External consumer" is intentionally broad.

Depending on the codebase, it may include:

* application developers
* library consumers
* end users
* administrators
* operators
* external services
* API clients
* plugins
* command-line users
* configuration authors
* runtime clients
* deployment environments

Do not assume which consumer types exist. Derive them from the codebase.

## External perspective

Describe the system strictly from outside its implementation boundary.

Look for externally meaningful surfaces such as:

* public APIs
* externally callable operations
* configuration surfaces
* extension points
* commands
* endpoints
* events
* inputs and outputs
* integration contracts
* exposed behaviors
* externally visible state
* externally controllable policies
* supported interaction modes

Do not organize this view around internal implementation components.

A public class or method should not automatically become a node merely because it is public.

Instead ask:

**What externally meaningful ability or interaction does this expose?**

Several public APIs may form one external surface capability.

One external capability may also be exposed through several different mechanisms.

## Not a user journey

Do not turn the External Surface View into a process or sequence.

Avoid structures such as:

`Start → Configure → Execute → Finish`

unless those are genuinely independent external capabilities rather than chronological steps.

The view should describe **what is available from outside**, not the order in which someone uses it.

## External hierarchy

Where useful, distinguish between:

* external surface
* consumer-facing area
* interaction capability
* exposed operation
* configuration surface
* external variant
* observable behavior

These are guidance, not a rigid schema.

Build the hierarchy from the evidence in the codebase.

# View B Definition: Functional View

The Functional View answers:

**What capabilities does the system provide and how do those capabilities relate functionally?**

Build the functional structure, where possible, from the bottom up.

First identify concrete capabilities, behaviors, guarantees, and functions provided by the system.

Then determine which of them belong together and can be grouped under a simple, meaningful higher-level concept.

Repeat this consolidation recursively until the result forms a small number of clear top-level areas and, ideally, one meaningful functional root.

The root should describe the broad capability or functional purpose of the codebase as a whole.

Do not primarily organize the Functional View around:

* files
* folders
* namespaces
* classes
* interfaces
* services
* packages
* technical layers

These are evidence, not the desired structure.

A capability may be distributed across multiple files, modules, or components.

Likewise, a technical module should not automatically become a feature.

Where useful, distinguish between:

* core capability
* sub-capability
* variant or realization
* concrete function or usage
* behavioral guarantee
* security or isolation guarantee

These are guidance, not a rigid schema.

# View C Definition: Operations View

The Operations View answers:

**How can the running system be administered, observed, maintained, controlled, and recovered?**

Independently identify the operational responsibilities and mechanisms that matter once the software is running or maintaining runnable state.

The view remains codebase-centered.

It should describe operational behavior and operability that are defined, enabled, constrained, or materially supported by the codebase.

Depending on the system, this may include both application-level operations and technical operability.

Look for concepts such as:

* runtime administration
* operator controls
* administrative maintenance
* user or access administration
* runtime configuration
* operational policy controls
* diagnostics
* health and readiness
* logging
* telemetry
* metrics
* task or job administration
* queue or workload control
* cleanup
* repair
* recovery
* fallback behavior
* last-known-good behavior
* runtime continuity
* persistence maintenance
* startup and shutdown behavior
* operational safeguards
* runtime security controls
* operational failure handling

Do not assume that administrative users, operators, superusers, maintenance interfaces, dashboards, or control planes exist.

Derive them from the codebase.

A library or small component may have little or no meaningful application-level operations surface.

A server, service, platform, or long-running application may have substantial operational responsibilities.

## Operational perspective

Describe the system from the perspective of keeping, controlling, observing, administering, or recovering the running system.

An item should not become an Operations node merely because an administrator can invoke it.

Ask instead:

**Does this materially contribute to administering, observing, maintaining, controlling, recovering, or sustaining the running system?**

Likewise, a logging library, configuration file, health endpoint, database helper, or maintenance method should not automatically become a node merely because it appears operational.

Ask:

**What operational responsibility or property does this provide?**

Several technical mechanisms may form one operational responsibility.

One operational responsibility may also span several parts of the codebase.

## Not an administrator-only External Surface View

Do not recreate the External Surface View using only administrator or operator interactions.

An administrator-facing action may appear in the External Surface View because it is externally invokable.

The same underlying area may independently appear in the Operations View when it represents a meaningful operational responsibility.

The questions are different:

**External Surface:** What can an external administrator or operator interact with?

**Operations:** What operational responsibility helps administer, observe, maintain, control, recover, or sustain the running system?

Do not force a corresponding Operations node merely because an administrator-facing External Surface node exists.

Do not force an External Surface node merely because an internal operational mechanism exists.

## Not deployment or build documentation

Do not turn the Operations View into a build, packaging, CI/CD, hosting, infrastructure, or deployment inventory.

Build scripts, project files, pipelines, containers, manifests, infrastructure definitions, hosting configuration, or deployment files should not automatically become Operations nodes merely because they are used to run or deploy the system.

They are relevant only when they materially define or support an operational responsibility of the running system itself.

Do not organize this view chronologically as:

`Build → Deploy → Start → Monitor → Recover`

The view describes **operational responsibilities and properties**, not a delivery or operational procedure.

## Operations hierarchy

Where useful, distinguish between:

* operational area
* runtime administration responsibility
* observability responsibility
* maintenance responsibility
* control responsibility
* recovery responsibility
* continuity or fallback mechanism
* operational security boundary
* operational configuration responsibility
* technical operability mechanism

These are guidance, not a rigid schema.

Build the hierarchy from the evidence in the codebase.

# Shared hierarchy rules

Apply the following rules independently to all three views.

## Build meaningful hierarchies

Do not force a fixed number of levels.

The meaning and depth of each branch should emerge from the code.

Every parent-child relationship should express a meaningful grouping.

## Look for shared parents

Do not automatically treat every discovered item as a separate top-level node.

Whenever several neighboring items appear, ask:

* Do these belong together?
* Are they different aspects of a broader concept?
* Is there a simple common concept that explains them together?
* Is one actually a specialization, variant, realization, exposure, guarantee, responsibility, or part of another?
* Are different abstraction levels currently being placed next to each other?

If introducing a shared parent makes the structure clearer, introduce it.

Repeat this recursively for groups that have already been formed.

## Keep siblings at comparable abstraction levels

Sibling nodes should, as far as possible, represent the same kind of thing.

Avoid placing a broad concept next to a narrow detail.

If neighboring nodes differ significantly in abstraction level, check whether one belongs below another or whether a shared parent is missing.

## Preserve meaningful distinctions

Do not compress a view so far that independently meaningful distinctions disappear.

Keep separate nodes when two concepts differ materially in one or more of these ways:

* lifecycle
* policy
* security boundary
* trust boundary
* validation boundary
* authorization behavior
* isolation behavior
* containment behavior
* external behavior
* configuration surface
* operational behavior
* failure behavior
* recovery behavior
* runtime continuity
* operational responsibility
* neighboring-view mappings

A distinction is especially worth preserving when two concepts map differently to nodes in an adjacent view.

For example, if two functional behaviors belong to the same broader capability but have different operational implications, keep them as separate functional nodes under their shared parent when collapsing them would hide materially different Functional-to-Operations mappings.

Likewise, if two external interactions expose different aspects of the same capability, keep them separate when that distinction materially improves the External-to-Functional mapping.

Do not add detail merely for completeness.

Preserve detail when it carries structural meaning.

## Preserve explicit system guarantees

Treat explicit guarantees as independently meaningful behaviors when they enforce a distinct property of the system.

In particular, do not absorb a meaningful guarantee into a generic configuration or technical node merely because the guarantee happens to be implemented through validation.

Look specifically for guarantees involving:

* containment
* isolation
* authorization
* trust
* access restrictions
* path or resource boundaries
* input acceptance rules
* integrity protection
* atomicity
* consistency
* fallback behavior
* last-known-good behavior
* recovery guarantees
* persistence guarantees
* compatibility boundaries

If such a guarantee answers a distinct question such as:

* "What is prevented?"
* "What remains isolated?"
* "What is guaranteed to remain valid?"
* "What boundary cannot be crossed?"
* "What happens when replacement fails?"
* "What state remains usable after failure?"

then consider representing it as its own Functional node.

If the guarantee also creates a distinct operational responsibility involving administration, observation, maintenance, control, recovery, or runtime continuity, preserve that responsibility independently in the Operations View.

Do not force an Operations node for every Functional guarantee.

An operational responsibility should exist only when it is independently meaningful from the Operations perspective.

A security, validation, recovery, or correctness behavior should not disappear from the Functional View merely because it is technically enforced inside another mechanism.

## Consider alternative groupings

Do not automatically accept the first plausible hierarchy.

For important areas, consider whether another grouping would explain the structure more clearly or with fewer concepts.

Prefer the structure that explains the most with the fewest clear and meaningful terms.

If two groupings are similarly plausible, mention the alternative briefly rather than forcing artificial certainty.

# Keep all three views independent

Derive all three views independently from the code.

Do not create the External Surface View by simply selecting public members from another view.

Do not create the Functional View by renaming External Surface nodes.

Do not create the Operations View by selecting administrator-facing External Surface nodes.

Do not create the Operations View by filtering Functional nodes for things that sound operational.

Do not alter the structure of one view merely to make it align visually or conceptually with another.

Their structures are expected to differ.

This difference is valuable information.

For example:

* several external interactions may map to one functional capability
* one external interaction may involve several functional capabilities
* one functional capability may have several operational responsibilities
* one operational responsibility may support several unrelated capabilities
* one external configuration surface may influence several different functional guarantees
* a functional capability may have no special operational responsibility
* an operational mechanism may be important even when it has no direct external interaction
* application-level administration may overlap externally with operator controls while remaining conceptually different in the Operations View
* recovery or continuity responsibilities may cut across several functional areas

First complete all three views independently.

Only afterwards identify the relationships between them.

# Naming

Use short, understandable names.

For the External Surface View, describe nodes in terms of **what an external consumer can interact with or rely on**.

For the Functional View, describe nodes in terms of **what the system can do or guarantee**.

For the Operations View, describe nodes in terms of **what operational responsibility helps administer, observe, maintain, control, recover, or sustain the running system**.

Internal class, method, file, namespace, package, endpoint, configuration, or service names may be used as supporting evidence, but should not automatically determine node names.

Keep Mermaid labels concise.

Put detailed explanations into the corresponding tables.

# References

Assign every relevant node a short stable reference.

External Surface View references use:

`E1`, `E2`, `E3`, ...

Functional View references use:

`F1`, `F2`, `F3`, ...

Operations View references use:

`O1`, `O2`, `O3`, ...

These references must remain consistent across:

* Mermaid diagram
* External Surface mapping table
* Functional mapping table
* Operations mapping table
* relation tables
* observations

Show the reference inside the Mermaid node label using a small textual marker:

`*E1`

`*F1`

`*O1`

For example:

```text
E1["External Surface *E1"]
E2["Configure system *E2"]

F1["System capabilities *F1"]
F2["Capability A *F2"]

O1["System operations *O1"]
O2["Runtime maintenance *O2"]
```

The reference is only an identifier.

It is not part of the actual surface, capability, or operational responsibility name.

# Uncertainty

Stay close to what can actually be supported by the code.

Do not invent external use cases merely because an API could theoretically be used that way.

Do not invent product behavior merely because an implementation could theoretically support it.

Do not invent administrator or operator roles merely because administrative behavior could theoretically exist.

Do not invent operational responsibilities merely because common production systems usually have them.

Do not assume deployment, infrastructure, observability, recovery, maintenance, or runtime-control behavior unless supported by evidence.

If something is clearly present but its role is uncertain, keep it only when useful and mark the uncertainty in the corresponding table.

# Mermaid output

First produce all three views together in one Mermaid diagram.

Use:

```text
---
config:
  layout: elk
  elk:
    nodePlacementStrategy: LINEAR_SEGMENTS
    mergeEdges: false
---
flowchart LR
```

The desired conceptual arrangement is:

```text
OUTSIDE                                                   RUNNING SYSTEM

External Surface View       Functional View       Operations View

        E                         F                     O

 what is exposed?          what does it mean?      how is it operated?
```

The External Surface View should appear on the left.

The Functional View should occupy the middle.

The Operations View should appear on the right.

Treat this as the configured left-to-right view order for the current product version.

## External Surface hierarchy orientation

Write External Surface hierarchy edges parent-first:

```text
parent --- child
```

This should make the External Surface hierarchy grow from the outside-left toward the Functional View.

Example:

```text
E1 --- E2
E2 --- E3
```

## Functional hierarchy orientation

Write Functional hierarchy edges parent-first:

```text
parent --- child
```

Keep the Functional View as the semantic middle layer.

Do not restructure the Functional hierarchy merely to improve relation alignment.

Example:

```text
F1 --- F2
F2 --- F3
```

## Operations hierarchy orientation

Write Operations hierarchy edges child-first:

```text
child --- parent
```

This is intentionally reversed only for Mermaid layout purposes.

It should place the Operations root toward the far right while its more detailed operational nodes face toward the Functional View.

Example:

```text
O3 --- O2
O2 --- O1
```

Because `---` is undirected, this reversed statement order must not be interpreted as ownership direction, operational sequence, execution flow, data flow, dependency direction, or runtime direction.

Semantic Operations paths must still always be described root-first in the mapping table.

# Mermaid structure

Use three separate subgraphs:

```text
---
config:
  layout: elk
  elk:
    nodePlacementStrategy: LINEAR_SEGMENTS
    mergeEdges: false
---
flowchart LR

    subgraph EXTERNAL["External Surface View"]

        E1["External Surface *E1"]

        E1 --- E2["External area A *E2"]
        E1 --- E3["External area B *E3"]

        E2 --- E4["External interaction A1 *E4"]
        E2 --- E5["External interaction A2 *E5"]
    end


    subgraph FUNCTIONAL["Functional View"]

        F1["Functional Purpose *F1"]

        F1 --- F2["Capability A *F2"]
        F1 --- F3["Capability B *F3"]

        F2 --- F4["Sub-capability A1 *F4"]
        F2 --- F5["Behavioral guarantee A2 *F5"]
    end


    subgraph OPERATIONS["Operations View"]

        O1["System Operations *O1"]

        O4["Runtime administration *O4"] --- O2["Operational area A *O2"]
        O5["Recovery responsibility *O5"] --- O2

        O2 --- O1
        O3["Operational area B *O3"] --- O1
    end


    EXTERNAL layout1@--> FUNCTIONAL
    FUNCTIONAL layout2@--> OPERATIONS

    classDef layoutConstraint opacity:0;
    class layout1,layout2 layoutConstraint;


    E4 -.- F4
    E5 -.- F5

    F4 -.- O4
    F5 -.- O5
```

The `layout1`, `layout2`, ... edges are layout constraints only.

After defining the view subgraphs, create exactly one directed layout-constraint edge from each view subgraph to the next view subgraph in the currently configured left-to-right view order.

Generate the layout-constraint chain from the current view order rather than from fixed view names or a fixed number of views.

For three configured views `A → B → C`, the layout chain has two constraints:

```text
A layout1@--> B
B layout2@--> C
```

For four configured views `A → B → C → D`, the layout chain has three constraints:

```text
A layout1@--> B
B layout2@--> C
C layout3@--> D
```

Assign all layout-constraint edges to the dedicated `layoutConstraint` class and make them visually invisible:

```text
classDef layoutConstraint opacity:0;
class layout1,layout2 layoutConstraint;
```

Extend the class assignment to all generated layout edge IDs when more layout constraints exist.

Do not use `~~~` to enforce the ordering of the view subgraphs.

Layout-constraint edges:

* exist only to preserve the configured view order in Mermaid layout
* carry no semantic relationship
* are not hierarchy edges
* are not cross-view relation edges
* have no relation references
* must not appear in relation tables
* are excluded from exact relation consistency rules

If a later product version replaces, adds, removes, or reorders views, regenerate this layout-constraint chain from that version's configured view order.

# Mermaid connection semantics

Use:

`---`

for hierarchy inside a view.

It means only:

**belongs under / is part of**

It must not imply:

* process flow
* execution order
* data flow
* dependency direction
* runtime direction

Use:

`-.-`

for semantic relationships between neighboring views.

Cross-view relation connections must:

* be undirected
* have no labels
* have no relation IDs on the line
* contain no explanatory text
* remain visually lightweight

All semantic details about these relationships belong in the relation tables.

Directed `layout...@-->` edges are a separate presentation-only mechanism.

They must never be interpreted as semantic cross-view relationships, process flow, execution order, data flow, dependency direction, or runtime direction.

# Allowed cross-view relation layers

For this version, create two separate relation layers:

**External Surface ↔ Functional**

and:

**Functional ↔ Operations**

Do not create direct:

**External Surface ↔ Operations**

relations.

The Functional View is intentionally the semantic bridge between outside behavior and operational responsibility in this product configuration.

A direct External-to-Operations mapping may be added later as a separate derived view if explicitly requested.

# External-to-Functional relation discovery

Only perform this step after the External Surface View and Functional View have both been independently completed.

For every relevant External Surface node, examine which Functional nodes materially explain or support that external surface.

For every relevant Functional node, examine which External Surface nodes expose, consume, control, configure, observe, or depend on it.

The purpose of this layer is to reveal patterns such as:

* several external interactions backed by one capability
* one external surface requiring several capabilities
* capabilities that exist without a currently visible external exposure
* one capability exposed through several different external mechanisms
* one configuration surface controlling several distinct guarantees
* one externally visible behavior resulting from several internal capabilities

Record every materially supported relationship between existing nodes.

Do not compress the relation set merely to make the diagram cleaner.

# Functional-to-Operations relation discovery

Only perform this step after the Functional View and Operations View have both been independently completed.

For every relevant Functional node, examine which Operations nodes materially contribute to administering, observing, maintaining, controlling, recovering, or sustaining that capability or guarantee in the running system.

For every relevant Operations node, examine which Functional nodes it materially administers, observes, maintains, controls, recovers, sustains, or operationally supports.

The purpose of this layer is to reveal:

* one functional capability with several operational responsibilities
* several functional capabilities sharing one operational mechanism
* capabilities that require runtime administration
* capabilities whose runtime behavior is observable through dedicated operational mechanisms
* guarantees with distinct recovery or continuity responsibilities
* operational controls that affect several functional areas
* functional capabilities with no special operational responsibility
* operational mechanisms that support only one narrow functional area
* runtime maintenance responsibilities that cut across several capabilities
* operational safeguards that preserve functional behavior
* application-level administration that differs from ordinary external usage

Record every materially supported relationship between existing nodes.

Do not compress the relation set merely to make the diagram cleaner.

Do not force every Functional node to have an Operations relation.

Do not force every Operations node to have a Functional relation when the relationship would be incidental or too broad to be meaningful.

# Do not inherit or suppress relations through hierarchy

Apply this rule to both relation layers.

A relation between parent nodes does not automatically replace relations between their descendants.

A relation between descendant nodes does not automatically replace a valid relation between their parents.

Do not omit a relationship merely because:

* an ancestor is already connected
* a descendant is already connected
* a broader relation already exists
* another relation looks visually similar

The relation layers exist specifically to reveal one-to-many, many-to-one, and many-to-many structures.

# Do not invent relations

Completeness does not mean connecting everything.

Create a relation only when the code materially supports it.

Do not connect nodes merely because:

* they are close in their hierarchy
* they share a folder
* they interact incidentally
* one eventually reaches code somewhere below the other
* an operational mechanism exists somewhere in the same subsystem
* the connection seems theoretically plausible

A relation should materially help explain how the two neighboring views correspond.

# Use existing nodes

Do not create extra nodes solely to make cross-view relations easier to express.

Relations should connect nodes that were independently discovered as meaningful members of their own view.

If an existing abstraction is too coarse to express an important relationship, reconsider that view only if the missing node is independently meaningful within the view itself.

Do not create mapping-only nodes.

# Exact relation consistency

For both semantic relation layers:

**One Mermaid `-.-` cross-view relation edge = one relation-table row.**

And:

**One relation-table row = one Mermaid `-.-` cross-view relation edge.**

There must be no undocumented Mermaid `-.-` relation.

There must be no relation-table row without a corresponding Mermaid `-.-` edge.

Presentation-only `layout...@-->` layout-constraint edges are explicitly excluded from this rule because they are not semantic relations.

# External Surface mapping table

After the Mermaid diagram, create the External Surface View table.

| Ref | External path | Meaning in simple terms | External evidence / surface | Relevant code areas | Confidence | Notes |
| --- | ------------- | ----------------------- | --------------------------- | ------------------- | ---------- | ----- |

The path must describe the semantic hierarchy from the External Surface root toward the specific interaction.

Example:

`E1 → E2 → E5`

Describe this view only from the external perspective.

Do not explain Functional or Operations mappings here.

# Functional mapping table

Then create the Functional View table.

| Ref | Functional path | Meaning in simple terms | Relevant code areas | Confidence | Notes |
| --- | --------------- | ----------------------- | ------------------- | ---------- | ----- |

The path should make the node's location in the Functional hierarchy unambiguous.

Example:

`F1 → F2 → F5`

Describe only the functional meaning or guarantee here.

Do not explain External Surface or Operations mappings in this table.

# Operations mapping table

Then create the Operations View table.

| Ref | Operations path | Operational responsibility in simple terms | Relevant code areas | Confidence | Notes |
| --- | --------------- | ------------------------------------------ | ------------------- | ---------- | ----- |

Semantic paths must always be written root-first even though Mermaid Operations hierarchy statements are written child-first for layout.

Example:

`O1 → O2 → O5`

Describe only the operational responsibility here.

Do not explain External Surface or Functional mappings in this table.

# External-to-Functional relation table

Then create:

## External ↔ Functional Relations

Use relation references:

`EF1`, `EF2`, `EF3`, ...

| Ref | External Ref | Functional Ref | Relation | Meaning in simple terms | Confidence | Evidence |
| --- | ------------ | -------------- | -------- | ----------------------- | ---------- | -------- |

Possible relation meanings may include:

* exposes
* configures
* controls
* invokes
* depends on
* provides access to
* represents
* observes
* supplies input to
* relies on

Choose the relation meaning from the actual code evidence.

Do not put these labels on Mermaid edges.

# Functional-to-Operations relation table

Then create:

## Functional ↔ Operations Relations

Use relation references:

`FO1`, `FO2`, `FO3`, ...

| Ref | Functional Ref | Operations Ref | Relation | Meaning in simple terms | Confidence | Evidence |
| --- | -------------- | -------------- | -------- | ----------------------- | ---------- | -------- |

Possible relation meanings may include:

* administered through
* observed through
* maintained through
* controlled through
* configured through
* recovered through
* sustained by
* operationally supported by
* monitored by
* guarded operationally by
* repaired through
* cleaned up through
* coordinated operationally by

Choose the relation meaning from the actual code evidence.

Do not put these labels on Mermaid edges.

# Keep all description layers separate

Treat the output as five distinct information layers.

## External Surface description layer

Contains only information about `E...` nodes.

Describe:

* what is externally visible
* what can be invoked, configured, supplied, observed, or relied upon
* which external consumer or integration surface it belongs to
* where this is evidenced in the code

Do not explain Functional or Operations mappings here.

## Functional description layer

Contains only information about `F...` nodes.

Describe:

* what the capability or guarantee is
* what the system provides, prevents, preserves, or ensures
* how it fits into the functional hierarchy
* where it is evidenced in code

Do not explain external exposure or Operations mapping here.

## Operations description layer

Contains only information about `O...` nodes.

Describe:

* what operational responsibility exists
* how the running system can be administered, observed, maintained, controlled, recovered, or sustained
* how it fits into the Operations hierarchy
* where it is evidenced in code

Do not explain external exposure or Functional mapping here.

## External-to-Functional relationship layer

Contains only information about how `E...` nodes relate to `F...` nodes.

Uses `EF...` references.

## Functional-to-Operations relationship layer

Contains only information about how `F...` nodes relate to `O...` nodes.

Uses `FO...` references.

This separation is essential.

Any of the three view definitions should be replaceable later without redefining the other views.

The relation logic should depend only on the two views it connects.

# Optional observations

After the tables, add a short section only when meaningful structural patterns are visible.

Keep observations separated by scope.

## External Surface observations

Only observations about the external surface.

Examples:

* several APIs represent one external capability
* a configuration surface is much broader than the observable runtime surface
* a capability exists but has no clear external exposure
* one external configuration controls several otherwise independent behaviors

Use `E...` references.

## Functional observations

Only observations about the Functional View.

Examples:

* one capability contains several independently meaningful guarantees
* two behaviors share a parent but differ substantially in lifecycle
* a security boundary deserves its own node because it represents a separate guarantee

Use `F...` references.

## Operations observations

Only observations about the Operations View.

Examples:

* one operational area contains both application-level administration and technical operability
* a recovery responsibility is distinct from ordinary runtime administration
* the system has substantial observability but little direct operator control
* maintenance is largely automated rather than exposed to administrators
* a runtime safeguard deserves its own node because it represents a distinct operational responsibility
* the codebase exposes little or no meaningful application-level operations behavior

Use `O...` references.

## External ↔ Functional observations

Only observations that emerge from `EF...` mappings.

Examples:

* several external surfaces converge on one capability
* one external operation spans several functional capabilities
* a functional capability has no direct external exposure
* multiple consumer types access the same capability differently
* one external configuration surface controls several functional guarantees

## Functional ↔ Operations observations

Only observations that emerge from `FO...` mappings.

Examples:

* one capability has several distinct operational responsibilities
* several capabilities converge on one shared operational mechanism
* a functional guarantee has a dedicated recovery responsibility
* an important capability has no special operational controls
* runtime administration cuts across several otherwise independent capabilities
* operational and functional boundaries differ significantly
* a small operational safeguard supports a disproportionately important guarantee
* observability spans functional areas that otherwise have little in common

Do not use observations as a substitute for missing relation rows.

# Final review

Before returning the result, review each layer separately.

## External Surface View

1. Does the view describe the system from outside its implementation boundary?
2. Has the view accidentally become a public class or method inventory?
3. Has a user journey or chronological process been mistaken for an external surface hierarchy?
4. Are external interactions grouped under meaningful shared concepts?
5. Are siblings at comparable abstraction levels?
6. Are different external consumer types only introduced when supported by evidence?
7. Are implementation details absent unless externally relevant?
8. Would an external consumer recognize the concepts in this view?
9. Have externally meaningful distinctions been preserved when they differ by configuration, lifecycle, policy, security, or neighboring Functional mappings?

## Functional View

10. Are there multiple top-level nodes that should share a parent?
11. Are siblings operating at different abstraction levels?
12. Are several nodes merely different aspects of the same broader capability?
13. Has code structure been mistaken for functional structure?
14. Are technical details placed too high?
15. Are concrete functions being presented as fundamental capabilities?
16. Could a group be explained more clearly by introducing a simpler shared concept?
17. Are variants of the same capability recognizable as variants?
18. Have independently meaningful behaviors been collapsed even though they differ in lifecycle, policy, security, recovery, or Operations mappings?
19. If two behaviors map differently to the Operations View, should they remain separate nodes under a shared parent?
20. Are explicit containment, isolation, authorization, trust, validation, integrity, atomicity, fallback, persistence, or recovery guarantees represented when they form distinct system behavior?
21. Has any meaningful security or correctness guarantee disappeared merely because it is technically enforced inside another mechanism?

## Operations View

22. Does the view describe meaningful responsibilities of the running system rather than implementation structure?
23. Has the view accidentally become an administrator-only copy of the External Surface View?
24. Are operator or administrator roles introduced only when supported by evidence?
25. Is an item operational because it materially helps administer, observe, maintain, control, recover, or sustain the system rather than merely because an operator can access it?
26. Has the view accidentally become build, deployment, hosting, infrastructure, or CI/CD documentation?
27. Has a chronological operational procedure been mistaken for an Operations hierarchy?
28. Are observability, administration, maintenance, control, recovery, and continuity distinctions preserved when they represent independently meaningful responsibilities?
29. Are technical mechanisms grouped into meaningful operational responsibilities rather than copied directly from classes, services, files, or libraries?
30. Are operational nodes at comparable abstraction levels?
31. Is the Operations View allowed to remain small when the codebase provides little meaningful operational behavior?
32. Are application-level administration and technical operability distinguished when the difference is meaningful?
33. Are recovery, fallback, continuity, maintenance, or operational-security responsibilities preserved when they form distinct operational behavior?

## External ↔ Functional Relations

34. Has every materially supported External-to-Functional relationship between existing nodes been considered?
35. Are one-to-many and many-to-one mappings preserved?
36. Was any valid relation suppressed because an ancestor or descendant already has one?
37. Does every `E -.- F` Mermaid edge have exactly one `EF...` relation row?
38. Does every `EF...` row have exactly one Mermaid edge?
39. Are unsupported or speculative mappings excluded?

## Functional ↔ Operations Relations

40. Has every materially supported Functional-to-Operations relationship between existing nodes been considered?
41. Are one-to-many, many-to-one, and cross-cutting operational relationships preserved?
42. Was any valid relation suppressed because a parent or descendant already has one?
43. Does every `F -.- O` Mermaid edge have exactly one `FO...` relation row?
44. Does every `FO...` row have exactly one Mermaid edge?
45. Are unsupported or merely incidental mappings excluded?
46. Have capabilities without special operational responsibilities been allowed to remain unmapped?
47. Have operational mechanisms without a material Functional correspondence been allowed to remain unmapped rather than forcing artificial relations?
48. Are distinct recovery, maintenance, control, observability, or continuity responsibilities mapped to the Functional nodes they materially concern?

## Separation

49. Was the External Surface View derived independently rather than copied from the Functional View?
50. Was the Functional View derived independently rather than inferred from either neighboring view?
51. Was the Operations View derived independently rather than copied from External Surface or Functional nodes?
52. Are administrator-facing External Surface interactions kept conceptually separate from operational responsibilities?
53. Are cross-view explanations confined to their relation layers?
54. Are there no direct External-to-Operations relations?
55. Could any one of the three view definitions be replaced without fundamentally rewriting the other two?

## Diagram

56. Is the External Surface View on the left?
57. Is the Functional View in the middle?
58. Is the Operations View on the right?
59. Does the External hierarchy grow toward the Functional View?
60. Does the Operations hierarchy grow toward the Functional View?
61. Are `*E...`, `*F...`, and `*O...` references visible and consistent?
62. Are hierarchy edges visually distinct from cross-view relation edges?
63. Are cross-view relation edges unlabeled?
64. Does the diagram expose useful many-to-many structures without explanatory text on the relation edges?
65. Is the diagram still reasonably readable on a normal screen?
66. Does the generated layout-constraint chain follow the currently configured left-to-right view order, with exactly one invisible directed layout constraint between each adjacent pair of views?
67. Are all `layout...@-->` edges presentation-only, visually invisible, and excluded from semantic relation tables and relation consistency checks?

The goal is not to produce three complete inventories.

The goal is to create a **compressed semantic model of the codebase from three independent perspectives**:

**External Surface View: what the outside world can interact with**

**Functional View: what those interactions and behaviors mean as system capabilities and guarantees**

**Operations View: how the running system can be administered, observed, maintained, controlled, recovered, and sustained**

The relation layers then expose how the perspectives correspond without collapsing them into one structure.

Preserve meaningful distinctions whenever collapsing them would hide different lifecycle, policy, security, containment, isolation, validation, recovery, external-surface, operational, or neighboring-view relationships.

In particular, do not allow an explicit system guarantee to disappear merely because it is technically enforced inside a broader mechanism.

Do not allow an operational responsibility to disappear merely because it happens to be exposed through an ordinary external interface or implemented through a broader runtime component.

The resulting artifact should be useful both for humans and for LLMs as a compact entry point for understanding the codebase.
