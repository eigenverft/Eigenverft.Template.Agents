Analyze the codebase and create a compact five-view user-facing codebase comprehension map.

The result should contain five independently derived views of the same codebase:

**User Touchpoints View**  
What does a user or direct consumer concretely interact with?

**User Features View**  
What meaningful features, capabilities, and outcomes does the system provide to its users through those touchpoints?

**Interaction Design View**  
How are the user touchpoints designed and structured to support effective interaction?

**UI Composition Architecture View**  
How are pages, layouts, UI components, scripts, state, routing, rendering responsibilities, and shared UI mechanisms connected and composed into the user-facing application?

**UI Code Organization View**  
Where in the codebase are the meaningful UI composition structures and responsibilities located?

The five views must remain conceptually separate.

Each view must also remain independently complete at the level of detail appropriate to that view.

Derive each view as if it had to stand on its own as a useful representation of the codebase from that perspective.

The presence of additional views must not reduce the structure, distinctions, or useful detail that a view would otherwise contain.

Their definitions are isolated below so that any individual view can later be replaced by another kind of view without changing the logic of the remaining views or unrelated relation layers.

The intended conceptual structure is:

```
                         User Features
                       ↗
User Touchpoints ──────→ Interaction Design
                       ↘
                         UI Composition Architecture → UI Code Organization
```

or independently:

**User Touchpoint → User Feature**

**User Touchpoint → Interaction Design**

**User Touchpoint → UI Composition Architecture → UI Code Location**

The User Touchpoints View is the common user-facing entry perspective of this product configuration.

User Features, Interaction Design, and UI Composition Architecture are parallel perspectives.

Do not treat them as successive stages.

UI Code Organization is downstream only from UI Composition Architecture.

Do not derive one view mechanically from another.

This structure also defines the current Mermaid layout topology.

If a later version replaces, adds, removes, reorders, or reconnects views, derive Mermaid layout constraints from that version's configured view topology.

Do not assume that all views must form one linear chain.

# View A Definition: User Touchpoints View

The User Touchpoints View answers:

**What can a user or direct consumer concretely see, invoke, manipulate, configure, enter, select, navigate, receive, or otherwise interact with?**

"User or direct consumer" is intentionally broad.

Depending on the codebase, it may include:

- end users
- administrators
- operators
- application developers
- library consumers
- command-line users
- API clients
- configuration authors
- plugin users
- runtime clients
- integration consumers

Do not assume which consumer types exist.

Derive them from the codebase.

## Direct interaction perspective

Describe the system strictly in terms of concrete user-facing or consumer-facing interaction surfaces.

Look for touchpoints such as:

- screens
- pages
- panels
- views
- dialogs
- menus
- navigation areas
- toolbars
- commands
- buttons
- controls
- forms
- fields
- selectors
- search inputs
- lists
- tables
- editors
- configuration surfaces
- CLI commands
- public API entry points
- endpoints
- extension entry points
- events consumed or produced directly by users or clients
- user-visible outputs
- notifications
- user-visible states
- direct integration surfaces

A touchpoint should represent something that a user or direct consumer can concretely interact with.

Do not organize this view around internal implementation components.

A UI component, class, method, endpoint, or command should not automatically become a node merely because it exists.

Instead ask:

**Is this a meaningful interaction point from the user's or direct consumer's perspective?**

Several implementation elements may form one touchpoint.

One touchpoint may also be realized through several implementation elements.

## Touchpoint, not feature

Do not describe what the system enables at an abstract capability level when identifying touchpoints.

For example:

`Search field`

is a touchpoint.

`Find relevant content`

is a user feature.

Likewise:

`Settings panel`

is a touchpoint.

`Configure synchronization behavior`

is a user feature.

Keep these distinctions separate.

## Not a user journey

Do not turn the User Touchpoints View into a chronological process or workflow.

Avoid structures such as:

`Open → Configure → Save → Finish`

unless those items are independently meaningful touchpoints.

The hierarchy should describe **what the user can directly interact with**, not the order in which interactions occur.

## Touchpoint hierarchy

Where useful, distinguish between:

- user-facing surface
- application area
- screen or view
- navigation surface
- interaction area
- command surface
- configuration surface
- input surface
- output surface
- concrete control
- external interaction entry point
- observable state surface

These are guidance, not a rigid schema.

Build the hierarchy from the evidence in the codebase.

# View B Definition: User Features View

The User Features View answers:

**What meaningful features, capabilities, behaviors, guarantees, and outcomes does the system provide to its users or direct consumers?**

Build the feature structure, where possible, from the bottom up.

First identify concrete things users can meaningfully accomplish, control, obtain, prevent, configure, observe, or rely on.

Then determine which of them belong together and can be grouped under a simple, meaningful higher-level feature concept.

Repeat this consolidation recursively until the result forms a small number of clear top-level feature areas and, ideally, one meaningful user-value root.

The root should describe the broad user-facing purpose of the product or codebase as a whole.

Do not primarily organize the User Features View around:

- screens
- pages
- buttons
- dialogs
- menus
- files
- folders
- namespaces
- classes
- interfaces
- services
- packages
- implementation layers

These are evidence, not the desired structure.

A feature may be available through several different touchpoints.

Likewise, one touchpoint may expose several different features.

A technical module should not automatically become a feature.

Where useful, distinguish between:

- feature area
- core user feature
- sub-feature
- user capability
- feature variant
- user-controlled behavior
- user-visible outcome
- behavioral guarantee
- security or isolation guarantee

These are guidance, not a rigid schema.

## User value perspective

Describe features in terms of what they allow the user or direct consumer to do, achieve, control, understand, or rely on.

Prefer:

`Find relevant content`

over:

`Search input`

Prefer:

`Configure synchronization behavior`

over:

`Settings panel`

Prefer:

`Recover previous state after failure`

over:

`Recovery service`

The feature hierarchy should represent meaningful user-facing capability, not surface structure and not implementation structure.

# View C Definition: Interaction Design View

The Interaction Design View answers:

**How are the user touchpoints designed and structured to support understandable, effective, and consistent interaction?**

Independently identify the meaningful interaction structures and behaviors present in the product.

Do not simply inventory UI controls.

Instead identify the interaction responsibilities and patterns expressed through the touchpoints.

Look for concepts such as:

- navigation behavior
- action placement
- action hierarchy
- command interaction
- input behavior
- form interaction
- selection behavior
- search interaction
- filtering interaction
- editing behavior
- confirmation behavior
- destructive-action handling
- progressive disclosure
- contextual actions
- feedback behavior
- loading behavior
- success feedback
- error feedback
- validation behavior
- recovery interaction
- empty states
- state transitions
- modal interaction
- focus behavior
- keyboard interaction
- discoverability mechanisms
- interaction consistency
- interaction variants

Do not organize this view around source files, implementation classes, component libraries, or folder structure.

These are evidence, not the desired structure.

A single interaction design concept may appear across many touchpoints.

One touchpoint may also participate in several interaction design concepts.

For example, one dialog may simultaneously participate in:

- form interaction
- validation feedback
- destructive-action confirmation
- keyboard interaction

Do not force the Interaction Design View to mirror the User Touchpoints View.

## Interaction behavior, not visual inventory

Do not turn this view into a catalog of visual styling.

Colors, typography, spacing, icons, and visual tokens should only become relevant when they materially affect interaction structure, hierarchy, state communication, discoverability, or behavior.

The primary question is not:

**What does it look like?**

The primary question is:

**How does the interaction work?**

## Not a feature inventory

Do not rename User Features as Interaction Design nodes.

For example:

`Find relevant content`

is a User Feature.

`Search interaction`

may be an Interaction Design concept.

`Search field`

may be a User Touchpoint.

These are related but distinct perspectives.

## Interaction Design hierarchy

Where useful, distinguish between:

- interaction area
- interaction model
- interaction pattern
- navigation pattern
- action pattern
- input pattern
- feedback pattern
- state behavior
- error or recovery pattern
- interaction variant
- concrete interaction behavior

These are guidance, not a rigid schema.

Build the hierarchy from the evidence in the codebase.

# View D Definition: UI Composition Architecture View

The UI Composition Architecture View answers:

**How are pages, layouts, UI components, scripts, state, routing, rendering responsibilities, and shared UI mechanisms connected and composed into the user-facing application?**

Independently identify the major composition structures that assemble and coordinate the user-facing system.

This view is concerned with how the visible application is technically put together.

Look for concepts such as:

- application shell
- page shell
- page composition
- layout system
- shared layouts
- page-specific layouts
- routing structure
- route composition
- navigation composition
- rendering entry points
- mounting or bootstrap points
- page initialization
- script initialization
- controllers
- presenters
- view models
- client-side page logic
- shared UI components
- page-local UI components
- component composition
- state ownership
- shared state
- page-local state
- contexts
- stores
- event coordination
- shared event mechanisms
- rendering helpers
- templates
- partials
- view composition
- server-side rendering boundaries
- client-side rendering boundaries
- hydration boundaries
- modal hosts
- notification hosts
- shared UI services
- isolated UI areas
- legacy UI islands
- composition boundaries

Do not simply reproduce frontend folders, component directories, or framework structure.

Files, folders, components, classes, scripts, templates, and modules are evidence for the UI Composition Architecture, but should only become nodes when they represent a meaningful composition responsibility or boundary.

A composition responsibility may span multiple files, components, scripts, or directories.

Several low-level UI elements may form one meaningful composition unit.

Prefer a compressed composition model over a complete UI source tree.

## Composition perspective

Ask questions such as:

- How is a page or screen assembled?
- Is there a shared application shell?
- Is layout controlled centrally or independently by each page?
- Are pages mounted through one common rendering path or several unrelated paths?
- Is routing centralized or distributed?
- Are scripts initialized centrally or per page?
- Is state shared globally, scoped to areas, or local to individual touchpoints?
- Are dialogs, notifications, navigation, or overlays centrally hosted?
- Do several pages reuse the same composition mechanisms?
- Are some UI areas isolated from the rest of the application?
- Are there several independent rendering systems?
- Do server-rendered and client-rendered areas coexist?
- Are interaction surfaces technically connected through shared infrastructure or largely independent?

Do not assume that a central UI architecture exists.

If the evidence shows several separate page systems, rendering paths, state models, or isolated UI islands, preserve those distinctions.

## Composition, not interaction design

Do not describe how an interaction should behave merely because the architecture enables it.

For example:

`Shared modal host`

may be a UI Composition Architecture node.

`Confirmation interaction`

may be an Interaction Design node.

`Delete confirmation dialog`

may be a User Touchpoint.

Likewise:

`Shared route layout`

may be a UI Composition Architecture node.

`Navigation interaction`

may be an Interaction Design node.

`Sidebar`

may be a User Touchpoint.

These concepts may map to one another through neighboring views, but they are not interchangeable.

## Composition, not code location

Do not turn this view into a map of files, directories, packages, or modules.

For example:

`Shared layout system`

may be a UI Composition Architecture node.

`src/layout/`, `AppLayout.tsx`, and `layout-state.ts`

may be UI Code Organization evidence or nodes.

The architecture describes **what composition responsibility exists**.

The code-organization view describes **where that responsibility lives**.

## Composition, not generic software architecture

Do not turn this view into a complete technical architecture of the application.

Backend services, persistence layers, business-domain modules, infrastructure, and unrelated technical components should only appear when they materially participate in composing or delivering the user-facing interface.

The question is not:

**How is the whole system implemented?**

The question is:

**How is the user-facing application assembled, rendered, connected, and coordinated?**

## UI Composition Architecture hierarchy

Where useful, distinguish between:

- user-facing application
- application shell
- composition domain
- rendering system
- layout system
- routing system
- page composition
- shared UI mechanism
- shared state mechanism
- page-local mechanism
- script or controller boundary
- component composition
- rendering boundary
- composition variant
- isolated UI area
- legacy UI island

These are guidance, not a rigid schema.

Build the hierarchy from the evidence in the codebase.

# View E Definition: UI Code Organization View

The UI Code Organization View answers:

**Where in the codebase are the meaningful UI composition structures and responsibilities located?**

Independently identify the source areas that provide useful navigation anchors for understanding, modifying, extending, testing, or tracing the user-facing application.

This view is intentionally code-organization-oriented.

Unlike the UI Composition Architecture View, source structure is primary evidence here.

Look for meaningful UI code locations such as:

- UI projects
- frontend modules
- packages
- source directories
- namespaces
- page directories
- route directories
- layout directories
- component areas
- shared UI areas
- state-management areas
- script areas
- controller areas
- view-model areas
- template areas
- styling areas when structurally relevant
- UI integration areas
- UI configuration areas
- rendering entry-point files
- bootstrap files
- route-definition files
- shared layout files
- shared state files
- important page-level files
- test areas
- generated UI code boundaries
- legacy UI areas
- cross-cutting UI source areas
- important code ownership or responsibility boundaries

Do not simply reproduce the frontend or repository tree.

A directory, project, package, namespace, module, component area, or file should become a node only when it forms a useful navigation or responsibility boundary.

Ask:

**If a developer needed to understand or change this part of the UI composition system, is this a meaningful place in the codebase to look?**

Several directories, files, packages, or namespaces may form one meaningful UI code area.

One project or module may contain several independently meaningful UI code areas.

One UI Composition Architecture responsibility may span several source areas.

One UI code area may contain code supporting several composition responsibilities.

A single key file may deserve its own node when it is an unusually important navigation anchor, rendering entry point, composition point, routing point, layout point, state owner, bootstrap point, or boundary.

Do not inventory files merely because they exist.

## Navigation perspective

Describe code organization in terms that help a developer orient themselves in the UI source.

The view may represent actual codebase names more directly than the other views when those names are useful navigation anchors.

For example, a project, module, package, namespace, directory, or file name may be the clearest node name when a developer can directly search for or navigate to it.

However, do not preserve source names mechanically when a simple grouped name would provide a clearer navigation model.

The purpose is not to rename the repository.

The purpose is to compress it into a useful map of **where meaningful UI composition code lives**.

## Distinguish UI Code Organization from UI Composition Architecture

UI Composition Architecture and UI Code Organization answer different questions.

**UI Composition Architecture:** What responsibility connects, assembles, renders, routes, lays out, hosts, or coordinates the user-facing application?

**UI Code Organization:** Where should a developer look in the codebase to understand or change that responsibility?

Do not mechanically translate UI Composition Architecture nodes into source locations.

Do not mechanically translate source locations into UI Composition Architecture nodes.

A single UI Composition Architecture responsibility may span several UI Code Organization nodes.

A single UI Code Organization node may contain several UI Composition Architecture responsibilities.

Their differences are valuable information.

## Concentration and fragmentation

Explicitly preserve source structures that help reveal whether UI responsibilities are concentrated or fragmented.

Look for situations such as:

- one composition responsibility located primarily in one source area
- one composition responsibility distributed across many directories or files
- several unrelated composition responsibilities concentrated in one source area
- a shared mechanism with one clear implementation anchor
- a nominally shared mechanism duplicated across several page areas
- page-local scripts scattered across many locations
- a central routing area coordinating many otherwise separate UI areas
- a central state area serving many unrelated touchpoints
- several independent layout implementations in different source areas
- a legacy UI area separated from the main composition system
- a small file acting as a critical composition or bootstrap point
- generated code mixed with authored UI code
- test ownership concentrated separately from implementation ownership

Do not automatically treat concentration as good or fragmentation as bad.

Represent the structure first.

Interpretation belongs in observations.

## Not a complete source tree

Do not reproduce every:

- folder
- project
- package
- namespace
- module
- component
- file
- stylesheet
- script
- test class
- generated file

Compress source structure aggressively when several neighboring source elements form one useful navigation area.

Preserve source distinctions when they materially affect:

- where a developer would make a change
- where related UI code is located
- rendering entry points
- page entry points
- routing ownership
- layout ownership
- state ownership
- script ownership
- component ownership
- shared versus page-local code
- test ownership
- generated versus authored code
- legacy boundaries
- UI Composition Architecture mappings

## Tests

Tests may appear when they form a meaningful code-navigation boundary.

Do not inventory test suites or individual test cases.

A UI test project, component-test area, interaction-test area, integration-test area, fixture area, or similar source region may deserve a node when it materially helps a developer locate validation or regression coverage for composition responsibilities represented elsewhere.

Do not assume every UI Composition Architecture node requires a corresponding test-area node.

## UI Code Organization hierarchy

Where useful, distinguish between:

- UI codebase area
- frontend project or module
- source responsibility area
- page area
- route area
- layout area
- shared-component area
- state area
- script or controller area
- integration area
- test area
- generated-code area
- legacy area
- key navigation anchor
- key file

These are guidance, not a rigid schema.

Build the hierarchy from the evidence in the codebase.

# Shared hierarchy rules

Apply the following rules independently to all five views.

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
- Is one actually a specialization, variant, realization, exposure, interaction pattern, feature, touchpoint, composition mechanism, source area, navigation anchor, or part of another?
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

- user audience
- interaction surface
- user outcome
- lifecycle
- policy
- authorization behavior
- isolation behavior
- containment behavior
- configuration behavior
- operational behavior
- navigation behavior
- input behavior
- feedback behavior
- state behavior
- validation behavior
- failure behavior
- recovery behavior
- interaction convention
- rendering responsibility
- routing responsibility
- layout responsibility
- state ownership
- script ownership
- page composition
- shared versus local behavior
- composition boundary
- rendering boundary
- source location
- navigation boundary
- change location
- test ownership
- generated-code boundary
- legacy boundary
- neighboring-view mappings

A distinction is especially worth preserving when two concepts map differently to nodes in an adjacent view.

For example, if two touchpoints expose different user features, keep them separate when collapsing them would hide materially different Touchpoint-to-Feature mappings.

Likewise, if two touchpoints use materially different interaction patterns, keep them separate when collapsing them would hide Touchpoint-to-Interaction-Design mappings.

If two touchpoints are assembled through different rendering paths, layout systems, state models, or script boundaries, preserve them when collapsing them would hide different Touchpoint-to-UI-Composition mappings.

If two UI Composition Architecture responsibilities are located in substantially different source areas, preserve them when collapsing them would hide materially different Architecture-to-Code-Organization mappings.

Do not add detail merely for completeness.

Preserve detail when it carries structural meaning.

## Preserve explicit user-facing guarantees

Treat explicit guarantees as independently meaningful user-facing behaviors when they enforce a distinct property that users or direct consumers can rely on.

Look specifically for guarantees involving:

- authorization
- isolation
- containment
- input acceptance
- integrity
- consistency
- atomicity
- persistence
- fallback behavior
- recovery behavior
- last-known-good behavior
- compatibility
- prevention of destructive actions
- recoverability
- state preservation

If such a guarantee answers a distinct question such as:

- "What can the user rely on?"
- "What is prevented?"
- "What remains isolated?"
- "What remains valid?"
- "What happens after failure?"
- "What state can be recovered?"
- "What action requires confirmation?"

then consider representing it as its own User Feature when it is independently meaningful to the user.

If the guarantee is expressed through distinct interaction behavior, also preserve that behavior in the Interaction Design View.

If the guarantee depends on a distinct UI composition responsibility, such as shared state ownership, a central host, a rendering boundary, or an isolated UI path, preserve that responsibility in the UI Composition Architecture View.

If that responsibility is materially distributed across or localized within distinct source areas, preserve those independently meaningful locations in the UI Code Organization View.

## Consider alternative groupings

Do not automatically accept the first plausible hierarchy.

For important areas, consider whether another grouping would explain the structure more clearly or with fewer concepts.

Prefer the structure that explains the most with the fewest clear and meaningful terms.

If two groupings are similarly plausible, mention the alternative briefly rather than forcing artificial certainty.

# Keep all five views independent

Derive all five views independently from the code.

Evaluate the necessary structure, distinctions, and level of detail of each view only against that view's own definition and the evidence in the codebase.

Each view must be sufficiently complete to remain useful if all other views were removed from the artifact.

Do not reduce the detail of one view merely because another view represents some of the same code, concepts, behaviors, responsibilities, or evidence more explicitly.

Do not compress, regroup, omit, or simplify a view merely to reduce overlap or redundancy with another view.

Do not remove a meaningful node or distinction from one view solely because similar information appears in another view.

Redundancy between independently derived views is allowed when the same product reality is independently meaningful from more than one perspective.

Such overlap is not itself a defect.

Differences in how independently complete views group or distinguish the same underlying behavior or code can be valuable information.

Do not create the User Touchpoints View by simply selecting UI classes, public methods, endpoints, or components.

Do not create the User Features View by renaming User Touchpoints nodes.

Do not create the Interaction Design View by mechanically translating User Touchpoints into interaction terminology.

Do not create the UI Composition Architecture View by mechanically translating User Touchpoints into components, pages, scripts, layouts, or files.

Do not create the UI Code Organization View by translating UI Composition Architecture nodes mechanically into folders, files, modules, or packages.

Do not alter the structure of one view merely to make it align visually or conceptually with another.

Do not alter the structure of one view merely because another independently derived view now covers similar ground.

Their structures are expected to differ.

Their structures may also partially overlap.

Both outcomes can be meaningful.

For example:

- several touchpoints may expose one user feature
- one touchpoint may expose several user features
- several touchpoints may use one interaction pattern
- one touchpoint may participate in several interaction patterns
- one interaction pattern may appear across unrelated product areas
- several touchpoints may share one layout or rendering path
- one touchpoint may depend on several composition mechanisms
- several pages may share one application shell
- one page may initialize its own isolated scripts and state
- similar touchpoints may be implemented through different UI composition architectures
- visually different touchpoints may share the same composition mechanism
- one shared component or state mechanism may support many unrelated touchpoints
- some touchpoints may live in isolated or legacy UI systems
- one UI Composition Architecture responsibility may span many source areas
- several UI Composition Architecture responsibilities may be concentrated in one source area
- one shared layout system may have one clear code anchor
- a conceptually shared mechanism may actually be duplicated across several page directories
- composition boundaries and source-location boundaries may differ significantly

First complete all five views independently.

Only afterwards identify the relationships between them.

Cross-view analysis may reveal that an independently derived view contains an actual mistake, unsupported distinction, or missed evidence.

Correct such an issue when justified by the code.

Do not revise a valid view merely to make the combined artifact less repetitive.

# Naming

Use short, understandable names.

For the User Touchpoints View, describe nodes in terms of **what the user or direct consumer concretely interacts with**.

For the User Features View, describe nodes in terms of **what the user can meaningfully do, achieve, control, observe, or rely on**.

For the Interaction Design View, describe nodes in terms of **how interaction behaves and is structured**.

For the UI Composition Architecture View, describe nodes in terms of **how the user-facing application is assembled, rendered, connected, and coordinated**.

For the UI Code Organization View, describe nodes in terms of **where meaningful UI composition code is located and where a developer should navigate to understand or change it**.

Internal class, method, file, namespace, package, project, module, component, template, script, or directory names may be used as supporting evidence.

Actual source names may be used directly in the UI Code Organization View when they are useful navigation anchors.

Keep Mermaid labels concise.

Put detailed explanations into the corresponding tables.

# References

Assign every relevant node a short stable reference.

User Touchpoints View references use:

`E1`, `E2`, `E3`, ...

User Features View references use:

`F1`, `F2`, `F3`, ...

Interaction Design View references use:

`I1`, `I2`, `I3`, ...

UI Composition Architecture View references use:

`A1`, `A2`, `A3`, ...

UI Code Organization View references use:

`C1`, `C2`, `C3`, ...

These references must remain consistent across:

- Mermaid diagram
- User Touchpoints mapping table
- User Features mapping table
- Interaction Design mapping table
- UI Composition Architecture mapping table
- UI Code Organization mapping table
- relation tables
- observations

Show the reference inside the Mermaid node label using a small textual marker:

`*E1`

`*F1`

`*I1`

`*A1`

`*C1`

For example:

```
E1["User Touchpoints *E1"]
F1["User Features *F1"]
I1["Interaction Design *I1"]
A1["UI Composition Architecture *A1"]
C1["UI Codebase *C1"]
```

The reference is only an identifier.

It is not part of the actual touchpoint, feature, interaction-design, composition-architecture, or source-area name.

# Uncertainty

Stay close to what can actually be supported by the code.

Do not invent user-facing touchpoints merely because a component could theoretically be exposed.

Do not invent user features merely because implementation code could theoretically support them.

Do not invent interaction patterns merely because several controls look superficially similar.

Do not invent shared UI composition architecture merely because several pages happen to use the same framework.

Do not assume centralization merely because code shares a directory or base class.

Do not assume fragmentation merely because code is located in different files.

Do not invent UI source responsibilities merely because a directory, file, project, component, or namespace name suggests them.

If something is clearly present but its role is uncertain, keep it only when useful and mark the uncertainty in the corresponding table.

# Output container structure

Produce the complete result in exactly two separate fenced output blocks.

The first output block must be a fenced `mermaid` block.

It must contain only the complete Mermaid diagram.

The second output block must be a separate fenced `markdown` block.

It must contain all remaining textual output, including:

- all five mapping tables
- all four relation tables
- optional observations
- all headings
- all explanations
- all other textual report content

Do not place any prose, table, heading, explanation, observation, or report text inside the Mermaid block.

Close the Mermaid block completely before opening the Markdown block.

Do not combine the Mermaid diagram and the textual report into one fenced block.

Do not produce any report content outside these two fenced blocks.

The required top-level output structure is:

````
```mermaid
[complete Mermaid diagram only]
```

```markdown
[complete textual report only]
```
````

# Mermaid output

First produce all five views together in the first fenced `mermaid` output block.

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
                         User Features View
                       ↗
User Touchpoints View ──→ Interaction Design View
                       ↘
                         UI Composition Architecture View → UI Code Organization View
```

The User Touchpoints View should appear on the left.

The User Features View, Interaction Design View, and UI Composition Architecture View should all appear to the right of User Touchpoints as parallel perspectives.

The UI Code Organization View should appear to the right of UI Composition Architecture.

User Features, Interaction Design, and UI Composition Architecture must not be visually or semantically presented as successive stages.

UI Code Organization is downstream only from UI Composition Architecture.

The relative vertical ordering of the three parallel views is secondary.

Do not restructure any view merely to force one parallel view above or below another.

## User Touchpoints hierarchy orientation

Write User Touchpoints hierarchy edges parent-first:

```
parent --- child
```

This should make the User Touchpoints hierarchy grow from the outside-left toward its neighboring views.

## User Features hierarchy orientation

Write User Features hierarchy edges child-first:

```
child --- parent
```

This is intentionally reversed only for Mermaid layout purposes.

It should place the User Features root toward the outer right while its more detailed feature nodes face toward User Touchpoints.

Semantic User Features paths must always be described root-first in the mapping table.

## Interaction Design hierarchy orientation

Write Interaction Design hierarchy edges child-first:

```
child --- parent
```

This is intentionally reversed only for Mermaid layout purposes.

It should place the Interaction Design root toward the outer right while its more detailed interaction nodes face toward User Touchpoints.

Semantic Interaction Design paths must always be described root-first in the mapping table.

## UI Composition Architecture hierarchy orientation

Write UI Composition Architecture hierarchy edges parent-first:

```
parent --- child
```

Keep the UI Composition Architecture View as the semantic bridge between concrete user-facing touchpoints and UI source organization.

Do not restructure the UI Composition Architecture hierarchy merely to improve relation alignment.

Its more detailed composition nodes should remain available for mappings both to User Touchpoints and UI Code Organization.

Semantic UI Composition Architecture paths must always be described root-first in the mapping table.

## UI Code Organization hierarchy orientation

Write UI Code Organization hierarchy edges child-first:

```
child --- parent
```

This is intentionally reversed only for Mermaid layout purposes.

It should place the UI Code Organization root toward the outer right while its more detailed source-area nodes face toward UI Composition Architecture.

Semantic UI Code Organization paths must always be described root-first in the mapping table.

Because `---` is undirected, reversed statement order in right-facing views must not be interpreted as ownership direction, dependency direction, execution flow, data flow, user journey, rendering direction, or source-navigation direction.

# Mermaid structure

Use five separate subgraphs:

```
---
config:
  layout: elk
  elk:
    nodePlacementStrategy: LINEAR_SEGMENTS
    mergeEdges: false
---
flowchart LR

    subgraph TOUCHPOINTS["User Touchpoints View"]

        E1["User Touchpoints *E1"]

        E1 --- E2["Touchpoint area A *E2"]
        E2 --- E3["Concrete touchpoint A1 *E3"]
    end


    subgraph FEATURES["User Features View"]

        F1["User Features *F1"]

        F3["Sub-feature A1 *F3"] --- F2["Feature area A *F2"]
        F2 --- F1
    end


    subgraph INTERACTION["Interaction Design View"]

        I1["Interaction Design *I1"]

        I3["Interaction pattern A1 *I3"] --- I2["Interaction area A *I2"]
        I2 --- I1
    end


    subgraph ARCHITECTURE["UI Composition Architecture View"]

        A1["UI Composition Architecture *A1"]

        A1 --- A2["Composition area A *A2"]
        A2 --- A3["Composition mechanism A1 *A3"]
    end


    subgraph CODE_ORGANIZATION["UI Code Organization View"]

        C1["UI Codebase *C1"]

        C3["UI source area A1 *C3"] --- C2["UI source area A *C2"]
        C2 --- C1
    end


    TOUCHPOINTS layout1@--> FEATURES
    TOUCHPOINTS layout2@--> INTERACTION
    TOUCHPOINTS layout3@--> ARCHITECTURE
    ARCHITECTURE layout4@--> CODE_ORGANIZATION

    classDef layoutConstraint opacity:0;
    class layout1,layout2,layout3,layout4 layoutConstraint;


    E3 -.- F3

    E3 -.- I3

    E3 -.- A3

    A3 -.- C3
```

The `layout1`, `layout2`, ... edges are layout constraints only.

For this product configuration, the layout topology is:

```
TOUCHPOINTS → FEATURES
TOUCHPOINTS → INTERACTION
TOUCHPOINTS → ARCHITECTURE
ARCHITECTURE → CODE_ORGANIZATION
```

Create one directed layout-constraint edge for each connection in the configured layout topology.

Do not force the view topology into one linear layout chain.

If several views branch from the same view, create separate layout constraints from that shared view to each branch.

If one branch continues into another view, create an additional layout constraint for that branch connection.

If a later product version replaces, adds, removes, reorders, or reconnects views, regenerate the layout constraints from that version's configured view topology.

Do not hard-code the assumption that every product version forms this exact topology.

Assign all layout-constraint edges to the dedicated `layoutConstraint` class and make them visually invisible:

```
classDef layoutConstraint opacity:0;
class layout1,layout2,layout3,layout4 layoutConstraint;
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

- user journey
- process flow
- execution order
- data flow
- dependency direction
- runtime direction
- rendering direction
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

For this version, create four separate relation layers:

**User Touchpoints ↔ User Features**

**User Touchpoints ↔ Interaction Design**

**User Touchpoints ↔ UI Composition Architecture**

**UI Composition Architecture ↔ UI Code Organization**

Do not create direct:

**User Features ↔ Interaction Design**

**User Features ↔ UI Composition Architecture**

**User Features ↔ UI Code Organization**

**Interaction Design ↔ UI Composition Architecture**

**Interaction Design ↔ UI Code Organization**

or:

**User Touchpoints ↔ UI Code Organization**

relations.

User Features, Interaction Design, and UI Composition Architecture are intentionally parallel perspectives connected independently to User Touchpoints.

UI Code Organization is intentionally connected to UI Composition Architecture rather than directly to User Touchpoints.

A direct relation between currently unconnected views may be added later as a separate derived layer only if explicitly requested.

# User-Touchpoints-to-User-Features relation discovery

Only perform this step after the User Touchpoints View and User Features View have both been independently completed.

For every relevant User Touchpoints node, examine which User Features nodes are materially exposed, controlled, invoked, observed, or made available through that touchpoint.

For every relevant User Features node, examine which User Touchpoints nodes materially provide access to, expose, control, or represent that feature.

The purpose of this layer is to reveal patterns such as:

- several touchpoints exposing one user feature
- one touchpoint exposing several user features
- one feature available through several interaction surfaces
- feature variants exposed through different touchpoints
- configuration touchpoints controlling several user behaviors
- a feature with no clearly identifiable direct touchpoint
- touchpoints that exist primarily to support one narrow feature
- broad touchpoints that provide access to many unrelated features

Record every materially supported relationship between existing nodes.

Do not compress the relation set merely to make the diagram cleaner.

# User-Touchpoints-to-Interaction-Design relation discovery

Only perform this step after the User Touchpoints View and Interaction Design View have both been independently completed.

For every relevant User Touchpoints node, examine which Interaction Design nodes materially describe how interaction at that touchpoint behaves.

For every relevant Interaction Design node, examine which User Touchpoints nodes materially express or use that interaction pattern or behavior.

The purpose of this layer is to reveal patterns such as:

- several touchpoints sharing one interaction pattern
- one touchpoint combining several interaction behaviors
- one interaction pattern appearing across unrelated product areas
- similar touchpoints using materially different interaction behaviors
- one navigation surface participating in several interaction models
- one form using several validation, feedback, and recovery patterns
- isolated touchpoints whose interaction behavior is not shared elsewhere
- broadly reused interaction behavior across many touchpoints

Record every materially supported relationship between existing nodes.

Do not compress the relation set merely to make the diagram cleaner.

# User-Touchpoints-to-UI-Composition-Architecture relation discovery

Only perform this step after the User Touchpoints View and UI Composition Architecture View have both been independently completed.

For every relevant User Touchpoints node, examine which UI Composition Architecture nodes materially assemble, render, route, host, initialize, coordinate, or provide shared UI infrastructure for that touchpoint.

For every relevant UI Composition Architecture node, examine which User Touchpoints nodes materially depend on, appear within, are assembled by, are mounted through, or are coordinated by that composition responsibility.

The purpose of this layer is to reveal patterns such as:

- several touchpoints sharing one application shell
- several pages using one common layout system
- one touchpoint depending on several shared composition mechanisms
- one page using a dedicated script or controller
- several touchpoints sharing one state mechanism
- one touchpoint owning entirely local state
- one rendering path serving many product areas
- several independent rendering paths within the same product
- touchpoints hosted by shared modal or notification infrastructure
- page-specific UI islands isolated from shared composition
- server-rendered and client-rendered touchpoints using different composition paths
- common routing infrastructure connecting many touchpoints
- UI areas that appear similar but are technically composed independently

Record every materially supported relationship between existing nodes.

Do not connect a touchpoint to every implementation element that transitively contributes to rendering it.

A UI Composition Architecture relation should materially help explain **how that touchpoint is assembled, rendered, connected, or coordinated**.

Do not compress the relation set merely to make the diagram cleaner.

# UI-Composition-Architecture-to-UI-Code-Organization relation discovery

Only perform this step after the UI Composition Architecture View and UI Code Organization View have both been independently completed.

For every relevant UI Composition Architecture node, examine which UI Code Organization nodes materially contain, locate, anchor, configure, test, initialize, or otherwise provide useful source navigation for that composition responsibility.

For every relevant UI Code Organization node, examine which UI Composition Architecture nodes materially live in, span, enter through, are configured in, are tested in, or are otherwise meaningfully associated with that source area.

The purpose of this layer is to reveal:

- one composition responsibility concentrated in one source area
- one composition responsibility distributed across several source areas
- several composition responsibilities concentrated in one UI code area
- shared layout responsibility with one clear source anchor
- shared layout responsibility duplicated across multiple page areas
- routing responsibility concentrated in a central routing area
- routing responsibility distributed across page-local definitions
- shared state mechanisms concentrated in one source area
- shared state mechanisms fragmented across several areas
- page-local scripts distributed across many page directories
- one central bootstrap or rendering entry point coordinating many UI areas
- a critical UI composition responsibility implemented in a surprisingly small source area
- legacy composition architecture isolated in a distinct code region
- generated UI code forming a meaningful source boundary
- composition boundaries and code-organization boundaries that align closely
- composition boundaries and code-organization boundaries that differ substantially

Record every materially supported relationship between existing nodes.

Do not connect an Architecture node to every file or directory touched transitively by its implementation.

A UI Code Organization relation should materially help a developer know **where to look**.

# Do not inherit or suppress relations through hierarchy

Apply this rule independently to all four relation layers.

A relation between parent nodes does not automatically replace relations between their descendants.

A relation between descendant nodes does not automatically replace a valid relation between their parents.

Do not omit a relationship merely because:

- an ancestor is already connected
- a descendant is already connected
- a broader relation already exists
- another relation looks visually similar

The relation layers exist specifically to reveal one-to-many, many-to-one, and many-to-many structures.

# Do not infer relations across parallel views

A User-Touchpoints-to-User-Features relation does not imply a User-Touchpoints-to-Interaction-Design relation.

A User-Touchpoints-to-Interaction-Design relation does not imply a User-Touchpoints-to-UI-Composition-Architecture relation.

A User-Touchpoints-to-UI-Composition-Architecture relation does not imply either of the other two relation types.

Do not derive User-Features-to-Interaction-Design relationships indirectly through a shared User Touchpoints node.

Do not derive User-Features-to-UI-Composition-Architecture relationships indirectly through a shared User Touchpoints node.

Do not derive Interaction-Design-to-UI-Composition-Architecture relationships indirectly through a shared User Touchpoints node.

The three parallel branches answer different questions and must be discovered independently.

# Do not infer code locations directly from touchpoints

A touchpoint using a UI Composition Architecture responsibility does not automatically imply a direct Touchpoint-to-UI-Code-Organization relation.

UI Code Organization relationships must be discovered through independently meaningful UI Composition Architecture nodes.

The UI Code Organization layer exists to explain where composition responsibilities live in source, not to bypass the UI Composition Architecture View.

# Do not infer architecture from code organization

A source area containing several UI files does not automatically imply one UI Composition Architecture responsibility.

A UI Composition Architecture responsibility does not automatically correspond to one directory, module, or file.

Do not derive Architecture structure mechanically from source layout.

Do not derive source layout mechanically from Architecture structure.

# Do not invent relations

Completeness does not mean connecting everything.

Create a relation only when the code materially supports it.

Do not connect nodes merely because:

- they are close in their hierarchy
- they appear on the same screen
- they share a source folder
- they share a framework
- they share a component library
- they interact incidentally
- one eventually invokes code related to another
- two touchpoints look visually similar
- two pages use similarly named files
- a composition mechanism happens to live somewhere inside a source area
- the connection seems theoretically plausible

A relation should materially help explain how the two views in that relation layer correspond.

# Use existing nodes

Do not create extra nodes solely to make cross-view relations easier to express.

Relations should connect nodes that were independently discovered as meaningful members of their own view.

If an existing abstraction is too coarse to express an important relationship, reconsider that view only if the missing node is independently meaningful within the view itself.

Do not create mapping-only nodes.

# Exact relation consistency

For all semantic relation layers:

**One Mermaid `-.-` cross-view relation edge = one relation-table row.**

And:

**One relation-table row = one Mermaid `-.-` cross-view relation edge.**

There must be no undocumented Mermaid `-.-` relation.

There must be no relation-table row without a corresponding Mermaid `-.-` edge.

Presentation-only `layout...@-->` layout-constraint edges are explicitly excluded from this rule because they are not semantic relations.

# Markdown report output

After the first fenced `mermaid` block has been fully closed, open the second fenced `markdown` block.

All remaining sections below must be produced inside that single fenced `markdown` block.

Do not open another Mermaid block.

Do not place any of the following sections inside the Mermaid block.

# User Touchpoints mapping table

After the Mermaid diagram, create the User Touchpoints View table.

| RefTouchpoint pathMeaning in simple termsUser-facing evidence / surfaceRelevant code areasConfidenceNotes |
| ------------------------------------------------------------------------------------------------------ |

The path must describe the semantic hierarchy from the User Touchpoints root toward the specific touchpoint.

Example:

`E1 → E2 → E5`

Describe this view only from the direct interaction perspective.

Do not explain mappings to other views here.

# User Features mapping table

Then create the User Features View table.

| RefFeature pathMeaning in simple termsRelevant code areasConfidenceNotes |
| ----------------------------------------------------------------------- |

Semantic paths must always be written root-first even though Mermaid User Features hierarchy statements are written child-first for layout.

Example:

`F1 → F2 → F5`

Describe only the user-facing feature, capability, outcome, or guarantee here.

Do not explain mappings to other views in this table.

# Interaction Design mapping table

Then create the Interaction Design View table.

| RefInteraction pathInteraction responsibility in simple termsRelevant code areasConfidenceNotes |
| ---------------------------------------------------------------------------------------------- |

Semantic paths must always be written root-first even though Mermaid Interaction Design hierarchy statements are written child-first for layout.

Example:

`I1 → I2 → I5`

Describe only the interaction behavior or design responsibility here.

Do not explain mappings to other views in this table.

# UI Composition Architecture mapping table

Then create the UI Composition Architecture View table.

| RefArchitecture pathUI composition responsibility in simple termsRelevant code areasConfidenceNotes |
| ----------------------------------------------------------------------------------------------- |

The path should make the node's location in the UI Composition Architecture hierarchy unambiguous.

Example:

`A1 → A2 → A5`

Describe only the composition, rendering, routing, layout, state, script, hosting, or coordination responsibility here.

Do not explain mappings to other views in this table.

# UI Code Organization mapping table

Then create the UI Code Organization View table.

| RefCode Organization pathSource location in simple termsConcrete UI code locationsConfidenceNotes |
| ----------------------------------------------------------------------------------------------- |

Semantic paths must always be written root-first even though Mermaid UI Code Organization hierarchy statements are written child-first for layout.

Example:

`C1 → C2 → C5`

Describe only the source organization and navigation meaning here.

Use concrete project, module, package, directory, namespace, component-area, script, template, or file locations where useful.

Do not explain UI Composition Architecture mappings in this table.

# User-Touchpoints-to-User-Features relation table

Then create:

## User Touchpoints ↔ User Features Relations

Use relation references:

`EF1`, `EF2`, `EF3`, ...

| RefTouchpoint RefFeature RefRelationMeaning in simple termsConfidenceEvidence |
| ---------------------------------------------------------------------------- |

Possible relation meanings may include:

- exposes
- provides access to
- invokes
- controls
- configures
- presents
- represents
- enables
- observes
- supplies input to
- receives output from

Choose the relation meaning from the actual code evidence.

Do not put these labels on Mermaid edges.

# User-Touchpoints-to-Interaction-Design relation table

Then create:

## User Touchpoints ↔ Interaction Design Relations

Use relation references:

`EI1`, `EI2`, `EI3`, ...

| RefTouchpoint RefInteraction RefRelationMeaning in simple termsConfidenceEvidence |
| -------------------------------------------------------------------------------- |

Possible relation meanings may include:

- uses
- expresses
- presents
- follows
- applies
- participates in
- provides surface for
- realizes
- varies from
- specializes

Choose the relation meaning from the actual code evidence.

Do not put these labels on Mermaid edges.

# User-Touchpoints-to-UI-Composition-Architecture relation table

Then create:

## User Touchpoints ↔ UI Composition Architecture Relations

Use relation references:

`EA1`, `EA2`, `EA3`, ...

| RefTouchpoint RefArchitecture RefRelationMeaning in simple termsConfidenceEvidence |
| --------------------------------------------------------------------------------- |

Possible relation meanings may include:

- rendered through
- composed by
- hosted by
- mounted through
- routed through
- laid out by
- initialized by
- controlled by
- state provided by
- shares composition with
- uses shared infrastructure
- isolated within

Choose the relation meaning from the actual code evidence.

Do not put these labels on Mermaid edges.

# UI-Composition-Architecture-to-UI-Code-Organization relation table

Then create:

## UI Composition Architecture ↔ UI Code Organization Relations

Use relation references:

`AC1`, `AC2`, `AC3`, ...

| RefArchitecture RefCode Organization RefRelationMeaning in simple termsConfidenceEvidence |
| ---------------------------------------------------------------------------------------- |

Possible relation meanings may include:

- located in
- primarily located in
- distributed across
- enters through
- initialized in
- configured in
- implemented across
- coordinated in
- state owned in
- rendered from
- laid out in
- hosted in
- tested in
- shares source area
- cross-cuts

Choose the relation meaning from the actual code evidence.

Do not put these labels on Mermaid edges.

# Keep all description layers separate

Treat the output as nine distinct information layers.

## User Touchpoints description layer

Contains only information about `E...` nodes.

Describe:

- what the user or direct consumer directly interacts with
- what kind of touchpoint it is
- which user-facing area it belongs to
- where this is evidenced in the code

Do not explain mappings to other views here.

## User Features description layer

Contains only information about `F...` nodes.

Describe:

- what the user can meaningfully do, achieve, control, observe, or rely on
- what the feature or guarantee provides
- how it fits into the feature hierarchy
- where it is evidenced in code

Do not explain touchpoint, interaction-design, UI-composition, or code-organization mappings here.

## Interaction Design description layer

Contains only information about `I...` nodes.

Describe:

- what interaction behavior or pattern exists
- what interaction responsibility it fulfills
- how it fits into the Interaction Design hierarchy
- where it is evidenced in code

Do not explain Touchpoint, User Feature, UI Composition Architecture, or UI Code Organization mappings here.

## UI Composition Architecture description layer

Contains only information about `A...` nodes.

Describe:

- how the user-facing application is assembled
- what rendering, routing, layout, state, script, component, hosting, or coordination responsibility exists
- whether the responsibility is shared or local
- how it fits into the UI Composition Architecture hierarchy
- where it is evidenced in code

Do not explain User Feature, Interaction Design, or UI Code Organization mappings here.

## UI Code Organization description layer

Contains only information about `C...` nodes.

Describe:

- where meaningful UI code is located
- what navigation or source boundary the node represents
- whether it is shared, page-local, generated, legacy, test-oriented, or otherwise structurally meaningful
- where a developer should look
- what concrete code locations form the area

Do not explain User Touchpoint, User Feature, Interaction Design, or UI Composition Architecture mappings here.

## User-Touchpoints-to-User-Features relationship layer

Contains only information about how `E...` nodes relate to `F...` nodes.

Uses `EF...` references.

## User-Touchpoints-to-Interaction-Design relationship layer

Contains only information about how `E...` nodes relate to `I...` nodes.

Uses `EI...` references.

## User-Touchpoints-to-UI-Composition-Architecture relationship layer

Contains only information about how `E...` nodes relate to `A...` nodes.

Uses `EA...` references.

## UI-Composition-Architecture-to-UI-Code-Organization relationship layer

Contains only information about how `A...` nodes relate to `C...` nodes.

Uses `AC...` references.

This separation is essential.

User Features, Interaction Design, and UI Composition Architecture must not collapse into one another merely because all three describe aspects of the same touchpoints.

UI Composition Architecture and UI Code Organization must not collapse into one another merely because architecture responsibilities are implemented in source locations.

The detail level of one description layer must not be reduced merely because another description layer contains overlapping evidence or concepts.

# Optional observations

After the tables, add a short section only when meaningful structural patterns are visible.

Keep observations separated by scope.

## User Touchpoints observations

Only observations about the User Touchpoints View.

Examples:

- one product area contains many unrelated touchpoints
- several technical controls together form one meaningful user touchpoint
- similar touchpoints are distributed across several product areas
- a touchpoint is unusually broad or unusually narrow

Use `E...` references.

## User Features observations

Only observations about the User Features View.

Examples:

- one feature area contains several independently meaningful outcomes
- several features are variants of one broader user capability
- a user-facing guarantee deserves its own node
- one feature appears broader than the touchpoints through which it is exposed

Use `F...` references.

## Interaction Design observations

Only observations about the Interaction Design View.

Examples:

- one interaction pattern appears repeatedly across unrelated areas
- similar actions use different interaction behavior
- error or validation behavior varies significantly
- one interaction area contains several distinct interaction models

Use `I...` references.

## UI Composition Architecture observations

Only observations about the UI Composition Architecture View.

Examples:

- most pages share one application shell
- layout composition is centrally controlled
- pages define their own layouts independently
- scripts are initialized centrally
- scripts are initialized separately per page
- routing provides a common composition boundary
- state ownership is centralized
- state ownership is fragmented across pages
- dialogs and notifications use shared hosts
- several independent rendering systems coexist
- one product area forms an isolated UI island
- legacy pages bypass the shared composition model
- server-rendered and client-rendered areas form distinct composition families
- component reuse is high while page composition remains fragmented
- visual similarity hides substantially different composition paths

Use `A...` references.

## UI Code Organization observations

Only observations about the UI Code Organization View.

Examples:

- most UI composition code is concentrated in a small number of source areas
- page-local UI code dominates the repository structure
- routing, layout, and state responsibilities are strongly centralized
- UI responsibilities are distributed across many unrelated folders
- one directory contains several unrelated composition responsibilities
- shared UI mechanisms are duplicated across page areas
- a small number of key files act as major composition anchors
- legacy UI code forms a clearly isolated source area
- generated and authored UI code are cleanly separated
- generated and authored UI code are mixed in navigation-critical areas
- tests mirror implementation organization closely
- test ownership differs substantially from implementation ownership

Use `C...` references.

## User Touchpoints ↔ User Features observations

Only observations that emerge from `EF...` mappings.

Examples:

- several touchpoints converge on one feature
- one touchpoint exposes many unrelated features
- one feature is available through several interaction surfaces
- feature exposure is fragmented across multiple touchpoints
- a user feature has no clear direct touchpoint

## User Touchpoints ↔ Interaction Design observations

Only observations that emerge from `EI...` mappings.

Examples:

- many touchpoints share one interaction pattern
- similar touchpoints use inconsistent interaction designs
- one touchpoint combines unusually many interaction behaviors
- an interaction pattern is reused across unrelated product areas
- some touchpoints have highly local interaction behavior

## User Touchpoints ↔ UI Composition Architecture observations

Only observations that emerge from `EA...` mappings.

Examples:

- many touchpoints share one composition mechanism
- several pages use one shared layout system
- similar touchpoints are rendered through different architectures
- one touchpoint depends on several shared UI mechanisms
- several unrelated touchpoints converge on one shared state or hosting mechanism
- a product area is compositionally isolated from the rest of the application
- one rendering path dominates most of the product
- several rendering paths coexist without a common shell
- page scripts are predominantly local rather than centralized
- shared components exist without shared composition architecture

## UI Composition Architecture ↔ UI Code Organization observations

Only observations that emerge from `AC...` mappings.

Examples:

- one composition responsibility is concentrated in one clear source area
- one composition responsibility is scattered across many source locations
- several unrelated composition responsibilities converge in one source area
- a shared layout system has one obvious implementation anchor
- a conceptually shared mechanism is duplicated across multiple directories
- one central routing area coordinates many UI composition domains
- state responsibility is architecturally unified but source-wise fragmented
- composition responsibilities are distributed according to page rather than responsibility
- one small source area carries disproportionately many composition responsibilities
- architecture boundaries and source boundaries align closely
- architecture boundaries and source boundaries differ substantially
- a legacy composition architecture maps cleanly to one isolated source area
- a composition responsibility has no clear source ownership

## Parallel-view observations

Only when genuinely useful, add a brief subsection for structural patterns visible because the parallel Touchpoint relation layers exist.

Do not create new direct relations between User Features, Interaction Design, and UI Composition Architecture.

Examples:

- several touchpoints expose the same feature but use different interaction designs
- several touchpoints use the same interaction design but are composed through different rendering paths
- visually similar touchpoints share neither feature boundaries nor technical composition
- one shared UI composition mechanism supports touchpoints with unrelated features
- one feature is exposed through several touchpoints that share a common composition path
- interaction consistency is high even though technical composition is fragmented
- technical composition is highly centralized while interaction design remains inconsistent
- similar features are exposed through technically isolated UI areas

Such observations must be derived from the existing `EF...`, `EI...`, and `EA...` mappings.

They must not substitute for direct relation layers between the parallel views.

## Architecture-to-code concentration observations

Only when genuinely useful, add a brief subsection for patterns visible because the UI Composition Architecture and UI Code Organization views are both present.

Do not create additional relation layers.

Examples:

- a conceptually centralized architecture is physically scattered through the codebase
- a technically fragmented architecture is colocated in one source area
- one source area has become a concentration point for many unrelated UI responsibilities
- one architectural responsibility has no clear code owner
- source layout follows pages while architecture follows shared responsibilities
- source layout and architecture mirror each other closely
- composition centralization exists architecturally but not organizationally
- duplicated source implementations undermine an otherwise shared composition concept
- isolated UI islands are also isolated in source organization
- isolated UI islands are hidden inside otherwise shared source areas

Such observations must be derived from existing `AC...` mappings.

Do not use observations as a substitute for missing relation rows.

# Final review

Before returning the result, review each layer separately.

## User Touchpoints View

1. Does the view describe what users or direct consumers concretely interact with?
2. Has the view accidentally become a UI class, API method, or component inventory?
3. Has a user journey or chronological process been mistaken for a touchpoint hierarchy?
4. Are touchpoints grouped under meaningful shared surfaces?
5. Are siblings at comparable abstraction levels?
6. Are different user or consumer types only introduced when supported by evidence?
7. Are internal implementation details absent unless they form a meaningful interaction point?
8. Would a user or direct consumer recognize the concepts in this view?
9. Have touchpoints remained distinct when they expose materially different features?
10. Have touchpoints remained distinct when they use materially different interaction designs?
11. Have touchpoints remained distinct when they use materially different UI composition paths?
12. Has a user feature accidentally been represented as a touchpoint?
13. Has an interaction pattern accidentally been represented as a touchpoint?
14. Has a technical composition mechanism accidentally been represented as a touchpoint?

## User Features View

15. Are there multiple top-level features that should share a parent?
16. Are siblings operating at different abstraction levels?
17. Are several nodes merely different aspects of the same broader user feature?
18. Has touchpoint structure been mistaken for feature structure?
19. Has implementation structure been mistaken for feature structure?
20. Are concrete controls being presented as fundamental user features?
21. Could a group be explained more clearly by introducing a simpler shared feature concept?
22. Are variants of the same user feature recognizable as variants?
23. Have independently meaningful user outcomes been collapsed even though they map differently to touchpoints?
24. Are explicit user-facing guarantees represented when they form distinct product behavior?
25. Does each feature describe something meaningful that a user can do, achieve, control, observe, or rely on?
26. Would the User Features View remain useful if the Touchpoints View were removed?

## Interaction Design View

27. Does the view describe interaction behavior rather than simply listing UI elements?
28. Has visual styling been mistaken for interaction design?
29. Has the view become a component-library inventory?
30. Are interaction patterns grouped by meaningful behavioral responsibility?
31. Are siblings at comparable abstraction levels?
32. Are navigation, actions, inputs, feedback, state, validation, and recovery distinguished when materially different?
33. Have independently meaningful interaction patterns been collapsed even though they appear on different touchpoints?
34. Has a User Feature accidentally been renamed as an Interaction Design node?
35. Has a composition mechanism accidentally been mistaken for an interaction pattern?
36. Does the view explain how interaction works rather than merely what functionality exists?
37. Would the Interaction Design View remain useful if the User Touchpoints View were removed?

## UI Composition Architecture View

38. Does the view explain how the user-facing application is assembled, rendered, connected, and coordinated?
39. Has the view accidentally become a complete frontend source tree?
40. Has the view accidentally become generic software architecture?
41. Are components, scripts, layouts, routes, state mechanisms, and rendering responsibilities included because they form meaningful composition responsibilities rather than merely because they exist?
42. Are siblings at comparable architectural abstraction levels?
43. Are shared and page-local composition responsibilities distinguished when materially different?
44. Is application-shell responsibility represented when one exists?
45. Are shared layouts distinguished from page-specific layouts when materially different?
46. Are centralized and page-local script initialization distinguished when materially different?
47. Is state ownership represented at the level supported by the code?
48. Are shared hosts such as modal, notification, overlay, or navigation infrastructure represented when structurally meaningful?
49. Are separate rendering systems preserved when the product contains more than one?
50. Are server-rendered, client-rendered, hydrated, or otherwise distinct rendering boundaries represented when materially meaningful?
51. Are isolated or legacy UI areas preserved rather than forced into a common architecture?
52. Has code sharing been mistaken for composition sharing?
53. Has framework usage alone been mistaken for a coherent UI architecture?
54. Does the view make it possible to distinguish centralized UI composition from fragmented page-local composition?
55. Has source organization been mistaken for architecture?
56. Would the UI Composition Architecture View remain useful if the User Touchpoints and UI Code Organization Views were removed?

## UI Code Organization View

57. Does the view answer where meaningful UI composition code is located?
58. Has the view accidentally become a complete frontend or repository tree?
59. Are projects, modules, directories, namespaces, packages, components, scripts, and files included because they form useful navigation boundaries rather than merely because they exist?
60. Would a developer know where to begin looking for important UI composition responsibilities from this view?
61. Have several low-level source locations been grouped when they form one meaningful navigation area?
62. Have source areas remained separate when a developer would genuinely navigate to or modify them independently?
63. Are key rendering, routing, layout, bootstrap, or state entry points preserved when they materially improve navigation?
64. Are individual files avoided unless they are unusually important navigation anchors?
65. Are test areas included only when they materially improve understanding of where validation or regression coverage lives?
66. Is generated code distinguished from authored code when that distinction materially affects navigation or modification?
67. Are legacy UI areas preserved when they form meaningful source boundaries?
68. Has architectural responsibility been invented merely to make source organization align with UI Composition Architecture?
69. Are siblings at comparable source-organizational abstraction levels?
70. Does the view make code concentration and fragmentation visible?
71. Can the view reveal when one source area carries many unrelated UI responsibilities?
72. Can the view reveal when one architectural responsibility is spread across many source areas?
73. Would the UI Code Organization View remain useful if the UI Composition Architecture View were removed?

## User Touchpoints ↔ User Features Relations

74. Has every materially supported Touchpoint-to-Feature relationship between existing nodes been considered?
75. Are one-to-many and many-to-one mappings preserved?
76. Was any valid relation suppressed because an ancestor or descendant already has one?
77. Does every `E -.- F` Mermaid edge have exactly one `EF...` relation row?
78. Does every `EF...` row have exactly one Mermaid edge?
79. Are unsupported or speculative mappings excluded?
80. Are features exposed through several touchpoints mapped to all materially relevant touchpoints?
81. Are broad touchpoints allowed to map to several unrelated features?

## User Touchpoints ↔ Interaction Design Relations

82. Has every materially supported Touchpoint-to-Interaction-Design relationship between existing nodes been considered?
83. Are one-to-many and many-to-one mappings preserved?
84. Was any valid relation suppressed because an ancestor or descendant already has one?
85. Does every `E -.- I` Mermaid edge have exactly one `EI...` relation row?
86. Does every `EI...` row have exactly one Mermaid edge?
87. Are unsupported or merely superficial similarities excluded?
88. Are interaction patterns reused across several touchpoints mapped to all materially relevant touchpoints?
89. Are touchpoints combining several interaction behaviors allowed to map to several Interaction Design nodes?

## User Touchpoints ↔ UI Composition Architecture Relations

90. Has every materially supported Touchpoint-to-UI-Composition-Architecture relationship between existing nodes been considered?
91. Are one-to-many and many-to-one mappings preserved?
92. Was any valid relation suppressed because an ancestor or descendant already has one?
93. Does every `E -.- A` Mermaid edge have exactly one `EA...` relation row?
94. Does every `EA...` row have exactly one Mermaid edge?
95. Are incidental implementation relationships excluded?
96. Does each relation materially explain how the touchpoint is assembled, rendered, routed, hosted, initialized, or coordinated?
97. Are touchpoints using several meaningful composition mechanisms mapped to all materially relevant architecture nodes?
98. Are shared composition mechanisms allowed to map to several unrelated touchpoints?
99. Are isolated touchpoints allowed to map only to local composition responsibilities?

## UI Composition Architecture ↔ UI Code Organization Relations

100. Has every materially supported Architecture-to-Code-Organization relationship between existing nodes been considered?
101. Are one-to-many, many-to-one, and distributed source-location mappings preserved?
102. Was any valid relation suppressed because a parent or descendant already has one?
103. Does every `A -.- C` Mermaid edge have exactly one `AC...` relation row?
104. Does every `AC...` row have exactly one Mermaid edge?
105. Are incidental file-level relationships excluded?
106. Does each relation materially help answer where a developer should look?
107. Are composition responsibilities spanning multiple source areas mapped to all materially relevant areas?
108. Are shared source areas allowed to map to several unrelated composition responsibilities?
109. Are concentrated responsibilities allowed to map primarily to one source anchor?
110. Are fragmented responsibilities allowed to map to several independently meaningful source areas?

## Parallel views

111. Was User Features derived independently from Interaction Design?
112. Was User Features derived independently from UI Composition Architecture?
113. Was Interaction Design derived independently from UI Composition Architecture?
114. Has any parallel view been simplified merely because another view describes the same touchpoint?
115. Has any parallel view been regrouped merely to align visually with another?
116. Are differences between feature boundaries, interaction-design boundaries, and UI-composition boundaries preserved?
117. Is overlap between parallel views allowed when independently justified?
118. Are there no direct User-Features-to-Interaction-Design Mermaid relations?
119. Are there no direct User-Features-to-UI-Composition-Architecture Mermaid relations?
120. Are there no direct Interaction-Design-to-UI-Composition-Architecture Mermaid relations?
121. Are any observations comparing the parallel views derived only from their independently supported Touchpoint mappings?

## UI Composition Architecture and UI Code Organization

122. Was UI Composition Architecture derived independently from UI Code Organization?
123. Was UI Code Organization derived independently from UI Composition Architecture?
124. Has either view been simplified, regrouped, or reorganized merely to resemble the other?
125. Are differences between composition responsibility boundaries and source-location boundaries preserved?
126. Is meaningful overlap between Architecture and Code Organization allowed when independently justified?
127. Is one architecture responsibility allowed to span several code locations?
128. Is one code location allowed to contain several architecture responsibilities?
129. Has a directory structure been mistaken for architecture?
130. Has an architecture hierarchy been mechanically translated into a source tree?
131. Do `AC...` mappings make concentration and fragmentation visible?
132. Are observations comparing architecture and code organization derived from existing `AC...` mappings rather than invented direct assumptions?

## Separation

133. Was the User Touchpoints View derived independently rather than copied from UI or API structure?
134. Was the User Features View derived independently rather than renamed from Touchpoints?
135. Was the Interaction Design View derived independently rather than translated from Touchpoints?
136. Was the UI Composition Architecture View derived independently rather than translated from Touchpoints or Interaction Design?
137. Was the UI Code Organization View derived independently rather than translated from UI Composition Architecture?
138. Would each view still be sufficiently complete and useful at its current detail level if the other four views were removed?
139. Has any view been compressed, regrouped, omitted from, or simplified merely because another view contains overlapping information?
140. Has any meaningful node or distinction been removed solely because another view represents similar information?
141. Are cross-view explanations confined to their relation layers?
142. Are there no direct User-Touchpoints-to-UI-Code-Organization relations?
143. Are there no direct User-Features-to-UI-Code-Organization relations?
144. Are there no direct Interaction-Design-to-UI-Code-Organization relations?
145. Could User Features be removed or replaced without redefining Interaction Design, UI Composition Architecture, or UI Code Organization?
146. Could Interaction Design be removed or replaced without redefining User Features, UI Composition Architecture, or UI Code Organization?
147. Could UI Code Organization be removed or replaced without redefining User Features or Interaction Design?

## Diagram

148. Is the User Touchpoints View on the left?
149. Are User Features, Interaction Design, and UI Composition Architecture all positioned to the right of User Touchpoints as parallel perspectives?
150. Is UI Code Organization positioned to the right of UI Composition Architecture?
151. Has any of the three parallel views accidentally been positioned semantically after another?
152. Has UI Code Organization accidentally been presented as downstream from User Features or Interaction Design?
153. Does the User Touchpoints hierarchy grow toward its neighboring views?
154. Does the User Features hierarchy grow toward User Touchpoints?
155. Does the Interaction Design hierarchy grow toward User Touchpoints?
156. Does the UI Composition Architecture hierarchy bridge User Touchpoints and UI Code Organization without being restructured merely for visual alignment?
157. Does the UI Code Organization hierarchy grow toward UI Composition Architecture?
158. Are `*E...`, `*F...`, `*I...`, `*A...`, and `*C...` references visible and consistent?
159. Are hierarchy edges visually distinct from semantic cross-view relation edges?
160. Are semantic cross-view relation edges unlabeled?
161. Does the diagram expose useful many-to-many structures without explanatory text on the edges?
162. Is the diagram still reasonably readable on a normal screen?
163. Does the generated layout-constraint topology match the configured view topology?
164. Is there exactly one presentation-only layout constraint from User Touchpoints to User Features?
165. Is there exactly one presentation-only layout constraint from User Touchpoints to Interaction Design?
166. Is there exactly one presentation-only layout constraint from User Touchpoints to UI Composition Architecture?
167. Is there exactly one presentation-only layout constraint from UI Composition Architecture to UI Code Organization?
168. Are all `layout...@-->` edges visually invisible and excluded from semantic relation tables and relation consistency checks?
169. Has the diagram avoided forcing the three parallel views into a false semantic sequence?
170. Has the diagram avoided bypassing UI Composition Architecture with a direct Touchpoints-to-Code-Organization relationship?

The goal is not to produce five complete inventories.

The goal is to create a **compressed semantic model of the user-facing system from five independent perspectives**:

**User Touchpoints View: what users or direct consumers concretely interact with**

**User Features View: what meaningful things users can do, achieve, control, observe, or rely on**

**Interaction Design View: how those concrete interactions behave and are structured**

**UI Composition Architecture View: how those concrete user-facing surfaces are assembled, rendered, connected, and coordinated technically**

**UI Code Organization View: where those UI composition responsibilities live in the codebase and where a developer should look to understand or change them**

Each view should be independently useful and independently complete at its appropriate level of semantic compression.

The existence of another view must not be used as a reason to remove otherwise meaningful structure or detail.

Overlap between views is acceptable when the same product reality is independently meaningful from different perspectives.

The User Touchpoints View acts as the common bridge to three different questions:

**What does this touchpoint enable for the user?**

**How does interaction at this touchpoint work?**

**How is this touchpoint technically assembled, rendered, connected, and coordinated?**

The UI Composition Architecture View then acts as the bridge to a source-location question:

**Where in the codebase do these UI composition responsibilities live?**

Do not collapse these questions into one view.

Do not assume that the user-facing application has one coherent composition architecture.

Do not assume that architecture boundaries and source-code boundaries align.

The resulting artifact should make centralization, fragmentation, concentration, duplication, isolation, and unclear ownership visible when supported by the code.

The resulting artifact should be useful both for humans and for LLMs as a compact entry point for understanding the product's user-facing features, concrete touchpoints, interaction behavior, UI composition architecture, and UI code organization.