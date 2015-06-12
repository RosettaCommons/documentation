# Placement 
## Placement-associated Movers & Filters

The placement method has been described in:

Fleishman, SJ, Whitehead TA, et al. Science 332, 816-821. (2011) and JMB 413:1047

The objective of the placement methods is to help in the task of generating hot-spot based designs of protein binders. The starting point for all of them is a protein target (typically chain A), libraries of hot-spot residues, and a scaffold protein.

A few keywords used throughout the following section have special meaning and are briefly explained here.

-   Hot-spot residue: typically a residue that forms optimized interactions with the target protein. The goal here is to find a low-energy conformation of the scaffold protein that incorporates as many such hot-spot residues as possible.
-   Stub: used interchangeably with hot-spot residue. This is a dismembered residue in a specified location against the target surface.
-   Placement: positioning of the scaffold protein such that it incorporates the hot-spot residue optimally.

Hotspot residue-libraries can be read once by the SetupHotspotConstraintsMover. In this mover you can decide how many hotspot residues will be kept in memory for a given run. This number of residues will be chosen randomly from the residues that were read. In this way, you can read arbitrarily large hotspot residue libraries, but each trajectory will only iterate over a smaller set.

##See Also

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