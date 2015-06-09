"I want to do _x_. How do I do _x_?"
===========

Typically, users come to an input structure with the notion that they want to perform a particular type of sampling, whether via running an application or using a RosettaScripts mover.
Here, we have categorized Rosetta's RosettaScripts-enabled movers by the type of structural perturbation they perform.


Structure determination via fragment substitution
-------------
-	AbscriptLoopCloserCM  
	handles loop closure in ab initio relax circumstances
-	AbscriptMover


, AddChain, AddChainBreak, AddConstraintsToCurrentConformationMover, AddEncounterConstraintMover, AddFoldUnit, AddHydrogens, AddJobPairData, AddMPLigandMover, , AddOrRemoveMatchCsts, AddSidechainConstraintsToHotspots, AlignChain, AlignEnds, AnchoredGraftMover,  AtomCoordinateCstMover, AtomTree, Auction, BBGaussian, , BackboneSampler, , , , BestHotspotCst, BfactorFitting, BluePrintBDR, , BridgeChains, , CAcstGenerator, , CDRDihedralConstraintMover, CartesianMD, CartesianSampler, ChangeAndResetFoldTreeMover, CircularPermutation, ClearConstraintsMover, CloseFold, CoMTrackerCM, CompoundTranslate, ComputeLigandRDF, ConformerSwitchMover, ConnectJumps, , ConstraintFileCstGenerator, ConstraintPreparer, ConstraintSetMover, ContactMap, ContingentAccept, CoordinateCst, , CreateAngleConstraint, CreateDistanceConstraint, CreateTorsionConstraint, CutOutDomain, DeclareBond, DefineMovableLoops, DeleteChainsMover, DeleteRegionMover, DensityMorphing, , , , , , , , DockSetupMover, DockWithHotspotMover, , DomainAssembly, Dssp, DumpPdb, DumpStatsSS, Environment, EnzRepackMinimize, , ExtendedPoseMover, ExtractAsymmetricPose, ExtractAsymmetricUnit, ExtractSubposeMover, , FavorNativeResidue, FavorNonNativeResidue, FavorSequenceProfile, FavorSymmetricSequence, , FindConsensusSequence, FitBfactors, FitSimpleHelix, , FlipMover, , FoldTreeFromLoops, , FragmentCM, FragmentJumpCM, FragmentLoopInserter, FusePosesNtoCMover, , GenericMonteCarlo, GenericSimulatedAnnealer, ,, GridInitMover, GrowLigand, , HamiltonianExchange, HighResDocker, HotspotDisjointedFoldTree, HotspotHasher, Hybridize, , , InitializeByBins, , InsertZincCoordinationRemarkLines, InsertionSiteTestMover, , InterfaceRecapitulation, InterfaceScoreCalculator, InterlockAroma, InverseRotamersCstGenerator, InvrotTreeCstGenerator, IteratedConvergence, IterativeLoophashLoopInserter, JumpRotamerSidechain, KeepRegionMover, , LigandDesign, LoadDensityMap, LoadVarSolDistSasaCalculatorMover, LoadZnCoordNumHbondCalculatorMover, ,, , MSDMover,  MakeStarTopology, MapHotspot, , MatchResiduesMover, MatcherMover, , MetricRecorder, MetropolisHastings,  , ModifyVariantType, ModulatedMover, MonteCarloRecover, MonteCarloReset, MonteCarloTest, MotifDnaPacker, MotifGraft, MultipleOutputWrapper, MultiplePoseMover, , NcbbDockDesign, NormalModeMinimizer, NtoCCstGenerator, OopCreatorMover, OopDockDesign, OptimizeThreading, PSSM2Bfactor, , , ParallelTempering, ParatopeEpitopeConstraintMover, ParatopeSiteConstraintMover, , , PatchdockTransform, PeptideStubMover, PeriodicBoxMover, , PerturbByBins, , , PlaceOnLoop, PlaceSimultaneously, PlaceStub, PlaceSurfaceProbe, PlacementMinimization, PredesignPerturbMover, , PrepareForCentroid, PrepareForFullatom, ProteinInterfaceMS, , RBIn, RBOut, RampingMover, RandomConformers, RandomMover, , , , , , RemoveCsts, RenderGridsToKinemage, , , RepeatPropagation, ReplaceRegionMover, ReportEffectivePKA, ReportFSC, ReportToDB, ResetBaseline, ResidueTypeConstraintMover, ResidueVicinityCstCreator, RestrictRegion, RigidBodyPerturbNoCenter, , RigidChunkCM, RingConformationMover, RollMover, RotamerRecoveryMover,  Rotate, Rotates, , , , ScaleMapIntensities, SchemePlaceMotifs, ScoreMover, ScriptCM, SeedFoldTree, SeedSetupMover, SegmentHybridizer, SeparateDnaFromNonDna, SetAACompositionPotential, SetCrystWeight, , SetRefinementOptions, SetSecStructEnergies, SetTemperatureFactor, , SetupCoiledCoilFoldTreeMover, SetupForDensityScoring, , SetupHotspotConstraints, SetupHotspotConstraintsLoops, SetupNCS, SetupPoissonBoltzmannPotential, , ShearMinCCDTrial, SheetCstGenerator, , ShoveResidueMover,  SilentTrajectoryRecorder, SimulatedTempering, SingleFragmentMover, SlideTogether, , , SpinMover, Splice, StapleMover, StartFresh, StartFrom, StoreCombinedStoredTasksMover, StoreCompoundTaskMover, StoreTaskMover, StructPerturberCM, Subroutine, Superimpose, SwapSegment, SwitchChainOrder, SwitchResidueTypeSetMover,, SymDofMover, SymFoldandDockMoveRbJumpMover, , SymFoldandDockSlideTrialMover, , , ,  , , TagPoseWithRefinementStats, TaskAwareCsts, , , TempWeightedMetropolisHastings, TopologyBrokerMover, , Transform, , Translate, TrialCounterObserver, TryRotamers, Tumble, UnbiasedRigidBodyPerturbNoCenter, UniformRigidBodyCM, UpdateEnzdesHeader, UpdateSolvent, VLB, VirtualRoot, VisualizeEmbeddingMover, , , , ddG, load_unbound_rot, profile,

Structure generation
-------------
-	BackboneGridSampler
-	BuildSheet
-	BundleGridSampler
-	PerturbBundle
-	PerturbBundleHelix
-	MakeBundle
-	MakeBundleHelix
-	MakePolyX
-	InsertPoseIntoPoseMover  
pose combination
-	build_Ala_pose  
-	SetupForSymmetry  
Necessary before doing anything else symmetrically
<!--
-	AddMembraneMover  
adds a membrane to a structure when needed
-	SymmetricAddMembraneMover
-->
-	GrowPeptides
-	From electron density:
	-	IdealizeHelices
	-	RecomputeDensityMap
	

Structure optimization
-------------
-	IdealizeMover  
Replace every residue with a version with bond lengths and angles from the database.
Add constraints to maintain original hydrogen bonds.
Then, minimize every side-chain and backbone dihedral (except proline phi) using dfpmin.
-	FinalMinimizer  
-	SaneMinMover  
-	TaskAwareMinMover  
-	Symmetrizer  
Functionally an optimization mover; will take a pose with sufficiently small deviations from symmetry and resolve them.
-	TaskAwareSymMinMover  
SymMinMover  
minimize with symmetry
-	LocalRelax  
FastRelax  
Repeatedly repack sidechains and minimize sidechains and backbone while ramping the repulsive weight up and down.
Respects resfiles, movemaps, and task operations.
-	RepackMinimize
Like a single cycle of relax, with a constant repulsive weight.
-	MinPackMover  
-	MinMover  
-	MinimizationRefiner  

Backbone degrees of freedom
-------------
-	Backrub  
BackrubDD  
BackrubSidechain  
ShortBackrubMover  
A particular form of backbone movement intended to coordinate with maintaining particular side chain positions.
-	Small
Make small perturbations to a backbone degree of freedom
-	Shear
Make small perturbations to one dihedral of a residue and contravarying perturbations to the other dihedral, to avoid a "lever arm effect"
-	SetTorsion  
Either set a torsion to a value or perturb a torsion by a value (with the perturb flag)
-	MinimizeBackbone  
Just minimize the backbone
-	RandomOmegaFlipMover
Flip a random omega angle; most useful for peptoids
-	BackboneTorsionPerturbation
-	BackboneTorsionSampler

Sidechain degrees of freedom
-------------
-	SetChiMover
-	SymRotamerTrialsMover
-	PackRotamersMover
-	RotamerTrialsMinMover
-	RotamerTrialsMover
-	RotamerTrialsRefiner
-	Sidechain
-	SidechainMC
-	RepackTrial
-	RepackingRefiner
-	BoltzmannRotamerMover
-	PackRotamersMoverPartGreedy
-	Prepack
-	SymPackRotamersMover  
-	PerturbRotamerSidechain  
-	DnaInterfacePacker
-	PerturbChiSidechain

Any conformational degree of freedom
-------------
-	RandomTorsionMover  
Perturbs a random torsion selected from a movemap

Loop conformational sampling
-------------
-	KicMover
-	LegacyKicSampler
-	SmallMinCCDTrial 
-	LoopBuilder
-	LoopCM
-	LoopCreationMover
-	LoopFinder
-	LoopHash  
	LoopHashDiversifier  
	LoopHashLoopClosureMover  
The LoopHash algorithms constitute a very rapid way to draw on loop conformations from fragment libraries that could achieve a given closure
-	LoopLengthChange
-	LoopModeler
-	LoopMoverFromCommandLine
-	LoopMover_Perturb_CCD
-	LoopMover_Perturb_KIC
-	LoopMover_Perturb_QuickCCD
-	LoopMover_Perturb_QuickCCD_Moves
-	LoopMover_Refine_Backrub
-	LoopMover_Refine_CCD
-	LoopMover_Refine_KIC
-	LoopMover_SlidingWindow
-	LoopProtocol
-	LoopRefineInnerCycleContainer
-	LoopRelaxMover
-	LoopRemodel
-	LoophashLoopInserter
-	LoopmodelWrapper
-	CCDEndsGraftMover
-	CCDLoopCloser
-	CCDLoopClosureMover
-	GeneralizedKIC  
An enormous, intricate system that largely operates on its own to perform kinematic loop closure on an arbitrary sequence of atoms.

Docking
-------------
-	DARC app  
Via a ray casting algorithm particularly fast on GPUs
-	FlexPepDock  
Concurrently samples backbone degrees of freedom on the peptide
-	SymDockProtocol  
Symmetric oligomer docking
-	RigidBodyTransMover  
manually manipulate the relative position of two bodies across a jump
-	Docking
-	DockingInitialPerturbation
-	DockingProtocol
-	DnaInterfaceMinMover 
-	SymFoldandDockRbTrialMover

Chemical connectivity
-------------
-	ForceDisulfides
-	DisulfideInsertion  
-	DisulfideMover  
-	Disulfidize

Design
-------------
-	FastDesign 
-	CoupledMover  
FastRelax mover that does design during repacking
-	RemodelMover  
Extremely diverse function: can do design, repacking, complete backbone remodeling, disulfide construction, and so forth   
-	EnzdesRemodelMover
-	DesignMinimizeHbonds
-	GreedyOptMutationMover
-	ParetoOptMutationMover
-	MutateResidue
-	RandomMutation
-	ConsensusDesignMover
-	AntibodyDesignMover
-	AntibodyDesignProtocol
-	DesignProteinBackboneAroundDNA
-	MatDesGreedyOptMutationMover  
-	FlxbbDesign  
Can be given a blueprint file to extrapolate into a movemap; does design, can do some relaxation; converts your pose to alanine before designing
-	DnaInterfaceMultiStateDesign


Analysis
-------------
-	InterfaceAnalyzerMover


Symmetric interfaces
-------------
-	SymRotamerTrialsMover
-	SymPackRotamersMover  
-	SymDockProtocol  
Symmetric oligomer docking
-	Symmetrizer  
Functionally an optimization mover; will take a pose with sufficiently small deviations from symmetry and resolve them.
-	TaskAwareSymMinMover  
SymMinMover  
minimize with symmetry  
-	DetectSymmetry  
-	GenericSymmetricSampler
<!--
-	MPSymDockMover
-->

<!--
Membrane proteins
-------------
-	MPDockingMover
-	MPDockingSetupMover
-	MPFastRelaxMover
-	MPSymDockMover
-	AddMembraneMover
-	MembranePositionFromTopologyMover
-	MembraneTopology
-	SetMembranePositionMover
-	VisualizeMembraneMover
-	TransformIntoMembraneMover
-->

