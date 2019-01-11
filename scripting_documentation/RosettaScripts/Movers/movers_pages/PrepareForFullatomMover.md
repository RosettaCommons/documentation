# PrepareForFullatom
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PrepareForFullatom

Convert a pose into fullatom mode in preparation for high-resolution loop 
modeling.  This is used internally by LoopModeler.

```xml
<PrepareForFullatom name="(&string)" force_repack="(no &bool)" scorefxn="(&string)"/>
```

Options:

* force_repack: By default, only sidechains that are part of the loop and 
  sidechains that couldn't be recovered from the input structure are repacked 
  when converting to fullatom mode.  If the input pose is already in fullatom 
  mode, most positions may be left unchanged.  Enabling this option forces the 
  entire protein to be repacked regardless.

* scorefxn: The name of the score function to use for repacking.  Required.

##See Also

* [[PrepareForCentroidMover]]
* [[SwitchResidueTypeSetMover]]
* [[Centroid vs fullatom]]
* [[I want to do x]]: Guide to choosing a mover