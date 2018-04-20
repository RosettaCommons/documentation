# AlaScan
*Back to [[Filters|Filters-RosettaScripts]] page.*
## AlaScan

Substitutes Ala for each interface position separately and measures the difference in ddg compared to the starting structure. The filter always returns true. The output is only placed in the REPORT channel of the tracer output. Repeats causes multiple ddg calculations to be averaged, giving better converged values.

```xml
<AlaScan name="(&string)" scorefxn="(score12 &string)" jump="(1 &Integer)" interface_distance_cutoff="(8.0 &Real)" partner1="(0 &bool)" partner2="(1 &bool)" repeats="(1 &Integer)" repack="(1 &bool)"/>
```

-   scorefxn: scorefxn to use for ddg calculations
-   jump: which jump to use for ddg calculations. If jump=0 the complex is not taken apart and only the dG of the mutation is computed.
-   interface\_distance\_cutoff: how far apart counts as an interface (in angstroms)
-   partner1: report ddGs for everything upstream of the jump
-   partner2: report ddGs for everything downstream of the jump
-   repack: repack in the bound and unbound states before reporting the energy (ddG). When false, don't repack (dG).

## See Also

* [[Docking applications|docking-applications]]
* [[DdgFilter]]
* [[ddGMover]]
* [[DdGScanFilter]]
* [[FilterScanFilter]]
