---
name: execute-3d-modeling
description: Use when the user requests building, reconstructing, converting or modifying a 3D model. Choose a workflow for the inputs and intended use, inspect each shape change from multiple angles before building on it, and verify the delivered asset.
---

# Build or edit 3D models

Read the brief, inspect the supplied inputs and establish how the result will be used. A printable part, deforming mesh and editable family each need different evidence. Establish units, orientation, a reliable scale landmark and protected interfaces. For an edit, reopen the maintained source and observe the current result. Use the requested application and formats. Where the choice is open, choose an available modeler that supports the required edits and can produce the deliverable.

Choose the route below whose first input matches the job. Combine routes where the output of one becomes the input to another. A scanned housing can be the fixed host for a fitted cover. A sculpt can be the detailed master for a lighter display mesh. For each major component, identify its shape, placement, connection and first construction operation. Keep low-impact assumptions reversible. Obtain missing measurements when they govern a critical fit.

## Interpret 2D artwork in depth

Read the artwork at the scope of the brief. For a local edit, use surrounding geometry to judge how the changed region continues or connects. For a set, distinguish views of the same piece from different members or arrangements. Use shared landmarks or interfaces to compare like features while preserving intended variation.

Before turning a stroke into geometry, ask what could have produced it. A curve drawn across a surface can suggest how it bulges or turns in depth even when the outer silhouette is ambiguous. Model a permanent ridge or seam only when the reference or brief supports one. Where a contour ends against another, look for its continuation before joining the parts.

When plausible readings would change the construction, look for evidence that distinguishes them. A closed outline could enclose a surface marking, a recess or a through-hole. Look for an inner wall, a floor or background visible through it. Where the brief leaves geometry open, use the visible form, its role and its neighbors to decide how it continues in depth, where it ends and what it meets or clears. Build the extent that role calls for, including portions hidden in every supplied view. Keep consequential assumptions reversible and inspect the result in the whole model. Where fidelity to an existing form or a required fit depends on a hidden feature, verify that feature against an independent reference, measurement or mating geometry.

If views of the same geometry disagree, first align pose and perspective using landmarks that stay fixed relative to the region under comparison. On a smooth form, the point that defines its silhouette can shift as the viewpoint changes. Stylized drawings can also deliberately exaggerate different features in each view. Where the geometry must stay consistent across views, preserve the relationships they share and use the brief's priorities to resolve any remaining conflict.

**Build or revise a region from artwork using a reviewed component plan for that region.** Reuse the current plan when it still covers the brief. To create one, crop the region from every supplied view that shows it on the same subject and variant. Retain enough surrounding form to locate its attachments and judge its relative size.

Where forms meet or overlap in projection, even a tight crop can include part of a neighbor. Keep that context visible. Decide which parts belong in this pass from the brief and how the forms fit together. Include a neighbor when the requested result requires shaping them together. If the neighbor needs an independent change, handle it in a separate pass.

**If the new forms depend on an existing structural framework that must remain unchanged,** locate that framework in the current 3D model. Temporarily hide obstructing geometry as needed and capture the relevant part, showing its orientation and the space or mounting surfaces available for the new forms. Restore the original visibility. You may reuse a view verified against the same model state. Before starting ImageGen, attach the model view alongside the artwork crops and identify the entire framework that must be preserved. When delegating, ensure the model view reaches ImageGen as an image input. Leave the initial breakdown of new components open wherever the brief permits.

Generate the two sheets of the component plan in order. For each ImageGen call, send the common instructions and the corresponding sheet section from the [component plan prompt](references/artwork-component-plan.md). Describe the target and identify any neighbors shown for context only. When delegating, give the subagent running ImageGen responsibility for inspecting, correcting and selecting each sheet. When redrawing a region with an accepted breakdown, supply its assembly sheet and parts list as ImageGen inputs, including on a fresh run. Reopen the grouping only when the brief or new evidence calls for it.

1. **Assembly sheet.** Send the artwork crops and any required fixed-framework view. Show the assembled reference, explosion, front and side in color and again as straight-line drawings. Keep both sets undimensioned. The straight-line explosion and its **Key Components** list define the numbered units for both sheets. Check the forms and proportions against the artwork. Trace each list entry to exactly one unit in each explosion and confirm that it carries the same features in both. On a retry, preserve the grouping except where the identified error requires a change.
2. **Component sheet.** Attach the selected assembly sheet alongside the original crops and any required framework view. Copy its **Key Components** list into every prompt for this sheet. Carry forward any assembly warning. Check for exactly one group per entry, under the same number and name. Compare its axonometric, front, side, reverse and bottom views with the entire unit in the straight-line explosion, including the features it carries. Use the assembly's front direction for every installed component and look straight up for the bottom view. Correct discrepancies on this sheet using the same assembly image and list.

Open every result and inspect it visually without measuring the image. Verify that the sheet shows its section headings, component names and view labels where specified, and that each label belongs to the drawings beneath it or beside it. Select the first usable result for each sheet. For a missing heading, a missing view or an error that makes a sheet unreliable for blockout, retain its reference images and revise its prompt with the specific correction needed. Allow up to five regenerations per sheet after its first attempt. If none passes, select the best version of that sheet and record a warning naming the affected items and the remaining discrepancy.

**Hand off the selected assembly sheet and component sheet together**, including any warnings. When generation is delegated, the subagent handles all intermediate reviews. Even if previews are visible, the modeling agent waits for the complete handoff, then reviews only the selected pair against the artwork and uses that review to guide the blockout.

**A plan that passes fixes the component count, grouping and forms for the blockout. A release with a warning gives the modeling agent responsibility for deciding what to use.** Carry forward the parts supported by the original crops. Where a discrepancy affects construction, build rough alternatives in the working model and compare them from views that reveal the difference. Check them against the artwork, their neighbors and any fixed framework. If the first trials fall short, try a different construction, deriving it directly from the artwork where needed. Record the interpretation you adopt beside the affected drawing so it guides later checks.

**For a modeling job, plan only the region you will build or edit next.** Keep both selected sheets with the crops and start the blockout or requested edit in the working 3D model. Inspect the resulting geometry in the assembly against the artwork and the plan as interpreted above. Verify fit on the original framework where applicable. Use the same plan for geometry corrections. Revisit the breakdown if new evidence or a revised brief changes which components are required. Complete the 3D inspection before requesting any further sheets.

Keep the depicted form, count and arrangement of visible features by default. Where the brief leaves a local feature open, adopt a variation only if a rough comparison with the depicted version shows a specific construction benefit, such as better fit at a required interface or clearance through a required motion. Limit the change to what provides that benefit and preserve the feature's role and the character of the overall design. Note the local difference and its reason with the model.

## Verify the main forms before any detail work

**Every modeling route requires this check before detail work begins.** Inspect the blockout or the existing geometry in context. For an edit, check the relationships the change can affect.

1. Check proportions at three scales against the brief and available references. Inspect length, width and depth within the part, its size and spacing relative to surrounding forms, and the silhouette of the whole model. When the silhouette differs from a reference, use corresponding landmarks in views matched for pose and perspective to compare the relative sizes and positions of the major forms that define it. If several changes could restore the intended proportion, use step 3 to test plausible changes to the extent or placement of the contributing forms before refining details. Where dimensions or mating surfaces govern the shape, measure them in the relevant section or assembly.

   For a shared edit to several comparable items, measure the affected feature on every item using corresponding landmarks. Use common units for dimensions or calculate the relevant proportion separately for each item. Use the arithmetic mean across items as the baseline and recalculate it after the edit. When each item has a reference target, also compare the mean absolute error against those targets before and after the edit. Check the individual results alongside the mean to catch regressions and preserve intended variation.

2. Where appearance matters, identify the masses that give the subject its character. View the whole model at its intended size from the defining angle and from directions that reveal how the masses sit in depth. In each view, compare what actually draws the eye with the emphasis intended for that view.

   Shape the blockout so its volumes and gaps establish the defining profiles and surface transitions. When using a reference, follow those features between corresponding landmarks in a comparable view. Check where the form changes direction or thickness, how far the change extends and whether the transition is sharp or gradual. If a discrepancy changes the character of the form, revise the forms or spacing that produce it before detailing.

   When the outline is close but the volume still looks wrong, compare cross-sections at the landmarks that define the form. Check their shape as well as their width and depth, and how one section changes into the next.

3. When a consequential shape decision is open, use the rough-study comparison in [Choose where to edit](#choose-where-to-edit) before refining a version. If the next local edit would carry the same correction farther along a main volume or silhouette, identify which forms are meant to create it. Where the brief leaves their construction open, include both the proposed edit and an alternative that reshapes those forms or changes where they meet. Preserve specified dimensions and interface requirements in every study. For a measured reconstruction, explore only the geometry the evidence leaves unresolved.

For an artwork-based blockout, build or revise each numbered component from its individual drawings, applying any corrections established in the 3D trials. A component may span several meshes. Use neighboring geometry as a reference where it determines fit. Where neighboring components determine each other's shape, rough them in together.

As soon as a numbered component's main form can be judged, inspect its own geometry from the directions shown in its individual drawings. Temporarily hide anything that obstructs the comparison and check for a close match to the accepted form in profile, thickness, surface transitions and attachments. Complete this check before refining the component or building geometry that depends on its shape.

Then restore the assembly and check each component's placement, fit and any required motion. Compare the assembled region with each original crop in a matching view. Its overall proportions, silhouette and spacing must agree with the visible artwork except for a documented local variation. Verify that variation under the condition that justified it and resolve unintended discrepancies at both scales before adding detail.

**Proceed to detail only when the observed shape and required fit support the brief.** If a check fails, pause detail work and use [Choose where to edit](#choose-where-to-edit) to identify the cause and choose a correction. After applying it, repeat the affected comparison. If evidence is missing, obtain the view, section or measurement needed to decide. Repeat the affected checks whenever a later edit changes a main form.

## Choose where to edit

Use the selected region to locate the requested result. Before choosing an edit, inspect it in the whole model, in the view, pose or assembly condition that matters. Identify what the brief fixes and which proportions, placements or shared dimensions can change. When the local form is already right, trace the silhouette, gap or interference to the other geometry that defines it. The effective edit may be several parts away or in a dimension that positions multiple parts.

When a part's shape or placement depends on a mechanism, or an edit could obstruct its action, check the mechanism before choosing what to reshape, even if the visible form already matches. In the rough assembly, follow a change at the input far enough to see whether it produces the intended effect. If the current mechanism forces a compromise in form or action and the brief leaves the operating principle open, keep the target form in one study and test a different principle that could resolve the conflict.

If a hanging or mounted part sits awkwardly against a neighbor, identify which region carries it. Where the brief allows, keep the part's shape fixed and try changing where it hangs or how it is angled on its support. Compare the gap and silhouette in the full model. If the support and the neighboring region can move relative to each other, check a pose that reveals which one the part follows.

When an interface limits the intended form or movement, identify which parts must fit together and which dimensions and motions the brief requires. If travel is reduced, locate the limiting position and its cause, and check whether the required motion is affected. Before giving up a form that serves the brief, preserve its shape in a rough study and test a change to the joint, mount or mating geometry if an adjustable feature could resolve the conflict. Compare that study with a local shape change. Weigh the form and movement each preserves against the rework and compromises for other parts that use the interface. Before adopting a shared change, verify fit across the required combinations and clearance throughout the required motion.

**Stop local refinement when an edit leaves the main discrepancy unresolved with little or no improvement, moves the problem elsewhere or undoes the requested form.** Keep the last useful state as a baseline. If placement is the issue, test a meaningful change to the support, neighboring part or controlling dimension wherever the brief allows it.

When the construction itself is in doubt, identify the decision that would change the result. A different cross-section, a different division of volume between neighboring parts, or a different support can each produce a distinct silhouette or fit. Build the plausible approaches as separate rough studies before refining any of them. Start from the requirements and fixed interfaces. Rebuild the affected component or block out the group together when their shapes depend on one another. Take each study far enough to expose the difference that matters.

Compare the studies with each other and with the baseline in the same assembly, views and relevant poses. Choose the approach that best serves the brief among those that meet the required constraints. If the choice hinges on an uncertain clearance or contour, check it directly before adding detail. If all studies miss the target, use the comparison to identify a different approach and how you would recognize an improvement. If no useful next study is apparent, keep the baseline and state what remains unresolved before editing that region again. If every viable approach conflicts with a protected feature, identify that conflict before continuing.

## Inspect each shape change before building on it

**After each change to shape or placement, inspect the result before the next modeling decision.** Treat the operations that produce one intended change as a single edit. Before accepting the revision, locate the exact detail your judgment depends on, such as an edge, transition or gap, in an inspected view of that revision. This check applies even when the working view looks correct and the dimensional checks pass.

**Judge a construction by how its forms occupy space and relate to one another in the intended use.** When different arrangements look alike in the supplied views, inspect the relationship that distinguishes them in the model, using a revealing angle, section or pose. For a revision, compare that relationship with the baseline under the same conditions. If the discrepancy has only moved out of sight, correct the construction before accepting it. Where the brief calls for a view-dependent effect, judge it within the intended viewing range and preserve any other required behavior.

Orbit the assembled model and inspect the change up close from complementary directions. Let the shape and fit questions determine the angles and how many you need. A front view might establish the outline, a side view the projection, a rear view the attachment, or an oblique view whether two contours only appear to touch. Count near-duplicate views as one. Continue until you can point to a view that resolves each relevant question about the edit.

If surrounding geometry obscures the detail, temporarily hide the obstructing parts. Keep the neighbors needed to judge the relationship visible. Inspect the exposed detail, using a section if the interface is still concealed.

When adjacent forms are visible but hard to distinguish, temporarily tint one to trace its outline against its neighbors. To judge a smooth transition, view both surfaces with the same neutral material and follow a moving highlight across the join.

Across variants and after corrections, repeat the revealing angles and framing. Reproduce any visibility, section, material or lighting settings used to expose the detail and inspect it again. Restore the original appearance and visibility, recheck the edited area with its neighbors in the assembled model, and inspect the whole model at its intended viewing size from the angles that reveal its silhouette and proportions.

Ground the decision in the views you actually saw. Open the viewport captures or rendered previews when working through scripts. Reference the inspected images of this revision in your working notes. State what the working view established and what each complementary direction let you verify about the same feature that was ambiguous before. A single labeled sheet can show the views together. If a view misses the feature, reframe and inspect it. If visual inspection is unavailable, mark the change visually unverified and pause work that depends on accepting it.

If one view improves and another gets worse, compare the candidate with the last accepted model in both views using matching angles and framing. Before accepting the trade-off, state what improved, what was lost and which priority in the brief justifies that loss. Keep the candidate provisional if the loss breaks a requirement or the brief gives no basis for accepting it. After a correction, recheck both views against the same baseline to confirm that the gain remains and reassess any remaining loss.

If a redesign appears to supersede geometry from an earlier trial, try suppressing that geometry before refining the new part. Leave it out of the accepted variant if the comparison shows that its role is covered and the intended form, fit and function hold without it.

## Reconstruct from drawings or line art

Use this route when supplied views define edges, openings and repeated design elements.

1. Identify which view controls the outline. Align views using a centerline, a shared plane and corresponding landmarks. Count visible openings or repeats. Distinguish contour edges from surface markings and hidden lines. For a photograph, account for perspective before comparing apparent widths.
2. Trace the main outline and holes as editable curves. Give plate-like regions thickness, sweep rod sections along centerlines, and build changing surfaces through cross sections taken from the other views. One drawing can define a flat relief. Record an assumed depth for a visual interpretation, or obtain a section when the depth determines fit.
3. Project the model back into each available view. Check landmark positions, openings, depth and repeat count. When the front matches but the side fails, adjust the depth section or reconcile the drawings. Verify the same outlines in the delivered file before accepting a close front match.

## Shape a freeform or stylized subject

Use this route for a character, sculpture or illustrated object whose identity rests on masses, gesture and negative space.

1. Block the main masses with a coarse cage or sculpt. Place landmarks at changes in direction and establish gaps between forms. Compare the neutral model at its intended size in the defining view and from angles that expose the depth and spacing of the masses.
2. When a silhouette misses the reference, compare the main masses, their spacing and the negative space between them. Adjust the proportion, placement or section that accounts for the mismatch and check the whole silhouette again. Use subdivision for smooth, editable curvature or sculpt finer transitions where direct surface editing is more effective. Keep the accepted coarse form available while refining.
3. For deformation, build or adjust topology around the regions that compress, stretch and twist. Bind a representative region to its controls, pose it through the required range and repair pinching or lost volume before carrying fine detail onto the finished mesh. For static display, check the surface under moving light. Verify the delivered silhouette and, where requested, a representative exported pose.

## Build a hard-surface visual asset for its destination

Start from the target viewing distance, required edits and any runtime budget. Build the planes, openings and major curves first. Cut or inset features that change the contour or reveal a real interior. Inspect the untextured result under neutral light.

- **Direct mesh.** For a rigid prop whose major edges fit the available geometry budget, model the visible bevels, recesses and curved profiles directly. Inspect flat faces for shading ripples and curves for faceting at delivery size.
- **Subdivision surface.** For close inspection or smooth product imagery, control the curvature with section spacing and supporting edges. Check reflections across adjoining surfaces. If a flat area pinches after smoothing, fix the controlling topology before adding surface finish.
- **Detailed master and lighter delivery mesh.** When close-up detail exceeds a runtime budget, retain the detailed master. Build a lighter mesh that preserves silhouette and holes, lay out its texture coordinates and transfer fine relief or color from corresponding surfaces. Isolate neighboring parts if they project onto each other. If the exported result has seams, inspect texture layout, normals and delivered triangulation. Inspect every requested detail level at its actual display size and check the footprint against the brief.

## Construct a dimensioned part or mechanical assembly

Start from the drawing, mating hardware and intended manufacturing process. Set datums at the seating plane, axis or hole pattern that defines the fit.

Where a mechanism’s action determines its form, identify what drives it, what stays fixed and how the parts transmit the action. In the rough assembly, trace a change at the input through those connections and check the resulting motion or effect.

1. Sketch and constrain the functional section. Extrude a constant section, revolve an axial profile, sweep a channel or loft between changing sections. Dimension mating features from the chosen datums. Derive related dimensions from their common driver.
2. Create the main body, cavities and seats. Assemble interacting bodies in position and reserve their insertion or motion paths. Add rounds, ribs and other finishing features after confirming the necessary wall and clearance.
3. Measure critical dimensions on the solid, inspect the tightest section and run the actual motion or insertion test. A part can clear at rest and catch during approach. If a rounded edge destroys a seat, correct the feature order or local relief and repeat the measurement.
4. Reopen the requested exchange solid or fabrication mesh and measure the same seats. For printing, check closure, face orientation, and the slicer's section through thin walls and holes. State which physical fits still require a specimen.

## Generate variants or a reusable kit

Use this route when the user needs multiple sizes, repeated patterned parts or components that can be rearranged. Gather the requested combinations, valid ranges and features that must stay interchangeable.

1. Build one representative member. Expose meaningful controls such as width, count or spacing. Derive internal positions and cavity sizes. Keep purchased hardware dimensions independent. Express repetition once, for example as a shaped section placed at stations along a path. Put the requested combinations in named presets or an equivalent input list. For a modular kit, give connections consistent positions and orientation and define which faces should meet or remain clear.
2. Generate the nominal member and boundary cases from the same construction. Test changes that interact. Increasing count alone might fit, while increasing count on the shortest body might break the edge margin. Guard invalid combinations. For a kit, assemble a seam, corner or reversed orientation where mistakes would show. For interchangeable modules, inspect the affected proportions in a representative mixed assembly and in the valid combinations at either end of the measured range. Where targets differ by assembly, also inspect the combination that deviates most from its own target. For moving variants, one tested combination can cover others when their shapes, paths and surroundings leave at least as much clearance throughout the required motion.
3. If the delivered model must respond to live input, change controls in the consuming environment and inspect the regenerated geometry there. For a fixed batch, evaluate each requested input through the same construction and export each result. Check output names, count, dimensions and a reopened extreme variant. If outputs drift, fix the shared construction and regenerate the affected members. For repeated display geometry, use instances where the destination preserves them and check the actual exported cost.

## Recover a scan, supplied mesh or generated starting shape

Choose this route when geometry already exists and may save reconstruction. Keep the raw input intact and inspect a working copy. Establish scale and orientation from a trustworthy dimension. Inspect loose pieces, boundaries, holes and surface direction. Switch off textures to see what is geometry and what is merely painted on.

If the input is a set of photographs of one object, first check for overlapping coverage from displaced camera positions. Match image features, estimate camera poses and inspect the sparse reconstruction for missing viewpoints before producing a dense surface. Set physical scale from a known length. When images show only one side, use the visible surface as measured evidence and treat any completion of the reverse side as inferred.

1. Preserve the recognizable shape, seams and measured landmarks. Remove acquisition debris and duplicate surfaces. Identify intended openings before patching holes. With partial capture, mark reconstructed or uncertain areas.
2. For a static visual mesh, simplify in low-curvature regions and compare the silhouette to the original. For a moving mesh, rebuild topology around the intended bends and test poses. Transfer useful detail to the clean mesh only after that shape holds. If a generated or scanned form misses an important section, reconstruct that section from evidence.
3. For an editable mechanical solid, fit planes, axes and sections to trustworthy regions, rebuild the required features and compare sections and mating measurements to the original. A faceted import alone cannot establish a nominal bore diameter or design tolerance. Reopen the delivered artifact and repeat its dimensional or visual checks.

## Fit new geometry onto or inside an existing host

Use this route for a fitted insert, internal passage, cover or added feature when the surrounding model must retain its exterior or existing interfaces.

1. Keep the host as fixed context. Inspect its units and transforms, then measure **in assembled coordinates**. Locate actual seats, normals, pocket floors and skin thickness with sections or surface measurements. A local axis or bounding box can misplace a feature on a rotated or scaled host.
2. Reserve space for installed components, cavities, fasteners, movement and service access. Construct the new feature separately against those measured surfaces. For an internal passage, route its centerline outside the reserved volumes, build its section and inspect narrow turns for remaining wall and bend clearance.
3. Section the assembled result at critical points. Verify intended seats, clearance, connectivity and exterior preservation. Investigate coarse collision hits on the real surfaces. If an added feature only looks aligned in isolation, check its coordinates and assembled orientation before reshaping it.
4. Reimport the addition and place it against the original host using the intended assembly transform. Repeat the fit check. Merge bodies only when the requested result needs a combined solid.

## Close the job

If a check fails, record the part, viewing or assembly condition and observed discrepancy. Apply the edit-selection and stopping rules above. Verify the requested form and the corrected condition together, then revisit the views, poses or sections that could reveal a trade-off. For a subjective choice, a controlled independent comparison can help when authorized. Keep the editable source. Open the actual requested output in its destination or a compatible reader. If only that file fails, check conversion settings, axes, simplification and missing dependencies before changing an already verified shape. Deliver the requested files with the checks performed and any material assumption or unverified condition.
