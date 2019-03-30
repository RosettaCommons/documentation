# LigInterfaceEnergy
*Back to [[Filters|Filters-RosettaScripts]] page.*
## LigInterfaceEnergy

Calculates interface energy across a ligand-protein interface taking into account (or not) enzdes style cst\_energy.

```xml
<LigInterfaceEnergy name="(&string)"  scorefxn="(&string)" include_cstE="(0 &bool)" jump_number="(last_jump &integer)" energy_cutoff="(0.0 &float)"/>
```

include\_cstE=1 will \*not\* subtract out the cst energy from interface energy. jump\_number defaults to last jump in the pose (assumed to be associated with ligand). energy should be less than energy\_cutoff to pass.

## See also:

* [[Ligand Docking|ligand-dock]]
* [[DSasaFilter]]
* [[RepackWithoutLigandFilter]]
