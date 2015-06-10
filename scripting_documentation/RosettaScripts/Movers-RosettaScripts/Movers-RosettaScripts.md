#Movers (RosettaScripts)

[[Return To RosettaScripts|RosettaScripts]]

Each mover definition has the following structure

```
<"mover_name" name="&string" .../>
```

where "mover\_name" belongs to a predefined set of possible movers that the parser recognizes and are listed below, name is a unique identifier for this mover definition and then any number of parameters that the mover needs to be defined.

[[_TOC_]]

## Predefined Movers

Predefined Movers are defined internally in the parser, and the protocol can use them without defining them explicitly.

**[[NullMover]]** - Does nothing.

## Meta Movers

Meta Movers don't do anything to the pose themselves, but cobmine or modify the applicaiton of other movers and filters.

### Combining Movers

**[[ParsedProtocol|ParsedProtocolMover]]** (formerly DockDesign) - Make RosettaScripts subroutines.

**[[MultiplePoseMover]]** - Allows "distribute and collect" from certain submovers.

**[[MultipleOutputWrapper|MultipleOutputWrapperMover]]** - Convert a single output mover to multiple output.

**[[Subroutine|SubroutineMover]]** - Run another XML file as a subroutine.

**[[ContingentAcceptMover]]** - Fail if a submover doesn't improve a filter value.

**[[IfMover]]** - Run different movers based on a filter value.

**[[RandomMover]]** - Randomly choose a mover from a weighted list.

### Looping/Monte Carlo Movers

**[[LoopOver|LoopOverMover]]** - Repeatedly apply a mover.

**[[GenericMonteCarlo|GenericMonteCarloMover]]** - Repeatedly apply a mover in a Monte Carlo fashion.

**[[GenericSimulatedAnnealer|GenericSimulatedAnnealerMover]]** - Repeatedly apply a mover in a Monte Carlo fashion with ramped temperatures.

**[[MonteCarloTest|MonteCarloTestMover]]** - 

**[[MonteCarloRecover|MonteCarloRecoverMover]]** - 

**[[MonteCarloUtil|MonteCarloUtilMover]]** - 

**[[MetropolisHastings|MetropolisHastingsMover]]**

**[[IteratedConvergence|IteratedConvergenceMover]]** - Repeatedly apply a mover until a filter gives stable values. 

**[[RampMover]]** - Repeatedly apply a mover while changing a score term.

### Reporting/Saving

**[[SavePoseMover]]** - Save or retrieve a pose for use in another mover/filter.

**[[ReportToDB|ReportToDBMover]]** - Report structural data to a relational database.

**[[ResetBaseline|ResetBaselineMover]]** - 

**[[TrajectoryReportToDB|TrajectoryReportToDBMover]]** - 

**[[DumpPdb|DumpPdbMover]]** - Save a pose to disk.

**[[PDBTrajectoryRecorder|PDBTrajectoryRecorderMover]]** - 

**[[SilentTrajectoryRecorder|SilentTrajectoryRecorderMover]]** - 

**[[MetricRecorder|MetricRecorderMover]]** - 

**[[AddJobPairData|AddJobPairDataMover]]** - 

**[[WriteLigandMolFile|WriteLigandMolFileMover]]** - 

**[[RenderGridsToKinemage|RenderGridsToKinemageMover]]** - 

**[[PyMolMover]]** - Send a pose to PyMol.

### Setup Movers

**[[SetupPoissonBoltzmannPotential|SetupPoissonBoltzmannPotentialMover]]** - 

## General Movers

These are movers that should be usable in most cases with most systems.

### Packing/Minimization

**[[ForceDisulfides|ForceDisulfidesMover]]** - 

**[[PackRotamersMover]]** - 

**[[PackRotamersMoverPartGreedy|PackRotamersMoverPartGreedyMover]]** - 

**[[MinMover]]** - 

**[[CutOutDomain|CutOutDomainMover]]** - 

**[[TaskAwareMinMover]]** - 

**[[MinPackMover]]** - 

**[[Sidechain|SidechainMover]]** - 

**[[SidechainMC|SidechainMCMover]]** - 

**[[RotamerTrialsMover]]** - 

**[[RotamerTrialsMinMover]]** - 

**[[ConsensusDesignMover]]** - 

### Idealize/Relax

**[[Idealize|IdealizeMover]]** - 

**[[FastRelax|FastRelaxMover]]** - 

**[[FastDesign|FastDesignMover]]** - 

### Docking/Assembly

**[[DockingProtocol|DockingProtocolMover]]** - 

**[[FlexPepDock|FlexPepDockMover]]** - 

### Backbone Design

**[[BridgeChains|BridgeChainsMover]]** - 

### Backbone Movement

**[[SetTorsion|SetTorsionMover]]** - 

**[[Shear|ShearMover]]** - 

**[[Small|SmallMover]]** - 

**[[Backrub|BackrubMover]]** - 

**[[InitializeByBins|InitializeByBinsMover]]** - 

**[[PerturbByBins|PerturbByBinsMover]]** - 

**[[BackboneGridSampler|BackboneGridSamplerMover]]** - 

### Constraints

**[[ClearConstraintsMover]]** - 

**[[ConstraintSetMover]]** - 

**[[ResidueTypeConstraintMover]]** - 

**[[TaskAwareCsts|TaskAwareCstsMover]]** - 

**[[AddConstraintsToCurrentConformationMover]]** - 

**[[AtomCoordinateCstMover]]** - 

**[[FavorSymmetricSequence|FavorSymmetricSequenceMover]]** - 

### Fragment Insertion

**[[SingleFragmentMover]]** - 

### Symmetry

See **[[SymmetryAndRosettaScripts]] for details on using Symmetry with RosettaScripts.

**[[SetupForSymmetry|SetupForSymmetryMover]]** - 

**[[DetectSymmetry|DetectSymmetryMover]]** - 

**[[SymDofMover]]** - 

**[[ExtractAsymmetricUnit|ExtractAsymmetricUnitMover]]** - 

**[[ExtractSubpose|ExtractSubposeMover]]** - 

**[[ExtractAsymmetricPose|ExtractAsymmetricPoseMover]]** - 

**[[SymPackRotamersMover]]** and SymRotamerTrialsMover - 

**[[SymMinMover]]** - 

**[[TaskAwareSymMinMover]]** - 

### Kinematic Closure Movers

**[[Generalized Kinematic Closure (GeneralizedKIC)|GeneralizedKICMover]]** - 

### Parametric Backbone Generation

**[[MakeBundle|MakeBundleMover]]** - 

**[[BundleGridSampler|BundleGridSamplerMover]]** - 

**[[PerturbBundle|PerturbBundleMover]]** - 

### Other Pose Manipulation

**[[MutateResidue|MutateResidueMover]]** - 

**[[AlignChain|AlignChainMover]]** - 

**[[BluePrintBDR|BluePrintBDRMover]]** - 

**[[ModifyVariantType|ModifyVariantTypeMover]]** - 

**[[MotifGraft|MotifGraftMover]]** - 

**[[LoopCreationMover]]** - 

**[[SegmentHybridize|SegmentHybridizeMover]]** - 

**[[Disulfidize|DisulfidizeMover]]** - 

**[[Dssp|DsspMover]]** - 

**[[AddChain|AddChainMover]]** - 

**[[AddChainBreak|AddChainBreakMover]]** - 

**[[FoldTreeFromLoops|FoldTreeFromLoopsMover]]** - 

**[[Superimpose|SuperimposeMover]]** - 

**[[SetSecStructEnergies|SetSecStructEnergiesMover]]** - 

**[[SwitchChainOrder|SwitchChainOrderMover]]** - 

**[[LoadPDB|LoadPDBMover]]** - 

**[[LoopLengthChange|LoopLengthChangeMover]]** - 

**[[MakePolyX|MakePolyXMover]]** - 

**[[MembraneTopology|MembraneTopologyMover]]** - 

**[[Splice|SpliceMover]]** - 

**[[SwitchResidueTypeSetMover]]** - 

**[[FavorNativeResidue|FavorNativeResidueMover]]** - 

**[[FavorSequenceProfile|FavorSequenceProfileMover]]** - 

**[[SetTemperatureFactor|SetTemperatureFactorMover]]** - 

**[[PSSM2Bfactor|PSSM2BfactorMover]]** - 

**[[RigidBodyTransMover]]** - 

**[[RollMover]]** - 

**[[RemodelMover]]** (including building disulfides) - 

**[[SetupNCS|SetupNCSMover]]** - 

**[[StoreTask|StoreTaskMover]]** - 

**[[StoreCompoundTaskMover]]** - 

**[[VirtualRoot|VirtualRootMover]]** - 






~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
