# SimpleHbondsToAtom
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SimpleHbondsToAtom

This filter checks whether an atom (defined by residues through res\_num/pdb\_num and target_atom_name) has at least n_partners H-bonds, where each H-bond needs to have at most hb_e_cutoff energy. It assumes that there is a single target heavy atom, and H-bonds to polar hydrogens attached to this atom are counted towards H-bonds involving the target atom. This filter is a substitute for HBondsToAtom filter, which doesn't work well with ligands. Before phasing out HBondsToAtom filter its functionalities should be added to this filter.

```xml
<SimpleHbondsToAtomFilter name="(hbonds_filter &string)" n_partners="(&integer)" hb_e_cutoff="(-0.5 &float)"
			  target_atom_name="(&string)" res_num/pdb_num="(&string)" scorefxn="(&string)"/>
```

-   n_partners: how many hbonding partners are expected 
-   target_atom_name: to which atom in the given residue are hydrogens bonds counted?
-   pdb\_num/res\_num: see [[RosettaScripts#rosettascripts-conventions_specifying-residues]]
-   hb_e_cutoff: hydrogen bond energy cutoff, -0.5 is a good default for relaxed/minimized structures.
-   scorefxn: Score function to use.

## See Also

* [[BuriedUnsatHbondsFilter]]
* [[HbondsToResidueFilter]]
