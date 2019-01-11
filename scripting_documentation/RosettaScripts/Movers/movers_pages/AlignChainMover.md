# AlignChain
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AlignChain

Align a chain in the working pose to a chain in a pose on disk (CA superposition).  All chains in the moving pose are rotated into the new coordinate frame, but the rotation is calculated on the specified chain.  Specifying the 0th chain results in a whole-Pose alignment.

```xml
<AlignChain name="(&string)" source_chain="(0&Int)" target_chain="(0&Int)" target_name="(&string)" align_to_com="(0 &bool)" />
```

- **source\_chain**: the chain number in the working pose. 0 means the entire pose.
- **target\_chain**: the chain number in the target pose. 0 means the entire pose.
- **target\_name**: file name of the target pose on disk. The pose will be read just once at the start of the run and saved in memory to save I/O.

target and source chains must have the same length of residues.

- **align_to_com**: Aligns pose to center of mass instead of 2nd pose/target. The variable target_name still needs to be declared, so just pass target_name="dummy".

##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[SuperimposeMover]]
* [[AddChainMover]]
* [[AddChainBreakMover]]
* [[BridgeChainsMover]]
* [[StartFromMover]]
* [[SwitchChainOrderMover]]
