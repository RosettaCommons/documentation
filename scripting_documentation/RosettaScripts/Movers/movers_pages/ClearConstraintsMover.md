# ClearConstraintsMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ClearConstraintsMover

Remove any constraints from the pose.

    <ClearConstraintsMover name="(&string)" />

Note that this will remove both geometric (e.g. atom pair constraints, coordinate constraints) and sequence constraints (e.g. amino acid composition constraints) from the pose.


##See Also

* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[AddConstraintsToCurrentConformationMover]]
* [[AddSidechainConstraintsToHotspotsMover]]
* [[TaskAwareCstsMover]]