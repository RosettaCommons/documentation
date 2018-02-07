# DSasa
*Back to [[Filters|Filters-RosettaScripts]] page.*
## DSasa

*(Formerly known as LigDSasa)*

Computes the fractional interface delta\_sasa for a ligand on a ligand-protein interface and checks to see if it is \*between\* the lower and upper threshold. A DSasa of 1 means ligand is totally buried (loses all it's accessible surface area), 0 means totally accessible (loses none upon interface formation).

```xml
<DSasa name="(&string)" lower_threshold="(0.0 &float)" upper_threshold="(1.0 &float)"/>
```

## See also:

* [[Ligand Docking|ligand-dock]]
* [[DiffAtomBurialFilter]]
* [[LigInterfaceEnergyFilter]]
* [[RepackWithoutLigandFilter]]
* [[SasaFilter]]
* [[TotalSasaFilter]]
