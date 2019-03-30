# InertPoseIntoPoseMover
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## InsertPoseIntoPoseMover

[[_TOC_]]

##Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

##Overview 

Insert a whole pose into another.  Loops, linkers, whaterver. No modeling here.  Wrapper to utility function insert_pose_into_pose.

Residues between start + end should be deleted before using this mover if needed.  See [[DeleteRegionMover]] or [[KeepRegionMover]] for how to do this is RosettaScripts.

Use the [[SavePoseMover]] to give the pose to this mover.  Works the same way in terms of saving and giving the reference pose as in the [[CCDEndsGraftMover]] XML example. 

##XML Script

**Combine with [[SavePoseMover]]**
```xml
     <InsertPoseIntoPoseMover name="(&string)" start_pdb_num (&string) end_pdb_num="(&string)" copy_pdbinfo="(&bool, false)" spm_reference_name=/>
```

###Required XML Options
-   start\_pdb\_num: PDB Number to start keep region from (including it). Ex: 24L.  Use start\_res\_num instead for internal numbering 
-   end\_pdb\_num: PDB Number to end keep region at (including it); Ex: 42L. Use end\_res\_num instead for internal numbering
-   spm_reference_name (&string): The name of the reference pose we are inserting.  See [[SavePoseMover]] for more info.

###Optional XML Options
-   copy_pdbinfo (&bool) (default=false): Copy the PDBInfo (PDB residue numbers and chain Ids) into the new pose.  Make these able to be output in the final pose. 


##See Also

* [[StorePoseSnapshotMover]]: Used to retain original residue numbering
* [[SavePoseMover]]
* [[AnchoredGraftMover]]
* [[CCDEndsGraftMover]]
* [[Insertion and Deletion | Movers-RosettaScripts#general-movers_insertion-and-deletion-grafting]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts