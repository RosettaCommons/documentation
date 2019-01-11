# EnergyPerResidue
*Back to [[Filters|Filters-RosettaScripts]] page.*
## EnergyPerResidue

Tests the energy of a particular residue (e.g. pdb\_num=1), or interface (whole\_interface=1), or whole protein (whole\_protein=1), or a set of residues (e.g. resnums=1,2,3). If whole\_interface is set to 1, it computes all the energies for the interface residues defined by the jump\_number and the interface\_distance\_cutoff. Helpful for post-design analyses. bb\_bb needs to be turn to 1, if one wants to evaluate backbone - backbone hydrogen bonding energies (short and long range). Set whole\_protein=1 to scan the whole protein, or provide resnums to scan a list of residues

```xml
<EnergyPerResidue name="(energy_per_res_filter &string)" scorefxn="(score12 &string)" 
score_type="(total_score &string)" pdb_num/res_num="(&string)" energy_cutoff="(0.0 &float)"
whole_interface="(0 &bool)" jump_number="(1 &int)" interface_distance_cutoff="(8.0 &float)" bb_bb="(0, bool)" resn resns="('1' &string)" whole_protein="(0 andint)" resnums="(andstring)/>"
```

-   pdb\_num/res\_num: see [[RosettaScripts#rosettascripts-conventions_specifying-residues]]
-   resnums, a list of residue numbers (1,2,3 for pose numbering or 1A,2A,3A for pdb numbering) to filter through

## See also

* [[HbondsToResidueFilter]]
* [[ResidueBurialFilter]]
* [[ResidueDistanceFilter]]
* [[ResidueIEFilter]]
