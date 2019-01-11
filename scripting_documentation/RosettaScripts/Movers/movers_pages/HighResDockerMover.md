# HighResDocker
*Back to [[Mover|Movers-RosettaScripts]] page.*
## HighResDocker

```xml
<HighResDocker name="&string" repack_every_Nth="(&int)" scorefxn="string" movemap_builder="&string" />
```

The high res docker performs cycles of rotamer trials or repacking, coupled with small perturbations of the ligand(s). The "movemap\_builder" describes which side-chain and backbone degrees of freedom exist. The Monte Carlo mover is used to decide whether to accept the result of each cycle. Ligand and backbone flexibility as well as which ligands to dock are described by LIGAND\_AREAS provided to INTERFACE\_BUILDERS, which are used to build the movemap according the the XML option.

The paper for HighResDocker (RosettaLigand docking with flexible XML protocols, Gordon Lemmon and Jens Meiler) gives a relatively good explanation on how to use HighResDocker with LIGAND_AREAS, INTERFACE_BUILDERS, and MOVEMAP_BUILDERS. The paper can be found [here](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3749076/pdf/nihms499730.pdf).

##See Also

* [[DockingMover]]
* [[DockingProtocolMover]]
* [[DockWithHotspotMover]]
* [[FlexPepDockMover]]
* [[Docking applications]]: Command line applications for docking
* [[I want to do x]]: Choosing a mover
