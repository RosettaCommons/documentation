# VirtualRoot
*Back to [[Mover|Movers-RosettaScripts]] page.*
## VirtualRoot

Reroot the pose foldtree on a (new) virtual residue. Useful for minimization in the context of absolute frames (coordinate constraints, electron density information, etc.)

```xml
<VirtualRoot name="(&string)" removable="(&bool false)" remove="(&bool false)" />
```

By default, the mover will add a virtual root residue to the pose if one does not already exist. If you wish to later remove the virtual root, add the root with a mover with removable set to true, and then later use a separate VirtualRoot mover with remove set to true to remove it.

Currently VirtualRoot with remove true is very conservative in removing virtual root residues, and won't remove the residue if it's no longer the root residue, if pose length changes mean that the root residue falls at a different numeric position, or if the virtual root residue wasn't added by a VirtualRoot mover with "removable" set. Don't depend on the behavior of no-op removals, though, as the mover may become more permissive in the future.

##See Also

* [[FoldTree overview]]
* [[FoldTreeFromLoopsMover]]
* [[HotspotDisjointedFoldTreeMover]]
* [[I want to do x]]
