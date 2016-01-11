# ResidueCount
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ResidueCount

Filters structures based on the total number of residues in the structure.

```
<ResidueCount name=(&string) max_residue_count=(Inf &Integer) min_residue_count=(0 &Integer) residue_types=("" &string) count_as_percentage=(0 &Bool) />
```

-   residue\_types: Comma-separated list of which residue type names. (e.g. "CYS,SER,HIS\_D" ). Only residues with type names matching those in the list will be counted.
-   max\_residue\_count: Is the total number of residues less than or equal to the maximum allowable residue count?
-   min\_residue\_count: Is the total number of residues more than or equal to the minimum allowable residue count?
-   count\_as\_percentage: If this is true, count residues as percentage (=100\*raw_number_of_specified_residue/total_residue) instead of counting raw number of it, also  max_residue_count/min_residue_count are assumed to be entered as percentage
-   residue_selector: Name of a residue selector which defines a subset of residues over which to perform calculation. Default is all residues.
-   task_operations: defines subset of residues over which to perform calculation, default only check designable residues
-   packable: T/F, also count repackable residues in task_operations

This is useful when protocols can make very large structures, e.g. with symmetric or modular assembly protocols that may be too big to handle with available computational resources.

## See Also

* [[LoadPDBMover]]
