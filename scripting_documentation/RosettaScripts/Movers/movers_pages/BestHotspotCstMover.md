# BestHotspotCst
*Back to [[Mover|Movers-RosettaScripts]] page.*
## BestHotspotCst

Removes Hotspot BackboneStub constraints from all but the best\_n residues, then reapplies constraints to only those best\_n residues with the given cb\_force constant. Useful to prune down a hotspot-derived constraint set to avoid getting multiple residues getting frustrated during minimization.

```xml
<BestHotspotCst name="(&string)" chain_to_design="(2 &integer)" best_n="(3 &integer)" cb_force="(1.0 &Real)"/>
```

-   best\_n: how many residues to cherry-pick. If there are fewer than best\_n residues with constraints, only those few residues will be chosen.
-   chain\_to\_design: which chain to reapply constraints
-   cb\_force: Cbeta force to use when reapplying constraints


##See Also

* [[RosettaScriptsPlacement]]: Movers related to hotspots, etc.
* [[AddSidechainConstraintsToHotspotsMover]]
* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[ClearConstraintsMover]]
* [[AddConstraintsToCurrentConformationMover]]
* [[TaskAwareCstsMover]]
* [[DockWithHotspotMover]]
* [[HotspotDisjointedFoldTreeMover]]
* [[MapHotspotMover]]
* [[PlaceStubMover]]
* [[PlaceSimultaneouslyMover]]
* [[PlaceOnLoopMover]]
* [[PlacementMinimizationMover]]
* [[I want to do x]]: Guide to choosing a mover
