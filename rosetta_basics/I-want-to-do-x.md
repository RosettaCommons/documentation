"I want to do _x_. How do I do _x_?"
===========

Typically, users come to an input structure with the notion that they want to perform a particular type of sampling, whether via running an application or using a RosettaScripts mover.
Here, we have categorized Rosetta's RosettaScripts-enabled movers by the type of structural perturbation they perform.

What we can't help you with
-----------

Very frequently, new graduate students in non-Rosetta labs are given very vague problem statements.
At least, they are vague with respect to the questions here.
For example: "You should acquire Rosetta and determine which of these mutations would be tolerated."
This is a great project and potentially super valuable, but it is a hard, hard question; machine learning algorithms trained on sequence data and dozens of structural features drawn from Rosetta-derived ensembles frequently get the right answer, but not always, and just looking at the change in Rosetta score won't get you there.

Unfortunately, there is no IsThisMutationTolerated mover.
This is not an error on the part of your PI; this is an important opportunity for you to figure out what sort of sampling is necessary to answer your question.
For example, suppose one of the mutations is alanine-to-proline at the second position of an alpha helix.
This is the third most common position for proline in alpha helices; thus, it is very improbable but not impossible.
So the question is: how fold-breaking is this mutation?

One starting point might be to make the mutation with a fixed backbone, repack in a shell around that residue, and evaluate the energy.
If it is too bad, maybe there needs to be some backbone motion to relieve strain.
Moreover, how good was your original model? Your work may benefit from taking a low quality NMR structure, generating an ensemble from each model, and proceding from the best cluster centroids of that ensemble.

Also, none of these results necessarily relate to the underlying question your PI asked.
Does your PI want to know how well tolerated the mutations are _structurally_?
Well, then you can produce some measurement derived from the RMSD of the whole protein, native and mutant ensembles both, or perhaps a subset of the protein near the mutation in question, or if it has a critical region like an interface with another protein or an active site, the RMSD there.
Naturally, you'd want to incorporate an energetic measurement, too; if in the mutant ensemble the lowest RMSD-to-native models have the worst energy even within your "best centroids" and vice-versa, that is a bad sign for the stablity of that mutation.
Does your PI want, rather, to know how well tolerated the mutations are _functionally_?
You are mostly out of luck.
This is a phenomenally complicated question.
Perhaps the RMSD over "functionally relevant" residues would be helpful, but that's just a possibility; it's impossible to endorse any generally useful metric and identifying "functionally relevant" residues is usually intractable.

In brief: most biological questions you are given are complicated and require extensive thought.
In contrast, this page _only_ tells you the type of sampling you can do, which is very valuable _once you have decided what you want to do_.

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
<!--
-	AddMembraneMover  
adds a membrane to a structure when needed
-	SymmetricAddMembraneMover
-->
-	GrowPeptides
-	From electron density:
	-	IdealizeHelices
	-	RecomputeDensityMap
	-	CartesianSampler
	

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
-	DisulfideInsertion  
-	[[DisulfideMover]] 
-	[[Disulfidize|DisulfidizeMover]]

Design
-------------
-	[[FastDesign|FastDesignMover]] 
-	CoupledMover  
FastRelax mover that does design during repacking
-	[[RemodelMover]]  
Extremely diverse function: can do design, repacking, complete backbone remodeling, disulfide construction, and so forth   
-	enzyme design
	-	EnzdesRemodelMover
	-	[[PredesignPerturbMover]]
-	[[DesignMinimizeHbonds|DesignMinimizeHbonds]]
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
<!--
-	MPSymDockMover
-->

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
