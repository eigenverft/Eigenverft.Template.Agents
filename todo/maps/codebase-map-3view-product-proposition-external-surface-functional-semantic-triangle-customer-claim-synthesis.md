Analyze the codebase and create a compact three-view product-and-codebase comprehension map.

The result should contain three independently derived views of the same codebase:

**Product Proposition View**
What meaningful consumer-relevant outcomes or product propositions are credibly supported by the codebase?

**External Surface View**
What does the system expose to the outside world?

**Functional View**
What capabilities does the system provide and how do those capabilities relate functionally?

After all three views and their relation layers have been completed, derive a separate:

**Customer Claim Synthesis**

The Customer Claim Synthesis answers:

**How could one or more existing Product Propositions be communicated as a concise customer-facing claim, what can already be claimed credibly, and what Functional support would be missing for a stronger desirable claim?**

The Customer Claim Synthesis is not a fourth view.

It is a derived synthesis layer built only after the three independent views and their relations are complete.

The three views must remain conceptually separate.

Each view must also remain independently complete at the level of detail appropriate to that view.

Derive each view as if it had to stand on its own as a useful representation of the codebase from that perspective.

The presence of additional views, relations, or the later Customer Claim Synthesis must not reduce the structure, distinctions, or useful detail that a view would otherwise contain.

A later synthesis layer must not retroactively influence which nodes, guarantees, external distinctions, hierarchy boundaries, or abstraction levels are independently necessary in an earlier view.

Their definitions are isolated below so that any individual view can later be replaced by another kind of view without changing the logic of the remaining views or unrelated relation layers.

The intended conceptual structure is:

PRODUCT / CONSUMER                              SYSTEM MEANING

Product Proposition → External Surface → Functional
          \___________________________________/

or conceptually:

**Product Proposition ↔ External Surface ↔ Functional Capability**

with an additional independent:

**Product Proposition ↔ Functional Capability**

relationship layer.

The three views therefore form a semantic triangle.

Do not interpret this triangle as a process or sequence.

The Product Proposition View represents consumer-relevant outcomes that the codebase can credibly support.

The External Surface View represents how external consumers can interact with or rely on the system.

The Functional View represents what the system actually does or guarantees.

The Customer Claim Synthesis then derives customer-facing communication from the completed Product Proposition View and its supporting evidence.

Do not derive one view mechanically from another.

The Product Proposition View must not be created merely by rewriting External Surface or Functional nodes in more customer-friendly language.

The External Surface View must not be created from Product Proposition nodes.

The Functional View must not be created from either neighboring view.

Only after all three views have been independently completed should the three relation layers be discovered.

Only after all three views and all three relation layers have been completed should Customer Claim Synthesis begin.

# View A Definition: Product Proposition View

The Product Proposition View answers:

**What meaningful consumer-relevant outcomes or product propositions are credibly supported by the codebase?**

A Product Proposition describes a meaningful outcome, value, or reliable product property that an external consumer can plausibly obtain or rely on because of the system.

The Product Proposition View is codebase-grounded.

It does not attempt to infer market demand, customer preference, willingness to pay, competitive differentiation, pricing, positioning, or commercial success.

Those require evidence outside the codebase.

Instead ask:

**What could we credibly say this product enables, provides, preserves, protects, or makes possible for a supported external consumer based on what the codebase actually does?**

Depending on the codebase, relevant consumers may include:

- end users
- application developers
- API clients
- administrators
- operators
- integration partners
- plugin authors
- organizations using the software
- teams relying on the software
- external services interacting with the software

Do not assume which consumer types exist.

Derive them from codebase evidence.

## Product Proposition is not marketing copy

Do not write slogans, promotional language, aspirational positioning, or unsupported claims.

Avoid claims such as:

- industry-leading
- enterprise-grade
- best-in-class
- effortless
- revolutionary
- highly scalable
- secure by design
- zero-downtime
- production-ready
- customer-loved

unless the exact meaning of such a claim is materially established by codebase evidence, which is uncommon.

Prefer concrete proposition language such as:

- users can...
- consumers can rely on...
- the product allows...
- the product preserves...
- the product prevents...
- the product supports...
- the product provides controlled...
- the product enables users to...
- the product maintains... when...

The Product Proposition View should establish a **claim boundary**, not produce finished marketing copy.

Marketing or Product may later translate one or several supported propositions into customer-facing communication.

That translation belongs to the later Customer Claim Synthesis.

## Product Proposition is not Functional rewritten

A Functional capability answers:

**What does the system do or guarantee?**

A Product Proposition answers:

**Why can that behavior matter as an outcome or reliable property for an external consumer?**

Do not create a Product Proposition merely by adding:

- user
- customer
- consumer
- safely
- easily
- reliably

to a Functional node name.

For example, conceptually:

Functional:
Controlled export

Product Proposition:
Customers can export data

is usually too close to a direct rewrite.

A stronger independent Product Proposition might instead capture an outcome such as:

Consumers can hand generated results to downstream recipients
without granting unrestricted access to the working environment

when that broader outcome is materially supported by the codebase.

Several Functional capabilities or guarantees may jointly support one Product Proposition.

One Functional capability may support several different Product Propositions.

A Product Proposition may also be meaningful even when no current External Surface clearly exposes it.

## Product Proposition admission rule

Create a Product Proposition node only when the proposition is independently meaningful from the product/consumer perspective.

For an important candidate, ask:

### Consumer relevance

Is there a supported external consumer for whom this outcome or property could meaningfully matter?

### Outcome beyond mechanism

Does the proposition describe an outcome, value, or reliable product property rather than merely naming a mechanism, API, component, operation, or internal capability?

### Codebase support

Can the proposition be materially supported by codebase evidence?

### Claim discipline

Does the proposition avoid unsupported assumptions about:

- demand
- desirability
- market size
- willingness to pay
- competitive advantage
- customer satisfaction
- strategic importance

If a candidate is merely a Functional capability expressed more pleasantly, keep it only in the Functional View.

If a candidate depends on unsupported market assumptions, do not include it.

## Current proposition versus latent product possibility

Do not force Product Proposition nodes into fixed categories such as:

`Current propositions`

and:

`Potential propositions`

Derive the Product Proposition hierarchy independently.

Only afterwards examine its relations.

A proposition that is:

- strongly supported by Functional nodes
- but has no clear current External Surface relation

may represent a **potential productization or exposure candidate**.

This is an observation, not proof of customer demand or commercial value.

Do not label such a proposition as:

- market opportunity
- high-value opportunity
- customer need
- missing feature
- revenue opportunity

based on codebase evidence alone.

Use cautious language such as:

- potentially productizable
- weakly exposed
- not clearly exposed through the current external surface
- existing capability with possible product-facing use

## Claim boundaries

For each meaningful Product Proposition, distinguish between:

**What the codebase supports saying**

and:

**What stronger interpretation would exceed the evidence**

when that distinction is useful.

For example, a codebase may support:

Preserves the last valid configuration when a runtime reload is invalid

without supporting:

Provides zero-downtime configuration

A codebase may support:

Restricts access according to scoped authorization rules

without supporting:

Provides enterprise-grade security

Use the Product Proposition table to preserve important claim boundaries.

These claim boundaries also constrain the later Customer Claim Synthesis.

A synthesized Customer Claim must not bypass or weaken a Product Proposition's claim boundary.

## Measurement opportunities

For each meaningful Product Proposition, consider whether the codebase reveals a plausible way to measure usage or outcome with privacy-minimizing instrumentation.

This is optional.

Do not invent measurement merely to fill the table.

Possible measurement categories include:

- invocation count
- activation count
- successful completion count
- failure count
- completion ratio
- latency distribution
- retry or recovery count
- aggregate usage frequency
- repeat use
- use of one supported variant versus another
- successful preservation of a guarantee
- aggregate workflow completion

Distinguish when useful between:

**Exposure / usage signal**

Was the relevant external interaction invoked?

and:

**Functional outcome signal**

Was the underlying capability successfully completed or guarantee meaningfully exercised?

Do not assume that an External Surface invocation is a sufficient proxy for a Functional outcome.

Several External Surfaces may expose the same Functional capability.

A Functional capability may therefore provide a better measurement boundary than any single External Surface.

## Privacy-minimizing measurement

Prefer measurement opportunities that can work without collecting customer content or unnecessary identifying information.

Where possible, prefer:

- aggregate counters
- coarse status categories
- success/failure outcomes
- bounded latency buckets
- anonymous or non-content event categories
- feature activation flags
- aggregate workflow counts

Avoid proposing collection of:

- source code contents
- file contents
- file names when unnecessary
- prompts
- emails or message bodies
- raw payloads
- document contents
- customer-generated text
- secrets
- authentication material
- personal identifiers
- stable user identifiers when aggregate measurement is sufficient

A privacy-minimizing measurement suggestion is not a legal privacy or compliance determination.

Do not claim that a proposed metric is legally compliant merely because it avoids content.

If the codebase already contains logging, metrics, statistics, audit records, telemetry, counters, or feedback mechanisms, use them as evidence when relevant.

Do not create Product Proposition nodes solely because telemetry exists.

## Product Proposition hierarchy

Where useful, distinguish between:

- broad product outcome
- consumer value area
- reliable product property
- user-achievable outcome
- controlled outcome
- protected outcome
- product-facing guarantee
- productized capability
- supporting proposition
- specialized proposition

These are guidance, not a rigid schema.

Build the hierarchy from the evidence in the codebase.

Do not force propositions into a fixed sales funnel, customer journey, or lifecycle.

# View B Definition: External Surface View

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

Do not assume which consumer types exist.

Derive them from the codebase.

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

## Not a Product Proposition View

Do not explain why an external interaction should matter commercially or as customer value.

External Surface answers:

**What is available from outside?**

Product Proposition answers:

**What consumer-relevant outcome or product property can the codebase credibly support?**

An External Surface may have no independently meaningful Product Proposition.

This may occur for:

- technical administration
- protocol metadata
- compatibility endpoints
- diagnostic interfaces
- operational configuration
- internal integration contracts

Do not invent a Product Proposition merely because an External Surface exists.

## Preserve externally meaningful interaction boundaries

Do not collapse externally different interaction surfaces merely because they share the same transport, host, protocol stack, controller framework, or implementation mechanism.

For example, several HTTP endpoints should not automatically share one semantic External parent merely because they are all HTTP.

Ask instead whether they represent materially different external interaction contracts or consumer roles.

Preserve separate External nodes or areas when surfaces differ materially in:

- consumer type
- interaction contract
- authorization model
- lifecycle
- configuration role
- capability-token semantics
- human versus machine interaction
- administrative versus ordinary use
- protocol behavior
- observable failure behavior
- neighboring Functional mappings

Shared transport is evidence about implementation or delivery.

It is not by itself sufficient evidence for a shared External semantic parent.

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

# View C Definition: Functional View

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

## Not a Product Proposition View

Do not modify Functional names or grouping merely to make them customer-friendly or marketable.

Functional answers:

**What does the system provide, prevent, preserve, or guarantee?**

It should remain semantically precise even when the resulting concepts are not directly marketable.

A Functional capability may support no Product Proposition.

A Functional capability may support several Product Propositions.

Several Functional capabilities may jointly support one Product Proposition.

Do not collapse Functional guarantees merely to make a Product Proposition or Customer Claim easier to express.

## Preserve Functional distinctions independently of Product synthesis

The fact that several Functional behaviors contribute to the same Product Proposition or Customer Claim is not evidence that they belong in one Functional node.

Do not merge, regroup, omit, or broaden Functional nodes merely because they later support the same Product Proposition or Customer Claim.

Derive the Functional hierarchy according to Functional semantics alone.

In particular, keep behaviors separate when they answer materially different system questions even when Product or Customer language later combines them.

Examples of distinct questions include:

- What enters the system, and under which validation rules?
- What leaves the system, and under which capability or lifetime rules?
- Who may claim work?
- Who may report or commit an outcome?
- What happens when a claim becomes stale?
- What state is normative?
- What state records execution?
- Who may approve a change?
- What remains valid after a failed replacement?
- What authority is represented in a task specification?
- What authority is mechanically enforced at an effect boundary?
- Which credentials remain outside an external request?
- Which authorization rule applies to an operation?
- What is persisted?
- What can be recovered?
- What remains isolated or contained?

If two behaviors answer different questions of this kind, prefer separate Functional nodes under a shared parent when both are independently meaningful.

Do not use Product communication simplicity as a Functional compression criterion.

## Preserve directionally or lifecycle-distinct behavior

Do not automatically combine two behaviors merely because they concern the same conceptual resource or broad feature area.

For example, consider preserving separate Functional nodes when two behaviors differ materially in:

- ingress versus egress
- creation versus consumption
- claim versus report
- proposal versus approval
- execution versus governance
- current state versus historical state
- validation versus recovery
- authorization representation versus authorization enforcement
- configuration acceptance versus runtime fallback

A shared higher-level Functional parent may group such behaviors without erasing the distinction.

# Shared hierarchy rules

Apply the following rules independently to all three views.

## Build meaningful hierarchies

Do not force a fixed number of levels.

The meaning and depth of each branch should emerge from the code.

Every parent-child relationship should express a meaningful grouping.

## Hierarchy levels

After the hierarchy of a view has been derived, assign each node its semantic hierarchy level within that view.

Use:

`L1`, `L2`, `L3`, ...

The root of a view is always:

`L1`

A direct child of the root is:

`L2`

Its direct child is:

`L3`

and so on.

Levels are derived from the final semantic hierarchy.

Do not force a hierarchy to have three levels.

A view may contain two, three, four, or more levels when supported by the code.

Do not add or remove grouping nodes merely to produce visually uniform level counts across views.

Hierarchy levels are descriptive metadata.

They are not node identifiers.

They do not replace stable node references.

They must not be used to make independently derived views structurally align.

## Look for shared parents

Do not automatically treat every discovered item as a separate top-level node.

Whenever several neighboring items appear, ask:

- Do these belong together?
- Are they different aspects of a broader concept?
- Is there a simple common concept that explains them together?
- Is one actually a specialization, variant, proposition, exposure, guarantee, capability, or part of another?
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

- consumer outcome
- product claim boundary
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
- neighboring-view mappings

A distinction is especially worth preserving when two concepts map differently to nodes in an adjacent view.

For example, if two Functional behaviors belong to the same broader capability but support materially different Product Propositions, keep them separate under their shared Functional parent when collapsing them would hide those differences.

Likewise, if two External interactions expose different aspects of the same capability, keep them separate when that distinction materially improves either External-to-Functional or Product-to-External mappings.

Within Product Proposition, keep outcomes separate when they materially differ in:

- consumer value
- guarantee relied upon
- current exposure
- measurement opportunity
- claim boundary
- neighboring External mappings
- neighboring Functional mappings

Do not collapse Product Proposition nodes merely because they could later be combined into one Customer Claim.

Do not collapse Functional nodes merely because they later contribute to the same Product Proposition or Customer Claim.

Customer Claim synthesis must adapt to the independently derived Product Propositions and Functional semantics, not the other way around.

Do not add detail merely for completeness.

Preserve detail when it carries structural meaning.

## Preserve explicit system guarantees

Treat explicit guarantees as independently meaningful Functional behaviors when they enforce a distinct property of the system.

In particular, do not absorb a meaningful guarantee into a generic configuration, Product Proposition, shared Functional parent, or Customer Claim merely because it contributes to a broader product outcome.

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
- "Who may claim work?"
- "Who may commit the resulting state?"
- "Which state is normative?"
- "What happens to stale authority?"

then consider representing it as its own Functional node.

A Product Proposition may rely on several such guarantees.

A Customer Claim may summarize several such guarantees.

Neither is a reason to collapse those guarantees in the Functional View.

## Consider alternative groupings

Do not automatically accept the first plausible hierarchy.

For important areas, consider whether another grouping would explain the structure more clearly or with fewer concepts.

Prefer the structure that explains the most with the fewest clear and meaningful terms.

If two groupings are similarly plausible, mention the alternative briefly rather than forcing artificial certainty.

# Keep all three views independent

Derive all three views independently from the codebase.

Evaluate the necessary structure, distinctions, and level of detail of each view only against that view's own definition and the evidence in the codebase.

Each view must be sufficiently complete to remain useful if the other two views and the later Customer Claim Synthesis were removed from the artifact.

Do not reduce the detail of one view merely because another view or later synthesis layer represents some of the same behavior, evidence, concepts, outcomes, or guarantees more explicitly.

Do not compress, regroup, omit, or simplify a view merely to reduce overlap or redundancy with another view or with the Customer Claim Synthesis.

Do not remove a meaningful node or distinction from one view solely because similar information appears elsewhere.

Do not simplify an earlier view because a later synthesis layer can describe the same information more compactly.

A synthesis layer is a consumer of view information.

It is not a replacement for that information.

Redundancy between independently derived views is allowed when the same codebase reality is independently meaningful from more than one perspective.

Such overlap is not itself a defect.

Differences in how independently complete views group or distinguish the same underlying behavior can be valuable information.

Do not create the Product Proposition View by renaming External or Functional nodes.

Do not create the External Surface View by translating Product Proposition nodes into APIs or UI areas.

Do not create the Functional View by translating Product Proposition outcomes into capabilities.

Do not alter Product Proposition nodes merely because several of them can later support one Customer Claim.

Do not alter External nodes merely because several external interactions contribute to the same Product Proposition or Customer Claim.

Do not alter Functional nodes merely because several Functional behaviors contribute to the same Product Proposition or Customer Claim.

Do not alter the structure of one view merely to make it align visually or conceptually with another.

Do not alter the structure of one view merely because another independently derived view now covers similar ground.

Do not alter the structure of one view merely to make hierarchy levels align with another view.

Their structures are expected to differ.

Their structures may partially overlap.

Their hierarchy depths may differ.

All of these outcomes can be meaningful.

For example:

- several External interactions may support one Product Proposition
- one External interaction may support several Product Propositions
- one Product Proposition may depend on several Functional capabilities or guarantees
- one Functional capability may support several Product Propositions
- several distinct Functional guarantees may jointly support one Product Proposition without becoming one Functional node
- several Product Propositions may jointly support one Customer Claim without being merged
- one Product Proposition may be functionally supported without a clear current External exposure
- one External Surface may expose technically important behavior without a clear Product Proposition
- a consumer-visible interaction may expose only part of the Functional behavior that supports its Product Proposition
- one Product Proposition may rely heavily on a guarantee that is not obvious from its External Surface
- measurement may be cleaner at a Functional boundary than at an External Surface
- current External exposure may underrepresent existing Functional product potential
- several independently meaningful Product Propositions may later combine into one concise Customer Claim
- several externally distinct interaction contracts may share one transport without belonging under one semantic External parent

First complete all three views independently.

Only afterwards identify the relationships between them.

Cross-view analysis may reveal that an independently derived view contains an actual mistake, unsupported distinction, or missed evidence.

Correct such an issue when justified by the codebase.

Do not revise a valid view merely to make the combined artifact less repetitive, easier to market, or easier to synthesize into Customer Claims.

# Naming

Use short, understandable names.

For the Product Proposition View, describe nodes in terms of:

**what meaningful outcome or reliable product property a supported external consumer can plausibly obtain or rely on**

For the External Surface View, describe nodes in terms of:

**what an external consumer can interact with or rely on**

For the Functional View, describe nodes in terms of:

**what the system can do or guarantee**

Do not use promotional adjectives in Product Proposition names unless directly justified.

Internal class, method, file, namespace, package, endpoint, or configuration names may be used as supporting evidence, but should not automatically determine Product Proposition or Functional names.

Keep Mermaid labels concise.

Put detailed explanations into the corresponding tables.

# References and levels

Assign every relevant node a short stable reference.

Product Proposition View references use:

`P1`, `P2`, `P3`, ...

External Surface View references use:

`E1`, `E2`, `E3`, ...

Functional View references use:

`F1`, `F2`, `F3`, ...

These references identify nodes.

They must remain independent of hierarchy level.

Do not restart node-reference numbering at each hierarchy level.

Do not encode the hierarchy level into the stable reference.

These references must remain consistent across:

- Mermaid diagram
- Product Proposition mapping table
- External Surface mapping table
- Functional mapping table
- relation tables
- Customer Claim Synthesis
- observations

Hierarchy levels must remain consistent across:

- Mermaid diagram
- the corresponding view mapping table
- the semantic hierarchy represented by that view

Show both the stable reference and hierarchy level inside the Mermaid node label.

Use:

`*P1 · L1`

`*E1 · L1`

`*F1 · L1`

The reference and hierarchy level are metadata.

Neither is part of the actual proposition, surface, or capability name.

The reference answers:

**Which node is this?**

The level answers:

**How deep is this node in this view's semantic hierarchy?**

# Uncertainty

Stay close to what can actually be supported by the codebase.

Do not invent:

- customer needs
- market demand
- commercial value
- willingness to pay
- pricing
- strategic importance
- competitive positioning
- market differentiation
- customer satisfaction
- adoption
- actual usage

unless such evidence has explicitly been provided outside the codebase.

Do not infer that a capability is valuable merely because it is technically sophisticated.

Do not infer that an External Surface is important merely because it is prominent in the code.

Do not infer that a missing External Surface means a Product Proposition should be built.

Do not infer that a plausible stronger Customer Claim should necessarily become a product requirement.

If a Product Proposition is plausibly supported but its consumer relevance is uncertain, keep it only when useful and mark the uncertainty.

If a measurement opportunity is plausible but the available instrumentation or privacy boundary is uncertain, state that uncertainty.

# Mermaid output

First produce all three views together in one Mermaid diagram.

Use:

---
config:
  layout: elk
  elk:
    nodePlacementStrategy: LINEAR_SEGMENTS
    mergeEdges: false
---
flowchart LR

The desired conceptual arrangement is:

PRODUCT / CONSUMER                                  SYSTEM MEANING

Product Proposition View    External Surface View    Functional View

          P                         E                      F

 why might it matter?        what is exposed?       what does it mean?

The Product Proposition View should appear on the left.

The External Surface View should occupy the middle.

The Functional View should appear on the right.

This visual order is a presentation arrangement.

It does not mean that Product Proposition must always be mediated through External Surface.

Product Proposition ↔ Functional is an independent allowed semantic relation layer.

The later Customer Claim Synthesis must not appear as another Mermaid view in this experiment.

## Product Proposition hierarchy orientation

Write Product Proposition hierarchy edges parent-first:

parent --- child

This should make the Product Proposition hierarchy grow toward the External Surface View.

## External Surface hierarchy orientation

Write External Surface hierarchy edges parent-first:

parent --- child

Keep External Surface as the middle interaction layer.

Do not restructure the External hierarchy merely to improve Product or Functional relation alignment.

Do not group semantically different External surfaces merely to improve Mermaid alignment or because they share a transport such as HTTP.

## Functional hierarchy orientation

Write Functional hierarchy edges child-first:

child --- parent

This is intentionally reversed only for Mermaid layout purposes.

It should place the Functional root toward the far right while its more detailed Functional nodes face toward External Surface and Product Proposition.

Because `---` is undirected, this reversed statement order must not be interpreted as ownership direction, dependency direction, execution flow, data flow, or causal direction.

Semantic Functional paths must still always be described root-first in the mapping table.

# Mermaid structure

Use three separate subgraphs:

---
config:
  layout: elk
  elk:
    nodePlacementStrategy: LINEAR_SEGMENTS
    mergeEdges: false
---
flowchart LR

    subgraph PRODUCT["Product Proposition View"]

        P1["Product Outcomes *P1 · L1"]

        P1 --- P2["Outcome area A *P2 · L2"]
        P1 --- P3["Outcome area B *P3 · L2"]

        P2 --- P4["Consumer outcome A1 *P4 · L3"]
        P2 --- P5["Reliable product property A2 *P5 · L3"]
    end


    subgraph EXTERNAL["External Surface View"]

        E1["External Surface *E1 · L1"]

        E1 --- E2["External area A *E2 · L2"]
        E1 --- E3["External area B *E3 · L2"]

        E2 --- E4["External interaction A1 *E4 · L3"]
        E2 --- E5["External interaction A2 *E5 · L3"]
    end


    subgraph FUNCTIONAL["Functional View"]

        F1["Functional Purpose *F1 · L1"]

        F4["Sub-capability A1 *F4 · L3"] --- F2["Capability A *F2 · L2"]
        F5["Behavioral guarantee A2 *F5 · L3"] --- F2

        F2 --- F1
        F3["Capability B *F3 · L2"] --- F1
    end


    PRODUCT layout1@--> EXTERNAL
    EXTERNAL layout2@--> FUNCTIONAL

    classDef layoutConstraint opacity:0;
    class layout1,layout2 layoutConstraint;


    P4 -.- E4
    P5 -.- E5

    P4 -.- F4
    P5 -.- F5

    E4 -.- F4
    E5 -.- F5

The example relation edges are structural examples only.

Do not assume one-to-one alignment between `P`, `E`, and `F` nodes.

The actual relation graph is expected to contain one-to-many, many-to-one, missing, and cross-level mappings.

The `layout1`, `layout2`, ... edges are layout constraints only.

For this product configuration, the layout order is:

PRODUCT → EXTERNAL → FUNCTIONAL

Create one directed layout-constraint edge between each adjacent view in the configured presentation order.

The presentation layout does not define semantic relation topology.

In particular, the semantic Product Proposition ↔ Functional relation layer may connect across the External Surface column.

Assign all layout-constraint edges to the dedicated `layoutConstraint` class and make them visually invisible.

Do not use `~~~` to enforce view ordering.

Layout-constraint edges:

- exist only to preserve configured Mermaid layout
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
- causal direction
- customer journey
- product funnel

Use:

`-.-`

for semantic relationships between views connected by an allowed relation layer.

Cross-view relation connections must:

- be undirected
- have no labels
- have no relation IDs on the line
- contain no explanatory text
- remain visually lightweight

All semantic details belong in the relation tables.

Directed `layout...@-->` edges are a separate presentation-only mechanism.

They must never be interpreted as semantic cross-view relationships.

Hierarchy levels shown in node labels do not alter connection semantics.

# Allowed cross-view relation layers

For this version, create three independent semantic relation layers:

**Product Proposition ↔ External Surface**

**Product Proposition ↔ Functional**

**External Surface ↔ Functional**

All three relation layers must be discovered independently.

Do not infer one relation layer from either of the others.

The presence of two sides of the triangle does not imply the third.

# Product-to-External relation discovery

Only perform this step after the Product Proposition View and External Surface View have both been independently completed.

For every relevant Product Proposition node, examine which External Surface nodes materially expose, deliver, surface, enable access to, or allow a consumer to realize that proposition today.

For every relevant External Surface node, examine which Product Proposition nodes it materially exposes or makes available to a consumer.

The purpose of this layer is to reveal patterns such as:

- one proposition exposed through several external mechanisms
- several propositions delivered through one external surface
- a proposition with no clear current external exposure
- an administrative or technical external surface with no clear Product Proposition
- one consumer outcome available through multiple interaction modes
- one external interface exposing only part of a broader product proposition

Record every materially supported relationship between existing nodes.

Do not create a Product-to-External relation merely because the External node eventually reaches Functional code that supports the proposition.

The External Surface must materially contribute to the consumer's current access to or experience of the proposition.

# Product-to-Functional relation discovery

Only perform this step after the Product Proposition View and Functional View have both been independently completed.

For every relevant Product Proposition node, examine which Functional nodes materially support, enable, guarantee, preserve, constrain, or make that proposition credible.

For every relevant Functional node, examine which Product Proposition nodes it materially supports.

The purpose of this layer is to reveal patterns such as:

- one proposition supported by several capabilities
- one proposition relying on several independent guarantees
- one Functional capability supporting several Product Propositions
- product value depending on a Functional guarantee that is not obvious externally
- a proposition supported by existing functionality without a clear current External exposure
- Functional capabilities that are important technically but do not form a consumer-relevant proposition
- broad propositions that are implemented through several distinct functional areas
- narrow guarantees that materially strengthen a larger product claim

Record every materially supported relationship between existing nodes.

Do not connect a Product Proposition to every Functional node transitively involved somewhere in implementation.

The Functional node must materially explain why the proposition is credible.

Do not merge several Functional nodes merely because they all map to the same Product Proposition.

Their many-to-one mapping is itself useful information.

# External-to-Functional relation discovery

Only perform this step after the External Surface View and Functional View have both been independently completed.

For every relevant External Surface node, examine which Functional nodes materially explain or support that external surface.

For every relevant Functional node, examine which External Surface nodes expose, consume, control, configure, observe, or depend on it.

The purpose of this layer is to reveal patterns such as:

- several external interactions backed by one capability
- one external surface requiring several capabilities
- capabilities that exist without a currently visible external exposure
- one capability exposed through several different external mechanisms
- one configuration surface controlling several distinct guarantees
- one externally visible behavior resulting from several internal capabilities

Record every materially supported relationship between existing nodes.

Do not compress the relation set merely to make the diagram cleaner.

Do not merge distinct Functional nodes merely to reduce the number of External-to-Functional relations.

Do not merge distinct External nodes merely because they map to the same Functional capability.

# Do not complete the semantic triangle automatically

Apply this rule strictly.

A:

`P ↔ E`

relation and:

`E ↔ F`

relation do not imply:

`P ↔ F`

A:

`P ↔ F`

relation and:

`E ↔ F`

relation do not imply:

`P ↔ E`

A:

`P ↔ E`

relation and:

`P ↔ F`

relation do not imply:

`E ↔ F`

Every relation must be materially supported according to the definition of its own relation layer.

Do not create missing triangle edges merely to make the diagram symmetric or complete.

Incomplete triangles are expected and can be valuable information.

# Do not inherit or suppress relations through hierarchy

Apply this rule independently to all three relation layers.

A relation between parent nodes does not automatically replace relations between their descendants.

A relation between descendant nodes does not automatically replace a valid relation between their parents.

Do not omit a relationship merely because:

- an ancestor is already connected
- a descendant is already connected
- a broader relation already exists
- another relation looks visually similar
- the other two sides of a semantic triangle already exist
- another relation connects nodes at comparable hierarchy levels

The relation layers exist specifically to reveal one-to-many, many-to-one, many-to-many, and incomplete-triangle structures.

Hierarchy levels must not be used to suppress valid relations.

# Do not invent relations

Completeness does not mean connecting everything.

Create a relation only when the codebase materially supports it.

Do not connect nodes merely because:

- they are close in their hierarchy
- they occur at similar hierarchy levels
- they share terminology
- one sounds like customer-friendly wording for another
- the connection would make the triangle look cleaner
- one eventually reaches implementation related to another
- the connection seems commercially plausible
- the connection seems theoretically plausible

Hierarchy-level similarity is never sufficient evidence for a relation.

# Use existing nodes

Do not create extra nodes solely to make cross-view relations easier to express.

Relations should connect nodes that were independently discovered as meaningful members of their own view.

If an existing abstraction is too coarse to express an important relationship, reconsider that view only if the missing node is independently meaningful within the view itself.

Do not create mapping-only nodes.

Do not create Product Proposition nodes solely to complete relation triangles.

Do not create nodes merely to make hierarchy levels align across views.

# Exact relation consistency

For all semantic relation layers:

**One Mermaid `-.-` cross-view relation edge = one relation-table row.**

And:

**One relation-table row = one Mermaid `-.-` cross-view relation edge.**

There must be no undocumented Mermaid semantic relation.

There must be no relation-table row without a corresponding Mermaid edge.

Presentation-only `layout...@-->` layout-constraint edges are explicitly excluded because they are not semantic relations.

Hierarchy levels are node metadata and do not affect relation identity.

Relation tables must refer to nodes using stable node references such as:

`P5`

`E7`

`F9`

not combined level-reference identifiers.

# Product Proposition mapping table

After the Mermaid diagram, create the Product Proposition View table.

| Ref | Level | Product Proposition path | Consumer-relevant outcome in simple terms | Relevant codebase evidence | Claim boundary | Measurement opportunity | Privacy considerations | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

The path must describe the semantic hierarchy from the Product Proposition root toward the specific proposition.

The `Level` column contains the level of the row's referenced node.

Describe only the Product Proposition perspective here.

Do not explain External Surface or Functional mappings in this table.

### Consumer-relevant outcome

Describe what meaningful outcome or reliable property the proposition represents.

### Relevant codebase evidence

Point to the code areas, contracts, UI behavior, configuration, tests, documentation in the codebase, or other repository-local evidence that makes the proposition credible.

### Claim boundary

When useful, distinguish the supported proposition from a stronger unsupported claim.

Keep this concise.

### Measurement opportunity

When useful and supported, describe a privacy-minimizing signal that could help estimate:

- usage
- completion
- adoption
- successful outcome
- guarantee exercise
- repeat use

Do not force a metric for every proposition.

### Privacy considerations

Identify what should preferably not be collected when measuring the proposition.

Do not make legal compliance claims.

# External Surface mapping table

Then create the External Surface View table.

| Ref | Level | External path | Meaning in simple terms | External evidence / surface | Relevant code areas | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |

The path must describe the semantic hierarchy from the External Surface root toward the specific interaction.

Describe this view only from the external perspective.

Do not explain Product Proposition or Functional mappings here.

# Functional mapping table

Then create the Functional View table.

| Ref | Level | Functional path | Meaning in simple terms | Relevant code areas | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- |

Semantic paths must always be written root-first even though Mermaid Functional hierarchy statements are written child-first for layout.

Describe only the Functional meaning or guarantee here.

Do not explain Product Proposition, External, or Customer Claim mappings in this table.

A Functional table row must remain independently understandable even if the Product Proposition View and Customer Claim Synthesis are removed.

# Product-to-External relation table

Then create:

## Product Proposition ↔ External Surface Relations

Use relation references:

`PE1`, `PE2`, `PE3`, ...

| Ref | Product Ref | External Ref | Relation | Meaning in simple terms | Confidence | Evidence |
| --- | --- | --- | --- | --- | --- | --- |

Possible relation meanings may include:

- exposed through
- delivered through
- accessible through
- surfaced through
- interacted with through
- configured through
- observable through
- currently available through

Choose the relation meaning from actual codebase evidence.

Do not put these labels on Mermaid edges.

# Product-to-Functional relation table

Then create:

## Product Proposition ↔ Functional Relations

Use relation references:

`PF1`, `PF2`, `PF3`, ...

| Ref | Product Ref | Functional Ref | Relation | Meaning in simple terms | Confidence | Evidence |
| --- | --- | --- | --- | --- | --- | --- |

Possible relation meanings may include:

- supported by
- enabled by
- depends on
- guaranteed by
- safeguarded by
- constrained by
- composed from
- made credible by
- relies on

Choose the relation meaning from actual codebase evidence.

Do not put these labels on Mermaid edges.

# External-to-Functional relation table

Then create:

## External ↔ Functional Relations

Use relation references:

`EF1`, `EF2`, `EF3`, ...

| Ref | External Ref | Functional Ref | Relation | Meaning in simple terms | Confidence | Evidence |
| --- | --- | --- | --- | --- | --- | --- |

Possible relation meanings may include:

- exposes
- configures
- controls
- invokes
- depends on
- provides access to
- represents
- observes
- supplies input to
- relies on

Choose the relation meaning from actual codebase evidence.

Do not put these labels on Mermaid edges.

# Customer Claim Synthesis

Only perform this step after:

1. the Product Proposition View is complete
2. the External Surface View is complete
3. the Functional View is complete
4. all `PE...` relations are complete
5. all `PF...` relations are complete
6. all `EF...` relations are complete

At this point, treat all three independently derived views as fixed inputs to the synthesis.

Customer Claim Synthesis may reveal an error or unsupported interpretation in an earlier view.

Correct an earlier view only when the codebase evidence shows that the earlier view itself was wrong.

Do not modify an earlier view merely because:

- a Customer Claim would become simpler
- fewer Product Propositions would be easier to communicate
- fewer Functional nodes would make the claim easier to explain
- fewer External nodes would make exposure easier to summarize
- several existing nodes contribute to one claim
- the resulting artifact would contain less redundancy

Customer Claims are derived communication artifacts.

They are not nodes in any of the three views.

They must not alter the structure, naming, detail, hierarchy, or relations of the three views.

Assign Customer Claim references:

`PC1`, `PC2`, `PC3`, ...

## Customer Claim purpose

A Customer Claim answers:

**How could one or more existing Product Propositions be expressed as a concise customer-facing statement while staying within the evidence and claim boundaries of the current codebase?**

A Customer Claim may synthesize:

- one Product Proposition
- several Product Propositions
- a broader Product Proposition together with important supporting descendant propositions

Do not assume:

`one Product Proposition = one Customer Claim`

Several Product Propositions may form one stronger coherent Customer Claim.

One Product Proposition may also support several materially different Customer Claims when each emphasizes a different supported consumer outcome.

A Product Proposition may have no useful Customer Claim.

Do not force claims merely for completeness.

## Customer-facing language

Customer Claims may be more concise, outcome-oriented, and communicative than Product Proposition node names.

They may use language appropriate for explaining the product to a prospective or existing customer.

However, they must remain materially supportable by the current codebase.

Do not use unsupported promotional superlatives or imply:

- proven customer demand
- customer satisfaction
- competitive superiority
- guaranteed commercial value
- market leadership
- regulatory compliance
- unlimited scale
- general security
- zero downtime
- general correctness

unless the exact claim is actually supported.

## Claim inheritance from Product Propositions

A Customer Claim must respect the claim boundaries of every Product Proposition that supports it.

Combining several Product Propositions must not be used to bypass a limitation present in any one of them.

If:

`P3`

supports a narrow containment claim and:

`P4`

supports reversible Git-aware changes,

their combination must not become an unsupported statement such as:

`All automated work is fully isolated and automatically reversible.`

Synthesis may combine supported outcomes.

It may not amplify them beyond their evidence.

## Existing Functional support

For each Customer Claim, identify the existing `F...` nodes that materially support the claim through the already established Product-to-Functional mappings.

Do not derive new Functional support merely because it would make the claim stronger.

Use existing `F...` references.

Do not replace several existing Functional references with one broader ancestor merely to simplify the Customer Claim table.

If several independently meaningful Functional guarantees support the claim, list those guarantees separately.

The purpose is to show:

**What Functional semantics currently make this claim credible?**

## Stronger desirable claim

When useful, consider whether a modestly stronger, still coherent customer-facing claim would be product-relevant if additional Functional behavior existed.

This is optional.

Do not invent stronger claims merely to populate the table.

A stronger desirable claim should remain close to the current product reality.

It should represent a plausible extension of an already supported Product Proposition or Customer Claim.

Do not jump from:

`controlled scoped authorization`

to:

`complete enterprise security platform`

or from:

`last-known-good runtime configuration`

to:

`self-healing zero-downtime infrastructure`

## Missing Functional support

If a stronger desirable claim is identified, determine what Functional behavior or guarantee is missing or insufficiently supported.

This is a **gap description**, not a new Functional node.

Do not create new `F...` references for behavior that the current codebase does not provide.

Describe the missing Functional support in plain semantic terms.

Ask:

**What would the system additionally need to do, prevent, preserve, enforce, or guarantee before the stronger claim could be made credibly?**

Examples of missing Functional support may include:

- stronger authorization enforcement
- broader containment
- durable persistence
- recovery guarantee
- consistent enforcement across all relevant interaction paths
- atomic replacement semantics
- externally accessible exposure of an existing capability
- explicit lifecycle behavior
- stronger verification
- stronger isolation
- additional input acceptance guarantees

Be precise.

Do not use vague gaps such as:

- needs better security
- needs to be enterprise-ready
- needs more scalability
- needs polish

unless the codebase allows the missing semantic requirement to be stated more concretely.

## Missing Functional support versus missing External exposure

Keep these distinct.

A claim may already have sufficient Functional support but lack a suitable External Surface.

That is not a missing Functional capability.

Represent such a case as:

**Functional support sufficient; external productization/exposure appears incomplete.**

Likewise, a proposition may be externally exposed but functionally insufficient for a stronger claim.

Do not collapse exposure gaps and Functional gaps.

## Claim status

Assign one of these statuses when useful:

**Supported now**

The current Product Propositions and Functional support materially justify the Customer Claim.

**Supported with important boundary**

The claim is usable only when an important limitation or condition remains explicit.

**Functionally supported but weakly exposed**

The underlying Product Proposition and Functional support exist, but current External Surface support appears incomplete or weak.

**Partially supported**

The current system supports a meaningful portion of the claim, but an important Functional or exposure gap remains.

**Requires Functional extension**

The stronger desirable claim would require additional Functional behavior or guarantee.

**Unsupported by current codebase**

The claim cannot currently be justified from the codebase.

Do not classify a claim as supported merely because individual words resemble Product Proposition names.

## Product / communication potential

When useful, classify a codebase-grounded potential.

Possible forms include:

**Communication potential**

Several existing Product Propositions can be combined into a clearer customer-facing explanation.

**Underexposed proposition**

Existing Functional support appears stronger than its current External Surface expression.

**Productization potential**

Existing capabilities could plausibly form a more explicit product-facing offering, but market desirability is unknown.

**Claim strengthening potential**

A narrowly identified Functional extension would permit a materially stronger but still adjacent Customer Claim.

**Measurement potential**

A useful privacy-minimizing signal exists or could plausibly be added to test actual use or outcome.

These categories describe codebase-grounded possibilities.

They do not imply:

- market opportunity
- business priority
- ROI
- expected revenue
- customer demand

# Customer Claim Synthesis table

Then create:

## Customer Claim Synthesis

| Ref | Product Refs | Customer-facing claim | Existing Functional support | Claim status | Stronger desirable claim | Missing Functional support / gap | External exposure note | Product / communication potential | Measurement signal | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

### Product Refs

List the existing Product Proposition references that materially support the Customer Claim.

Example:

`P9, P10, P11, P12`

Do not reference External or Functional nodes here as the primary claim source.

### Customer-facing claim

Write a concise, understandable statement suitable for explaining the existing product capability to a customer.

It may synthesize several Product Propositions.

Stay within current evidence.

### Existing Functional support

List the relevant existing `F...` references and briefly state what they contribute.

These should be traceable through existing `PF...` relations.

Preserve independently meaningful Functional distinctions.

Do not replace several supporting guarantees with a broader parent merely to shorten this field.

Do not invent new Functional mappings.

### Claim status

Use the status definitions above.

### Stronger desirable claim

Optional.

State a nearby stronger Customer Claim that could become supportable if the identified gap were addressed.

Do not use aspirational marketing language.

### Missing Functional support / gap

Describe what the current system would additionally need to do or guarantee.

If no Functional gap exists, state:

`None identified for the current claim.`

If the issue is only external exposure, state that explicitly rather than inventing a Functional gap.

### External exposure note

Use the existing `PE...` and `EF...` evidence to summarize whether the claim is:

- clearly exposed
- exposed through several surfaces
- only indirectly exposed
- weakly exposed
- not clearly exposed

Do not create new relations here.

Do not collapse semantically different External surfaces into one description merely because they share the same transport.

### Product / communication potential

Describe only codebase-grounded potential.

### Measurement signal

Where useful, reuse or combine the privacy-minimizing measurement opportunities identified in the supporting Product Propositions.

Do not invent customer-content telemetry merely because a synthesized claim spans several propositions.

# Keep all description and synthesis layers separate

Treat the output as seven distinct information layers.

## Product Proposition description layer

Contains only information about `P...` nodes.

## External Surface description layer

Contains only information about `E...` nodes.

## Functional description layer

Contains only information about `F...` nodes.

## Product-to-External relationship layer

Contains only `PE...` mappings.

## Product-to-Functional relationship layer

Contains only `PF...` mappings.

## External-to-Functional relationship layer

Contains only `EF...` mappings.

## Customer Claim Synthesis layer

Contains only derived `PC...` claims.

It may reference existing `P...`, `F...`, and relation evidence.

It must not modify them.

The synthesis layer must preserve the full independently derived granularity of its inputs even when the customer-facing output is intentionally more compressed.

This separation is essential.

# Optional observations

After the tables, add a short section only when meaningful structural patterns are visible.

Keep observations separated by scope.

## Product Proposition observations

Only observations about `P...`.

## External Surface observations

Only observations about `E...`.

## Functional observations

Only observations about `F...`.

## Product Proposition ↔ External Surface observations

Only observations emerging from `PE...`.

## Product Proposition ↔ Functional observations

Only observations emerging from `PF...`.

## External ↔ Functional observations

Only observations emerging from `EF...`.

## Triangle observations

Only observations emerging from the combination of existing `PE...`, `PF...`, and `EF...` evidence.

Do not invent missing triangle relations.

## Customer Claim observations

Only observations about the derived `PC...` layer.

Examples:

- several Product Propositions combine naturally into one customer-facing claim
- one proposition is more useful as supporting evidence than as a standalone claim
- a current claim is strong but requires an explicit boundary
- a stronger adjacent claim is blocked by one clearly identifiable Functional gap
- several potential stronger claims all depend on the same missing Functional guarantee
- a claim is already functionally supported but underexposed externally
- existing measurement can validate usage but not the claimed outcome
- a stronger claim would require outcome-level measurement rather than invocation-level telemetry
- one concise Customer Claim depends on several distinct Functional guarantees that must remain separate in the Functional View

Do not use Customer Claim observations to modify the independently derived views.

# Final review

Before returning the result, review each layer separately.

## Product Proposition View

1. Does every Product Proposition describe a meaningful consumer-relevant outcome or reliable product property?
2. Has any Product Proposition merely renamed a Functional capability in friendlier language?
3. Has any Product Proposition merely renamed an External interaction?
4. Is each proposition materially supported by codebase evidence?
5. Has market demand been invented?
6. Has willingness to pay been invented?
7. Has competitive advantage been invented?
8. Has customer satisfaction or adoption been invented?
9. Are promotional adjectives avoided unless materially supported?
10. Does the hierarchy group related product outcomes under meaningful shared concepts?
11. Are siblings at comparable product-abstraction levels?
12. Are distinct outcomes preserved when they differ in claim boundary, guarantee, exposure, or neighboring mappings?
13. Are current and potential propositions not forced into artificial fixed branches?
14. Are propositions without clear current exposure allowed when functionally supported?
15. Are such propositions described cautiously rather than assumed to be market opportunities?
16. Are Product Propositions allowed to remain absent where a capability has no clear consumer-level outcome?
17. Does every important claim stay within what the codebase can support?
18. Are stronger unsupported interpretations captured as claim boundaries when useful?
19. Are measurement opportunities optional rather than forced?
20. Where measurement is suggested, does it measure something meaningfully related to the proposition?
21. Has invocation been distinguished from successful Functional outcome when that distinction matters?
22. Are privacy-minimizing measurements preferred?
23. Are customer contents, payloads, secrets, or unnecessary identifiers avoided?
24. Has the Product Proposition hierarchy remained independent from the later Customer Claim Synthesis?
25. Have Product Proposition nodes remained separate even when several later combine into one Customer Claim?

## External Surface View

26. Does the view describe the system from outside its implementation boundary?
27. Has the view accidentally become a public class or method inventory?
28. Has a customer journey or chronological process been mistaken for an external hierarchy?
29. Are external interactions grouped under meaningful shared concepts?
30. Are siblings at comparable abstraction levels?
31. Are different external consumer types only introduced when supported by evidence?
32. Are implementation details absent unless externally relevant?
33. Would an external consumer recognize the concepts in this view?
34. Has the view remained independent rather than being reorganized around Product Propositions?
35. Are technical/admin surfaces preserved even when they have no obvious Product Proposition?
36. Have semantically different external interaction contracts remained distinct even when they share HTTP, MCP, browser hosting, or another transport?
37. Has shared transport been mistaken for a meaningful External parent?
38. Have authorization, lifecycle, consumer-role, capability-token, or human-vs-machine differences been preserved where meaningful?
39. Has the External View remained unchanged in necessary detail merely because Customer Claim Synthesis uses a smaller number of communication concepts?

## Functional View

40. Are there multiple top-level nodes that should share a parent?
41. Are siblings operating at different abstraction levels?
42. Are several nodes merely different aspects of the same broader capability?
43. Has code structure been mistaken for Functional structure?
44. Are technical details placed too high?
45. Are concrete functions being presented as fundamental capabilities?
46. Could a group be explained more clearly by introducing a simpler shared concept?
47. Are variants of the same capability recognizable as variants?
48. Have independently meaningful behaviors been collapsed even though they differ in lifecycle, policy, security, recovery, Product Proposition mappings, External mappings, or Customer Claim contribution?
49. Are explicit containment, isolation, authorization, trust, validation, integrity, atomicity, fallback, persistence, or recovery guarantees represented when they form distinct system behavior?
50. Has any guarantee disappeared merely because it contributes to a broader Product Proposition or Customer Claim?
51. Has the Functional View remained semantically precise rather than becoming product or marketing language?
52. Have missing capabilities mentioned in Customer Claim Synthesis remained gaps rather than being invented as current `F...` nodes?
53. Have distinct Functional behaviors remained separate when they answer materially different system questions?
54. Have ingress and egress been collapsed merely because both concern artifact transfer?
55. Have claim and report semantics been collapsed merely because both belong to an execution lifecycle?
56. Have normative Governance state and Execution state been collapsed merely because both contribute to one governed-work Product Proposition?
57. Have authorization representation and actual enforcement been kept distinct where the codebase distinguishes them?
58. Has credential separation remained explicit when it represents an independent trust guarantee?
59. Have several Functional nodes remained separate even when they map to the same `P...` or `PC...`?
60. Has the Functional hierarchy been derived from Functional semantics rather than from the later customer story?

## Hierarchy levels

61. Does every view root have level `L1`?
62. Does every direct child of an `L1` node have `L2`, every direct child of an `L2` node have `L3`, and so on?
63. Are levels derived from the semantic hierarchy rather than used to determine it?
64. Has any view been artificially deepened or flattened merely to obtain a preferred number of levels?
65. Have hierarchy levels remained independent across views rather than aligned for symmetry?
66. Are stable node references independent of hierarchy levels?
67. Is each node's level identical in its Mermaid label and mapping-table row?
68. Are relation tables using stable node references without level prefixes?

## Product Proposition ↔ External Surface Relations

69. Has every materially supported Product-to-External relationship between existing nodes been considered?
70. Are one-to-many and many-to-one mappings preserved?
71. Are Product Propositions allowed to have no current External mapping?
72. Are External Surface nodes allowed to have no Product mapping?
73. Was any valid relation suppressed because an ancestor or descendant already has one?
74. Does every `P -.- E` Mermaid edge have exactly one `PE...` relation row?
75. Does every `PE...` row have exactly one Mermaid edge?
76. Are unsupported or merely aspirational mappings excluded?
77. Does each relation represent actual current exposure rather than theoretical productization?

## Product Proposition ↔ Functional Relations

78. Has every materially supported Product-to-Functional relationship between existing nodes been considered?
79. Are propositions supported by several Functional capabilities mapped to all materially relevant ones?
80. Are Functional capabilities allowed to support several Product Propositions?
81. Was any valid relation suppressed because a parent or descendant already has one?
82. Does every `P -.- F` Mermaid edge have exactly one `PF...` relation row?
83. Does every `PF...` row have exactly one Mermaid edge?
84. Are transitive or merely incidental Functional relationships excluded?
85. Does each relation materially explain why the proposition is credible?
86. Are important guarantees mapped when they materially support the proposition even if they are not externally obvious?
87. Are Product Proposition nodes without adequate Functional support reconsidered rather than kept for marketing appeal?
88. Have multiple `PF...` mappings been preserved instead of merging their Functional endpoints simply because one Product Proposition depends on all of them?

## External ↔ Functional Relations

89. Has every materially supported External-to-Functional relationship between existing nodes been considered?
90. Are one-to-many and many-to-one mappings preserved?
91. Was any valid relation suppressed because an ancestor or descendant already has one?
92. Does every `E -.- F` Mermaid edge have exactly one `EF...` relation row?
93. Does every `EF...` row have exactly one Mermaid edge?
94. Are unsupported or speculative mappings excluded?
95. Has the existing External-to-Functional semantics remained independent from the Product Proposition layer?
96. Have valid `EF...` mappings remained explicit even when several Functional nodes support the same Product Proposition or Customer Claim?
97. Has relation count been reduced only when the underlying semantic relation is actually absent, not because broader nodes were introduced for convenience?

## Triangle consistency

98. Has each of the three relation layers been discovered independently?
99. Has any missing triangle edge been invented merely because the other two edges exist?
100. Are incomplete triangles allowed?
101. Are Product-to-External relations based on current consumer exposure rather than inferred through Functional nodes?
102. Are Product-to-Functional relations based on actual capability/guarantee support rather than inferred through External nodes?
103. Are External-to-Functional relations based on system correspondence rather than inferred through Product Propositions?
104. Do triangle observations use existing relation evidence without creating new implicit relations?
105. Are functionally supported but externally unexposed propositions identified cautiously?

## Customer Claim Synthesis

106. Was Customer Claim Synthesis performed only after all three views and all relation layers were complete?
107. Has Customer Claim Synthesis left all `P...`, `E...`, and `F...` structures unchanged except where independent code evidence proves an actual error?
108. Does every `PC...` claim reference one or more existing Product Propositions?
109. Is every current Customer Claim materially supported by those Product Propositions?
110. Does every Customer Claim respect all relevant Product Proposition claim boundaries?
111. Has combining several Product Propositions avoided amplifying them into a stronger unsupported statement?
112. Are Customer Claims allowed to combine several Product Propositions when that produces clearer customer communication?
113. Are Product Propositions allowed to support no Customer Claim?
114. Is Customer Claim language understandable without becoming unsupported marketing copy?
115. Does `Existing Functional support` reference only existing `F...` nodes?
116. Are those Functional references traceable through existing `PF...` mappings?
117. When several independent Functional guarantees support one claim, are those guarantees listed separately instead of replaced with one broad ancestor?
118. Has no missing behavior been invented as a current Functional node?
119. Is a stronger desirable claim optional rather than forced?
120. Where a stronger desirable claim is proposed, is it adjacent to current product reality rather than speculative?
121. Is the missing Functional support stated as specific system behavior or guarantee rather than vague improvement language?
122. Are Functional gaps distinguished from External exposure gaps?
123. Is `Supported now` used only when the current codebase materially supports the claim?
124. Is `Partially supported` used when an important gap remains?
125. Is `Functionally supported but weakly exposed` used only when the Functional side is already sufficient?
126. Does Product / communication potential avoid claims about demand, revenue, ROI, or market size?
127. Are measurement signals grounded in existing Product Proposition measurement opportunities where possible?
128. Are privacy-minimizing constraints preserved when several Product Propositions are synthesized into one claim?
129. Has the Customer Claim layer compressed communication without compressing the underlying semantic views?

## View independence

130. Was Product Proposition derived independently rather than copied from External or Functional?
131. Was External Surface derived independently rather than organized around Product Proposition?
132. Was Functional derived independently rather than organized around Product Proposition or External?
133. Would each view remain sufficiently complete and useful if the other two views and Customer Claim Synthesis were removed?
134. Has any view been compressed, regrouped, omitted from, or simplified merely because another view or Customer Claim contains overlapping information?
135. Has any meaningful node or distinction been removed solely because another layer represents similar information?
136. Is redundancy allowed when independently meaningful?
137. Are cross-view explanations confined to their relation layers?
138. Has Customer Claim Synthesis remained a derived layer rather than becoming an implicit fourth view?
139. Has any earlier view been retroactively optimized for simpler customer communication?
140. Would the External and Functional Views still look materially appropriate if the Product Proposition and Customer Claim layers did not exist?
141. Would adding another future synthesis layer leave the existing three views unchanged unless new code evidence reveals a genuine error?

## Diagram

142. Is the Product Proposition View on the left?
143. Is the External Surface View in the middle?
144. Is the Functional View on the right?
145. Does Product Proposition grow toward External?
146. Does External grow toward Functional?
147. Does Functional grow toward External?
148. Are `*P...`, `*E...`, and `*F...` references visible and consistent?
149. Is a hierarchy level `L...` visible on every Mermaid node?
150. Do Mermaid levels accurately match hierarchy depth?
151. Are hierarchy edges visually distinct from semantic cross-view relation edges?
152. Are semantic cross-view relation edges unlabeled?
153. Are Product-to-Functional edges allowed to cross the External column without being interpreted as direct External relations?
154. Does the diagram expose useful incomplete triangles, one-to-many structures, and many-to-many structures without explanatory text on the edges?
155. Is the diagram still reasonably readable on a normal screen?
156. Does the generated layout-constraint chain match the configured presentation order?
157. Is there exactly one presentation-only layout constraint from Product Proposition to External Surface?
158. Is there exactly one presentation-only layout constraint from External Surface to Functional?
159. Are all `layout...@-->` edges visually invisible and excluded from semantic relation tables and relation consistency checks?
160. Has Customer Claim Synthesis remained outside the Mermaid diagram in this experiment?

The goal is not to produce three complete inventories.

The goal is to create a **compressed product-and-codebase semantic model from three independent perspectives**:

**Product Proposition View: what meaningful consumer-relevant outcomes or reliable product properties the codebase can credibly support**

**External Surface View: what the outside world can actually interact with**

**Functional View: what the system actually does, prevents, preserves, or guarantees**

The Product Proposition View must remain grounded in software reality.

It should help answer:

**What can we credibly claim?**

**What existing capability may be underexposed from a product perspective?**

**What stronger claim would exceed the evidence?**

**What usage or outcome signal could potentially be measured with privacy-minimizing instrumentation?**

The later Customer Claim Synthesis should then help answer:

**How would we explain the supported product value concisely to a customer?**

**Which independently meaningful Product Propositions naturally combine into one customer-facing claim?**

**What can we already claim today?**

**What nearby stronger claim might be desirable?**

**What Functional behavior or guarantee is specifically missing before we could make that stronger claim credibly?**

**Is the real gap Functional, or is the capability already present but weakly exposed?**

It must not pretend to answer:

**What customers want**

**What customers will pay for**

**What will sell**

**What is competitively differentiated**

without evidence beyond the codebase.

The three independent relation layers expose:

**which propositions are currently surfaced externally**

**which capabilities and guarantees make those propositions credible**

and:

**how current external interactions correspond to actual system functionality**

Incomplete triangles are meaningful.

A proposition may be functionally real but weakly exposed.

An external surface may be technically necessary without representing a compelling Product Proposition.

A Functional capability may be important without being independently productizable.

Several distinct Functional guarantees may jointly support one Product Proposition or Customer Claim without becoming one Functional node.

Several externally different interaction contracts may share the same transport without becoming one External semantic area.

A Customer Claim may combine several Product Propositions without replacing or simplifying them.

A stronger desired Customer Claim may expose a precise missing Functional requirement without pretending that requirement already exists.

Customer-facing communication may be compressed.

The semantic views that support it must not be compressed merely because the communication is.

Do not force symmetry.

Do not convert technical sophistication into assumed product value.

Do not convert potential productization into assumed market demand.

Do not convert desired claims into current product reality.

Do not convert customer-facing synthesis into a reason to erase independently meaningful Functional or External distinctions.

The resulting artifact should be useful as a codebase-grounded bridge between product reasoning, customer communication, Product Ownership, and Functional system semantics.