# ResidueCount

Documentation last updated on 17 November 2017 by Vikram K. Mulligan (vmullig@uw.edu).

*Back to [[Filters|Filters-RosettaScripts]] page.*
## ResidueCount

Filters structures based on the total number of residues in the structure.

```xml
<ResidueCount name="(&string)" max_residue_count="(Inf &Integer)" min_residue_count="(0 &Integer)" residue_types="('' &string)" count_as_percentage="(0 &Bool)" residue_selector="selector" />
```

-   residue\_types: Comma-separated list of which residue type names. (e.g. "CYS,SER,HIS\_D" ). Only residues with type names matching those in the list will be counted.
-   include\_property:  Comma-separated list of properties (e.g. "HYDROPHOBIC,ALIPHATIC").  Residues with any of these properties will be counted.
-   max\_residue\_count: Is the total number of residues less than or equal to the maximum allowable residue count?
-   min\_residue\_count: Is the total number of residues more than or equal to the minimum allowable residue count?
-   count\_as\_percentage: If this is true, count residues as percentage (=100\*raw_number_of_specified_residue/total_residue) instead of counting raw number of it, also  max_residue_count/min_residue_count are assumed to be entered as percentage
-   residue_selector: Name of a residue selector which defines a subset of residues over which to perform calculation. Default is all residues.
-   task_operations: defines subset of residues over which to perform calculation, default only check designable residues
-   packable: T/F, also count repackable residues in task_operations

This is useful when protocols can make very large structures, e.g. with symmetric or modular assembly protocols that may be too big to handle with available computational resources.

Note that this filter uses _OR_ logic for selection: that is, any residue matching any of the listed types or any of the listed properties will be counted.  A residue matching more than one type or property will only be counted once.  (For example, if "THR" is provided as a type and "POLAR,ALPHA_AA" is provided as a property, each threonine will be counted once, despite matching the type and both of the properties.  Anything matching at least one of these -- beta-3-lysine, for example, since it is polar despite not being an alpha amino acid -- will also be counted.)

## See Also

* [[LoadPDBMover]]
