# HighResEnsemble
*Back to [[Mover|Movers-RosettaScripts]] page.*
## HighResEnsemble

```xml
<HighResEnsemble name="&string" chains="&string" cycles="(&int)" repack_every_Nth="(&int)" scorefxn="&string" movemap_builder="&&string" final_score="&string" final_move="&string" rosetta="&bool" />
```

HighResEnsemble is the extension of HighResDocker designed for ligand ensemble docking. chains identifies the ligand chains included in the ensemble. It performs cycles of rotamer trials/repacking coupled with small ligand perturbations. The number of cycles are described using cycles and repack_every_Nth. It also takes place of the FinalMinimizer and InterfaceScoreCalculator movers used in single ligand docking. This allows HighResEnsemble to output individual models for each protein-ligand combination. 

scorefxn and final_score identifies the score function used for docking stage and gradient minimization stage respectively. movemap_builder and final_move describes which residues will have sidechain and/or backbone flexibility during each stage. rosetta is an option used for benchmarking purposes and should not be changed from default of false. 

HighResEnsemble requires ligand areas to be defined for each ligand in the ensemble. These ligand areas must be included in the appropriate interface builders and movemap builders. 

Additional details for LIGAND_AREAS, INTERFACE_BUILDERS, and MOVEMAP_BUILDERS used in conjunction with HighResEnsemble can be found in RosettaLigand docking with flexible XML protocols, Gordon Lemmon and Jens Meiler (http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3749076/pdf/nihms499730.pdf).

##See Also

* [[HighResMover]]
* [[DockingMover]]
* [[DockingProtocolMover]]
* [[DockWithHotspotMover]]
* [[FlexPepDockMover]]
* [[Docking applications]]: Command line applications for docking
* [[I want to do x]]: Choosing a mover
