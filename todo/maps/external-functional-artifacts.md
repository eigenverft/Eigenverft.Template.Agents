Analyze the codebase and create a compact three-view codebase comprehension map.

The result should contain three independently derived views of the same codebase:

**External Surface View**
What does the system expose to the outside world?

**Functional View**
What capabilities does the system provide and how do those capabilities relate functionally?

**Artifacts View**
What meaningful software artifacts does the codebase consume, depend on, assemble, produce, or package, and how is the codebase organized around those artifacts?

The three views must remain conceptually separate.

Their definitions are isolated below so that any individual view can later be replaced by another kind of view without changing the logic of the remaining views or the relation layers.

The intended conceptual progression is:

**Outside → Meaning → Artifacts**

or:

**External Surface → Functional Capability → Artifacts**

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

# View C Definition: Artifacts View

The Artifacts View answers:

**What meaningful software artifacts does the codebase consume, depend on, assemble, produce, or package, and how is the codebase organized around those artifacts?**

Independently identify the meaningful software artifacts that define what enters, supports, results from, or is packaged by the codebase.

"Artifact" is intentionally broader than "build output."

Depending on the codebase, relevant artifacts may include:

* executable applications
* command-line binaries
* services or workers
* libraries
* reusable packages
* plugin packages
* generated bundles
* compiled modules
* project outputs
* referenced libraries
* package dependencies
* native dependencies
* generated code or generated resources
* configuration files copied or packaged with an output
* schemas
* templates
* static assets
* images
* scripts
* resource folders
* runtime support files
* content files
* test or validation artifacts
* other files or packages that materially belong to a produced or consumed software artifact

Do not assume which artifact types exist.

Derive them from the codebase.

## Artifact perspective

Describe the codebase in terms of meaningful software artifacts and artifact boundaries.

Ask questions such as:

**What concrete software things does this codebase depend on, assemble, produce, package, or carry with its outputs?**

**Which parts of the codebase materially belong to which artifact?**

**Which supporting files or resources are part of an artifact even though they are not executable code?**

**Which referenced or supplied artifacts form meaningful boundaries for what the codebase can build or provide?**

An artifact should not automatically become a node merely because a file exists.

A package reference should not automatically become a node merely because it appears in a project file.

An executable, library, image, settings file, asset folder, package, or test assembly should not automatically become a node merely because it is generated or copied.

Instead ask:

**Does this represent a meaningful artifact, artifact group, dependency boundary, packaged resource, or produced software unit that helps explain the codebase?**

Several files may form one meaningful artifact.

Several projects may contribute to one artifact.

One project may contribute to several artifacts.

One artifact may contain executable code plus supporting settings, templates, static assets, schemas, images, scripts, native files, or other resources.

A meaningful external library or package may represent an artifact boundary when the codebase materially depends on it.

## Do not force an incoming/outgoing hierarchy

Artifacts may be consumed by the codebase, produced by the codebase, packaged into another artifact, or used only to support validation or assembly.

Direction is useful evidence, but it is not a mandatory hierarchy.

Do not automatically create top-level branches such as:

`Incoming Artifacts`

and:

`Outgoing Artifacts`

merely because some artifacts are consumed and others are produced.

Use such grouping only when it is independently meaningful for the codebase.

The hierarchy should emerge from meaningful artifact relationships and boundaries.

For example, a produced executable and the configuration, static assets, native libraries, or templates packaged with it may belong together under one shared artifact concept.

Likewise, several external libraries may belong under one meaningful dependency-artifact boundary when they collectively provide one distinct reusable platform or integration dependency.

## Not a build-process view

Do not turn the Artifacts View into a chronological build process.

Avoid structures such as:

`Restore → Compile → Test → Package → Publish`

The Artifacts View describes **what meaningful artifacts exist and how the codebase is organized around them**, not the sequence of commands used to create them.

Build files, solution files, workspace definitions, project files, package manifests, lock files, scripts, and build configuration are important evidence for discovering artifact structure.

They should not automatically become Artifacts nodes merely because they control the build.

Instead use them to answer questions such as:

* what produces an artifact?
* what belongs to an artifact?
* what references another artifact?
* what is packaged together?
* what output type exists?
* what supporting content is copied or generated?
* which artifacts are applications, libraries, tests, plugins, tools, or supporting resources?

## Not deployment documentation

Do not infer deployment architecture merely because an artifact can theoretically be deployed.

An executable is still an artifact even when the codebase contains no deployment definition.

A package is still an artifact even when its publication mechanism is unknown.

A container image may be an artifact when the codebase materially defines or produces it, but do not expand from that fact into runtime infrastructure, hosting topology, environments, orchestration, or operational procedures unless another view explicitly asks for those concepts.

## Tests and validation artifacts

Do not automatically inventory tests.

A test project, validation executable, fixture package, generated test resource, or similar element belongs in the Artifacts View only when it forms a meaningful artifact or artifact-support boundary.

Do not describe individual test cases or testing behavior merely because test code exists.

Ask:

**Does this testing or validation element materially help explain what the codebase builds, depends on, or produces?**

If yes, represent it at the appropriate compressed artifact level.

## Artifact hierarchy

Where useful, distinguish between:

* artifact family
* runnable artifact
* reusable artifact
* supporting artifact
* packaged resource
* dependency artifact
* generated artifact
* validation artifact
* artifact group
* artifact boundary
* artifact-specific supporting content

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
* Is one actually a specialization, variant, realization, exposure, guarantee, artifact, supporting resource, dependency, or part of another?
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
* artifact boundary
* packaging behavior
* dependency boundary
* neighboring-view mappings

A distinction is especially worth preserving when two concepts map differently to nodes in an adjacent view.

For example, if two functional behaviors belong to the same broader capability but are materially carried by different artifacts, keep them as separate functional nodes under their shared parent when collapsing them would hide different Functional-to-Artifacts mappings.

Likewise, if two external interactions expose different aspects of the same capability, keep them separate when that distinction materially improves the External-to-Functional mapping.

Within the Artifacts View, preserve separate artifact nodes when two artifacts differ materially in role, packaging, dependency boundary, runtime identity, reuse boundary, validation role, or neighboring Functional mappings.

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

If a distinct artifact boundary materially carries, constrains, packages, supplies, or separates that guarantee, preserve that artifact distinction independently in the Artifacts View.

Do not force an Artifacts node for every Functional guarantee.

An artifact should exist only when it is independently meaningful from the Artifacts perspective.

A security or validation behavior should not disappear from the Functional View merely because it is implemented or packaged inside a broader artifact.

## Consider alternative groupings

Do not automatically accept the first plausible hierarchy.

For important areas, consider whether another grouping would explain the structure more clearly or with fewer concepts.

Prefer the structure that explains the most with the fewest clear and meaningful terms.

If two groupings are similarly plausible, mention the alternative briefly rather than forcing artificial certainty.

# Keep all three views independent

Derive all three views independently from the code.

Do not create the External Surface View by simply selecting public members from another view.

Do not create the Functional View by renaming External Surface nodes.

Do not create the Artifacts View by translating Functional nodes into executable names.

Do not create the Artifacts View by reproducing the solution, workspace, project, package, or folder tree.

Do not alter the structure of one view merely to make it align visually or conceptually with another.

Their structures are expected to differ.

This difference is valuable information.

For example:

* several external interactions may map to one functional capability
* one external interaction may involve several functional capabilities
* one functional capability may be carried by several artifacts
* one artifact may provide or support several unrelated capabilities
* several projects may combine into one runnable artifact
* one project may contribute to several artifacts
* a produced executable may include supporting configuration, resources, schemas, images, or native files
* a functional capability may materially depend on a reusable external artifact
* a test or validation artifact may support several functional areas without itself being an externally meaningful capability
* artifact boundaries may differ substantially from source-code module boundaries

First complete all three views independently.

Only afterwards identify the relationships between them.

# Naming

Use short, understandable names.

For the External Surface View, describe nodes in terms of **what an external consumer can interact with or rely on**.

For the Functional View, describe nodes in terms of **what the system can do or guarantee**.

For the Artifacts View, describe nodes in terms of **what meaningful software artifact, artifact group, packaged resource, or dependency boundary exists**.

Internal class, method, namespace, folder, project, package, file, or output names may be used as supporting evidence, but should not automatically determine node names.

When a concrete artifact name is itself the clearest meaningful name, it may be used.

Keep Mermaid labels concise.

Put detailed explanations into the corresponding tables.

# References

Assign every relevant node a short stable reference.

External Surface View references use:

`E1`, `E2`, `E3`, ...

Functional View references use:

`F1`, `F2`, `F3`, ...

Artifacts View references use:

`A1`, `A2`, `A3`, ...

These references must remain consistent across:

* Mermaid diagram
* External Surface mapping table
* Functional mapping table
* Artifacts mapping table
* relation tables
* observations

Show the reference inside the Mermaid node label using a small textual marker:

`*E1`

`*F1`

`*A1`

For example:

```text
E1["External Surface *E1"]
E2["Configure system *E2"]

F1["System capabilities *F1"]
F2["Capability A *F2"]

A1["Codebase Artifacts *A1"]
A2["Runnable Application *A2"]
```

The reference is only an identifier.

It is not part of the actual surface, capability, or artifact name.

# Uncertainty

Stay close to what can actually be supported by the codebase.

For the Artifacts View, inspect relevant repository-local evidence when available, including source code and artifact-defining files such as:

* solution or workspace definitions
* project files
* package manifests
* lock files
* build configuration
* packaging configuration
* resource inclusion rules
* copy-to-output rules
* generated-file rules
* package references
* project references
* scripts
* container build definitions
* content and asset declarations

Use such files as evidence.

Do not globally reinterpret the other views as repository-structure views merely because the Artifacts View may need this evidence.

Do not invent external use cases merely because an API could theoretically be used that way.

Do not invent product behavior merely because an implementation could theoretically support it.

Do not invent output artifacts merely because a project could theoretically be compiled.

Do not assume a referenced package is structurally important merely because it appears in a dependency manifest.

Do not assume a file is packaged merely because it exists in the repository.

Do not infer deployment topology merely from an artifact type.

If something is clearly present but its artifact role is uncertain, keep it only when useful and mark the uncertainty in the corresponding table.

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
OUTSIDE                                                     ARTIFACTS

External Surface View       Functional View       Artifacts View

        E                         F                    A

 what is exposed?          what does it mean?      what exists as artifacts?
```

The External Surface View should appear on the left.

The Functional View should occupy the middle.

The Artifacts View should appear on the right.

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

## Artifacts hierarchy orientation

Write Artifacts hierarchy edges child-first:

```text
child --- parent
```

This is intentionally reversed only for Mermaid layout purposes.

It should place the Artifacts root toward the far right while its more detailed artifact nodes face toward the Functional View.

Example:

```text
A3 --- A2
A2 --- A1
```

Because `---` is undirected, this reversed statement order must not be interpreted as production direction, packaging direction, dependency direction, build sequence, ownership direction, execution flow, or data flow.

Semantic Artifacts paths must still always be described root-first in the mapping table.

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


    subgraph ARTIFACTS["Artifacts View"]

        A1["Codebase Artifacts *A1"]

        A4["Application Artifact *A4"] --- A2["Runnable Artifacts *A2"]
        A5["Supporting Resources *A5"] --- A2

        A2 --- A1
        A3["Reusable Artifacts *A3"] --- A1
    end


    EXTERNAL layout1@--> FUNCTIONAL
    FUNCTIONAL layout2@--> ARTIFACTS

    classDef layoutConstraint opacity:0;
    class layout1,layout2 layoutConstraint;


    E4 -.- F4
    E5 -.- F5

    F4 -.- A4
    F5 -.- A5
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
* production direction
* packaging direction
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

They must never be interpreted as semantic cross-view relationships, process flow, build order, production direction, packaging direction, dependency direction, execution flow, data flow, or runtime direction.

# Allowed cross-view relation layers

For this version, create two separate relation layers:

**External Surface ↔ Functional**

and:

**Functional ↔ Artifacts**

Do not create direct:

**External Surface ↔ Artifacts**

relations.

The Functional View is intentionally the semantic bridge between outside behavior and artifact structure in this product configuration.

A direct External-to-Artifacts mapping may be added later as a separate derived view if explicitly requested.

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

# Functional-to-Artifacts relation discovery

Only perform this step after the Functional View and Artifacts View have both been independently completed.

For every relevant Functional node, examine which Artifacts nodes materially carry, provide, package, support, supply, constrain, or embody that capability or guarantee.

For every relevant Artifacts node, examine which Functional nodes it materially carries, provides, supports, supplies, constrains, or enables.

The purpose of this layer is to reveal:

* one functional capability carried by several artifacts
* several functional capabilities provided by one runnable or reusable artifact
* capabilities split across several independently meaningful produced artifacts
* supporting resources that materially enable a capability
* reusable library or package artifacts that materially support several capabilities
* functional behavior that depends on a distinct external artifact boundary
* one artifact containing executable behavior plus supporting configuration or resources
* validation artifacts that materially support functional guarantees
* functional capabilities with no independently meaningful artifact distinction
* artifacts that exist for structural, validation, packaging, or support reasons without representing an independent Functional capability

Record every materially supported relationship between existing nodes.

Do not compress the relation set merely to make the diagram cleaner.

Do not connect a Functional node to every transitive dependency that participates somewhere in its implementation.

Do not force every Functional node to have an Artifacts relation.

Do not force every Artifacts node to have a Functional relation when the relationship would be incidental or too broad to be meaningful.

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

Create a relation only when the codebase materially supports it.

Do not connect nodes merely because:

* they are close in their hierarchy
* they share a folder
* they share a project
* one references another transitively
* an artifact is copied into an output directory
* an artifact is part of the same solution or workspace
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

Do not explain Functional or Artifacts mappings here.

# Functional mapping table

Then create the Functional View table.

| Ref | Functional path | Meaning in simple terms | Relevant code areas | Confidence | Notes |
| --- | --------------- | ----------------------- | ------------------- | ---------- | ----- |

The path should make the node's location in the Functional hierarchy unambiguous.

Example:

`F1 → F2 → F5`

Describe only the functional meaning or guarantee here.

Do not explain External Surface or Artifacts mappings in this table.

# Artifacts mapping table

Then create the Artifacts View table.

| Ref | Artifacts path | Artifact meaning in simple terms | Artifact evidence | Relevant code areas | Confidence | Notes |
| --- | -------------- | -------------------------------- | ----------------- | ------------------- | ---------- | ----- |

Semantic paths must always be written root-first even though Mermaid Artifacts hierarchy statements are written child-first for layout.

Example:

`A1 → A2 → A5`

Describe only the artifact, artifact group, supporting resource, or artifact boundary here.

When useful, state whether the artifact is consumed, produced, packaged, generated, reused, or supporting in the meaning, evidence, or notes fields.

Do not force this direction into the hierarchy itself.

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

# Functional-to-Artifacts relation table

Then create:

## Functional ↔ Artifacts Relations

Use relation references:

`FA1`, `FA2`, `FA3`, ...

| Ref | Functional Ref | Artifacts Ref | Relation | Meaning in simple terms | Confidence | Evidence |
| --- | -------------- | ------------- | -------- | ----------------------- | ---------- | -------- |

Possible relation meanings may include:

* provided by
* carried by
* packaged in
* supported by
* supplied by
* depends on
* embodied in
* distributed across
* bundled with
* validated through
* constrained by
* requires as supporting artifact

Choose the relation meaning from the actual codebase evidence.

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

Do not explain Functional or Artifacts mappings here.

## Functional description layer

Contains only information about `F...` nodes.

Describe:

* what the capability or guarantee is
* what the system provides, prevents, preserves, or ensures
* how it fits into the functional hierarchy
* where it is evidenced in code

Do not explain external exposure or Artifacts mapping here.

## Artifacts description layer

Contains only information about `A...` nodes.

Describe:

* what meaningful artifact, artifact group, packaged resource, or dependency boundary exists
* what materially belongs to it
* whether it is consumed, produced, generated, packaged, reused, or supporting when useful
* how it fits into the Artifacts hierarchy
* where its existence and role are evidenced in the codebase

Do not explain external exposure or Functional mapping here.

## External-to-Functional relationship layer

Contains only information about how `E...` nodes relate to `F...` nodes.

Uses `EF...` references.

## Functional-to-Artifacts relationship layer

Contains only information about how `F...` nodes relate to `A...` nodes.

Uses `FA...` references.

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

## Artifacts observations

Only observations about the Artifacts View.

Examples:

* several projects combine into one meaningful runnable artifact
* one produced artifact contains both executable code and substantial supporting resources
* several outputs share one reusable artifact
* a distinct dependency artifact forms an important codebase boundary
* test projects form a separate validation-artifact family
* artifact boundaries differ substantially from source-folder boundaries
* the repository produces little or no independently meaningful runnable output

Use `A...` references.

## External ↔ Functional observations

Only observations that emerge from `EF...` mappings.

Examples:

* several external surfaces converge on one capability
* one external operation spans several functional capabilities
* a functional capability has no direct external exposure
* multiple consumer types access the same capability differently
* one external configuration surface controls several functional guarantees

## Functional ↔ Artifacts observations

Only observations that emerge from `FA...` mappings.

Examples:

* one functional capability is distributed across several artifacts
* one artifact carries many otherwise separate capabilities
* several capabilities depend on one shared reusable artifact
* a functional guarantee depends on a distinct supporting resource
* artifact and functional boundaries differ significantly
* a substantial artifact exists primarily for validation or support rather than representing its own capability
* an apparently simple capability requires executable and non-executable supporting artifacts

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
18. Have independently meaningful behaviors been collapsed even though they differ in lifecycle, policy, security, recovery, or Artifacts mappings?
19. If two behaviors map differently to the Artifacts View, should they remain separate nodes under a shared parent?
20. Are explicit containment, isolation, authorization, trust, validation, integrity, atomicity, fallback, persistence, or recovery guarantees represented when they form distinct system behavior?
21. Has any meaningful security or correctness guarantee disappeared merely because it is technically implemented or packaged inside another artifact?

## Artifacts View

22. Does the view describe meaningful software artifacts and artifact boundaries rather than implementation structure?
23. Has the view accidentally become the solution, project, workspace, package, or folder tree?
24. Has the view accidentally become a chronological build process?
25. Has the view accidentally become deployment or infrastructure documentation?
26. Are files, project references, package references, and resources treated as evidence rather than automatically promoted to nodes?
27. Are executable code and supporting non-code resources grouped when they materially belong to one artifact?
28. Are independently meaningful runnable, reusable, supporting, dependency, generated, or validation artifacts preserved when appropriate?
29. Are incoming and outgoing directions treated as properties rather than automatically forced into top-level hierarchy branches?
30. Are artifact nodes grouped under meaningful shared concepts?
31. Are siblings at comparable abstraction levels?
32. Have several projects that form one meaningful artifact been compressed appropriately?
33. Have different artifacts that happen to come from one project remained separate when their artifact boundaries materially differ?
34. Are dependencies represented only when they form meaningful artifact boundaries rather than because they merely occur in a manifest?
35. Are supporting settings, schemas, templates, static assets, images, scripts, native files, or resource folders preserved when they materially belong to an artifact?
36. Are test or validation elements included only when they form meaningful artifact or artifact-support boundaries?
37. Has deployment topology been excluded unless it is itself directly necessary to identify an artifact?
38. Are artifact distinctions preserved when they differ in runtime identity, reuse, packaging, validation role, dependency boundary, or Functional mappings?

## External ↔ Functional Relations

39. Has every materially supported External-to-Functional relationship between existing nodes been considered?
40. Are one-to-many and many-to-one mappings preserved?
41. Was any valid relation suppressed because an ancestor or descendant already has one?
42. Does every `E -.- F` Mermaid edge have exactly one `EF...` relation row?
43. Does every `EF...` row have exactly one Mermaid edge?
44. Are unsupported or speculative mappings excluded?

## Functional ↔ Artifacts Relations

45. Has every materially supported Functional-to-Artifacts relationship between existing nodes been considered?
46. Are one-to-many, many-to-one, and distributed artifact relationships preserved?
47. Was any valid relation suppressed because a parent or descendant already has one?
48. Does every `F -.- A` Mermaid edge have exactly one `FA...` relation row?
49. Does every `FA...` row have exactly one Mermaid edge?
50. Are unsupported, transitive, or merely incidental mappings excluded?
51. Have Functional nodes without independently meaningful artifact distinctions been allowed to remain unmapped?
52. Have Artifacts nodes without a material Functional correspondence been allowed to remain unmapped rather than forcing artificial relations?
53. Are supporting resources related only to the Functional nodes they materially enable or constrain?
54. Are external dependency artifacts related only when they materially help explain a capability or guarantee?

## Separation

55. Was the External Surface View derived independently rather than copied from the Functional View?
56. Was the Functional View derived independently rather than inferred from either neighboring view?
57. Was the Artifacts View derived independently rather than copied from Functional nodes or source-project structure?
58. Are build and packaging files used as Artifacts evidence without turning the other views into repository-structure views?
59. Are cross-view explanations confined to their relation layers?
60. Are there no direct External-to-Artifacts relations?
61. Could any one of the three view definitions be replaced without fundamentally rewriting the other two?

## Diagram

62. Is the External Surface View on the left?
63. Is the Functional View in the middle?
64. Is the Artifacts View on the right?
65. Does the External hierarchy grow toward the Functional View?
66. Does the Artifacts hierarchy grow toward the Functional View?
67. Are `*E...`, `*F...`, and `*A...` references visible and consistent?
68. Are hierarchy edges visually distinct from cross-view relation edges?
69. Are cross-view relation edges unlabeled?
70. Does the diagram expose useful many-to-many structures without explanatory text on the relation edges?
71. Is the diagram still reasonably readable on a normal screen?
72. Does the generated layout-constraint chain follow the currently configured left-to-right view order, with exactly one invisible directed layout constraint between each adjacent pair of views?
73. Are all `layout...@-->` edges presentation-only, visually invisible, and excluded from semantic relation tables and relation consistency checks?

The goal is not to produce three complete inventories.

The goal is to create a **compressed semantic model of the codebase from three independent perspectives**:

**External Surface View: what the outside world can interact with**

**Functional View: what those interactions and behaviors mean as system capabilities and guarantees**

**Artifacts View: what meaningful software artifacts the codebase consumes, depends on, assembles, produces, packages, or carries with its outputs**

The relation layers then expose how the perspectives correspond without collapsing them into one structure.

Preserve meaningful distinctions whenever collapsing them would hide different lifecycle, policy, security, containment, isolation, validation, recovery, external-surface, artifact, packaging, dependency, or neighboring-view relationships.

In particular, do not allow an explicit system guarantee to disappear merely because it is technically implemented or packaged inside a broader artifact.

Do not allow a meaningful artifact boundary to disappear merely because it happens to align with a project, package, folder, or build output.

The resulting artifact should be useful both for humans and for LLMs as a compact entry point for understanding the codebase.
