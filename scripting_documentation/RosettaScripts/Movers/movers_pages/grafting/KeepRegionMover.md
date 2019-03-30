# KeepRegionMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## KeepRegionMover

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com

PI: Roland Dunbrack

###Purpose
Keeps a region of the current pose, deletes all the rest.  Residue number is parsed at apply time (PROTOCOLS section), so it does not nessessarily need to exist in the definition section (MOVERS section) (AKA for Protein Grafting).

```xml
<KeepRegionMover name="(&string)" start_pdb_num="(&string (Ex: 24L))" end_pdb_num="(&string (Ex: 42L))">
```

###Required

-   start\_pdb\_num: PDB Number to start keep region from (including it). Ex: 24L.  Use start\_res\_num instead for internal numbering 

-   end\_pdb\_num: PDB Number to end keep region at (including it); Ex: 42L. Use end\_res\_num instead for internal numbering

###Optional

-   nter\_overhang (&Size): Keep additional N residues on the nter side 
 - new_start = start_num - N
-   cter\_overhang (&Size): Keep additional N residues on the cter side
 - new_end = end + N

##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[DeleteRegionMover]]
* [[InsertPoseIntoPoseMover]]
