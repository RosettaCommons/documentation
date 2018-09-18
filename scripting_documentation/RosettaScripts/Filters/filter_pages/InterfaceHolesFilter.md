# InterfaceHoles
*Back to [[Filters|Filters-RosettaScripts]] page.*
## InterfaceHoles

Looks for voids at protein/protein interfaces using Will Sheffler's packstat. The number reported is the difference in the holes score between bound/unbound conformations. Be sure to set the -holes:dalphaball option (and to compile the corresponding executable in source/external/DAlpahBall)!

```xml
<InterfaceHoles name="(&string)" jump="(1 &integer)" threshold="(200 &integer)"/>
```

-   jump: Which jump to calculate InterfaceHoles across?
-   threshold: return false if above this number

## See Also:

* [[InterfacePackingFilter]]
* [[Protein-protein docking|docking-protocol]]
* [[CavityVolumeFilter]]
* [[ShapeComplementarityFilter]]
* [[SSShapeComplementarityFilter]]
* [[ResInInterfaceFilter]]
* [[SpecificResiduesNearInterfaceFilter]]
* [[ExposedHydrophobicsFilter]]
