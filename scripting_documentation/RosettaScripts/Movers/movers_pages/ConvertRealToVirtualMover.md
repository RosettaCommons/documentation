# ConvertRealToVirtualMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ConvertRealToVirtualMover

[[include:mover_ConvertRealToVirtualMover_type]]

This mover is useful for building specific protocols or for ignoring parts of your pose.  A virtual residue is one that is not scored or output to a PDB.


## Example Use case

This mover was used to do iterative, semi-enumerative sampling of carbohydrate branches in the GlycanTreeRelax mover.  

##See Also

* [[ConvertVirtualToRealMover]]: Change a virtual residue back into a real one.
* [[GlycanTreeRelax]]: Example use of this mover.
* [[I want to do x]]: Guide to choosing a mover