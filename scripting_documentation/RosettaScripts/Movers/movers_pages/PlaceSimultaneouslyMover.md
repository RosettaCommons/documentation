# PlaceSimultaneously
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PlaceSimultaneously

Places hotspot residues simultaneously on a scaffold, rather than iteratively as in PlaceStub. It is faster therefore allowing more backbone sampling, and should be useful in placing more than 2 hotspots.

```xml
<PlaceSimultaneously name="(&string)" chain_to_design="(2 &Integer)" repack_non_ala="(1 &bool)" optimize_fold_tree="(1 &bool)" after_placement_filter="(true_filter &string)" auction="(&string)" stub_score_filter="(&string)" stubscorefxn="backbone_stub_constraint &string" coor_cst_cutoff="100 &Real"/>
     <DesignMovers>
        <Add mover_name="(null_mover &string)" use_constraints="(1 &bool)" coord_cst_std="(0.5 &Real)"/>
     </DesignMovers>
     <StubSets explosion="(0 &integer)" stub_energy_threshold="(1.0 &Real)"  max_cb_dist="(3.0 &Real)" cb_force="(0.5 &Real)">
        <Add stubfile="(& string)" filter_name="(&string)"/>
     </StubSets>
     <StubMinimize min_repeats_before_placement="(0&Integer)" min_repeats_after_placement="(1&Integer)">
       <Add mover_name="(null_mover &string)" bb_cst_weight="(10.0 &Real)"/>
     </StubMinimize>
     <NotifyMovers>
       <Add mover_name="(&string)"/>
     </NotifyMovers>
</PlaceSimultaneously>
```

Most of the options are similar to PlaceStub above. Differences are mentioned below:

-   explosion: which chis to explode
-   stub\_energy\_threshold: after placement and minimization, what energy cutoff to use for each of the hotspots.
-   after\_placement\_filter: After all individual placement filters pass, this is called (might be redundant?)
-   min\_repeats: How many minimization repeats (over StubMinimize movers) after placement
-   movers defined under NotifyMovers will not be allowed to change the identities or rotamers of their hot-spot residues beyond what PlaceSimultaneously has decided on. This would be useful for avoiding losing the hot-spot residues in design movers after placement.
-   filters specified in the StubSets section may be set during PlaceSimultaneously's execution by PlaceSimultaneously. This allows filters to be set specifically for placed hot-spot residues. One such filter is AtomicContact.
-   rb\_stub\_minimization: a StubMinimization mover that will be run before PlaceSimultaneously.
-   auction: and Auction mover that will be run before PlaceSimultaneously.
-   stub\_score\_filter: a StubScoreFilter that will be run before PlaceSimultaneously.
-   stubscorefxn is the energy function used for hotspot, default to backbone\_stub\_constraint to produce old results. Use "backbone\_stub\_linear\_constraint" will use a different protocol for placesimultaneously. The difference is that rather than choose one type from the stub library randomly, this protocol will choose only the residue type in the stub library, when placed by packer, have the lowest deviation (coordinate constraint energy) from the stub library conformation.
-   coor\_cst\_cutoff is the threshold coordinate constraint energy between the added hotspot residues and the one in the stub library. Use with stubscorefxn=backbone\_stub\_linear\_constraint. PlaceSimultaneously fails if placed residues deviates beyond this threshold.

rb\_stub\_minimization, auction and stub\_score\_filter allow the user to specify the first moves and filtering steps of PlaceSimultaneously before PlaceSimultaneously is called proper. In this way, a configuration can be quickly triaged if it isn't compatible with placement (through Auction's filtering). If the configuration passes these filters and movers then PlaceSimultaneously can be run within loops of docking and placement, until a design is identified that produces reasonable ddg and sasa.


##See Also

* [[AuctionMover]]: Special mover associated with PlaceSimultaneously
* [[RosettaScriptsPlacement]]
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
