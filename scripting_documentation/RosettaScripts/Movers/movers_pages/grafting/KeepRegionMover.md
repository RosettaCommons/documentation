# KeepRegionMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## KeepRegionMover

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com

PI: Roland Dunbrack

###Purpose
Keeps a region of the current pose, deletes all the rest.  Residue number is parsed at apply time (PROTOCOLS section), so it does not nessessarily need to exist in the definition section (MOVERS section) (AKA for Protein Grafting).

[[include:mover_KeepRegionMover_type]]


##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[DeleteRegionMover]]
* [[InsertPoseIntoPoseMover]]
