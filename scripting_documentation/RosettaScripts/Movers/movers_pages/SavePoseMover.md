# SavePoseMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SavePoseMover

This mover allows one to save a pose at any time point through out a trajectory or from disk, and recall it any time point again to replace a current pose. Can also just be used with filter, eg. delta filters.

```
<SavePoseMover name="native" restore_pose="(1, &bool)" reference_name="(&string)" pdb_file="(&string)" />
```

-   restore\_pose - if you want to replace it
-   reference\_name - is what the pose gets saved under. so to recall that one specific pose, just re-call it under the name given when first called.
-   pdb\_file - Optional. If present, will load the given PDB file into the referenced pose at parse time.


##See Also

* [[SaveAndRetrieveSidechainsMover]]
* [[DumpPdbMover]]
* [[I want to do x]]: Guide to choosing a mover