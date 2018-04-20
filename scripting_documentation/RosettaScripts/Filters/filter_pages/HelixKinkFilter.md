# HelixKink
*Back to [[Filters|Filters-RosettaScripts]] page.*
## HelixKink

```xml
<HelixKink name="(&string)" bend="(20, &Real)" resnums="(&string)" helix_start="(1 &int)"  helix_end="(1 &int)"/>
```

-   bend: cutoff for bend angle
-   resnums: comma separated residues to be evaluated. Any helix contains any residues in this list will be considered, default without specifying will scan whole proteins
-   helix\_start and helix\_end specify a range that needs to be one continuous helix to be evaluated. Default is 1, but you should set a sensible value when you specify.

## See also

* [[AbInitio Modeling|abinitio-relax]]
* [[Loop Modeling|loopmodel]]
* [[HelixPairingFilter]]
* [[SecondaryStructureFilter]]
* [[SecondaryStructureCountFilter]]
* [[SecondaryStructureHasResidueFilter]]
