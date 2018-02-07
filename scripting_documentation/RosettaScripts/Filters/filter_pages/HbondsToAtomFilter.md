# HbondsToAtom
*Back to [[Filters|Filters-RosettaScripts]] page.*
## HbondsToAtom

This filter checks whether a atom defined by residues through res\_num/pdb\_num and atomname are hbonded with as many hbonds as defined by partners, where each hbond needs to have at most energy\_cutoff energy. For backbone-backone hydrogen bonds, turn flag on (bb\_bb=1).

This filter was written in the context of protein interface design, so it may not work as expected with hydrogen bonds not across a single interface.

```xml
<HbondsToAtom name="(hbonds_filter &string)" partners="(&integer)" energy_cutoff="(-0.5 &float)" backbone="(0 &bool)" bb_bb="(0 &bool)" sidechain="(1 &bool)" atomname="(&string)" res_num/pdb_num="(&string)">
```

-   partners: how many hbonding partners are expected 
-   backbone: should we count backbone-backbone hbonds?
-   sidechain: should we count backbone-sidechain and sidechain-sidechain hbonds?
-   atomname: to which atom in the given residue are hydrogens counted?
-   pdb\_num/res\_num: see [[RosettaScripts#rosettascripts-conventions_specifying-residues]]

## See Also

* [[BuriedUnsatHbondsFilter]]
* [[HbondsToResidueFilter]]
