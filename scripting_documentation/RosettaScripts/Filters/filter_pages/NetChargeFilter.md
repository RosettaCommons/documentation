# NetCharge
*Back to [[Filters|Filters-RosettaScripts]] page.*

<i>Note:  This page is about the NetCharge </i>filter<i>.  For information about the `netcharge` score term, see [[this page|NetChargeEnergy]].</i>

## NetCharge

This filter sums up all of the positively and negatively charged amino acids in your structure and reports a simplistic sequence-based net charge.

```xml
<NetCharge name="(&string)" min="(-100 &Integer)" max="(100 &Integer)" chain="(0 &Integer)" task_operations="('' &string)" />
```

-   min: minimum net charge desired (default: -100).
-   max: maximum net charge desired (default: 100).
-   chain: specify which chain you want to calculate the net charge (In the input PDB file, from top to bottom: 1 means first chain, 2 means the second chain, and so forth). Use the value 0 (default) if you want to consider all residues in the input PDB structure.
-   task_operations: all residues that are designable according to the task_operations will be selected for computing the net charge. Residues not set to be designable will not be counted.

This filter assigns basic residues LYS and ARG residues to +1, while acidic residues ASP and GLU are assigned to -1.

To design for a desired net charge rather than filtering after the fact, you can use the [[netcharge score term|NetChargeEnergy]].

## See also:

* [[TotalSasaFilter]]
* [[SasaFilter]]
* [[ResidueBurialFilter]]
* [[ExposedHydrophobicsFilter]]
* [[NetChargeEnergy]]
