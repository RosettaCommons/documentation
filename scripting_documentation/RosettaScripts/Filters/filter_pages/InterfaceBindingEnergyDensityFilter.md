# InterfaceBindingEnergyDensityFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## InterfaceBindingEnergyDensityFilter

Takes two other filters: Ddg and Sasa. Computes Ddg/Sasa and returns the value. Fails if the value is not below some threshold.

```xml
<InterfaceBindingEnergyDensityFilter name="(&string)" sasa_filter="(&string)"  ddG_filter="(&string)" threshold="(-0.015 &float)"/>
```

-   sasa\_filter is the name of a previously defined Sasa filter
-   ddG\_filter is the name of a previously defined Ddg filter
-   threshold sets the fail condition for the filter, this filter fails if Ddg/Sasa is not below the threshold.

See also:

* [[Docking applications|docking-applications]]
* [[DdgFilter]]
* [[SasaFilter]]
