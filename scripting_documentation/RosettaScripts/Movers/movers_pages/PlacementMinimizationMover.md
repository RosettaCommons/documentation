# PlacementMinimization
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PlacementMinimization

This is a special mover associated with PlaceSimultaneously, below. It carries out the rigid-body minimization towards all of the stubsets.

```xml
<PlacementMinimization name="( &string)" minimize_rb="(1 &bool)" host_chain="(2 &integer)" optimize_foldtree="(0 &bool)" cb_force="(0.5 &Real)">
  <StubSets>
    <Add stubfile="(&string)"/>
  </StubSets>
</PlacementMinimization>
```


##See Also

* [[PlaceSimultaneouslyMover]]
* [[RosettaScriptsPlacement]]
* [[MinMover]]
* [[SymMinMover]]
* [[Minimization overview]]
* [[AddSidechainConstraintsToHotspotsMover]]
* [[BestHotspotCstMover]]
* [[DockWithHotspotMover]]
* [[HotspotDisjointedFoldTreeMover]]
* [[MapHotspotMover]]
* [[PlaceStubMover]]
* [[PlaceOnLoopMover]]
* [[I want to do x]]: Guide to choosing a mover
