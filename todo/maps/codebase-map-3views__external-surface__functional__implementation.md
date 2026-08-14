Analyze the codebase and create a compact three-view codebase comprehension map.

The result should contain three independently derived views of the same codebase:

**External Surface View**
What does the system expose to the outside world?

**Functional View**
What capabilities does the system provide and how do those capabilities relate functionally?

**Implementation View**
How is the system technically structured to provide those capabilities?

The three views must remain conceptually separate.

Their definitions are isolated below so that any individual view can later be replaced by another kind of view without changing the logic of the remaining views or the relation layers.

The intended conceptual progression is:

**Outside → Meaning → Inside**

or:

**External Surface → Functional Capability → Implementation**

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

# View C Definition: Implementation View

The Implementation View answers:

**How is the system technically structured to provide its behavior?**

Independently identify the major technical building blocks that implement the system.

Group implementation elements into meaningful structural units based on technical responsibility, cohesion, and implementation boundaries.

Look for concepts such as:

* major components
* subsystems
* modules
* services
* adapters
* infrastructure areas
* shared implementation mechanisms
* important implementation boundaries
* security boundaries
* validation boundaries
* lifecycle boundaries
* external dependency boundaries

Do not simply reproduce the folder or namespace tree.

Files, folders, namespaces, classes, and packages are evidence for the implementation structure, but should only become nodes when they represent a meaningful technical responsibility or boundary.

A component may span multiple files, folders, or namespaces.

Several small implementation units may form one meaningful component.

Prefer a compressed technical model over a complete source tree.

Where useful, distinguish between:

* system or subsystem
* component
* technical responsibility
* implementation mechanism
* concrete implementation unit
* security or validation boundary
* lifecycle responsibility
* dependency boundary

These are guidance, not a rigid schema.

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
* Is one actually a specialization, variant, realization, exposure, guarantee, or part of another?
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
* implementation responsibility
* neighboring-view mappings

A distinction is especially worth preserving when two concepts map differently to nodes in an adjacent view.

For example, if two functional behaviors belong to the same broader capability but are realized by different implementation areas, keep them as separate functional nodes under their shared parent rather than collapsing them into one broad node.

Likewise, if two external interactions expose different aspects of the same capability, keep them separate when that distinction materially improves the External-to-Functional mapping.

Do not add detail merely for completeness.

Preserve detail when it carries structural meaning.

## Preserve explicit system guarantees

Treat explicit guarantees as independently meaningful behaviors when they enforce a distinct property of the system.

In particular, do not absorb a meaningful guarantee into a generic configuration or implementation node merely because the guarantee happens to be implemented through validation.

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

If the guarantee is enforced by a distinct technical responsibility, also preserve that responsibility in the Implementation View.

A security or validation behavior should not disappear merely because it is implemented inside a broader configuration parser, adapter, service, or state object.

## Consider alternative groupings

Do not automatically accept the first plausible hierarchy.

For important areas, consider whether another grouping would explain the structure more clearly or with fewer concepts.

Prefer the structure that explains the most with the fewest clear and meaningful terms.

If two groupings are similarly plausible, mention the alternative briefly rather than forcing artificial certainty.

# Keep all three views independent

Derive all three views independently from the code.

Do not create the External Surface View by simply selecting public members from the Implementation View.

Do not create the Functional View by renaming External Surface nodes.

Do not create the Implementation View by mechanically translating the Functional View.

Do not alter the structure of one view merely to make it align visually or conceptually with another.

Their structures are expected to differ.

This difference is valuable information.

For example:

* several external interactions may map to one functional capability
* one external interaction may involve several functional capabilities
* one functional capability may span several implementation areas
* one implementation component may support several unrelated capabilities
* one external configuration surface may influence several different functional guarantees
* one functional guarantee may be enforced across several implementation boundaries

First complete all three views independently.

Only afterwards identify the relationships between them.

# Naming

Use short, understandable names.

For the External Surface View, describe nodes in terms of **what an external consumer can interact with or rely on**.

For the Functional View, describe nodes in terms of **what the system can do or guarantee**.

For the Implementation View, describe nodes in terms of **what technical responsibility they fulfill**.

Internal class, method, file, namespace, or package names may be used as supporting evidence, but should not automatically determine node names.

Keep Mermaid labels concise.

Put detailed explanations into the corresponding tables.

# References

Assign every relevant node a short stable reference.

External Surface View references use:

`E1`, `E2`, `E3`, ...

Functional View references use:

`F1`, `F2`, `F3`, ...

Implementation View references use:

`I1`, `I2`, `I3`, ...

These references must remain consistent across:

* Mermaid diagram
* External Surface mapping table
* Functional mapping table
* Implementation mapping table
* relation tables
* observations

Show the reference inside the Mermaid node label using a small textual marker:

`*E1`

`*F1`

`*I1`

For example:

```
E1["External Surface *E1"]
E2["Configure system *E2"]

F1["System capabilities *F1"]
F2["Capability A *F2"]

I1["System implementation *I1"]
I2["Component A *I2"]
```

The reference is only an identifier.

It is not part of the actual surface, capability, or component name.

# Uncertainty

Stay close to what can actually be supported by the code.

Do not invent external use cases merely because an API could theoretically be used that way.

Do not invent product behavior merely because an implementation could theoretically support it.

Do not invent architectural boundaries that are not supported by the code.

If something is clearly present but its role is uncertain, keep it only when useful and mark the uncertainty in the corresponding table.

# Mermaid output

First produce all three views together in one Mermaid diagram.

Use:

```
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

```
OUTSIDE                                                   INSIDE

External Surface View       Functional View       Implementation View

        E                         F                       I

 what is exposed?          what does it mean?       how is it built?
```

The External Surface View should appear on the left.

The Functional View should occupy the middle.

The Implementation View should appear on the right.

Treat this as the configured left-to-right view order for the current product version.

## External Surface hierarchy orientation

Write External Surface hierarchy edges parent-first:

```
parent --- child
```

This should make the External Surface hierarchy grow from the outside-left toward the Functional View.

Example:

```
E1 --- E2
E2 --- E3
```

## Functional hierarchy orientation

Write Functional hierarchy edges parent-first:

```
parent --- child
```

Keep the Functional View as the semantic middle layer.

Do not restructure the Functional hierarchy merely to improve relation alignment.

Example:

```
F1 --- F2
F2 --- F3
```

## Implementation hierarchy orientation

Write Implementation hierarchy edges child-first:

```
child --- parent
```

This is intentionally reversed only for Mermaid layout purposes.

It should place the Implementation root toward the far right while its more detailed implementation nodes face toward the Functional View.

Example:

```
I3 --- I2
I2 --- I1
```

Because `---` is undirected, this reversed statement order must not be interpreted as ownership direction, dependency direction, execution flow, or data flow.

Semantic Implementation paths must still always be described root-first in the mapping table.

# Mermaid structure

Use three separate subgraphs:

```
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


    subgraph IMPLEMENTATION["Implementation View"]

        I1["Implementation *I1"]

        I4["Subsystem A1 *I4"] --- I2["Component A *I2"]
        I5["Validation boundary A2 *I5"] --- I2

        I2 --- I1
        I3["Component B *I3"] --- I1
    end


    EXTERNAL layout1@--> FUNCTIONAL
    FUNCTIONAL layout2@--> IMPLEMENTATION

    classDef layoutConstraint opacity:0;
    class layout1,layout2 layoutConstraint;


    E4 -.- F4
    E5 -.- F5

    F4 -.- I4
    F5 -.- I5
```

The `layout1`, `layout2`, ... edges are layout constraints only.

After defining the view subgraphs, create exactly one directed layout-constraint edge from each view subgraph to the next view subgraph in the currently configured left-to-right view order.

Generate the layout-constraint chain from the current view order rather than from fixed view names or a fixed number of views.

For three configured views `A → B → C`, the layout chain has two constraints:

```
A layout1@--> B
B layout2@--> C
```

For four configured views `A → B → C → D`, the layout chain has three constraints:

```
A layout1@--> B
B layout2@--> C
C layout3@--> D
```

Assign all layout-constraint edges to the dedicated `layoutConstraint` class and make them visually invisible:

```
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

**Functional ↔ Implementation**

Do not create direct:

**External Surface ↔ Implementation**

relations.

The Functional View is intentionally the semantic bridge between outside behavior and internal realization.

A direct External-to-Implementation mapping may be added later as a separate derived view if explicitly requested.

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

# Functional-to-Implementation relation discovery

Only perform this step after the Functional View and Implementation View have both been independently completed.

For every relevant Functional node, examine which Implementation nodes materially contribute to realizing or enforcing it.

For every relevant Implementation node, examine which Functional nodes it materially contributes to.

The purpose of this layer is to reveal:

* one functional node implemented by several implementation nodes
* several functional nodes sharing one implementation node
* functional behavior distributed across several technical areas
* technical components serving several functional areas
* guarantees enforced across several technical boundaries
* implementation boundaries that support only one narrow guarantee
* validation responsibilities that enforce functional behavior rather than merely parse input

Record every materially supported relationship between existing nodes.

Do not compress the relation set merely to make the diagram cleaner.

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

| RefExternal pathMeaning in simple termsExternal evidence / surfaceRelevant code areasConfidenceNotes |
| ---------------------------------------------------------------------------------------------------- |

The path must describe the semantic hierarchy from the External Surface root toward the specific interaction.

Example:

`E1 → E2 → E5`

Describe this view only from the external perspective.

Do not explain Functional or Implementation mappings here.

# Functional mapping table

Then create the Functional View table.

| RefFunctional pathMeaning in simple termsRelevant code areasConfidenceNotes |
| --------------------------------------------------------------------------- |

The path should make the node's location in the Functional hierarchy unambiguous.

Example:

`F1 → F2 → F5`

Describe only the functional meaning or guarantee here.

Do not explain External Surface or Implementation mappings in this table.

# Implementation mapping table

Then create the Implementation View table.

| RefImplementation pathTechnical responsibility in simple termsRelevant code areasConfidenceNotes |
| ------------------------------------------------------------------------------------------------ |

Semantic paths must always be written root-first even though Mermaid Implementation hierarchy statements are written child-first for layout.

Example:

`I1 → I2 → I5`

Describe only the technical responsibility here.

Do not explain External Surface or Functional mappings in this table.

# External-to-Functional relation table

Then create:

## External ↔ Functional Relations

Use relation references:

`EF1`, `EF2`, `EF3`, ...

| RefExternal RefFunctional RefRelationMeaning in simple termsConfidenceEvidence |
| ------------------------------------------------------------------------------ |

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

# Functional-to-Implementation relation table

Then create:

## Functional ↔ Implementation Relations

Use relation references:

`FI1`, `FI2`, `FI3`, ...

| RefFunctional RefImplementation RefRelationMeaning in simple termsConfidenceEvidence |
| ------------------------------------------------------------------------------------ |

Possible relation meanings may include:

* implemented by
* supported by
* realized by
* provided through
* technically enabled by
* shared implementation
* enforced by
* validated by
* guarded by
* persisted by
* coordinated by

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

Do not explain internal capability or implementation mappings here.

## Functional description layer

Contains only information about `F...` nodes.

Describe:

* what the capability or guarantee is
* what the system provides, prevents, preserves, or ensures
* how it fits into the functional hierarchy
* where it is evidenced in code

Do not explain external exposure or implementation mapping here.

## Implementation description layer

Contains only information about `I...` nodes.

Describe:

* what technical responsibility the component or boundary has
* how it fits into the implementation hierarchy
* where it is evidenced in code

Do not explain external exposure or functional mapping here.

## External-to-Functional relationship layer

Contains only information about how `E...` nodes relate to `F...` nodes.

Uses `EF...` references.

## Functional-to-Implementation relationship layer

Contains only information about how `F...` nodes relate to `I...` nodes.

Uses `FI...` references.

This separation is essential.

Any of the three views should be replaceable later without redefining the other views.

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

## Implementation observations

Only observations about the Implementation View.

Examples:

* one technical subsystem contains several distinct responsibilities
* a security or validation boundary is implemented inside a broader component
* an external dependency forms an important architectural boundary

Use `I...` references.

## External ↔ Functional observations

Only observations that emerge from `EF...` mappings.

Examples:

* several external surfaces converge on one capability
* one external operation spans several functional capabilities
* a functional capability has no direct external exposure
* multiple consumer types access the same capability differently
* one external configuration surface controls several functional guarantees

## Functional ↔ Implementation observations

Only observations that emerge from `FI...` mappings.

Examples:

* one functional capability is distributed across many implementation areas
* one implementation component supports many capabilities
* several capabilities converge on one shared mechanism
* functional and technical boundaries differ significantly
* a functional security guarantee is enforced by a small but distinct implementation boundary
* a behavior that looks simple from outside requires several runtime responsibilities

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
18. Have independently meaningful behaviors been collapsed even though they differ in lifecycle, policy, security, recovery, or Implementation mappings?
19. If two behaviors map differently to the Implementation View, should they remain separate nodes under a shared parent?
20. Are explicit containment, isolation, authorization, trust, validation, integrity, atomicity, fallback, persistence, or recovery guarantees represented when they form distinct system behavior?
21. Has any meaningful security or correctness guarantee disappeared merely because it is implemented as validation inside another component?

## Implementation View

22. Is the view merely reproducing folders, namespaces, or classes?
23. Are implementation nodes grouped by meaningful technical responsibility?
24. Are several implementation mechanisms actually part of one larger component?
25. Are components and low-level details incorrectly placed as siblings?
26. Could the technical structure be compressed further without losing meaningful boundaries?
27. Have meaningful technical boundaries disappeared even though they represent different security, lifecycle, configuration, dependency, or Functional mappings?
28. Are explicit validation, containment, security, lifecycle, and external dependency boundaries preserved when they represent distinct technical responsibilities?

## External ↔ Functional Relations

29. Has every materially supported External-to-Functional relationship between existing nodes been considered?
30. Are one-to-many and many-to-one mappings preserved?
31. Was any valid relation suppressed because an ancestor or descendant already has one?
32. Does every `E -.- F` Mermaid edge have exactly one `EF...` relation row?
33. Does every `EF...` row have exactly one Mermaid edge?
34. Are unsupported or speculative mappings excluded?

## Functional ↔ Implementation Relations

35. Has every materially supported Functional-to-Implementation relationship between existing nodes been considered?
36. Are one-to-many, many-to-one, and distributed implementations preserved?
37. Was any valid relation suppressed because a parent or descendant already has one?
38. Does every `F -.- I` Mermaid edge have exactly one `FI...` relation row?
39. Does every `FI...` row have exactly one Mermaid edge?
40. Are unsupported or merely incidental mappings excluded?
41. Are distinct guarantees mapped to the technical responsibilities that actually enforce them?

## Separation

42. Was the External Surface View derived independently rather than copied from the Functional View?
43. Was the Functional View derived independently rather than inferred from either neighboring view?
44. Was the Implementation View derived independently rather than copied from the Functional View?
45. Are cross-view explanations confined to their relation layers?
46. Are there no direct External-to-Implementation relations?
47. Could any one of the three view definitions be replaced without fundamentally rewriting the other two?

## Diagram

48. Is the External Surface View on the left?
49. Is the Functional View in the middle?
50. Is the Implementation View on the right?
51. Does the External hierarchy grow toward the Functional View?
52. Does the Implementation hierarchy grow toward the Functional View?
53. Are `*E...`, `*F...`, and `*I...` references visible and consistent?
54. Are hierarchy edges visually distinct from cross-view relation edges?
55. Are cross-view relation edges unlabeled?
56. Does the diagram expose useful many-to-many structures without explanatory text on the relation edges?
57. Is the diagram still reasonably readable on a normal screen?
58. Does the generated layout-constraint chain follow the currently configured left-to-right view order, with exactly one invisible directed layout constraint between each adjacent pair of views?
59. Are all `layout...@-->` edges presentation-only, visually invisible, and excluded from semantic relation tables and relation consistency checks?

The goal is not to produce three complete inventories.

The goal is to create a **compressed semantic model of the codebase from three independent perspectives**:

**External Surface View: what the outside world can interact with**

**Functional View: what those interactions and behaviors mean as system capabilities and guarantees**

**Implementation View: how those capabilities and guarantees are technically realized**

The relation layers then expose how the perspectives correspond without collapsing them into one structure.

Preserve meaningful distinctions whenever collapsing them would hide different lifecycle, policy, security, containment, isolation, validation, recovery, external-surface, or implementation relationships.

In particular, do not allow an explicit system guarantee to disappear merely because it is implemented as validation inside a broader component.

The resulting artifact should be useful both for humans and for LLMs as a compact entry point for understanding the codebase.
