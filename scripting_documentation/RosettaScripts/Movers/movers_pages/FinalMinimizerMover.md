# FinalMinimizer
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FinalMinimizer

This mover is part of the LigandDocking protocol.

[[include:mover_FinalMinimizer_type]]

The "movemap_builder" specifies which [[MoveMapBuilder|RosettaScripts#rosettascript-sections_ligands_movemap_builders]] is used to make a movemap that will describe which side-chain and backbone degrees of freedom exist.

If backbone movement is specified in the movemap_builder, the mover will set up a custom loop foldtree for the pose prior to minimizing, with added cuts and jumps such that any residues not specified to move in the movemap will stay fixed in space (as opposed to being moved by lever-arm effects). The mover should return the foldtree to its original state at the end of the process.

To keep the minimized loops from opening up, the mover will automatically add the `chainbreak` term to the scorefunction being used if the weight of this term has not been set manually. In addition, it will also add coordinate constraints to the backbone Calphas of the residues being moved. (The scorefunction will not be adjusted if it does not have that term turned on, though.) If `remove_constraints` is true, these constraints are removed at the end of the minimization.

##See Also

* [[DockingMover]]
* [[MinMover]]
* [[HighResDockerMover]]
* [[FlexPepDockMover]]
* [[DockingProtocolMover]]
* [[Minimization overview]]
