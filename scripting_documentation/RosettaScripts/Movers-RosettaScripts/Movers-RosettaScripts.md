#Movers (RosettaScripts)

[[Return To RosettaScripts|RosettaScripts]]

Each mover definition has the following structure

```
<"mover_name" name="&string" .../>
```

where "mover\_name" belongs to a predefined set of possible movers that the parser recognizes and are listed below, name is a unique identifier for this mover definition and then any number of parameters that the mover needs to be defined.

* Predefined Movers

Predefined Movers are defined internally in the parser, and the protocol can use them without defining them explicitly.

**NullMover** - Does nothing.

Has an empty apply. Will be used as the default mover in \<PROTOCOLS\> if no mover\_name is specified. Can be explicitly specified, with the name "null".


* [[General Movers | general-movers]]

* [[Special Movers | special-movers]]
* [[Loop Modeling Movers | loop-modeling-movers]]
* These movers are at least somewhat specific to the design of protein-protein interfaces. Attempting to use them with, for example, protein-DNA complexes may result in unexpected behavior.

[[Protein Interface Modeling, Design, and Analysis Movers | protein-interface-design-movers]]
* [[Ligand Centric Movers | ligand-centric-movers]]
* [[DNA Interface Design Movers | dna-interface-design-movers]] 

Currently Undocumented
----------------------
The following Movers are available through RosettaScripts, but are not currently documented. See the code (particularly the respective parse\_my\_tag() and apply() functions) for details. (Some may be undocumented as they are experimental/not fully functional.)

AddEncounterConstraintMover, BackboneSampler, BackrubSidechain, BluePrintBDR, CAcstGenerator, CCDLoopCloser, CartesianSampler, CircularPermutation, CloseFold, CompoundTranslate, ConformerSwitchMover, ConstraintFileCstGenerator, CoordinateCst, DefineMovableLoops, DesignProteinBackboneAroundDNA, DnaInterfaceMinMover, DnaInterfaceMultiStateDesign, DockSetupMover, DockingInitialPerturbation, EnzdesRemodelMover, ExtendedPoseMover, FavorNonNativeResidue, FlxbbDesign, FragmentLoopInserter, GenericSymmetricSampler, GridInitMover, GrowPeptides, HamiltonianExchange, HotspotHasher, Hybridize, InsertZincCoordinationRemarkLines, InterlockAroma, InverseRotamersCstGenerator, InvrotTreeCstGenerator, IterativeLoophashLoopInserter, JumpRotamerSidechain, LigandDesign, LoadVarSolDistSasaCalculatorMover, LoadZnCoordNumHbondCalculatorMover, LoopHash, LoopHashDiversifier, LoopMover\_Perturb\_CCD, LoopMover\_Perturb\_KIC, LoopMover\_Perturb\_QuickCCD, LoopMover\_Perturb\_QuickCCD\_Moves, LoopMover\_Refine\_Backrub, LoopMover\_Refine\_CCD, LoopMover\_Refine\_KIC, LoopMover\_SlidingWindow, LoopRefineInnerCycleContainer, LoopRelaxMover, LoophashLoopInserter, MatchResiduesMover, MatcherMover, MinimizeBackbone, ModifyVariantType, ModulatedMover, MotifDnaPacker, NtoCCstGenerator, PDBReload, ParallelTempering, PerturbChiSidechain, PerturbRotamerSidechain, PlaceSurfaceProbe, RandomConformers, RemodelLoop, RemoveCsts, RepackTrial, ResidueVicinityCstCreator, RigidBodyPerturbNoCenter, RotamerRecoveryMover, Rotates, SaneMinMover, ScoreMover, SeedFoldTree, SeedSetupMover, SeparateDnaFromNonDna, SetAACompositionPotential, SetChiMover, SetSecStructEnergies, SetupForDensityScoring, SetupHotspotConstraints, SetupHotspotConstraintsLoops, ShearMinCCDTrial, SheetCstGenerator, ShoveResidueMover, SimulatedTempering, SmallMinCCDTrial, StapleMover, StoreCombinedStoredTasksMover, SwapSegment, Symmetrizer, TempWeightedMetropolisHastings, ThermodynamicRigidBodyPerturbNoCenter, TrialCounterObserver, load\_unbound\_rot, profile
