# OligomericAverageDegree
*Back to [[Filters|Filters-RosettaScripts]] page.*
## OligomericAverageDegree

A version of the AverageDegree filter (see [[here|AverageDegreeFilter]]) that is compatible with oligomeric building blocks. Includes other subunits within the same building block in the neighbor count. Also works for monomeric building blocks.

```xml
<OligomericAverageDegree name="(&string)" jump="(1 &Size)" sym_dof_names="('' &string)" threshold="(0 &Size)" distance_threshold="(10.0 &Real)" multicomp="(0 &bool)" write2pdb="(0 &bool)" task_operations="(comma-delimited list of task operations)" />
```

-   jump - Which jump separates the building block from others?
-   sym\_dof\_names - Which sym\_dofs separate the building blocks from the others (must also set multicomp=1 if it is a multicomponent symmetric system)?
-   threshold - How many residues need to be on average in the sphere of each of the residues under scrutiny in order for the filter to return true.
-   distance\_threshold - Size of sphere around each residue under scrutiny.
-   write2pdb - Whether to write the residue-level AverageDegree values to the output .pdb file.
-   multicomp - Set to true if the systems has multiple components.
-   task\_operations - Define residues under scrutiny (all repackable residues).

## See also

* [[AverageDegreeFilter]]
* [[GetRBDOFValuesFilter]]
* [[SymUnsatHbondsFilter]]
* [[ClashCheckFilter]]
* [[InterfacePackingFilter]]
* [[MutationsFilter]]
