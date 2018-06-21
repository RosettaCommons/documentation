# AtomCoordinateCstMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AtomCoordinateCstMover

The mover which adds coordinate constraints to the pose for the relax application. Coordinate constraints are added to the pose according to the state of the pose at apply time, or based on a separate native pose.

```xml
<AtomCoordinateCstMover name="(&string)" coord_dev="(&Real 0.5)" bounded="(&bool false)" bound_width="(&Real 0)" sidechain="(&bool false)" native="(&bool false)" task_operations="(&comma-delimited list of taskoperations)" func_groups="(&bool false)" />
```

-   coord\_dev - the strength/deviation of the constraints to use (e.g. -relax:coord\_cst\_stdev)
-   bounded - whether to use harmonic (false) or bounded (true) constraints
-   bound\_width - the width of the bounded constraint (e.g. -relax::coord\_cst\_width)
-   sidechain - whether to constrain just the backbone heavy atoms (false) or all heavy atoms (true) (e.g. -relax:coord\_constrain\_sidechains)
-   native - if true, use the pose from -in:file:native as the reference instead of the pose at apply time. A heuristic based on the size and PDB designations is used to match up residues in the two poses. Poses of differing sequences can be used, even for sidechain constraints. Only matching atoms will be constrained.
-   task\_operations - if given, only apply constraints to those residues which are listed as packable by the task\_operations. If not given, apply constraints to all residues in the pose.
-   func\_groups - if true, will apply coordinate constraints on the functional atoms of the constraints residues. For example, the N atoms of an Arg residue. If this option is used the constraint applied are only harmonic. Using bounded constraints will throw an error.

Remember that to have effect, the coordinate\_constraint scoreterm must be on in the scorefunction. It is highly recommended that you apply a virtual root to your pose prior to applying these constraints, especially if you're constraining against a native. (See the [VirtualRoot](#VirtualRoot) mover.)


##See Also

* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[ClearConstraintsMover]]
* [[AddConstraintsToCurrentConformationMover]]
* [[AddSidechainConstraintsToHotspotsMover]]
* [[TaskAwareCstsMover]]
