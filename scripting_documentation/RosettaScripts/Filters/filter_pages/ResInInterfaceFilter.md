# ResInInterface
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ResInInterface

Computes the number of residues in the interface specified by jump\_number.  Returns true if it is above threshold and false otherwise. Useful as a quick and ugly filter after docking for making sure that the partners make contact.

```xml
<ResInInterface name="(riif &string)" residues="(20 &integer)" jump_number="(1 &integer)"/>
```

## See also

* [[Protein-protein docking|docking-protocol]]
* [[CavityVolumeFilter]]
* [[InterfaceHolesFilter]]
* [[ShapeComplementarityFilter]]
* [[ExposedHydrophobicsFilter]]
* [[ResidueDistanceFilter]]
* [[SpecificResiduesNearInterfaceFilter]]
