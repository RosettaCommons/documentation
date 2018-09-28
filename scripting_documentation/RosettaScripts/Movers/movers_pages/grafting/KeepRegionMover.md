# KeepRegionMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## KeepRegionMover

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com

PI: Roland Dunbrack

###Purpose
Keeps a region of the current pose, deletes all the rest.  Residue number is parsed at apply time (PROTOCOLS section), so it does not nessessarily need to exist in the definition section (MOVERS section) (AKA for Protein Grafting).

```xml
<KeepRegionMover name="(&string)" residue_selector="(&string)">
```

###Required

-   residue_selector (&string): Name of a residue selector defined in the RESIDUE_SELECTORS section which selects the residues to be deleted.

###Optional

-   nter\_overhang (&Size): Keep additional N residues on the nter side 
 - region_start = region - N
-   cter\_overhang (&Size): Keep additional N residues on the cter side
 - region_end = region + N

##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[DeleteRegionMover]]
* [[InsertPoseIntoPoseMover]]
