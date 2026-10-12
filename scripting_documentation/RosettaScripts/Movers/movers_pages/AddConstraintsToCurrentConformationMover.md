# AddConstraintsToCurrentConformationMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddConstraintsToCurrentConformationMover

Add constraints to the pose based on the current conformation. It can either apply coordinate constraints to protein Calpha and DNA heavy atoms (the default) or atom pair distance constraints between protein Calpha pairs. The functional form for the coordinate constraints can either be harmonic or bounded (flat-bottom), whereas atom pair distance constraints are currently only gaussian in form.

[[include:mover_AddConstraintsToCurrentConformationMover_type]]

##See Also

* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[ClearConstraintsMover]]
* [[AddSidechainConstraintsToHotspotsMover]]
* [[TaskAwareCstsMover]]
