# CavityVolume
*Back to [[Filters|Filters-RosettaScripts]] page.*
## CavityVolume

Uses Will Sheffler's packing code to estimate the total volume of intra-protein voids. The value returned is the sum of volumes of the computed cavities in Angstroms <sup>3</sup>. A value of 20 is approximately equal to the volume of a carbon atom. This filter currently has no options or threshold, and currently always returns true, but that is likely to change in the future.

```
<CavityVolume name=(&string) />
```

**Example**

```
<FILTERS>
    <CavityVolume name="cav_vol" />
</FILTERS>
<PROTOCOLS>
    <Add filter_name="cav_vol" />
</PROTOCOLS>
```

## See Also:

* [[Protein-protein docking|docking-protocol]]
* [[InterfaceHolesFilter]]
* [[ShapeComplementarityFilter]]
* [[SSShapeComplementarityFilter]]
* [[ResInInterfaceFilter]]
* [[SpecificResiduesNearInterfaceFilter]]
* [[ExposedHydrophobicsFilter]]
