# SetupForDensityScoring
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SetupForDensityScoring

Initialize the pose for using density scoring.

[[include:mover_SetupForDensityScoring_type]]

By default, this mover functions equivalently to the [[VirtualRootMover]], by (unconditionally) adding a virtual residue to the root of the FoldTree. This allows the protein to freely against the fixed density background.

By setting the `realign` option to "min" (the only other valid value), it will also attempt to do a rigid body  minimization of the Pose into the density map. (The density map is not provided to the mover, but is instead should be passed to the proper command line options. See [[density map scoring]] for details.)

##See Also

* [[Density Map Scoring]]
* [[VirtualRootMover]]
* [[FoldTree overview]]
* [[I want to do x]]
