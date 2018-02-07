# PlaceStub
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PlaceStub

Hotspot-based sidechain placement. This is the main workhorse of the hot-spot centric method for protein-binder design. A paper describing the method and a benchmark will be published soon. The "stub" (hot-spot residue) is chosen at random from the provided stub set. To minimize towards the stub (during placement), the user can define a series of movers (StubMinimize tag) that can be combined with a weight. The weight determines the strength of the backbone stub constraints that will influence the mover it is paired with. Finally, a series of user-defined design movers (DesignMovers tag) are made and the result is filtered according to final\_filter.

For complicated systems, there are a few limitations in PlaceStub that you should be aware of:
* PlaceStub seems to assume that the "target" (immobile protein) is located in the first chain and the "scaffold" (protein being docked) is located in the second chain.  Having more than two chains can lead to unexpected results or errors.
* PlaceStub does not seem to play well with certain ligand molecules.  Removing any non-protein residues from your pose may resolve certain errors.
* There has been discussion (circa December 2016) to remove APPLY_TO_POSE from RosettaScripts.

There are two main ways to use PlaceStub:

1.  PlaceStub (default). Move the stub so that it's on top of the current scaffold position, then move forward to try to recover the original stub position.
2.  PlaceScaffold. Move the scaffold so that it's on top of the stub. You'll keep the wonderful hotspot interactions, but suffer from lever effects on the scaffold side. PlaceScaffold can be used as a replacement for docking by deactivating the "triage\_positions" option.

```xml
<PlaceStub name="(&string)" place_scaffold="(0 &bool)" triage_positions="(1 &bool)" chain_to_design="(2 &integer)" score_threshold="(0.0 &Real)" allowed_host_res="(&string)" stubfile="(&string)" minimize_rb="(0 &bool)" after_placement_filter="(true_filter &string)" final_filter="(true_filter &string)" max_cb_dist="(4.0 &Real)" hurry="(1 &bool)" add_constraints="(1 &bool)" stub_energy_threshold="(1.0 &Real)" leave_coord_csts="(0 &bool)" post_placement_sdev="(1.0 &Real)">
     <StubMinimize>
        <Add mover_name="(&string)" bb_cst_weight="(10, &Real)"/>
     </StubMinimize>
     <DesignMovers>
        <Add mover_name="(&string)" use_constraints="(1 &bool)" coord_cst_std="(0.5 &Real)"/>
     </DesignMovers>
     <NotifyMovers>
        <Add mover_name="(&string)"/>
     </NotifyMovers>
</PlaceStub>
```

-   place\_scaffold: use PlaceScaffold instead of PlaceStub. this will place the scaffold on the stub's position by using an inverse rotamer approach.
-   triage\_positions: remove potential scaffold positions based on distance/cst cutoffs. speeds up the search, but must be turned off to use place\_scaffold=1 as a replacement for docking (that is, when placing the scaffold at positions regardless of the input structure). triage\_positions=1 triages placements based on whether the hotspot is close enough (within max\_cb\_distance) and whether the hotspot's vectors align with those of the host position (with some tolerance).
-   chain\_to\_design
-   score\_threshold
-   allowed\_host\_res: A list of residues on the host scaffold where the stub may be placed. The list should be comma-seperated and may contain either rosetta indices (e.g. 123) or pdb indices (e.g. 123A). Note that allowed residues must still pass the triage step (if enabled) and other restrictions on which residues may be designed (e.g. not proline).
-   stubfile: using a stub file other than the one used to make constraints. This is useful for placing stubs one after the other.
-   minimize\_rb: do we want to minimize the rb dof during stub placement? This will allow a previously placed stub to move a a little to accommodate the new stub. It's a good idea to use this with the previously placed stub adding its implied constraints.
-   after\_placement\_filter: The name of a filter to be applied immediately after stub placement and StubMinimize movers, but before the DesignMovers run. Useful for quick sanity check on tstring) score_low=(score4Lhe goodness of the stub.
-   final\_filter: The name of a filter to be applied at the final stage of stub placement as the last test, after DesignMovers run. Useful, e.g., if we want a stub to form an hbond to a particular target residue.
-   max\_cb\_dist: the maximum cb-cb distance between stub and potential host residue to be considered for placement
-   hurry: use a truncated scorefxn for minimization. large speed increases, doesn't seem to be less accurate.
-   add\_constraints: should we apply the coordinate constraints to this stub?
-   stub\_energy\_threshold: Decoys are only considered if the single-residue energy of the stub is below this value
-   leave\_coord\_csts: should the coordinate constraints be left on when placement is completed successfully? This is useful if you plan on making moves after placement and you want the hotspot's placement to be respected. Note that designing a residue that has constraints on it is likely to yield crashes. You can use task operations to disallow that residue from designing.
-   post\_placement\_sdev: relating to the item above. The lower the sdev (towards 0) the more stringent the constraint.

The available tracers are:

-   protocols.ProteinInterfaceDesign.movers.PlaceStubMover - light-io documentation of the run
-   STATS.PlaceStubMover - statistics on distances and score values during placement
-   DEBUG.PlaceStubMover - more io intensive documentation

From-source-generated documentation below:
[[include:../../xsd/mover_PlaceStub_type]]


**Submovers:** Submovers are used to determine what moves are used following stub placement. For example, once a stub has been selected, a StubMinimize mover can try to optimize the current pose towards that stub. A DesignMover can be used to design the pose around that stub. Using DesignMover submovers within PlaceStub (instead of RepackMinimize movers outside PlaceStub) allows one to have a "memory" of which stub has been used. In this way, a DesignMover can fail a filter without causing the trajectory to completely reset. Instead, the outer PlaceStub mover will select another stub, and the trajectory will continue.
 There are two types of sub movers that can be called within the mover.

1.  **StubMinimize**
     Without defining this submover, the protocol will simply perform a rigid body minimization as well as sc minimization of previous placed stubs in order to minimize towards the stub. Otherwise, a series of previously defined movers can be added, such as backrub, that will be applied for the stub minimization step. Before and after the list of stub minimize movers, there will be a rigid body minimization and a sc minimization of previously placed stubs. The bb\_cst\_weight determines how strong the constraints are that are derived from the stubs.
    -   mover\_name: a user previously defined design or minimize mover.
    -   bb\_cst\_weight: determines the strength of the constraints derived from the stubs. This value is a weight on the cb\_force, so larger values are stronger constraints.

    Valid/sensible StubMinimize movers are:
    -   BackrubDD
    -   LoopRemodel

2.  **DesignMovers**
     Design movers are typically used once the stubs are placed to fill up the remaining interface, since placestub does not actually introduce any further design other than stub placement.
    -   mover\_name: a user previously defined design or minimize mover.
    -   use\_constraints: whether we should use coordinate constraints during this design mover
    -   coord\_cst\_std: the std of the coordinate constraint for this mover. The coord constraints are harmonic, and the force constant, k=1/std. The smaller the std, the stronger the constraint

    Valid/sensible DesignMovers are:
    -   RepackMinimize

3.  **NotifyMovers**
    Movers placed in this section will be notified not to repack the PlaceStub-placed residues. This is not necessary if placement movers are used in a nested (recursive) fashion, as the placement movers automatically notify movers nested in them of the hot-spot residues. Essentially, you want to make the downstream movers (you list under this section) aware about the placement decisions in this upstream mover. These movers will not be run at in this placestub, but will be subsequently aware of placed residues for subsequent use. Useful for running design moves after placestub is done, e.g., in loops. Put task awareness only in the deepest placestub mover (if PlaceStub is nested), where the final decisions about which residues harbour hot-spot residues is made.


##See Also

* [[RosettaScriptsPlacement]]
* [[AddSidechainConstraintsToHotspotsMover]]
* [[BestHotspotCstMover]]
* [[DockWithHotspotMover]]
* [[HotspotDisjointedFoldTreeMover]]
* [[MapHotspotMover]]
* [[PlaceSimultaneouslyMover]]
* [[PlaceOnLoopMover]]
* [[PlacementMinimizationMover]]
* [[I want to do x]]: Guide to choosing a mover
