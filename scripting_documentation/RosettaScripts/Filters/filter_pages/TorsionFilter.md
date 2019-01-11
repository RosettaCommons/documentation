# Torsion
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Torsion

```xml
<Torsion name="(&string)" lower="(0&Real)" upper="(0&Real)" resnum="(0&residue number)" torsion="('' &string)" task_operations="(&comma-delimited list of taskoperations)"/>
```

-   lower: lower cutoff
-   upper: upper cutoff
-   resnum: pdb/rosetta numbering
-   torsion: phi/psi/""
-   task\_operations: The residues to be output can also be defined through a task factory. All residues that are designable according to the taskfactory will be output. resnum and task\_operations are mutually exclusive, so don't set both at the same time.

not setting torsion, will cause the report of both phi and psi. Not specifying resnum will cause a report of all residues. If you want to filter on a given torsion, you have to specify both resnum the torsion and the higher/upper values.

## See also:

* [[AngleToVectorFilter]]
* [[GeometryFilter]]
* [[SecondaryStructureFilter]]
* [[SecondaryStructureHasResidueFilter]]

