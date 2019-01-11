# ExtendChainMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ExtendChainMover

This mover will add arbitrary bits of idealized secondary structure at the beginning or end of chains.

```
<ExtendChain name="&string" motif=(&string) chain=(&integer) segment=(&string) prepend=(&bool)/>
```

- motif: A string with what motif should be added to the Pose.  For example, "10HA" adds 10 helical residues.  "1LG-1LB-10HA" should be valid but this author doesn't know what that does.  
- chain: An integer, with which chain of the Pose should be modified.  Notice this is number not letter; you'll need to know the internal numbering of the Pose.
- prepend: by default, append to the C-terminus of the chain; if prepend is true, it probably goes to the N-terminus instead
- segment: a different way to specify what to modify, other than by chain number; this author doesn't know how it works.
- length: NOT a valid option!  You have to use motif instead.

##See Also

* [[I want to do x]]: Guide to choosing a mover