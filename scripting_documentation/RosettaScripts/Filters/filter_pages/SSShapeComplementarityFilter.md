# SSShapeComplementarity
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SSShapeComplementarity (SecondaryStructureShapeComplementarity)

[[include:filter_ssshapecomplementarity_type]]


##### Example

The following example XML will create a SecondaryStructureShapeComplementarity filter which uses the secondary structure definitions in "input.blueprint" and computes the SC of all helices with the rest of the protein.

```xml
<FILTERS>
    <SSShapeComplementarity name="ss_sc" blueprint="input.blueprint" verbose="1" loops="0" helices="1" />
<FILTERS>
<PROTOCOLS>
    <Add filter_name="ss_sc" />
</PROTOCOLS>
```

## See Also:

* [[Protein-protein docking|docking-protocol]]
* [[CavityVolumeFilter]]
* [[InterfaceHolesFilter]]
* [[ShapeComplementarityFilter]]
* [[SpecificResiduesNearInterfaceFilter]]
* [[ResInInterfaceFilter]]
* [[ExposedHydrophobicsFilter]]
