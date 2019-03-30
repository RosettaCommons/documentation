# MapHotspot
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MapHotspot

Map out the residues that might serve as a hotspot region on a target. This requires massive user guidance. Each hot-spot residue should be roughly placed by the user (at least as backbone) against the target. Each hot-spot residue should have a different chain ID. The method iterates over all allowed residue identities and all allowed rotamers for each residue. Tests its filters and for the subset that pass selects the lowest-energy residue by score12. Once the first hot-spot residue is identified it iterates over the next and so on until all hot-spot residues are placed. The output contains one file per residue identity combination.

[[include:../../xsd/mover_MapHotspot_type]]


```xml
<MapHotspot name="&string" clash_check="(0 &bool)" file_name_prefix="(map_hs &string)">
   <Jumps>
     <Jump jump="(&integer)" explosion="(0 &integer)" filter_name="(true_filter & string)" allowed_aas="('ADEFIKLMNQRSTVWY' &string)" scorefxn_minimize="(score12 &string)" mover_name="(null &string)"/>
     ....
   </Jumps>
</MapHotspot>
```

-   clash\_check: whether the rotamer set is prescreened by the packer for clashes. Advised to be off always.
-   file\_name\_prefix: Prefix for the output file names.
-   explosion: How many chi angles to explode (giving more rotamers.
-   allowed\_aas: 1-letter codes for the allowed residues.
-   scorefxn\_minimize: which scorefxn to use during rb/sc minimization.
-   mover\_name: a mover (no restrictions) to run just before hot-spot residue minimization.


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
