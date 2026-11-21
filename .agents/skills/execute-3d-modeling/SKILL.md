---
name: execute-3d-modeling
description: Use when the user requests building, reconstructing, converting or modifying a 3D model. Select a workflow for the available inputs and intended use, construct and inspect the geometry, and verify the delivered asset.
---

# Model a 3D object

Read the brief, inspect the supplied inputs and establish how the result will be used. A printable part, deforming mesh and editable family each need different evidence. Establish units, orientation, a reliable scale landmark and protected interfaces. For an edit, reopen the maintained source and observe the current result. Use the requested application and formats. Where the choice is open, choose an available modeler that supports the required edits and can produce the deliverable.

Choose the route below whose first input matches the job. Combine routes where the output of one becomes the input to another. A scanned housing can be the fixed host for a fitted cover. A sculpt can be the detailed master for a lighter display mesh. For each major component, identify its shape, placement, connection and first construction operation. Keep low-impact assumptions reversible. Obtain missing measurements when they govern a critical fit.

## Reconstruct from drawings or line art

Use this route when supplied views define edges, openings and repeated design elements.

1. Identify which view controls the outline. Align views using a centerline, a shared plane and corresponding landmarks. Count visible openings or repeats. Distinguish contour edges from surface markings and hidden lines. For a photograph, account for perspective before comparing apparent widths.
2. Trace the main outline and holes as editable curves. Give plate-like regions thickness, sweep rod sections along centerlines, and build changing surfaces through cross sections taken from the other views. One drawing can define a flat relief. Record an assumed depth for a visual interpretation, or obtain a section when the depth determines fit.
3. Project the model back into each available view. Check landmark positions, openings, depth and repeat count. When the front matches but the side fails, adjust the depth section or reconcile the drawings. Verify the same outlines in the delivered file before accepting a close front match.

## Shape a freeform or stylized subject

Use this route for a character, sculpture or illustrated object whose identity rests on masses, gesture and negative space.

1. Block the main masses with a coarse cage or sculpt. Place landmarks at changes in direction and establish gaps between forms. Compare the neutral model at its intended size in the defining view and a second view that exposes depth.
2. Change the mass or its section when the silhouette fails. Use subdivision for smooth, editable curvature or sculpt finer transitions where direct surface editing is more effective. Keep the accepted coarse form available while refining.
3. For deformation, build or adjust topology around the regions that compress, stretch and twist. Bind a representative region to its controls, pose it through the required range and repair pinching or lost volume before carrying fine detail onto the finished mesh. For static display, check the surface under moving light. Verify the delivered silhouette and, where requested, a representative exported pose.

## Build a hard-surface visual asset for its destination

Start from the target viewing distance, required edits and any runtime budget. Build the planes, openings and major curves first. Cut or inset features that change the contour or reveal a real interior. Inspect the untextured result under neutral light.

- **Direct mesh.** For a rigid prop whose major edges fit the available geometry budget, model the visible bevels, recesses and curved profiles directly. Inspect flat faces for shading ripples and curves for faceting at delivery size.
- **Subdivision surface.** For close inspection or smooth product imagery, control the curvature with section spacing and supporting edges. Check reflections across adjoining surfaces. If a flat area pinches after smoothing, fix the controlling topology before adding surface finish.
- **Detailed master and lighter delivery mesh.** When close-up detail exceeds a runtime budget, retain the detailed master. Build a lighter mesh that preserves silhouette and holes, lay out its texture coordinates and transfer fine relief or color from corresponding surfaces. Isolate neighboring parts if they project onto each other. If the exported result has seams, inspect texture layout, normals and delivered triangulation. Inspect every requested detail level at its actual display size and check the footprint against the brief.

## Construct a dimensioned part or mechanical assembly

Start from the drawing, mating hardware and intended manufacturing process. Set datums at the seating plane, axis or hole pattern that defines the fit.

1. Sketch and constrain the functional section. Extrude a constant section, revolve an axial profile, sweep a channel or loft between changing sections. Dimension mating features from the chosen datums. Derive related dimensions from their common driver.
2. Create the main body, cavities and seats. Assemble interacting bodies in position and reserve their insertion or motion paths. Add rounds, ribs and other finishing features after confirming the necessary wall and clearance.
3. Measure critical dimensions on the solid, inspect the tightest section and run the actual motion or insertion test. A part can clear at rest and catch during approach. If a rounded edge destroys a seat, correct the feature order or local relief and repeat the measurement.
4. Reopen the requested exchange solid or fabrication mesh and measure the same seats. For printing, check closure, face orientation, and the slicer's section through thin walls and holes. State which physical fits still require a specimen.

## Generate variants or a reusable kit

Use this route when the user needs multiple sizes, repeated patterned parts or components that can be rearranged. Gather the requested combinations, valid ranges and features that must stay interchangeable.

1. Build one representative member. Expose meaningful controls such as width, count or spacing. Derive internal positions and cavity sizes. Keep purchased hardware dimensions independent. Express repetition once, for example as a shaped section placed at stations along a path. Put the requested combinations in named presets or an equivalent input list. For a modular kit, give connections consistent positions and orientation and define which faces should meet or remain clear.
2. Generate the nominal member and boundary cases from the same construction. Test changes that interact. Increasing count alone might fit, while increasing count on the shortest body might break the edge margin. Guard invalid combinations. For a kit, assemble a seam, corner or reversed orientation where mistakes would show.
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

If a check fails, record the part, viewing or assembly condition and observed discrepancy. Change the profile, surface or operation that controls it, then repeat the same check and a second condition that could reveal a trade-off. For a subjective choice, a controlled independent comparison can help when authorized. Keep the editable source. Open the actual requested output in its destination or a compatible reader. If only that file fails, check conversion settings, axes, simplification and missing dependencies before changing an already verified shape. Deliver the requested files with the checks performed and any material assumption or unverified condition.
