# BuriedUnsatHbonds
*Back to [[Filters|Filters-RosettaScripts]] page.*
## BuriedUnsatHbonds

Maximum number of buried unsatisfied H-bonds allowed. If a jump number is specified (default=1), then this number is calculated across the interface of that jump. If jump\_number=0, then the filter is calculated for a monomer. Note that \#unsat for monomers is often much higher than 20. Notice that water is not assumed in these calculations. By specifying task\_operations you can decide which residues will be used to compute the statistic. ONly residues that are defined as repackable (or designable) will be used for computing. Others will be ignored. A tricky aspect is that backbone unsatisfied hbonds will also only be counted for residues that are mentioned in the task\_operations, so this is somewhat inconsistent.

```
<BuriedUnsatHbonds name="(&string)" scorefxn="(&string)" jump_number="(1 &Size)" cutoff="(20 &Size)" task_operations="(&string)"/>
```

# See Also:

* [[HbondsToResidueFilter]]
* [[HbondsToAtomFilter]]
