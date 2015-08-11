# A note on parsing residue selections in movers and filters

Return to [[Development Documentation|development_documentation/Development-Documentation]].

Page created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory, 25 June 2015.

## Ways in which users can specify residues

Historically, users could specify residue indices in one of two ways: using Rosetta's internal numbering (<i>e.g.</i> ```7```), in which each residue in each pose is given a unique, continuous, 1-based index, or using PDB numbering (<i>e.g.</i> ```7A```), in which the user must specify a residue index and a chain letter.  A third option has also been added: using reference poses, in which a known position from an earlier stage of a pose is used to select a position in the current pose.  The format for this is:
 
```
refpose(<refpose_name>,<Rosetta_index_in_refpose>)±<residue_offset>
```

For example, at a particular point in a script, I could create a snapshot of the pose using the StorePoseSnapshot mover, and call it "refpose1".  I could then apply movers that alter the residue numbering (inserting residues, deleting residues, <i>etc.</i>), then tell Rosetta that I want to mutate the residue that's three residues past the residue that was residue 12 when I took the pose snapshot using the string ```refpose(refpose1,12)+3```.  This can be particularly handy when working with variable-length loops.

## How the reference pose machinery works internally

Pose objects now store an owning pointer to a ReferencePoseSet object.  By default, this owning pointer is null, costing nearly nothing in memory overhead.  When the StorePoseSnapshot mover is applied, a ReferencePoseSet object is created (if none exists), the owning pointer is set to point to it, and a new ReferencePose object is created within the ReferencePoseSet and initialized.  A ReferencePose object stores a mapping of (old_pose_index_in_reference_state) to (current_pose_index_in_current_state).  If the residue in the reference state has ceased to exist, the mapping will be onto residue 0.  The map is initialized to be a simple mapping of each residue onto itself, since the pose length and numbering has not yet been modified.

## Getting movers that alter pose length to update stored reference poses

So long as movers that add, insert, or delete residues do so by calling the various addition, insertion, or deletion methods in the core::pose::Pose class, the reference pose numbering is updated automatically, and no changes are required to the mover.  If a mover bypasses these methods, directly calling the addition, insertion, or deletion methods in the core::conformation::Conformation class, the reference pose numbering will be incorrect.

## Getting movers and filters that take residue indices as input to understand reference poses

Previously, movers that could parse both Rosetta numbering and PDB numbering did so by calling the ```core::pose::parse_resnum()``` function in core/pose/selection.cc.  This function is still used for this purpose, although now it can <i>also</i> parse reference pose numbers.  However, it does not do so by default.  In order to permit a mover or filter to take advantage of reference poses, the following small changes must be made:

- The mover or filter must store a string for the residue selection rather than an integer or a core::Size.  This adds negligibly to the memory overhead of the mover or filter.

- In the mover or filter's ```apply()``` function (<i>NOT in its</i> ```parse_my_tag``` <i>function!</i>), the mover or filter should call ```core::pose::parse_resnum()```, with ```check_for_refpose=true``` to convert the string into a Rosetta index for the current state of the pose.  This adds negligibly to the computational cost of the mover or filter, but it must be done at apply time rather than initial setup time because the whole point of reference poses is that the pose length or numbering might change from the start of a script or protocol to the point at which a mover or filter is applied.  Note that if ```check_for_refpose=false``` (the default), then the function doesn't consider whether the string could specify reference pose numbering, and only performs the old behaviour of checking for Rosetta or PDB numbering.  This is to prevent movers that have not been modified to parse residue numbering at apply time from using reference poses.

## Where does the code live?

* ReferencePose and ReferencePoseSet classes are in core/pose/reference_pose/
* Utility functions for updating reference poses have been added to core/pose/Pose.cc.
* The StorePoseSnapshot mover is in protocols/simple_moves/StorePoseSnapshot.cc.
* The MutateResidue mover, which serves as an example of how movers can be modified to use reference poses, is in protocols/simple_moves/MutateResidue.cc.

##See Also

* [[RosettaScripts Developer Guide]]
* [[StorePoseSnapshotMover]]
* [[MutateResidueMover]]: A mover that currently supports reference poses