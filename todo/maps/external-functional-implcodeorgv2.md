Analyze the codebase and create a compact four-view codebase comprehension map.

The result should contain four independently derived views of the same codebase:

**External Surface View**
What does the system expose to the outside world?

**Functional View**
What capabilities does the system provide and how do those capabilities relate functionally?

**Implementation View**
How is the system technically structured to provide those capabilities?

**Code Organization View**
Where in the codebase are the system's meaningful capabilities and responsibilities located?

The four views must remain conceptually separate.

Each view must also remain independently complete at the level of detail appropriate to that view.

Derive each view as if it had to stand on its own as a useful representation of the codebase from that perspective.

The presence of additional views must not reduce the structure, distinctions, or useful detail that a view would otherwise contain.

Their definitions are isolated below so that any individual view can later be replaced by another kind of view without changing the logic of the remaining views or unrelated relation layers.

The intended conceptual structure is:

```
                         Implementation
                       ↗
External → Functional
                       ↘
                         Code Organization

```

or:

**External Surface → Functional Capability → Technical Realization**

and independently:

**Functional Capability → Code Location**

The Functional View is the semantic center of this product configuration.

Implementation and Code Organization are parallel perspectives.

Do not treat them as successive stages.

Do not derive one view mechanically from another.

This structure also defines the current Mermaid layout topology.

If a later version replaces, adds, removes, or reconnects views, derive Mermaid layout constraints from that version's configured view topology. Do not assume that all views must form one linear chain.

# View A Definition: External Surface View

The External Surface View answers:

**What can an external consumer observe, invoke, configure, provide, receive, depend on, or interact with without understanding the internal implementation?**

"External consumer" is intentionally broad.

Depending on the codebase, it may include:

- application developers
- library consumers
- end users
- administrators
- operators
- external services
- API clients
- plugins
- command-line users
- configuration authors
- runtime clients
- deployment environments

Do not assume which consumer types exist. Derive them from the codebase.

## External perspective

Describe the system strictly from outside its implementation boundary.

Look for externally meaningful surfaces such as:

- public APIs
- externally callable operations
- configuration surfaces
- extension points
- commands
- endpoints
- events
- inputs and outputs
- integration contracts
- exposed behaviors
- externally visible state
- externally controllable policies
- supported interaction modes

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

- external surface
- consumer-facing area
- interaction capability
- exposed operation
- configuration surface
- external variant
- observable behavior

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

- files
- folders
- namespaces
- classes
- interfaces
- services
- packages
- technical layers

These are evidence, not the desired structure.

A capability may be distributed across multiple files, modules, or components.

Likewise, a technical module should not automatically become a feature.

Where useful, distinguish between:

- core capability
- sub-capability
- variant or realization
- concrete function or usage
- behavioral guarantee
- security or isolation guarantee

These are guidance, not a rigid schema.

# View C Definition: Implementation View

The Implementation View answers:

**How is the system technically structured to provide its behavior?**

Independently identify the major technical building blocks that implement the system.

Group implementation elements into meaningful structural units based on technical responsibility, cohesion, and implementation boundaries.

Look for concepts such as:

- major components
- subsystems
- modules
- services
- adapters
- infrastructure areas
- shared implementation mechanisms
- important implementation boundaries
- security boundaries
- validation boundaries
- lifecycle boundaries
- external dependency boundaries

Do not simply reproduce the folder or namespace tree.

Files, folders, namespaces, classes, and packages are evidence for the implementation structure, but should only become nodes when they represent a meaningful technical responsibility or boundary.

A component may span multiple files, folders, or namespaces.

Several small implementation units may form one meaningful component.

Prefer a compressed technical model over a complete source tree.

Where useful, distinguish between:

- system or subsystem
- component
- technical responsibility
- implementation mechanism
- concrete implementation unit
- security or validation boundary
- lifecycle responsibility
- dependency boundary

These are guidance, not a rigid schema.

# View D Definition: Code Organization View

The Code Organization View answers:

**Where in the codebase are the system's meaningful capabilities and responsibilities located?**

Independently identify the source areas that provide useful navigation anchors for understanding, modifying, extending, testing, or tracing the system.

This view is intentionally code-organization-oriented.

Unlike the Functional and Implementation Views, source structure is primary evidence here.

Look for meaningful code locations such as:

- projects
- modules
- packages
- source directories
- namespaces
- source-area groupings
- key entry-point files
- important shared-code areas
- integration areas
- adapters
- configuration code areas
- test areas
- generated-code boundaries
- cross-cutting source areas
- important code ownership or responsibility boundaries

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

## Distinguish Code Organization from Implementation

Implementation and Code Organization answer different questions.

**Implementation:** What technical responsibility does this component fulfill?

**Code Organization:** Where should a developer look in the codebase?

Do not mechanically translate Implementation nodes into source locations.

Do not mechanically translate source locations into Implementation components.

A single Implementation component may span several Code Organization nodes.

A single Code Organization node may contain several Implementation responsibilities.

Their differences are valuable information.

## Not a complete source tree

Do not reproduce every:

- folder
- project
- package
- namespace
- file
- test class
- generated file

Compress source structure aggressively when several neighboring source elements form one useful navigation area.

Preserve source distinctions when they materially affect:

- where a developer would make a change
- where related code is located
- entry points
- extension points
- configuration ownership
- test ownership
- generated versus authored code
- dependency boundaries
- cross-cutting code
- neighboring Functional mappings

## Tests

Tests may appear when they form a meaningful code-navigation boundary.

Do not inventory test suites or individual test cases.

A test project, test module, integration-test area, fixture area, or similar source region may deserve a node when it materially helps a developer locate validation or regression coverage for capabilities represented elsewhere.

Do not assume every Functional node requires a corresponding test-area node.

## Code Organization hierarchy

Where useful, distinguish between:

- repository or codebase area
- project or module
- source responsibility area
- package or namespace area
- entry-point area
- shared-code area
- integration area
- test area
- generated-code area
- key navigation anchor

These are guidance, not a rigid schema.

Build the hierarchy from the evidence in the codebase.

# Shared hierarchy rules

Apply the following rules independently to all four views.

## Build meaningful hierarchies

Do not force a fixed number of levels.

The meaning and depth of each branch should emerge from the code.

Every parent-child relationship should express a meaningful grouping.

## Look for shared parents

Do not automatically treat every discovered item as a separate top-level node.

Whenever several neighboring items appear, ask:

- Do these belong together?
- Are they different aspects of a broader concept?
- Is there a simple common concept that explains them together?
- Is one actually a specialization, variant, realization, exposure, guarantee, technical responsibility, source area, navigation anchor, or part of another?
- Are different abstraction levels currently being placed next to each other?

If introducing a shared parent makes the structure clearer, introduce it.

Repeat this recursively for groups that have already been formed.

## Keep siblings at comparable abstraction levels

Sibling nodes should, as far as possible, represent the same kind of thing.

Avoid placing a broad concept next to a narrow detail.

If neighboring nodes differ significantly in abstraction level, check whether one belongs below another or whether a shared parent is missing.

## Preserve meaningful distinctions

Do not compress a view so far that independently meaningful distinctions disappear.

Keep separate nodes when two concepts differ materially in one or more of these ways:

- lifecycle
- policy
- security boundary
- trust boundary
- validation boundary
- authorization behavior
- isolation behavior
- containment behavior
- external behavior
- configuration surface
- operational behavior
- failure behavior
- recovery behavior
- runtime continuity
- implementation responsibility
- source location
- navigation boundary
- change location
- test ownership
- generated-code boundary
- neighboring-view mappings

A distinction is especially worth preserving when two concepts map differently to nodes in an adjacent view.

For example, if two functional behaviors belong to the same broader capability but are realized by different implementation areas, keep them separate under their shared Functional parent rather than collapsing them into one broad node.

Likewise, if two functional behaviors live in substantially different source areas, preserve them when collapsing them would hide materially different Functional-to-Code-Organization mappings.

Do not add detail merely for completeness.

Preserve detail when it carries structural meaning.

## Preserve explicit system guarantees

Treat explicit guarantees as independently meaningful behaviors when they enforce a distinct property of the system.

In particular, do not absorb a meaningful guarantee into a generic configuration or implementation node merely because the guarantee happens to be implemented through validation.

Look specifically for guarantees involving:

- containment
- isolation
- authorization
- trust
- access restrictions
- path or resource boundaries
- input acceptance rules
- integrity protection
- atomicity
- consistency
- fallback behavior
- last-known-good behavior
- recovery guarantees
- persistence guarantees
- compatibility boundaries

If such a guarantee answers a distinct question such as:

- "What is prevented?"
- "What remains isolated?"
- "What is guaranteed to remain valid?"
- "What boundary cannot be crossed?"
- "What happens when replacement fails?"
- "What state remains usable after failure?"

then consider representing it as its own Functional node.

If the guarantee is enforced by a distinct technical responsibility, also preserve that responsibility in the Implementation View.

If the guarantee is materially distributed across or localized within distinct source areas, preserve those independently meaningful locations in the Code Organization View.

A security or validation behavior should not disappear merely because it is implemented inside a broader configuration parser, adapter, service, state object, project, folder, or source area.

## Consider alternative groupings

Do not automatically accept the first plausible hierarchy.

For important areas, consider whether another grouping would explain the structure more clearly or with fewer concepts.

Prefer the structure that explains the most with the fewest clear and meaningful terms.

If two groupings are similarly plausible, mention the alternative briefly rather than forcing artificial certainty.

# Keep all four views independent

Derive all four views independently from the code.

Evaluate the necessary structure, distinctions, and level of detail of each view only against that view's own definition and the evidence in the codebase.

Each view must be sufficiently complete to remain useful if all other views were removed from the artifact.

Do not reduce the detail of one view merely because another view represents some of the same code, concepts, boundaries, responsibilities, or evidence more explicitly.

Do not compress, regroup, omit, or simplify a view merely to reduce overlap or redundancy with another view.

Do not remove a meaningful node or distinction from one view solely because similar information appears in another view.

Redundancy between independently derived views is allowed when the same codebase reality is independently meaningful from more than one perspective.

Such overlap is not itself a defect.

Differences in how independently complete views group or distinguish the same underlying code can be valuable information.

Do not create the External Surface View by simply selecting public members from another view.

Do not create the Functional View by renaming External Surface nodes.

Do not create the Implementation View by mechanically translating the Functional View.

Do not create the Code Organization View by translating Functional or Implementation nodes into folders, projects, or files.

Do not alter the structure of one view merely to make it align visually or conceptually with another.

Do not alter the structure of one view merely because another independently derived view now covers similar ground.

Their structures are expected to differ.

Their structures may also partially overlap.

Both outcomes can be meaningful.

This difference is valuable information.

For example:

- several external interactions may map to one functional capability
- one external interaction may involve several functional capabilities
- one functional capability may span several implementation areas
- one implementation component may support several unrelated capabilities
- one functional capability may span several source areas
- one source area may support several unrelated capabilities
- one implementation component may span several source locations
- one source location may contain several implementation responsibilities
- a capability may have a clear source entry point while its implementation spans several technical components
- technical and source-code boundaries may differ significantly
- a meaningful technical boundary and a meaningful source-navigation boundary may describe some of the same code without making either view redundant

First complete all four views independently.

Only afterwards identify the relationships between them.

Cross-view analysis may reveal that an independently derived view contains an actual mistake, unsupported distinction, or missed evidence.

Correct such an issue when justified by the code.

Do not revise a valid view merely to make the combined artifact less repetitive.

# Naming

Use short, understandable names.

For the External Surface View, describe nodes in terms of **what an external consumer can interact with or rely on**.

For the Functional View, describe nodes in terms of **what the system can do or guarantee**.

For the Implementation View, describe nodes in terms of **what technical responsibility they fulfill**.

For the Code Organization View, describe nodes in terms of **where meaningful code is located and what source area a developer should navigate to**.

Internal class, method, file, namespace, package, project, module, or directory names may be used as supporting evidence.

Actual source names may be used directly in the Code Organization View when they are useful navigation anchors.

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

Code Organization View references use:

`C1`, `C2`, `C3`, ...

These references must remain consistent across:

- Mermaid diagram
- External Surface mapping table
- Functional mapping table
- Implementation mapping table
- Code Organization mapping table
- relation tables
- observations

Show the reference inside the Mermaid node label using a small textual marker:

`*E1`

`*F1`

`*I1`

`*C1`

For example:

```
E1["External Surface *E1"]
F1["System capabilities *F1"]
I1["System implementation *I1"]
C1["Codebase *C1"]

```

The reference is only an identifier.

It is not part of the actual surface, capability, component, or source-area name.

# Uncertainty

Stay close to what can actually be supported by the code.

Do not invent external use cases merely because an API could theoretically be used that way.

Do not invent product behavior merely because an implementation could theoretically support it.

Do not invent architectural boundaries that are not supported by the code.

Do not invent source responsibilities merely because a directory, file, project, or namespace name suggests them.

If something is clearly present but its role is uncertain, keep it only when useful and mark the uncertainty in the corresponding table.

# Mermaid output

First produce all four views together in one Mermaid diagram.

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

The intended conceptual topology is:

```
                         Implementation View
                       ↗
External Surface → Functional
                       ↘
                         Code Organization View

```

The External Surface View should appear on the left.

The Functional View should appear to its right as the semantic center.

Both the Implementation View and Code Organization View should appear to the right of the Functional View as parallel perspectives.

Their relative vertical ordering is secondary.

Do not restructure any view merely to force Implementation above Code Organization or Code Organization above Implementation.

## External Surface hierarchy orientation

Write External Surface hierarchy edges parent-first:

```
parent --- child

```

This should make the External Surface hierarchy grow toward the Functional View.

## Functional hierarchy orientation

Write Functional hierarchy edges parent-first:

```
parent --- child

```

Keep the Functional View as the semantic center.

Do not restructure the Functional hierarchy merely to improve relation alignment.

## Implementation hierarchy orientation

Write Implementation hierarchy edges child-first:

```
child --- parent

```

This is intentionally reversed only for Mermaid layout purposes.

It should place the Implementation root toward the outer right while its more detailed implementation nodes face toward the Functional View.

Semantic Implementation paths must always be described root-first in the mapping table.

## Code Organization hierarchy orientation

Write Code Organization hierarchy edges child-first:

```
child --- parent

```

This is intentionally reversed only for Mermaid layout purposes.

It should place the Code Organization root toward the outer right while its more detailed source-area nodes face toward the Functional View.

Semantic Code Organization paths must always be described root-first in the mapping table.

Because `---` is undirected, reversed statement order in either right-side view must not be interpreted as ownership direction, dependency direction, execution flow, data flow, or source-navigation direction.

# Mermaid structure

Use four separate subgraphs:

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
        E2 --- E3["External interaction A1 *E3"]
    end


    subgraph FUNCTIONAL["Functional View"]

        F1["Functional Purpose *F1"]

        F1 --- F2["Capability A *F2"]
        F2 --- F3["Sub-capability A1 *F3"]
    end


    subgraph IMPLEMENTATION["Implementation View"]

        I1["Implementation *I1"]

        I3["Implementation area A1 *I3"] --- I2["Component A *I2"]
        I2 --- I1
    end


    subgraph CODE_ORGANIZATION["Code Organization View"]

        C1["Codebase *C1"]

        C3["Source area A1 *C3"] --- C2["Source area A *C2"]
        C2 --- C1
    end


    EXTERNAL layout1@--> FUNCTIONAL
    FUNCTIONAL layout2@--> IMPLEMENTATION
    FUNCTIONAL layout3@--> CODE_ORGANIZATION

    classDef layoutConstraint opacity:0;
    class layout1,layout2,layout3 layoutConstraint;


    E3 -.- F3

    F3 -.- I3
    F3 -.- C3

```

The `layout1`, `layout2`, ... edges are layout constraints only.

For this product configuration, the layout topology is:

```
EXTERNAL → FUNCTIONAL
FUNCTIONAL → IMPLEMENTATION
FUNCTIONAL → CODE_ORGANIZATION

```

Create one directed layout-constraint edge for each connection in the configured layout topology.

Do not force the view topology into one linear layout chain.

If several views branch from the same view, create separate layout constraints from that shared view to each branch.

If a later product version replaces, adds, removes, reorders, or reconnects views, regenerate the layout constraints from that version's configured view topology.

Do not hard-code the assumption that every product version has one left view, one middle view, and two right views.

Assign all layout-constraint edges to the dedicated `layoutConstraint` class and make them visually invisible:

```
classDef layoutConstraint opacity:0;
class layout1,layout2,layout3 layoutConstraint;

```

Extend or reduce the class assignment to exactly the generated layout edge IDs.

Do not use `~~~` to enforce view topology.

Layout-constraint edges:

- exist only to express configured Mermaid layout topology
- carry no semantic relationship
- are not hierarchy edges
- are not semantic cross-view relation edges
- have no relation references
- must not appear in relation tables
- are excluded from exact relation consistency rules

# Mermaid connection semantics

Use:

`---`

for hierarchy inside a view.

It means only:

**belongs under / is part of**

It must not imply:

- process flow
- execution order
- data flow
- dependency direction
- runtime direction
- source-navigation direction

Use:

`-.-`

for semantic relationships between views connected by an allowed relation layer.

Cross-view relation connections must:

- be undirected
- have no labels
- have no relation IDs on the line
- contain no explanatory text
- remain visually lightweight

All semantic details about these relationships belong in the relation tables.

Directed `layout...@-->` edges are a separate presentation-only mechanism.

They must never be interpreted as semantic cross-view relationships.

# Allowed cross-view relation layers

For this version, create three separate relation layers:

**External Surface ↔ Functional**

**Functional ↔ Implementation**

**Functional ↔ Code Organization**

Do not create direct:

**External Surface ↔ Implementation**

**External Surface ↔ Code Organization**

or:

**Implementation ↔ Code Organization**

relations.

Implementation and Code Organization are intentionally parallel perspectives connected independently to Functional.

A direct relation between them may be added later as a separate derived layer only if explicitly requested.

# External-to-Functional relation discovery

Only perform this step after the External Surface View and Functional View have both been independently completed.

For every relevant External Surface node, examine which Functional nodes materially explain or support that external surface.

For every relevant Functional node, examine which External Surface nodes expose, consume, control, configure, observe, or depend on it.

Record every materially supported relationship between existing nodes.

Do not compress the relation set merely to make the diagram cleaner.

# Functional-to-Implementation relation discovery

Only perform this step after the Functional View and Implementation View have both been independently completed.

For every relevant Functional node, examine which Implementation nodes materially contribute to realizing or enforcing it.

For every relevant Implementation node, examine which Functional nodes it materially contributes to.

The purpose of this layer is to reveal:

- one functional node implemented by several implementation nodes
- several functional nodes sharing one implementation node
- functional behavior distributed across several technical areas
- technical components serving several functional areas
- guarantees enforced across several technical boundaries
- implementation boundaries that support only one narrow guarantee
- validation responsibilities that enforce functional behavior rather than merely parse input

Record every materially supported relationship between existing nodes.

Do not compress the relation set merely to make the diagram cleaner.

# Functional-to-Code-Organization relation discovery

Only perform this step after the Functional View and Code Organization View have both been independently completed.

For every relevant Functional node, examine which Code Organization nodes materially contain, locate, anchor, test, configure, or otherwise provide useful source navigation for that capability or guarantee.

For every relevant Code Organization node, examine which Functional nodes materially live in, span, enter through, are tested in, or are otherwise meaningfully associated with that source area.

The purpose of this layer is to reveal:

- one functional capability distributed across several source areas
- several functional capabilities concentrated in one source area
- capabilities with a clear entry point and supporting code elsewhere
- shared source areas serving many capabilities
- guarantees whose enforcement code is located in a distinct source area
- capabilities with dedicated test or validation areas
- source areas that cut across otherwise unrelated functional capabilities
- code organization that differs significantly from functional organization

Record every materially supported relationship between existing nodes.

Do not connect a Functional node to every file or directory touched transitively by its implementation.

A Code Organization relation should materially help a developer know **where to look**.

# Do not inherit or suppress relations through hierarchy

Apply this rule independently to all three relation layers.

A relation between parent nodes does not automatically replace relations between their descendants.

A relation between descendant nodes does not automatically replace a valid relation between their parents.

Do not omit a relationship merely because:

- an ancestor is already connected
- a descendant is already connected
- a broader relation already exists
- another relation looks visually similar

The relation layers exist specifically to reveal one-to-many, many-to-one, and many-to-many structures.

# Do not infer relations across parallel views

A Functional-to-Implementation relation does not imply a Functional-to-Code-Organization relation.

A Functional-to-Code-Organization relation does not imply a Functional-to-Implementation relation.

Do not derive an Implementation-to-Code-Organization relationship indirectly through a shared Functional node.

The two right-side relation layers answer different questions and must be discovered independently.

# Do not invent relations

Completeness does not mean connecting everything.

Create a relation only when the code materially supports it.

Do not connect nodes merely because:

- they are close in their hierarchy
- they share a folder
- they share a project
- they interact incidentally
- one eventually reaches code somewhere below the other
- a technical component happens to live in a source area
- the connection seems theoretically plausible

A relation should materially help explain how the two views in that relation layer correspond.

# Use existing nodes

Do not create extra nodes solely to make cross-view relations easier to express.

Relations should connect nodes that were independently discovered as meaningful members of their own view.

If an existing abstraction is too coarse to express an important relationship, reconsider that view only if the missing node is independently meaningful within the view itself.

Do not create mapping-only nodes.

# Exact relation consistency

For all semantic relation layers:

**One Mermaid** **`-.-`** **cross-view relation edge = one relation-table row.**

And:

**One relation-table row = one Mermaid** **`-.-`** **cross-view relation edge.**

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

Do not explain mappings to other views here.

# Functional mapping table

Then create the Functional View table.

| RefFunctional pathMeaning in simple termsRelevant code areasConfidenceNotes |
| --------------------------------------------------------------------------- |

The path should make the node's location in the Functional hierarchy unambiguous.

Example:

`F1 → F2 → F5`

Describe only the functional meaning or guarantee here.

Do not explain mappings to other views in this table.

# Implementation mapping table

Then create the Implementation View table.

| RefImplementation pathTechnical responsibility in simple termsRelevant code areasConfidenceNotes |
| ------------------------------------------------------------------------------------------------ |

Semantic paths must always be written root-first even though Mermaid Implementation hierarchy statements are written child-first for layout.

Example:

`I1 → I2 → I5`

Describe only the technical responsibility here.

Do not explain Functional or Code Organization mappings in this table.

# Code Organization mapping table

Then create the Code Organization View table.

| RefCode Organization pathSource location in simple termsConcrete code locationsConfidenceNotes |
| ---------------------------------------------------------------------------------------------- |

Semantic paths must always be written root-first even though Mermaid Code Organization hierarchy statements are written child-first for layout.

Example:

`C1 → C2 → C5`

Describe only the source organization and navigation meaning here.

Use concrete project, module, package, directory, namespace, or file locations where useful.

Do not explain Functional or Implementation mappings in this table.

# External-to-Functional relation table

Then create:

## External ↔ Functional Relations

Use relation references:

`EF1`, `EF2`, `EF3`, ...

| RefExternal RefFunctional RefRelationMeaning in simple termsConfidenceEvidence |
| ------------------------------------------------------------------------------ |

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

- implemented by
- supported by
- realized by
- provided through
- technically enabled by
- shared implementation
- enforced by
- validated by
- guarded by
- persisted by
- coordinated by

Choose the relation meaning from the actual code evidence.

Do not put these labels on Mermaid edges.

# Functional-to-Code-Organization relation table

Then create:

## Functional ↔ Code Organization Relations

Use relation references:

`FC1`, `FC2`, `FC3`, ...

| RefFunctional RefCode Organization RefRelationMeaning in simple termsConfidenceEvidence |
| --------------------------------------------------------------------------------------- |

Possible relation meanings may include:

- located in
- primarily located in
- distributed across
- enters through
- configured in
- validated in
- tested in
- shares source area
- supported by code in
- cross-cuts

Choose the relation meaning from the actual code evidence.

Do not put these labels on Mermaid edges.

# Keep all description layers separate

Treat the output as seven distinct information layers.

## External Surface description layer

Contains only information about `E...` nodes.

Do not explain mappings to other views here.

## Functional description layer

Contains only information about `F...` nodes.

Do not explain mappings to other views here.

## Implementation description layer

Contains only information about `I...` nodes.

Describe technical responsibilities and boundaries only.

Do not explain Functional or Code Organization mappings here.

## Code Organization description layer

Contains only information about `C...` nodes.

Describe source locations and navigation boundaries only.

Do not explain Functional or Implementation mappings here.

## External-to-Functional relationship layer

Contains only information about how `E...` nodes relate to `F...` nodes.

Uses `EF...` references.

## Functional-to-Implementation relationship layer

Contains only information about how `F...` nodes relate to `I...` nodes.

Uses `FI...` references.

## Functional-to-Code-Organization relationship layer

Contains only information about how `F...` nodes relate to `C...` nodes.

Uses `FC...` references.

This separation is essential.

Implementation and Code Organization must not collapse into one another merely because both describe internal aspects of the codebase.

The detail level of one description layer must not be reduced merely because another description layer contains overlapping evidence or concepts.

# Optional observations

After the tables, add a short section only when meaningful structural patterns are visible.

Keep observations separated by scope.

## External Surface observations

Only observations about the external surface.

Use `E...` references.

## Functional observations

Only observations about the Functional View.

Use `F...` references.

## Implementation observations

Only observations about technical structure.

Use `I...` references.

## Code Organization observations

Only observations about source organization.

Use `C...` references.

## External ↔ Functional observations

Only observations that emerge from `EF...` mappings.

## Functional ↔ Implementation observations

Only observations that emerge from `FI...` mappings.

## Functional ↔ Code Organization observations

Only observations that emerge from `FC...` mappings.

Examples:

- one capability is distributed across many source areas
- several capabilities converge on one shared code area
- a capability has one obvious entry point but substantial supporting code elsewhere
- a functional guarantee is enforced in a surprisingly small source area
- functional and source boundaries align closely
- functional and source boundaries differ substantially

## Parallel-view observations

Only when genuinely useful, add a brief subsection for structural patterns visible because both right-side relation layers exist.

Do not create new direct relations between Implementation and Code Organization.

Examples:

- a functionally unified capability is implemented by one component but scattered across several source areas
- one technical component spans several distinct code-navigation areas
- several technical components are colocated in one source area
- Implementation boundaries and Code Organization boundaries align unusually closely
- Implementation and source-layout boundaries differ substantially

Such observations must be derived from the existing `FI...` and `FC...` mappings.

They must not substitute for an Implementation ↔ Code Organization relation layer.

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
18. Have independently meaningful behaviors been collapsed even though they differ in lifecycle, policy, security, recovery, Implementation mappings, or Code Organization mappings?
19. If two behaviors map differently to either right-side view, should they remain separate nodes under a shared parent?
20. Are explicit containment, isolation, authorization, trust, validation, integrity, atomicity, fallback, persistence, or recovery guarantees represented when they form distinct system behavior?
21. Has any meaningful security or correctness guarantee disappeared merely because it is implemented or located inside another area?

## Implementation View

22. Is the view merely reproducing folders, namespaces, projects, or classes?
23. Are implementation nodes grouped by meaningful technical responsibility?
24. Are several implementation mechanisms actually part of one larger component?
25. Are components and low-level details incorrectly placed as siblings?
26. Could the technical structure be compressed further without losing meaningful boundaries?
27. Have meaningful technical boundaries disappeared even though they represent different security, lifecycle, configuration, dependency, or Functional mappings?
28. Are explicit validation, containment, security, lifecycle, and external dependency boundaries preserved when they represent distinct technical responsibilities?
29. Has the Implementation View been distorted merely to resemble the Code Organization View?

## Code Organization View

30. Does the view answer where meaningful code is located?
31. Has the view accidentally become a complete repository or folder tree?
32. Are projects, modules, directories, namespaces, packages, and files included because they form useful navigation boundaries rather than merely because they exist?
33. Would a developer know where to begin looking for important parts of the system from this view?
34. Have several low-level source locations been grouped when they form one meaningful navigation area?
35. Have source areas remained separate when a developer would genuinely navigate to or modify them independently?
36. Are key entry points preserved when they materially improve navigation?
37. Are individual files avoided unless they are unusually important navigation anchors?
38. Are test areas included only when they materially improve understanding of where validation or regression coverage lives?
39. Is generated code distinguished from authored code when that distinction materially affects navigation or modification?
40. Has architectural responsibility been invented merely to make source organization align with Implementation?
41. Are siblings at comparable source-organizational abstraction levels?
42. Has the Code Organization View been distorted merely to resemble the Implementation View?

## External ↔ Functional Relations

43. Has every materially supported External-to-Functional relationship between existing nodes been considered?
44. Are one-to-many and many-to-one mappings preserved?
45. Was any valid relation suppressed because an ancestor or descendant already has one?
46. Does every `E -.- F` Mermaid edge have exactly one `EF...` relation row?
47. Does every `EF...` row have exactly one Mermaid edge?
48. Are unsupported or speculative mappings excluded?

## Functional ↔ Implementation Relations

49. Has every materially supported Functional-to-Implementation relationship between existing nodes been considered?
50. Are one-to-many, many-to-one, and distributed implementations preserved?
51. Was any valid relation suppressed because a parent or descendant already has one?
52. Does every `F -.- I` Mermaid edge have exactly one `FI...` relation row?
53. Does every `FI...` row have exactly one Mermaid edge?
54. Are unsupported or merely incidental mappings excluded?
55. Are distinct guarantees mapped to the technical responsibilities that actually enforce them?

## Functional ↔ Code Organization Relations

56. Has every materially supported Functional-to-Code-Organization relationship between existing nodes been considered?
57. Are one-to-many, many-to-one, and distributed source-location mappings preserved?
58. Was any valid relation suppressed because a parent or descendant already has one?
59. Does every `F -.- C` Mermaid edge have exactly one `FC...` relation row?
60. Does every `FC...` row have exactly one Mermaid edge?
61. Are incidental file-level relationships excluded?
62. Does each relation materially help answer where a developer should look?
63. Are capabilities spanning multiple source areas mapped to all materially relevant areas?
64. Are shared source areas allowed to map to several unrelated capabilities?

## Parallel right-side views

65. Was Implementation derived independently from Code Organization?
66. Was Code Organization derived independently from Implementation?
67. Has either right-side view been simplified, compressed, regrouped, or reorganized merely because the other view contains overlapping information?
68. Has either right-side view been simplified or reorganized merely to align with the other?
69. Are differences between technical boundaries and source boundaries preserved rather than normalized away?
70. Is meaningful overlap between Implementation and Code Organization allowed when independently justified by each view?
71. Are there no direct Implementation-to-Code-Organization Mermaid relations?
72. Are any observations comparing the two derived only from their independent Functional mappings?

## Separation

73. Was the External Surface View derived independently rather than copied from the Functional View?
74. Was the Functional View derived independently rather than inferred from any neighboring view?
75. Was the Implementation View derived independently rather than copied from the Functional View or Code Organization View?
76. Was the Code Organization View derived independently rather than translated from Functional or Implementation nodes?
77. Would each view still be sufficiently complete and useful at its current detail level if the other three views were removed?
78. Has any view been compressed, regrouped, omitted from, or simplified merely because another view contains overlapping information?
79. Has any meaningful node or distinction been removed solely because another view represents similar information?
80. Are cross-view explanations confined to their relation layers?
81. Are there no direct External-to-Implementation relations?
82. Are there no direct External-to-Code-Organization relations?
83. Could either right-side view be removed or replaced without redefining the other right-side view?

## Diagram

84. Is the External Surface View on the left?
85. Is the Functional View positioned as the semantic center immediately to its right?
86. Are both Implementation and Code Organization positioned to the right of Functional as parallel views?
87. Has either right-side view accidentally been positioned semantically after the other?
88. Does the External hierarchy grow toward Functional?
89. Do both right-side hierarchies grow toward Functional?
90. Are `*E...`, `*F...`, `*I...`, and `*C...` references visible and consistent?
91. Are hierarchy edges visually distinct from semantic cross-view relation edges?
92. Are semantic cross-view relation edges unlabeled?
93. Does the diagram expose useful many-to-many structures without explanatory text on the edges?
94. Is the diagram still reasonably readable on a normal screen?
95. Does the generated layout-constraint topology match the configured view topology?
96. Is there exactly one presentation-only layout constraint from External to Functional?
97. Is there exactly one presentation-only layout constraint from Functional to Implementation?
98. Is there exactly one presentation-only layout constraint from Functional to Code Organization?
99. Are all `layout...@-->` edges visually invisible and excluded from semantic relation tables and relation consistency checks?
100. Has the diagram avoided forcing the two parallel right-side views into a false semantic sequence?

The goal is not to produce four complete inventories.

The goal is to create a **compressed semantic model of the codebase from four independent perspectives**:

**External Surface View: what the outside world can interact with**

**Functional View: what those interactions and behaviors mean as system capabilities and guarantees**

**Implementation View: how those capabilities and guarantees are technically realized**

**Code Organization View: where a developer should look in the codebase to understand, modify, extend, or test those capabilities**

Each view should be independently useful and independently complete at its appropriate level of semantic compression.

The existence of another view must not be used as a reason to remove otherwise meaningful structure or detail.

Overlap between views is acceptable when the same codebase reality is independently meaningful from different perspectives.

The Functional View acts as the semantic bridge to two different internal questions:

**How is it built internally?**

and:

**Where is it in the code?**

Do not collapse these questions into one view.

The resulting artifact should be useful both for humans and for LLMs as a compact entry point for understanding and working with the codebase.