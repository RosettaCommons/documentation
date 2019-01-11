# LoopFinder
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoopFinder

Finds loops in the current pose and loads them into the DataMap for use by subsequent movers (eg - LoopRemodel)

    <LoopFinder name="&string" interface="(1 &Size)" ch1="(0 &bool)" ch2="(1 &bool)" min_length="(3 &Integer)"
     max_length="(1000 &Integer)" iface_cutoff="(8.0 &Real)" resnum/pdb_num="(&string)" 
    CA_CA_distance="(15.0 &Real)" mingap="(1 &Size)"/>

-   interface: only keep loops at the interface? value = jump number to use (0 = keep all loops)
-   ch1: keep loops on partner 1
-   ch2: keep loops on partner 2
-   resnum/pdb\_num: if specified, loop finder only takes the loops that are within the defined CA\_CA\_distance. If this option is occluded, it extracts loops given by chain1, chain2 and interface options.So occlude if you don't know the residue.
-   CA\_CA\_distance: cutoff for CA distances between defined residue and any interface loop residue
-   iface\_cutoff: distance cutoff for interface
-   min\_length: minimum loop length (inclusive)
-   max\_length: maximum loop length (inclusive)
-   mingap: minimum gap size between loops (exclusive, so mingap=1 -\> single-residue gaps are disallowed). Setting this to 0 will almost certainly cause problems!
-   pdb\_num/res\_num: see the main [[RosettaScripts Documentation|RosettaScripts#rosettascripts-conventions_specifying-residues]] for more.


##See Also

##See Also

* [[RosettaScriptsLoopModeling]]
* [[Loopmodel application|loopmodel]]
* [[Loop file format|loops-file]]
* [[LoopBuilderMover]]
* [[LoopCreationMover]]
* [[LoopFinderMover]]
* [[LoopLengthChangeMover]]
* [[LoopModelerMover]]
* [[LoopMoverFromCommandLineMover]]
* [[LoopProtocolMover]]
* [[LoopRemodelMover]]
