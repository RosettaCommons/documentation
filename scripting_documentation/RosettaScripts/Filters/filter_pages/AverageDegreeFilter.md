# AverageDegree
*Back to [[Filters|Filters-RosettaScripts]] page.*
## AverageDegree

What is the average degree connectivity of a subset of residues? Found to be useful for discriminating non-interacting designs from natural complexes. Apparently, many non-interacting designs use surfaces that are poorly embedded in the designed monomer, a feature that can be easily captured by this simple metric. See Fleishman et al. J. Mol. Biol. 414:289

```xml
<AverageDegree name="(&string)" threshold="(0&Real)" distance_threshold="(&10.0)" task_operations="(comma-delimited list)"/>
```

-   threshold: how many residues need to be on average in the sphere of each of the residues under scrutiny.
-   distance\_threshold: Size of sphere around each residue under scrutiny.
-   task\_operations: define residues under scrutiny (all repackable residues).

## See Also

* [[DockingMover]]
* [[DockingProtocolMover]]
* [[DockWithHotspotMover]]
* [[InterfaceBindingEnergyDensityFilter]]
* [[InterfaceHolesFilter]]
* [[InterfacePackingFilter]]
