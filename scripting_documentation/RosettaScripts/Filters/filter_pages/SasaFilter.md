# Sasa
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Sasa

Computes the sasa specifically in the interface. If it is \*\*higher\*\* than threshold, it passes. However, it also has the option for an upper\_threshold, where it fails if it is above the upper\_threshold.

```xml
<Sasa name="(sasa_filter &string)" threshold="(800 &float)" upper_threshold="(1000000000000000 &float)" hydrophobic="(0&bool)" polar="(0&bool)" jump="(1 &integer)" sym_dof_names("" &string)/>
```

-   upper\_threshold: maximum size allowed
-   hydrophobic: compute hydrophobic-only SASA?
-   polar: compute polar\_only SASA?
-   jump: across which jump to compute total SASA?
-   sym\_dof\_names: Use sym\_dof\_names controlling the master jumps to determine across which jump(s) to compute total SASA. For use with multi-component symmetries.

hydrophobic/polar are computed by discriminating each atom into polar (acceptor/donor or polar hydrogen) or hydrophobic (all else) and summing the delta SASA over each category. Notice that at this point only total sasa can be computed across jumps other than 1. Trying to compute hydrophobic or polar sasa across any other jump will cause an exit during parsing.

## See also

* [[Protein-protein docking|docking-protocol]]
* [[TotalSasaFilter]]
* [[DSasaFilter]]
* [[NetChargeFilter]]
* [[PackStatFilter]]
* [[InterfaceBindingEnergyDensityFilter]]

