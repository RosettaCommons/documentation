# ExposedHydrophobics
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ExposedHydrophobics

Computes the SASA for each hydrophobic residue (A, F, I, M, L, W, V, Y). The score returned reflects both the number of solvent-exposed hydrophobic residues and the degree to which they are exposed. The score is calculated as follows. For each hydrophobic residue, if the SASA is above a certain cutoff value (default=20), then the value of ( SASA - sasa\_cutoff ) is added to the calculated score. The filter passes if the calculated score is less than the user-specified threshold.

```xml
<ExposedHydrophobics name="(&string)" sasa_cutoff="(20 &Real)" threshold="(-1 &Real)" />
```

-   sasa\_cutoff: If a residue has SASA lower than this value, it is considered buried and does not affect the score returned by the ExposedHydrophobics filter.
-   threshold: If a protein has an ExposedHydrophobics total score below this value, it passes the filter. If a negative threshold is specified, the filter will always pass.

## See also:

* [[CavityVolumeFilter]]
* [[InterfaceHolesFilter]]
* [[ShapeComplementarityFilter]]
* [[SSShapeComplementarityFilter]]

