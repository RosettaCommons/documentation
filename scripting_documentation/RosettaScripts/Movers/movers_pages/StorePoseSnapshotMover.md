# StorePoseSnapshot
Page created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory, 26 June 2015.<br/>
Back to [[Mover|Movers-RosettaScripts]] page.<br/>
## StorePoseSnapshot

Rosetta's sequential residue numbering can create headaches in protocols in which residues are to be inserted or deleted, and in which one wishes subsequently to refer to residues past the insertion or deletion point.  The StorePoseSnapshot mover is intended as a means of permitting a user to store a named snapshot or "reference pose" at a particular point in a protocol, then use the residue numbering of the pose <i>at that point in the protocol</i> for movers and filters that might be applied sometime later, after pose indices may have been altered by insertions or deletions.

The syntax for the mover is very simple:

```xml
<StorePoseSnapshot name="(&string)" reference_pose_name="(&string)" />
```

-   reference_pose_name: The name of the snapshot or reference pose object.  Many different snapshots may be stored (by applying different StorePoseSnapshot movers at different points in the protocol), and may subsequently be referred to by different names.

Here's an example of how the mover might be used with other movers that take advantage of reference poses.  In this script, we import a pose, store a snapshot, delete residues 5 through 8, then mutate a residue that would have been at position 10 in the original structure (but which will now be at position 6, since 4 residues were deleted).  We then delete residues 3 to 5, and mutate the residue <i>before</i> the residue that used to be at position 10 (but which is now at position 3, so the residue preceding it is position 2). 

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
	</SCOREFXNS>
	<TASKOPERATIONS>
	</TASKOPERATIONS>
	<FILTERS>
	</FILTERS>
	<MOVERS>
		<StorePoseSnapshot name="storesnapshot1" reference_pose_name="ref1" />
		<DeleteRegionMover name="delete5to8" start_res_num="5" end_res_num="8" /> 
		<MutateResidue name="mutate_old_10" target="refpose(ref1,10)" new_res="LEU" />
		<DeleteRegionMover name="delete3to5" start_res_num="3" end_res_num="5" /> 
		<MutateResidue name="mutate_res_before_old_10" target="refpose(ref1,10)-1" new_res="LYS" />
	</MOVERS>
	<APPLY_TO_POSE>
	</APPLY_TO_POSE>
	<PROTOCOLS>
		<Add mover="fullatom" />
		<Add mover="storesnapshot1" />
		<Add mover="delete5to8" />
		<Add mover="mutate_old_10" />
		<Add mover="delete3to5" />
		<Add mover="mutate_res_before_old_10" />
	</PROTOCOLS>
</ROSETTASCRIPTS>
```

Movers and filters that can use reference pose numbering parse input of the form ```refpose(<reference_pose_name>,<index_in_reference_pose>)±<offset>```, where the offset permits a user to specify that the target residue is N residues before or after a particular residue corresponding to an index in the reference pose.  Note that because this is a new, experimental feature, only the [[MutateResidue|MutateResidueMover]] currently supports reference pose residue numbering as an input, though it is easy to modify other movers to permit this (see [[this note|A note on parsing residue selections in movers and filters]] in the developers' documentation for information on how to do this).

<b>Warning:</b>  Reference poses have not been tested with symmetry!  Use at your own risk with symmetric poses!

##See Also

* [[DeleteRegionMover]]
* [[InsertPoseIntoPoseMover]]
* [[KeepRegionMover]]
* [[ReplaceRegionMover]]
* [[I want to do x]]: Guide to choosing a RosettaScripts mover
