# TotalSasa
*Back to [[Filters|Filters-RosettaScripts]] page.*
## TotalSasa

Computes the overall sasa of the pose. If it is \*\*higher\*\* than threshold, it passes. However, it also has the option for an upper\_threshold, where it fails if it is above the upper\_threshold.

```xml
<TotalSasa name="(sasa_filter &string)" threshold="(800 &float)" upper_threshold="(1000000000000000 &float)" hydrophobic="(0&bool)" polar="(0&bool)" task_operations="(comma-delimited list of operations &string)" />
```

-   upper\_threshold: maximum size allowed
-   hydrophobic: compute hydrophobic-only SASA?
-   polar: compute polar\_only SASA?
-   task\_operations: Only report the SASA for those residues specified as packable for the given taskoperations. If not specified, compute over all residues.
-   report\_per\_residue\_sasa: Add the per-residue SASA to the tracer output.

hydrophobic/polar are computed by discriminating each atom into polar (acceptor/donor or polar hydrogen) or hydrophobic (all else) and summing the SASA over each category.

## See also

* [[Protein-protein docking|docking-protocol]]
* [[SasaFilter]]
* [[DSasaFilter]]
* [[NetChargeFilter]]
* [[PackStatFilter]]
* [[InterfaceBindingEnergyDensityFilter]]

