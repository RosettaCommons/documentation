# DockWithHotspotMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## DockWithHotspotMover

Does centroid docking with long range hotspot constraints and interchain\_cen energy function.

```xml
<DockWithHotspotMover name="&string" hotspot_score_weight="(10 &Real)" centroidscore_filter="(0 &Real)" hotspotcst_filter="40 &Real">
     <HotspotFiles explosion="(0 &integer)" stub_energy_threshold="(1.0 &Real)"  max_cb_dist="(3.0 &Real)" cb_force="(0.5 &Real)">
        <HotspotFile file_name="(hotspot1 &string)" cb_force="1.0 &Real"/>
        <HotspotFile file_name="(hotspot2 &string)" cb_force="1.0 &Real"/>
     </HotspotFiles>
</DockWithHotspotMover>
```

-   hotspot\_score\_weight is the weighting of hotspot constraints
-   centroidscore\_filter is evaluated when interface is mutated to Alanine and pose is converted to centroid. Only docking decoys passing this threshold will be retained.
-   hotspotcst\_filter is a penalty term from a summation of all stub libraries. Only docking decoys passing this threshold will be retained. Default is 40 for each stub library.
-   file\_name is the name of stub library. Put on multiple lines if you have several stub libraries.
-   cb\_force is the weighting factor in matching CB distance. Default to 1.0. Set to 0.0 when you are interested in matching backbone (Ca, C and N) only. Useful in using backbone hydrogen bond in hotspot library


##See Also

* [[DockingMover]]
* [[DockingProtocolMover]]
* [[FlexPepDockMover]]
* [[HighResDockerMover]]
* [[Docking applications]]: Command-line applications for docking
* [[RosettaScriptsPlacement]]
* [[AddSidechainConstraintsToHotspotsMover]]
* [[BestHotspotCstMover]]
* [[HotspotDisjointedFoldTreeMover]]
* [[MapHotspotMover]]
* [[PlaceStubMover]]
* [[PlaceSimultaneouslyMover]]
* [[PlaceOnLoopMover]]
* [[PlacementMinimizationMover]]
* [[I want to do x]]: Guide to choosing a mover
