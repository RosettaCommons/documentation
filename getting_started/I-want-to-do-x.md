#I want to sample X

Ususally, users come to Rosetta with an idea of the [[biological problem they want to solve|Solving-a-Biological-Problem]]. Sometimes, users come with an input structure and the notion that they want to perform a particular type of sampling, whether via running an application or using a RosettaScripts mover.
Here, we have categorized Rosetta's RosettaScripts-enabled movers by the type of structural perturbation they perform, but the [[biological problems|Solving-a-Biological-Problem]] page will better serve you for application use.
If neither page helps, perhaps you haven't determined [[what the problem is|Determining-what-a-problem-is]]?

[[_TOC_]]

<!--
AddChain, AddChainBreak, AddConstraintsToCurrentConformationMover
AddEncounterConstraintMover, AddFoldUnit, AddMPLigandMover, AddOrRemoveMatchCsts
AddSidechainConstraintsToHotspots, AlignChain, AlignEnds, ,  AtomCoordinateCstMover, AtomTree, Auction, , , , BestHotspotCst, BfactorFitting, BluePrintBDR, BridgeChains, , CAcstGenerator, CDRDihedralConstraintMover, ChangeAndResetFoldTreeMover, CircularPermutation, ClearConstraintsMover, CloseFold, CoMTrackerCM, CompoundTranslate, ConformerSwitchMover, ConnectJumps
ConstraintFileCstGenerator, ConstraintPreparer, ConstraintSetMover, ContactMap, ContingentAccept, CoordinateCst, CreateAngleConstraint, CreateDistanceConstraint, CreateTorsionConstraint, CutOutDomain, DeclareBond, DeleteChainsMover, DeleteRegionMover, DensityMorphing, DomainAssembly, Dssp, DumpPdb, DumpStatsSS, Environment, , ExtendedPoseMover, ExtractAsymmetricPose, ExtractAsymmetricUnit, ExtractSubposeMover
FitBfactors, , FlipMover, FoldTreeFromLoops, FragmentCM, FragmentJumpCM, FragmentLoopInserter, FusePosesNtoCMover, GenericMonteCarlo, 
, GridInitMover, GrowLigand
HotspotDisjointedFoldTree, HotspotHasher
 Hybridize, InitializeByBins, InsertZincCoordinationRemarkLines, InsertionSiteTestMover, InterfaceRecapitulation, , InterlockAroma, InverseRotamersCstGenerator, InvrotTreeCstGenerator, IterativeLoophashLoopInserter, JumpRotamerSidechain, KeepRegionMover, LoadDensityMap, , MSDMover,  MakeStarTopology, MapHotspot, MatchResiduesMover, MatcherMover, 
, MetropolisHastings, ModifyVariantType, ModulatedMover, MonteCarloRecover, MonteCarloReset, MonteCarloTest, MotifDnaPacker, MotifGraft, MultipleOutputWrapper, MultiplePoseMover, , NtoCCstGenerator, , OptimizeThreading, PSSM2Bfactor, , ParatopeEpitopeConstraintMover, ParatopeSiteConstraintMover, PatchdockTransform, PeptideStubMover, PeriodicBoxMover, PerturbByBins, PlaceOnLoop, PlaceSimultaneously, PlaceStub, PlaceSurfaceProbe, PlacementMinimization, , ProteinInterfaceMS, , RBIn, RBOut, RampingMover, RandomConformers, RandomMover, RemoveCsts, 
RenderGridsToKinemage, RepeatPropagation, ReplaceRegionMover, ReportEffectivePKA, ReportFSC, ReportToDB, ResetBaseline, ResidueTypeConstraintMover, ResidueVicinityCstCreator, RestrictRegion, RigidChunkCM, RingConformationMover, RollMover, RotamerRecoveryMover,  Rotate, Rotates, ScaleMapIntensities, SchemePlaceMotifs, ScoreMover, ScriptCM, SeedFoldTree, SeedSetupMover, SegmentHybridizer, SeparateDnaFromNonDna, , SetCrystWeight, SetRefinementOptions, SetSecStructEnergies, SetTemperatureFactor, SetupCoiledCoilFoldTreeMover, SetupForDensityScoring, SetupHotspotConstraints, 
SetupHotspotConstraintsLoops, SetupNCS, SetupPoissonBoltzmannPotential, , , SheetCstGenerator, ShoveResidueMover,  SilentTrajectoryRecorder, SimulatedTempering, SingleFragmentMover, SlideTogether, SpinMover, Splice, StapleMover, StartFresh, StartFrom, StoreCombinedStoredTasksMover, StoreCompoundTaskMover, StoreTaskMover, StructPerturberCM, Subroutine, Superimpose, SwapSegment, SwitchChainOrder, SwitchResidueTypeSetMover,, 
SymDofMover, , TagPoseWithRefinementStats, TaskAwareCsts, TempWeightedMetropolisHastings, TopologyBrokerMover, Transform, Translate, TrialCounterObserver, TryRotamers, Tumble, , ,, UpdateSolvent, VLB, VirtualRoot, VisualizeEmbeddingMover, ddG, load_unbound_rot, profile,
-->

Structure determination via fragment substitution
-------------
-	AbscriptLoopCloserCM  
	handles loop closure in ab initio relax circumstances
-	AbscriptMover

<!--
Structure generation
-------------
-	[[BackboneGridSampler|BackboneGridSamplerMover]]
-	BuildSheet
-	[[BundleGridSampler|BundleGridSamplerMover]]
-	[[PerturbBundle|PerturbBundleMover]]
-	PerturbBundleHelix
-	[[MakeBundle|MakeBundleMover]]
-	MakeBundleHelix
-	[[MakePolyX|MakePolyXMover]]
-	BackboneSampler
-	FitSimpleHelix
-	InsertPoseIntoPoseMover  
pose combination
-	[[build_Ala_pose|BuildAlaPoseMover]]
-	[[SetupForSymmetry|SetupForSymmetryMover]]  
Necessary before doing anything else symmetrically
-	[[AddHydrogens|AddHydrogensMover]]  
adds and optimizes missing hydrogens  
-	AddMembraneMover  
adds a membrane to a structure when needed
-	SymmetricAddMembraneMover  
-	GrowPeptides
-	From electron density:
	-	IdealizeHelices
	-	RecomputeDensityMap
	-	CartesianSampler
-->
Structure generation
-------------
-   [[BackboneGridSampler|BackboneGridSamplerMover]]
-   BuildSheet
-   [[BundleGridSampler|BundleGridSamplerMover]]
-   [[PerturbBundle|PerturbBundleMover]]
-   PerturbBundleHelix
-   [[MakeBundle|MakeBundleMover]]
-   MakeBundleHelix
-   [[MakePolyX|MakePolyXMover]]
-   BackboneSampler
-   FitSimpleHelix
-   InsertPoseIntoPoseMover
pose combination
-   [[build_Ala_pose|BuildAlaPoseMover]]
-   [[SetupForSymmetry|SetupForSymmetryMover]]
Necessary before doing anything else symmetrically
-   [[AddHydrogens|AddHydrogensMover]]
adds and optimizes missing hydrogens
-   SymmetricAddMembraneMover
-   GrowPeptides
-   From electron density:
    -   IdealizeHelices
	-   RecomputeDensityMap
	-   CartesianSampler

Residue Insertion and Deletion
------------------------------
-   [[AddChain|AddChainMover]]
-   [[AnchoredGraftMover]]
-   [[CCDEndsGraftMover]]
-   [[CutOutDomain|CutOutDomainMover]]
-   [[DeleteRegionMover]]
-   [[InsertPoseIntoPoseMover]]
-   [[KeepRegionMover]]
-   [[MotifGraft|MotifGraftMover]]
-   [[ReplaceRegionMover]]
-   [[Splice|SpliceMover]]
-   [[SwitchChainOrder|SwitchChainOrderMover]]


Structure optimization
-------------
-	[[IdealizeMover]]  
Replace every residue with a version with bond lengths and angles from the database.
Add constraints to maintain original hydrogen bonds.
Then, minimize every side-chain and backbone dihedral (except proline phi) using dfpmin.
-	[[FinalMinimizer|FinalMinimizerMover]]  
-	SaneMinMover  
-	[[TaskAwareMinMover]]  
-	Symmetrizer  
Functionally an optimization mover; will take a pose with sufficiently small deviations from symmetry and resolve them.
-	[[TaskAwareSymMinMover]]  
[[SymMinMover]]  
minimize with symmetry
-	LocalRelax  
[[FastRelax|FastRelaxMover]]  
Repeatedly repack sidechains and minimize sidechains and backbone while ramping the repulsive weight up and down.
Respects resfiles, movemaps, and task operations.
-	[[RepackMinimize|RepackMinimizeMover]]
Like a single cycle of relax, with a constant repulsive weight.
-	[[MinPackMover]]  
-	[[EnzRepackMinimize|EnzRepackMinimizeMover]]  
-	[[MinMover]]  
-	[[MinimizationRefiner|MinimizationRefinerMover]]
-	NormalModeMinimizer

Ensemble generation
-------------
-	[[FastRelax|FastRelaxMover]]
-	[[Backrub|BackrubMover]]
-	[[ParallelTempering|Tempering-MetropolisHastings#ParallelTempering]]
-	CanonicalSampling
-	BBGaussian
-   [[GenericSimulatedAnnealer|GenericSimulatedAnnealerMover]]
-	[[GeneralizedKIC]] 

Backbone degrees of freedom
-------------
-	[[Backrub|BackrubMover]]  
[[BackrubDD|BackrubDDMover]]  
BackrubSidechain  
ShortBackrubMover  
A particular form of backbone movement intended to coordinate with maintaining particular side chain positions.
-	[[Small|SmallMover]]
Make small perturbations to a backbone degree of freedom
-	[[Shear|ShearMover]]
Make small perturbations to one dihedral of a residue and contravarying perturbations to the other dihedral, to avoid a "lever arm effect"
-	[[SetTorsion|SetTorsionMover]]  
Either set a torsion to a value or perturb a torsion by a value (with the perturb flag)
-	MinimizeBackbone  
Just minimize the backbone
-	RandomOmegaFlipMover
Flip a random omega angle; most useful for peptoids
-	BackboneTorsionPerturbation
-	BackboneTorsionSampler
-	BBGaussian

Sidechain degrees of freedom
-------------
-	SetChiMover
-	[[SymRotamerTrialsMover|SymPackRotamersMover]]
-	[[PackRotamersMover]]
-	[[RotamerTrialsMinMover]]
-	[[RotamerTrialsMover]]
-	[[RotamerTrialsRefiner|RotamerTrialsRefinerMover]]
-	[[Sidechain|SidechainMover]]
-	[[SidechainMC|SidechainMCMover]]
-	RepackTrial
-	[[RepackingRefiner|RepackingRefinerMover]]
-	BoltzmannRotamerMover
-	[[PackRotamersMoverPartGreedyMover]]
-	[[Prepack|PrepackMover]]
-	[[SymPackRotamersMover]] 
-	PerturbRotamerSidechain  
-	[[DnaInterfacePacker|DnaInterfacePackerMover]]
-	PerturbChiSidechain

Any conformational degree of freedom
-------------
-	RandomTorsionMover  
Perturbs a random torsion selected from a movemap

Loop conformational sampling
-------------
-	AnchoredGraftMover  
	a composite mover that does a lot of loop modeling followed by repacking to graft in residues
-	[[KicMover]]
-	LegacyKicSampler
-	SmallMinCCDTrial 
-	ShearMinCCDTrial
-	[[LoopBuilder|LoopBuilderMover]]
-	LoopCM
-	[[LoopCreationMover]]
-	[[LoopFinder|LoopFinderMover]]
-	LoopHash  
	LoopHashDiversifier  
	LoopHashLoopClosureMover  
The LoopHash algorithms constitute a very rapid way to draw on loop conformations from fragment libraries that could achieve a given closure
-	[[LoopLengthChange|LoopLengthChangeMover]]
-	[[LoopModeler|LoopModelerMover]]
-	[[LoopMoverFromCommandLine|LoopMoverFromCommandLineMover]]
-	LoopMover_Perturb_CCD
-	LoopMover_Perturb_KIC
-	LoopMover_Perturb_QuickCCD
-	LoopMover_Perturb_QuickCCD_Moves
-	LoopMover_Refine_Backrub
-	LoopMover_Refine_CCD
-	LoopMover_Refine_KIC
-	LoopMover_SlidingWindow
-	[[LoopProtocol|LoopProtocolMover]]
-	LoopRefineInnerCycleContainer
-	LoopRelaxMover
-	[[LoopRemodel|LoopRemodelMover]]
-	[[LoophashLoopInserter|LoopCreationMover]]
-	LoopmodelWrapper
-	CCDEndsGraftMover
-	CCDLoopCloser
-	CCDLoopClosureMover
-	DefineMovableLoops
-	[[GeneralizedKIC]]  
An enormous, intricate system that largely operates on its own to perform kinematic loop closure on an arbitrary sequence of atoms.

Docking
-------------
-	[[DARC]] app  
Via a ray casting algorithm particularly fast on GPUs
-	[[FlexPepDock|FlexPepDockMover]]  
Concurrently samples backbone degrees of freedom on the peptide
-	SymDockProtocol  
Symmetric oligomer docking
-	[[RigidBodyTransMover]]  
manually manipulate the relative position of two bodies across a jump
-	RigidBodyPerturbNoCenter
-	UnbiasedRigidBodyPerturbNoCenter
-	UniformRigidBodyCM
-	Docking
-	DockingInitialPerturbation
-	[[DockingProtocol|DockingProtocolMover]]
-	DnaInterfaceMinMover 
-	SymFoldandDockRbTrialMover
-	[[HighResDocker|HighResDockerMover]]
-	DockSetupMover
-	[[DockWithHotspotMover]]

Chemical connectivity
-------------
-	[[ForceDisulfides|ForceDisulfidesMover]]  
Given a list of residue pairs (for example, disulfides), repack residue shells around them but do not change the CYS-type residues themselves.  
-	DisulfideInsertion  
Mutates two residue positions to CYS:disulfide, link them conformationally, and add constraints to have good disulfide distance, angle, and dihedral to the pose.
Intended for adding a disulfide to short potentially macrocyclic peptides.
-	[[DisulfideMover]]  
Given two residue positions, mutate both to CYS:disulfide and link them conformationally; do no repacking or minimization
-	[[Disulfidize|DisulfidizeMover]]  
Tries every possible pair of residues in a pose to try to introduce one or more new disulfides as long as they score well

Design
-------------
-	[[FastDesign|FastDesignMover]] 
-       [[Controlling amino acid composition during design|AACompositionEnergy]]
-	CoupledMover  
FastRelax mover that does design during repacking
-	[[RemodelMover]]  
Extremely diverse function: can do design, repacking, complete backbone remodeling, disulfide construction, and so forth   
-	enzyme design
	-	EnzdesRemodelMover
	-	[[PredesignPerturbMover]]
-	[[DesignMinimizeHbondsMover]]
-	[[GreedyOptMutationMover]]
-	ParetoOptMutationMover
-	[[MutateResidue|MutateResidueMover]]
-	[[RandomMutation|RandomMutationMover]]
-	[[ConsensusDesignMover]]
-	AntibodyDesignMover
-	AntibodyDesignProtocol
-	DesignProteinBackboneAroundDNA
-	MatDesGreedyOptMutationMover  
-	FlxbbDesign  
Can be given a blueprint file to extrapolate into a movemap; does design, can do some relaxation; converts your pose to alanine before designing
-	DnaInterfaceMultiStateDesign
-	NcbbDockDesign  
docking and design of noncanonical backbones (peptidomimetics)
-	LigandDesign
-	Not design movers per se, but they bias the amino acid composition for a sequence and thus can contribute to a design protocol.
	-	SetAACompositionPotential 
	-	[[FavorNativeResidue|FavorNativeResidueMover]]
	-	FavorNonNativeResidue
	-	[[FavorSequenceProfile|FavorSequenceProfileMover]]
	-	[[FavorSymmetricSequence|FavorSymmetricSequenceMover]]
	-	FindConsensusSequence

Analysis
-------------
-	[[InterfaceAnalyzerMover]]
-	[[ComputeLigandRDF|ComputeLigandRDFMover]]
-	[[InterfaceScoreCalculator|InterfaceScoreCalculatorMover]]
-	[[MetricRecorder|MetricRecorderMover]]
-	LoadVarSolDistSasaCalculatorMover
-	LoadZnCoordNumHbondCalculatorMover

<!--
Symmetric interfaces
-------------
-	[[SymRotamerTrialsMover|SymPackRotamersMover]]
-	[[SymPackRotamersMover]]  
-	SymDockProtocol  
Symmetric oligomer docking
-	Symmetrizer  
Functionally an optimization mover; will take a pose with sufficiently small deviations from symmetry and resolve them.
-	[[TaskAwareSymMinMover]]  
[[SymMinMover]]  
minimize with symmetry  
-	[[DetectSymmetry|DetectSymmetryMover]]  
-	GenericSymmetricSampler
-	fold and dock
	-	SymFoldandDockMoveRbJumpMover
	-	SymFoldandDockSlideTrialMover
	-	SymFoldandDockRbTrialMover  
-	MPSymDockMover
-->

Symmetric interfaces
-------------
-	[[SymRotamerTrialsMover|SymPackRotamersMover]]
-	[[SymPackRotamersMover]]  
-	SymDockProtocol  
Symmetric oligomer docking
-	Symmetrizer  
Functionally an optimization mover; will take a pose with sufficiently small deviations from symmetry and resolve them.
-	[[TaskAwareSymMinMover]]  
[[SymMinMover]]  
minimize with symmetry  
-	[[DetectSymmetry|DetectSymmetryMover]]  
-	GenericSymmetricSampler
-	fold and dock
	-	SymFoldandDockMoveRbJumpMover
	-	SymFoldandDockSlideTrialMover
	-	SymFoldandDockRbTrialMover  

Molecular dynamics codes
-------------
-	CartesianMD
-	[[HamiltonianExchange|Tempering-MetropolisHastings#HamiltonianExchange]]

Peptidomimetics
-------------
-	NcbbDockDesign  
-	OopCreatorMover
-	OopDockDesign

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

Antibody Modeling and Design
----------------------------

-   [[AntibodyDesignMover]]
-   [[AntibodyDesignModeler]]
-   [[AntibodyDesignProtocol]]
-   [[CDRDihedralConstraintMover]]
-   [[ParatopeSiteConstraintMover]] 
-   [[ParatopeEpitopeSiteConstraintMover]]


##See Also

* [[RosettaScripts]]: The RosettaScripts home page
* [[List of RosettaScripts movers|Movers-RosettaScripts]]
* [[Getting Started]]: A page for people new to Rosetta
* [[Resources for learning biophysics and computational modeling]]
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Rosetta Servers]]: Web-based servers for Rosetta applications
* [[Scripting Documentation]]: Scripting interfaces to Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of Rosetta terms
* [[Rosetta overview]]: Overview of major concepts in Rosetta