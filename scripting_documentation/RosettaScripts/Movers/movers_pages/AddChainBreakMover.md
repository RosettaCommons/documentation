# AddChainBreak
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddChainBreak

Adds a chainbreak at the specified position

```xml
<AddChainBreak name="(&string)" resnum="(&string)" change_foldtree="(1 &bool)" find_automatically="(0 &bool)" distance_cutoff="(2.5&Real)" remove="(0 &bool)"/>
```

-   resnum: add a chainbreak at the given position.  Specifically, add the `CUTPOINT_LOWER` variant type to the given residue and a `CUTPOINT_UPPER` to resnum + 1.
-   change\_foldtree: add a jump at the cut site.
-   find\_automatically: find cutpoints automatically according to the distance between subsequent C and N atoms.
-   distance\_cutoff: the distance cutoff between subsequent C and N atoms at which to decide that a cutpoint exists.
-   remove: if true remove the chainbreak from the specified position rather than add it.

##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[FoldTree overview]]
* [[AddChainMover]]
* [[AlignChainMover]]
* [[BridgeChainsMover]]
* [[StartFromMover]]
* [[SwitchChainOrderMover]]
