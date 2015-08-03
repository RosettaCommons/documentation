# DeleteRegionMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## DeleteRegionMover

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com

PI: Roland Dunbrack

###Pupose
Deletes a region of the current pose.  Residue number is parsed at apply time (PROTOCOLS section), so the residue does not nessessarily need to exist in the definition section (MOVERS section).

```
<DeleteRegionMover name=(&string) start_pdb_num=(&string (Ex: 24L)) end_pdb_num=(&string (Ex: 42L)) />
```

###Required

-   start\_pdb\_num (&string): PDB Number to start deletion from (including it). Ex: 24L.  Use start\_res\_num instead for internal numbering 

-   end\_pdb\_num (&string): PDB Number to end deletion at (including it); Ex: 42L. Use end\_res\_num instead for internal numbering

###Optional

-   nter\_overhang (&size): Delete additional N residues on the nter side 
 - new_start = start_num - N
-   cter\_overhang (&size): Delete additional N residues on the cter side
 - new_end = end + N

##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[KeepRegionMover]]
* [[InsertPoseIntoPoseMover]]
