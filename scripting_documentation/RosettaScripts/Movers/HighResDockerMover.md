# HighResDocker
## HighResDocker

```
<HighResDocker name="&string" repack_every_Nth=(&int) scorefxn="string" movemap_builder="&string" />
```

The high res docker performs cycles of rotamer trials or repacking, coupled with small perturbations of the ligand(s). The "movemap\_builder" describes which side-chain and backbone degrees of freedom exist. The Monte Carlo mover is used to decide whether to accept the result of each cycle. Ligand and backbone flexibility as well as which ligands to dock are described by LIGAND\_AREAS provided to INTERFACE\_BUILDERS, which are used to build the movemap according the the XML option.


