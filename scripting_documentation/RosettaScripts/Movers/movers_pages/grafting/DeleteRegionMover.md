# DeleteRegionMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## DeleteRegionMover

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com

PI: Roland Dunbrack

###Pupose
Deletes a region of the current pose. The region is specified by residue selectors that are applied at apply time, so the residue does not necessarily need to exist in the input structure. If residue numbers are provided, a ResidueIndexResidueSelector is automatically created at parse time.

```xml
<DeleteRegionMover name="(&string)"
                   residue_selector="(&string, '')"
                   start="(&string, '' (Ex: 24L))" end="(&string, '' (Ex: 42L))"
                   rechain="(&bool, false)" />
```

###Required
Start and end, OR a residue selector must be provided.

###Optional
-   residue_selector (&string): Name of a residue selector defined in the RESIDUE_SELECTORS section which selects the residues to be deleted.
-   start (&string): Rosetta or PDB residue number to start deletion from (including it). Examples: "24L", "108"
-   end (&string): Rosetta or PDB residue number to end deletion at (including it). Examples: "42L", "115" 
-   nter\_overhang (&size): Delete additional N residues on the nter side 
 - new_start = start_num - N
-   cter\_overhang (&size): Delete additional N residues on the cter side
 - new_end = end + N
-   rechain (&bool): If true, terminus variants will be added to residues bordering the deleted region, and chain IDs will be recomputed.  For example, in a 100-residue, single-chain pose, deleting residues 50-51 with rechain=true will result in a two-chain, 98-residue pose, with one chain spanning residues 1-49 and the other spanning residues 50-98.  If rechain=false, the resulting pose will be a single-chain, 98-residue pose with a chainbreak between residues 49 and 50.

##See Also

* [[StorePoseSnapshotMover]]: Used to retain original residue numbering when adding/deleting residues
* [[I want to do x]]: Guide to choosing a mover
* [[KeepRegionMover]]
* [[InsertPoseIntoPoseMover]]
* [[ReplaceRegionMover]]
