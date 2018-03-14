# SavePoseMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SavePoseMover

This mover allows one to save a pose at any time point through out a trajectory or from disk, and recall it any time point again to replace a current pose. Can also just be used with filter, eg. delta filters.

```xml
<SavePoseMover name="native" restore_pose="(1, &bool)" reference_name="(&string)" pdb_file="(&string)" />
```

-   restore\_pose - If you set this to 0, the pose will be _saved_ as whatever name is specified by reference_name.  If you set it to 1 (the default), it will delete the current pose and _restore the pose previously saved_ as reference_name as the current pose.
-   reference\_name - When saving a pose, the current pose will be saved under this name, to be referenced by other instances of SavePoseMover or other movers/filters.  When restoring a pose, this should be the name used by a previous SavePoseMover in which restore_pose=0.
-   pdb\_file - Optional. If present, will load the given PDB file into the referenced pose at parse time, rather than using the current pose.  If used, restore_pose should be set to 0???


##See Also

* [[SaveAndRetrieveSidechainsMover]]
* [[DumpPdbMover]]
* [[I want to do x]]: Guide to choosing a mover
