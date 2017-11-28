# ClearConstraintsMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ClearConstraintsMover

Remove any constraints from the pose.

    <ClearConstraintsMover name="(&string)" />

Note that this will remove both geometric (_e.g._ atom pair constraints, coordinate constraints) and sequence constraints (_e.g._ amino acid composition constraints, net charge constraints) from the pose.  To remove only the latter, use the [[ClearCompositionConstraintsMover]].


##See Also

* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[AddConstraintsToCurrentConformationMover]]
* [[AddSidechainConstraintsToHotspotsMover]]
* [[TaskAwareCstsMover]]
* [[ClearCompositionConstraintsMover]]
* [[AddCompositionConstraintMover]]
* [[AddNetChargeConstraintMover]]
