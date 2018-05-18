# PlaceOnLoop
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PlaceOnLoop

Remodels loops using kinematic loop closure, including insertion and deletion of residues. Handles hotspot constraint application through these sequence changes.

```xml
<PlaceOnLoop name="( &string)" host_chain="(2 &integer)" loop_begin="(&integer)" loop_end="(&integer)" minimize_toward_stub="(1&bool)" stubfile="(&string)" score_high="(score12 &string)" score_low="(score4L&string)" closing_attempts="(100&integer)" shorten_by="(&comma-delimited list of integers)" lengthen_by="(&comma-delimited list of integers)"/>
```

currently only minimize\_toward\_stub is avaible. closing attempts: how many kinematic-loop closure cycles to use. shorten\_by, lengthen\_by: by how many residues to change the loop. No change is also added by default.

At each try, a random choice of loop change will be picked and attempted. If the loop cannot close, failure will be reported.

Demonstrated in JMB 413:1047


##See Also

* [[RosettaScriptsPlacement]]
* [[RosettaScriptsLoopModeling]]
* [[Loopmodel application|loopmodel]]
* [[Loop file format|loops-file]]
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
