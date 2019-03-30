# TaskAwareCsts
*Back to [[Mover|Movers-RosettaScripts]] page.*
## TaskAwareCsts

Add coordinate constraints to all residues that are considered designable by the task\_operations. Mean and SD are hardwired to 0,1 at present. If you want to use this, don't forget to make downstream movers aware of coordinate constraints by changing their scorefxn's coordinate\_constraint weight.

```xml
<TaskAwareCsts name="(&string)" anchor_resnum="('' &string)" task_operations="(&comma-delimited list of task operations)"/>
```
-  anchor_resnum: which residue to use as anchor for the coordinate constraints? Since Rosetta conformation sampling is done in torsion space coordinate constraints are relative to a position. If this option is not set the anchor is set to the first designable residue defined in the task_operations. Use general pose numbering here: 3 means 3rd residue in the pose, whereas 3B means residue 3 in chain b. The residue number is parsed at apply time.
-  task_operations: residues defined as designable have coordinate restraints placed on their CAs.



##See Also

* [[Task operations in RosettaScripts|TaskOperations-RosettaScripts]]
* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[ClearConstraintsMover]]
* [[AddConstraintsToCurrentConformationMover]]
* [[AddSidechainConstraintsToHotspotsMover]]
* [[TaskAwareMinMOver]]
* [[TaskAwareSymMinMover]]
* [[I want to do x]]: Guide to choosing a mover
