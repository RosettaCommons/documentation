# HotspotDisjointedFoldTree
*Back to [[Mover|Movers-RosettaScripts]] page.*
## HotspotDisjointedFoldTree

Creates a disjointed foldtree where each selected residue has cuts N- and C-terminally to it.

```xml
<HotspotDisjointedFoldTree name="(&string)" ddG_threshold="(1.0 &Real)" resnums="('' comma-delimited list of residues &string)" scorefxn="(score12 &string)" chain="(2 &Integer)" radius="(8.0 &Real)"/>
```

-   ddG\_threshold: The procedure can look for hot-spot residues automatically by using this threshold. If you want to shut it off, specify a number above 100R.e.u. and set the residues in resnums
-   chain: Anything other than chain 1 is untested, but should not be a big problem to make work.
-   radius: what distance from the target protein constitutes interface. Used in conjunction with the ddG\_threshold to set the target residues automatically.


##See Also

* [[FoldTree Overview]]
* [[RosettaScriptsPlacement]]
* [[FoldTreeFromLoopsMover]]
* [[VirtualRootMover]]
* [[AddSidechainConstraintsToHotspotsMover]]
* [[BestHotspotCstMover]]
* [[DockWithHotspotMover]]
* [[HotspotDisjointedFoldTreeMover]]
* [[MapHotspotMover]]
* [[PlaceStubMover]]
* [[PlaceSimultaneouslyMover]]
* [[PlaceOnLoopMover]]
* [[PlacementMinimizationMover]]
* [[I want to do x]]: Guide to choosing a mover
