# CavityVolume
*Back to [[Filters|Filters-RosettaScripts]] page.*
## CavityVolume

Uses Will Sheffler's packing code (packstat) to estimate the total volume of intra-protein voids. 

The value returned is the sum of volumes of the computed cavities in Angstroms <sup>3</sup>. A value of 20 is approximately equal to the volume of a carbon atom. This filter currently has no options or threshold, and currently always returns true, but that is likely to change in the future.

This calculation of cavity volume is inherently stochastic (packstat is stochastic). 
Therefore, setting the temperature to be permissive for the variation in results with the same input 
or 
using the average value of many decoys (nstruct) is recommended.

The filter should not count cavities that are exposed to solvent.


```xml
<CavityVolume name="(&string)" />
```

**Example**

```xml
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
