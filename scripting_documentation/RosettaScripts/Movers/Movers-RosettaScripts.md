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

**[[MonteCarloTest|MonteCarloTestMover]]** - Tests the Monte Carlo criterion of a mover 

**[[MonteCarloRecover|MonteCarloRecoverMover]]** - Recovers a pose from the generic monte carlo mover

**[[MonteCarloUtil|MonteCarloUtilMover]]** - (developer release only) Recovers the lowest energy pose of a given Monte Carlo object

**[[MetropolisHastings|MetropolisHastingsMover]]** - Performs Metropolis-Hastings Monte Carlo simulations

**[[IteratedConvergence|IteratedConvergenceMover]]** - Repeatedly apply a mover until a filter gives stable values. 

**[[RampMover]]** - Repeatedly apply a mover while changing a score term.

### Reporting/Saving

**[[SavePoseMover]]** - Save or retrieve a pose for use in another mover/filter.

**[[ReportToDB|ReportToDBMover]]** - Report structural data to a relational database.

**[[ResetBaseline|ResetBaselineMover]]** - Reset the baseline (not needed for MC)

**[[TrajectoryReportToDB|TrajectoryReportToDBMover]]** - Reports multiple structures to an output forming a trajectory

**[[DumpPdb|DumpPdbMover]]** - Save a pose to disk.

**[[PDBTrajectoryRecorder|PDBTrajectoryRecorderMover]]** - Records a multimodel PDB file

**[[SilentTrajectoryRecorder|SilentTrajectoryRecorderMover]]** - Records a trajectory in a silent file

**[[MetricRecorder|MetricRecorderMover]]** - Record metrics in a text file

**[[AddJobPairData|AddJobPairDataMover]]** - Add a key:value pair to the current job for inclusion in output

**[[WriteLigandMolFile|WriteLigandMolFileMover]]** - Create a V2000 mol file for each pose

**[[RenderGridsToKinemage|RenderGridsToKinemageMover]]** - (for debugging) Creates a Kinemage file containing scoring grid(s)

**[[PyMolMover]]** - Send a pose to PyMol

### Setup Movers

**[[SetupPoissonBoltzmannPotential|SetupPoissonBoltzmannPotentialMover]]** - Runtime environment initialization for the PB solver (ddG mover)

## General Movers

These are movers that should be usable in most cases with most systems

### Packing/Minimization

**[[ForceDisulfides|ForceDisulfidesMover]]** - Ensures that unrecognized disulfides are formed and bond geometry is correct

**[[PackRotamersMover]]** - Repacks sidechains

**[[PackRotamersMoverPartGreedy|PackRotamersMoverPartGreedyMover]]** - Optimizes around target residues and repacks sidechains

**[[MinMover]]** - Minimizes sidechains and/or backbone

**[[CutOutDomain|CutOutDomainMover]]** - Uses a template to remove specified residues

**[[TaskAwareMinMover]]** - Minimizes sidechains and/or backbone with positions specified by TaskOperations

**[[MinPackMover]]** - Packs and minimizes a side chain, calls Monte Carlo

**[[Sidechain|SidechainMover]]** - "off rotamer" sidechain-only moves

**[[SidechainMC|SidechainMCMover]]** - "off rotamer" sidechain-only Monte Carlo sampling

**[[RotamerTrialsMover]]** - Cycles through residues to find the lowest energy rotamer for each

**[[RotamerTrialsMinMover]]** - Cycles through residues to find each lowest energy rotamer in the context of the current pose

**[[ConsensusDesignMover]]** - Mutates residues to create a consensus of multiple sequences, while considering the scores of the residues

### Idealize/Relax

**[[Idealize|IdealizeMover]]** - Forces ideal bond lengths and angles

**[[FastRelax|FastRelaxMover]]** - Performs FastRelax all-atom refinement

**[[FastDesign|FastDesignMover]]** - Performs FastRelax all-atom refinement, but adds design-related features

### Docking/Assembly

**[[DockingProtocol|DockingProtocolMover]]** - Performs full docking protocol with current defaults

**[[FlexPepDock|FlexPepDockMover]]** - Performs ab initio or refinement peptide docking

### Backbone Design

**[[BridgeChains|BridgeChainsMover]]** - Connects chains using fragment insertion Monte Carlo

### Backbone Movement

**[[SetTorsion|SetTorsionMover]]** - Sets torsion to a specified or random value

**[[Shear|ShearMover]]** - Makes shear-style torsion moves that minimize downstream propagation

**[[Small|SmallMover]]** - Makes small-move-style torsion moves (no propagation minimization)

**[[Backrub|BackrubMover]]** - Makes local rotations around two backbone atoms

**[[InitializeByBins|InitializeByBinsMover]]** - Randomizes stretches of backbone based on torsion bins

**[[PerturbByBins|PerturbByBinsMover]]** - Perturbs stretches of backbone based on torsion bins

**[[BackboneGridSampler|BackboneGridSamplerMover]]** - Generates a residue chain and samples torsion angles


### Constraints

**[[ClearConstraintsMover]]** - Removes constraints from the pose

**[[ConstraintSetMover]]** - Adds constraints to the pose

**[[ResidueTypeConstraintMover]]** - Constrains residue type

**[[TaskAwareCsts|TaskAwareCstsMover]]** - Adds constraints to residues designated by task_operations

**[[AddConstraintsToCurrentConformationMover]]** - Adds constraints based on the current conformation

**[[AtomCoordinateCstMover]]** - Adds coordinate constraints for Relax

**[[FavorSymmetricSequence|FavorSymmetricSequenceMover]]** - Adds constraints to prefer symmetric sequences

### Fragment Insertion

**[[SingleFragmentMover]]** - Performs a single fragment insertion

### Symmetry

See [[SymmetryAndRosettaScripts]] for details on using Symmetry with RosettaScripts.

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

## Computational 'affinity maturation' movers

**[[RandomMutation|RandomMutationMover]]** -

**[[GreedyOptMutationMover]]** -

## Loop Modeling Movers

See [[RosettaScriptsLoopModeling]] for an overview.

**[[LoopModeler|LoopModelerMover]]** - 

**[[LoopBuilder|LoopBuilderMover]]** - 

**[[LoopProtocol|LoopProtocolMover]]** - 

**[[KicMover]]** - 

**[[RepackingRefiner|RepackingRefinerMover]]** - 

**[[RotamerTrialsRefiner|RotamerTrialsRefinerMover]]** - 

**[[MinimizationRefiner|MinimizationRefinerMover]]** - 

**[[PrepareForCentroid|PrepareForCentroidMover]]** - 

**[[PrepareForFullatom|PrepareForFullatomMover]]** - 

## Protein Interface Modeling, Design, and Analysis Movers

These movers are at least somewhat specific to the design of protein-protein interfaces. Attempting to use them with, for example, protein-DNA complexes may result in unexpected behavior.

**[[PatchdockTransform|PatchdockTransformMover]]** -

**[[ProteinInterfaceMS|ProteinInterfaceMSMover]]** -

**[[InterfaceAnalyzerMover]]** -

**[[Docking|DockingMover]]** -

**[[DockWithHotspotMover]]** -

**[[Prepack|PrepackMover]]** -

**[[RepackMinimize|RepackMinimizeMover]]** -

**[[DesignMinimizeHBonds|DesignMinimizeHBondsMover]]** -

**[[build_Ala_pose|BuildAlaPoseMover]]** -

**[[SaveAndRetrieveSidechains|SaveAndRetrieveSidechainsMover]]** -

**[[AtomTree|AtomTreeMover]]** -

**[[SpinMover]]** -

**[[TryRotamers|TryRotamersMover]]** -

**[[BackrubDD|BackrubDDMover]]** -

**[[BestHotspotCst|BestHotspotCstMover]]** -

**[[DomainAssembly|DomainAssemblyMover]]** (Not tested thoroughly) -

**[[LoopFinder|LoopFinderMover]]** -

**[[LoopRemodel|LoopRemodelMover]]** -

**[[LoopMoverFromCommandLine|LoopMoverFromCommandLineMover]]** -

**[[DisulfideMover]]** -

**[[InterfaceRecapitulation|InterfaceRecapitulationMover]]** -

**[[VLB|VLBMover]]** (aka Variable Length Build) -

**[[HotspotDisjointedFoldTree|HotspotDisjointedFoldTreeMover]]** -

**[[AddSidechainConstraintsToHotspots|AddSidechainConstraintsToHotspotsMover]]** -


### Placement and Placement-associated Movers & Filters

See [[RosettaScriptsPlacement]] for more information.

**[[Auction|AuctionMover]]** -

**[[MapHotspot|MapHotspotMover]]** -

**[[PlacementMinimization|PlacementMinimizationMover]]** -

**[[PlaceOnLoop|PlaceOnLoopMover]]** -

**[[PlaceStub|PlaceStubMover]]** -

**[[PlaceSimultaneously|PlaceSimultaneouslyMover]]** -

**[[RestrictRegion|RestrictRegionMover]]** -

**[[StubScore|StubScoreFilter]]** -

**[[ddG|ddGMover]]** -

**[[ContactMap|ContactMapMover]]** -

## Ligand-centric Movers

### Ligand docking

These movers replace the executable for ligand docking and provide greater flexibility to the user in customizing the docking protocol. An example XML file for ligand docking can be found in the demos directory under Rosetta/demos/protocol_capture/2015/rosettaligand_transform/. The movers below are listed in the order they generally occur in a ligand docking protocol.

**[[StartFrom|StartFromMover]]** -

**[[Transform|TransformMover]]** -

**[[Translate|TranslateMover]]** -

**[[Rotate|RotateMover]]** -

**[[SlideTogether|SlideTogetherMover]]** -

**[[HighResDocker|HighResDockerMover]]** -

**[[FinalMinimizer|FinalMinimizerMover]]** -

**[[InterfaceScoreCalculator|InterfaceScoreCalculatorMover]]** -

**[[ComputeLigandRDF|ComputeLigandRDFMover]]** -

### Enzyme Design

**[[EnzRepackMinimize|EnzRepackMinimizeMover]]** -

**[[AddOrRemoveMatchCsts|AddOrRemoveMatchCstsMover]]** -

**[[PredesignPerturbMover]]** -

### Ligand design

**[[GrowLigand|GrowLigandMover]]** -

**[[AddHydrogens|AddHydrogensMover]]** -

## DNA Interface Design Movers

**[[DnaInterfacePacker|DnaInterfacePackerMover]]** -

