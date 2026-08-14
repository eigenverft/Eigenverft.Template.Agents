Analyze the codebase and create a compact three-view codebase comprehension map.

The result should contain three independently derived views of the same codebase:

**External Surface View**
What does the system expose to the outside world?

**Functional View**
What capabilities does the system provide and how do those capabilities relate functionally?

**Code Organization View**
Where in the codebase are the system's meaningful capabilities and responsibilities located?

The three views must remain conceptually separate.

Their definitions are isolated below so that any individual view can later be replaced by another kind of view without changing the logic of the remaining views or the relation layers.

The intended conceptual progression is:

**Outside → Meaning → Location**

or:

**External Surface → Functional Capability → Code Organization**

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

# View C Definition: Code Organization View

The Code Organization View answers:

**Where in the codebase are the system's meaningful capabilities and responsibilities located?**

Independently identify the source areas that provide useful navigation anchors for understanding, modifying, extending, testing, or tracing the system.

This view is intentionally code-organization-oriented.

Unlike the Functional View, source structure is primary evidence here.

Look for meaningful code locations such as:

* projects
* modules
* packages
* source directories
* namespaces
* source-area groupings
* key entry-point files
* important shared-code areas
* integration areas
* adapters
* configuration code areas
* test areas
* generated-code boundaries
* cross-cutting source areas
* important code ownership or responsibility boundaries

Do not simply reproduce the repository tree.

A directory, project, namespace, package, or file should become a node only when it forms a useful navigation or responsibility boundary.

Ask:

**If a developer needed to understand or change this part of the system, is this a meaningful place in the codebase to look?**

Several directories or namespaces may form one meaningful code area.

One project may contain several independently meaningful code areas.

One capability may span several source areas.

One source area may contain code supporting several capabilities.

A single key file may deserve its own node when it is an unusually important navigation anchor, entry point, composition point, or boundary.

Do not inventory files merely because they exist.

## Navigation perspective

Describe code organization in terms that help a developer orient themselves in the source.

The view may represent actual codebase names more directly than the other views when those names are useful navigation anchors.

For example, a project, module, package, namespace, or directory name may be the clearest node name when a developer can directly search for or navigate to it.

However, do not preserve source names mechanically when a simple grouped name would provide a clearer navigation model.

The purpose is not to rename the repository.

The purpose is to compress it into a useful map of **where meaningful code lives**.

## Not an Implementation View

Do not turn the Code Organization View into an architectural or implementation-responsibility model.

The Implementation View asks:

**What technical responsibility does this component fulfill?**

The Code Organization View asks:

**Where should a developer look in the codebase?**

A single implementation responsibility may be distributed across several code areas.

A single source area may contain several implementation responsibilities.

Do not invent architectural components merely to make the source layout look cleaner.

Do not hide meaningful source boundaries merely because they do not correspond neatly to architectural components.

## Not a complete source tree

Do not reproduce every:

* folder
* project
* package
* namespace
* file
* test class
* generated file

Compress source structure aggressively when several neighboring source elements form one useful navigation area.

Preserve source distinctions when they materially affect:

* where a developer would make a change
* where related code is located
* entry points
* extension points
* configuration ownership
* test ownership
* generated versus authored code
* dependency boundaries
* cross-cutting code
* neighboring Functional mappings

## Tests

Tests may appear when they form a meaningful code-navigation boundary.

Do not inventory test suites or individual test cases.

A test project, test module, integration-test area, fixture area, or similar source region may deserve a node when it materially helps a developer locate validation or regression coverage for capabilities represented elsewhere.

Do not assume every Functional node requires a corresponding test-area node.

## Code Organization hierarchy

Where useful, distinguish between:

* repository or codebase area
* project or module
* source responsibility area
* package or namespace area
* entry-point area
* shared-code area
* integration area
* test area
* generated-code area
* key navigation anchor

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
* Is one actually a specialization, variant, realization, exposure, guarantee, source area, navigation anchor, or part of another?
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
* source location
* navigation boundary
* change location
* test ownership
* generated-code boundary
* neighboring-view mappings

A distinction is especially worth preserving when two concepts map differently to nodes in an adjacent view.

For example, if two functional behaviors belong to the same broader capability but live in substantially different source areas, keep them as separate functional nodes under their shared parent when collapsing them would hide materially different Functional-to-Code-Organization mappings.

Likewise, if two external interactions expose different aspects of the same capability, keep them separate when that distinction materially improves the External-to-Functional mapping.

Within the Code Organization View, preserve separate nodes when source areas materially differ in where a developer would inspect, modify, extend, or test the relevant code.

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

If a guarantee is materially distributed across or localized within distinct source areas, preserve those independently meaningful locations in the Code Organization View.

Do not create Code Organization nodes solely because a guarantee exists.

A source area should remain independently useful as a navigation concept.

A security or validation behavior should not disappear from the Functional View merely because its code lives inside a broader source area.

## Consider alternative groupings

Do not automatically accept the first plausible hierarchy.

For important areas, consider whether another grouping would explain the structure more clearly or with fewer concepts.

Prefer the structure that explains the most with the fewest clear and meaningful terms.

If two groupings are similarly plausible, mention the alternative briefly rather than forcing artificial certainty.

# Keep all three views independent

Derive all three views independently from the code.

Do not create the External Surface View by simply selecting public members from the Code Organization View.

Do not create the Functional View by renaming External Surface nodes.

Do not create the Code Organization View by translating Functional nodes into folders or projects.

Do not alter the structure of one view merely to make it align visually or conceptually with another.

Their structures are expected to differ.

This difference is valuable information.

For example:

* several external interactions may map to one functional capability
* one external interaction may involve several functional capabilities
* one functional capability may span several source areas
* one source area may support several unrelated capabilities
* one capability may have a clear entry point but substantial supporting code elsewhere
* one source area may contain both runtime code and configuration or composition code
* test code may be organized differently from the production capability it validates
* a cross-cutting source area may map to many Functional nodes
* source organization may differ substantially from functional organization

First complete all three views independently.

Only afterwards identify the relationships between them.

# Naming

Use short, understandable names.

For the External Surface View, describe nodes in terms of **what an external consumer can interact with or rely on**.

For the Functional View, describe nodes in terms of **what the system can do or guarantee**.

For the Code Organization View, describe nodes in terms of **where meaningful code is located and what source area a developer should navigate to**.

Actual project, module, package, namespace, directory, or file names may be used when they are useful navigation anchors.

Keep Mermaid labels concise.

Put detailed explanations into the corresponding tables.

# References

Assign every relevant node a short stable reference.

External Surface View references use:

`E1`, `E2`, `E3`, ...

Functional View references use:

`F1`, `F2`, `F3`, ...

Code Organization View references use:

`C1`, `C2`, `C3`, ...

These references must remain consistent across:

* Mermaid diagram
* External Surface mapping table
* Functional mapping table
* Code Organization mapping table
* relation tables
* observations

Show the reference inside the Mermaid node label using a small textual marker:

`*E1`

`*F1`

`*C1`

For example:

```text
E1["External Surface *E1"]
E2["Configure system *E2"]

F1["System capabilities *F1"]
F2["Capability A *F2"]

C1["Codebase *C1"]
C2["Application source *C2"]
```

The reference is only an identifier.

It is not part of the actual surface, capability, or code-area name.

# Uncertainty

Stay close to what can actually be supported by the code.

Do not invent external use cases merely because an API could theoretically be used that way.

Do not invent product behavior merely because an implementation could theoretically support it.

Do not invent source responsibilities merely because a directory or project name suggests them.

Do not assume a file is an important navigation anchor merely because it is large or central in the dependency graph.

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
OUTSIDE                                                   CODE

External Surface View       Functional View       Code Organization View

        E                         F                         C

 what is exposed?          what does it mean?        where is it?
```

The External Surface View should appear on the left.

The Functional View should occupy the middle.

The Code Organization View should appear on the right.

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

## Code Organization hierarchy orientation

Write Code Organization hierarchy edges child-first:

```text
child --- parent
```

This is intentionally reversed only for Mermaid layout purposes.

It should place the Code Organization root toward the far right while its more detailed source-area nodes face toward the Functional View.

Example:

```text
C3 --- C2
C2 --- C1
```

Because `---` is undirected, this reversed statement order must not be interpreted as ownership direction, dependency direction, execution flow, data flow, or source-navigation order.

Semantic Code Organization paths must still always be described root-first in the mapping table.

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


    subgraph CODE_ORGANIZATION["Code Organization View"]

        C1["Codebase *C1"]

        C4["Source area A1 *C4"] --- C2["Source area A *C2"]
        C5["Test or support area A2 *C5"] --- C2

        C2 --- C1
        C3["Source area B *C3"] --- C1
    end


    EXTERNAL layout1@--> FUNCTIONAL
    FUNCTIONAL layout2@--> CODE_ORGANIZATION

    classDef layoutConstraint opacity:0;
    class layout1,layout2 layoutConstraint;


    E4 -.- F4
    E5 -.- F5

    F4 -.- C4
    F5 -.- C5
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

They must never be interpreted as semantic cross-view relationships, process flow, execution order, data flow, dependency direction, runtime direction, or source-navigation order.

# Allowed cross-view relation layers

For this version, create two separate relation layers:

**External Surface ↔ Functional**

and:

**Functional ↔ Code Organization**

Do not create direct:

**External Surface ↔ Code Organization**

relations.

The Functional View is intentionally the semantic bridge between outside behavior and source-code location in this product configuration.

A direct External-to-Code-Organization mapping may be added later as a separate derived view if explicitly requested.

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

# Functional-to-Code-Organization relation discovery

Only perform this step after the Functional View and Code Organization View have both been independently completed.

For every relevant Functional node, examine which Code Organization nodes materially contain, locate, anchor, test, configure, or otherwise provide useful source navigation for that capability or guarantee.

For every relevant Code Organization node, examine which Functional nodes materially live in, span, enter through, are tested in, or are otherwise meaningfully associated with that source area.

The purpose of this layer is to reveal:

* one functional capability distributed across several source areas
* several functional capabilities concentrated in one source area
* capabilities with a clear entry point and supporting code elsewhere
* shared source areas serving many capabilities
* guarantees whose enforcement code is located in a distinct source area
* capabilities with dedicated test or validation areas
* source areas that cut across otherwise unrelated functional capabilities
* code organization that differs significantly from functional organization

Record every materially supported relationship between existing nodes.

Do not compress the relation set merely to make the diagram cleaner.

Do not connect a Functional node to every file or directory touched transitively by its implementation.

A Code Organization relation should materially help a developer know **where to look**.

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
* they share a project
* a file imports another file
* one eventually calls code somewhere in another area
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

Do not explain Functional or Code Organization mappings here.

# Functional mapping table

Then create the Functional View table.

| Ref | Functional path | Meaning in simple terms | Relevant code areas | Confidence | Notes |
| --- | --------------- | ----------------------- | ------------------- | ---------- | ----- |

The path should make the node's location in the Functional hierarchy unambiguous.

Example:

`F1 → F2 → F5`

Describe only the functional meaning or guarantee here.

Do not explain External Surface or Code Organization mappings in this table.

# Code Organization mapping table

Then create the Code Organization View table.

| Ref | Code Organization path | Source location in simple terms | Concrete code locations | Confidence | Notes |
| --- | ---------------------- | ------------------------------- | ----------------------- | ---------- | ----- |

Semantic paths must always be written root-first even though Mermaid Code Organization hierarchy statements are written child-first for layout.

Example:

`C1 → C2 → C5`

Describe only the source organization and navigation meaning here.

Use concrete project, module, package, directory, namespace, or file locations where useful.

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

# Functional-to-Code-Organization relation table

Then create:

## Functional ↔ Code Organization Relations

Use relation references:

`FC1`, `FC2`, `FC3`, ...

| Ref | Functional Ref | Code Organization Ref | Relation | Meaning in simple terms | Confidence | Evidence |
| --- | -------------- | --------------------- | -------- | ----------------------- | ---------- | -------- |

Possible relation meanings may include:

* located in
* primarily located in
* distributed across
* enters through
* configured in
* validated in
* tested in
* shares source area
* supported by code in
* cross-cuts

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

Do not explain Functional or Code Organization mappings here.

## Functional description layer

Contains only information about `F...` nodes.

Describe:

* what the capability or guarantee is
* what the system provides, prevents, preserves, or ensures
* how it fits into the functional hierarchy
* where it is evidenced in code

Do not explain external exposure or Code Organization mapping here.

## Code Organization description layer

Contains only information about `C...` nodes.

Describe:

* where meaningful code is located
* what source area or navigation boundary the node represents
* what concrete projects, modules, directories, namespaces, packages, or files belong to it
* how it fits into the Code Organization hierarchy

Do not explain external exposure or Functional mapping here.

## External-to-Functional relationship layer

Contains only information about how `E...` nodes relate to `F...` nodes.

Uses `EF...` references.

## Functional-to-Code-Organization relationship layer

Contains only information about how `F...` nodes relate to `C...` nodes.

Uses `FC...` references.

This separation is essential.

Any of the three view definitions should be replaceable later without redefining the other views.

The relation logic should depend only on the two views it connects.

# Optional observations

After the tables, add a short section only when meaningful structural patterns are visible.

Keep observations separated by scope.

## External Surface observations

Only observations about the external surface.

Use `E...` references.

## Functional observations

Only observations about the Functional View.

Use `F...` references.

## Code Organization observations

Only observations about source organization.

Examples:

* one project contains several independently meaningful source areas
* one capability-oriented source area spans several directories
* important behavior is concentrated in a small number of entry-point files
* tests are organized differently from the production code they validate
* source structure closely follows functional structure
* source structure differs significantly from functional structure
* a shared code area cuts across many otherwise independent responsibilities

Use `C...` references.

## External ↔ Functional observations

Only observations that emerge from `EF...` mappings.

## Functional ↔ Code Organization observations

Only observations that emerge from `FC...` mappings.

Examples:

* one capability is distributed across many source areas
* several capabilities converge on one shared code area
* a capability has one obvious entry point but substantial supporting code elsewhere
* a functional guarantee is enforced in a surprisingly small source area
* functional and source boundaries align closely
* functional and source boundaries differ substantially
* test coverage for one capability is concentrated in a distinct source area

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
18. Have independently meaningful behaviors been collapsed even though they differ in lifecycle, policy, security, recovery, or Code Organization mappings?
19. If two behaviors map differently to the Code Organization View, should they remain separate nodes under a shared parent?
20. Are explicit containment, isolation, authorization, trust, validation, integrity, atomicity, fallback, persistence, or recovery guarantees represented when they form distinct system behavior?
21. Has any meaningful security or correctness guarantee disappeared merely because its code is located inside another source area?

## Code Organization View

22. Does the view answer where meaningful code is located?
23. Has the view accidentally become a complete repository or folder tree?
24. Are projects, modules, directories, namespaces, packages, and files included because they form useful navigation boundaries rather than merely because they exist?
25. Would a developer know where to begin looking for important parts of the system from this view?
26. Have several low-level source locations been grouped when they form one meaningful navigation area?
27. Have source areas remained separate when a developer would genuinely navigate to or modify them independently?
28. Are key entry points preserved when they materially improve navigation?
29. Are individual files avoided unless they are unusually important navigation anchors?
30. Are test areas included only when they materially improve understanding of where validation or regression coverage lives?
31. Is generated code distinguished from authored code when that distinction materially affects navigation or modification?
32. Has architectural responsibility been invented merely to make source organization cleaner?
33. Are siblings at comparable source-organizational abstraction levels?
34. Are cross-cutting source areas preserved when they materially support several capabilities?

## External ↔ Functional Relations

35. Has every materially supported External-to-Functional relationship between existing nodes been considered?
36. Are one-to-many and many-to-one mappings preserved?
37. Was any valid relation suppressed because an ancestor or descendant already has one?
38. Does every `E -.- F` Mermaid edge have exactly one `EF...` relation row?
39. Does every `EF...` row have exactly one Mermaid edge?
40. Are unsupported or speculative mappings excluded?

## Functional ↔ Code Organization Relations

41. Has every materially supported Functional-to-Code-Organization relationship between existing nodes been considered?
42. Are one-to-many, many-to-one, and distributed source-location mappings preserved?
43. Was any valid relation suppressed because a parent or descendant already has one?
44. Does every `F -.- C` Mermaid edge have exactly one `FC...` relation row?
45. Does every `FC...` row have exactly one Mermaid edge?
46. Are incidental file-level relationships excluded?
47. Does each relation materially help answer where a developer should look for the capability or guarantee?
48. Are capabilities spanning multiple source areas mapped to all materially relevant areas?
49. Are shared source areas allowed to map to several unrelated capabilities?
50. Are test or validation areas mapped only where they materially help locate coverage for a Functional node?

## Separation

51. Was the External Surface View derived independently rather than copied from the Functional View?
52. Was the Functional View derived independently rather than inferred from either neighboring view?
53. Was the Code Organization View derived independently rather than generated by translating Functional nodes into source paths?
54. Are cross-view explanations confined to their relation layers?
55. Are there no direct External-to-Code-Organization relations?
56. Could any one of the three view definitions be replaced without fundamentally rewriting the other two?

## Diagram

57. Is the External Surface View on the left?
58. Is the Functional View in the middle?
59. Is the Code Organization View on the right?
60. Does the External hierarchy grow toward the Functional View?
61. Does the Code Organization hierarchy grow toward the Functional View?
62. Are `*E...`, `*F...`, and `*C...` references visible and consistent?
63. Are hierarchy edges visually distinct from cross-view relation edges?
64. Are cross-view relation edges unlabeled?
65. Does the diagram expose useful many-to-many structures without explanatory text on the relation edges?
66. Is the diagram still reasonably readable on a normal screen?
67. Does the generated layout-constraint chain follow the currently configured left-to-right view order, with exactly one invisible directed layout constraint between each adjacent pair of views?
68. Are all `layout...@-->` edges presentation-only, visually invisible, and excluded from semantic relation tables and relation consistency checks?

The goal is not to produce three complete inventories.

The goal is to create a **compressed semantic model of the codebase from three independent perspectives**:

**External Surface View: what the outside world can interact with**

**Functional View: what those interactions and behaviors mean as system capabilities and guarantees**

**Code Organization View: where a developer should look in the codebase to understand, modify, extend, or test those capabilities**

The relation layers then expose how the perspectives correspond without collapsing them into one structure.

Preserve meaningful distinctions whenever collapsing them would hide different lifecycle, policy, security, containment, isolation, validation, recovery, external-surface, source-location, navigation, test-ownership, or neighboring-view relationships.

In particular, do not allow an explicit system guarantee to disappear merely because its implementation happens to be located inside a broader source area.

Do not allow a meaningful source-navigation boundary to disappear merely because it does not correspond neatly to a Functional node.

The resulting artifact should be useful both for humans and for LLMs as a compact entry point for understanding and working with the codebase.
