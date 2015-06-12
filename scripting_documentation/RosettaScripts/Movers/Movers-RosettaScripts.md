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

**[[SetupForSymmetry|SetupForSymmetryMover]]** - Symmeterizes a pose based on a definition file

**[[DetectSymmetry|DetectSymmetryMover]]** - Symmeterizes a pose composed of symmetric chains

**[[SymDofMover]]** - Sets up symmetric systems of aligned structures

**[[ExtractAsymmetricUnit|ExtractAsymmetricUnitMover]]** - Turn symmetric pose into a nonsymmetric pose (inverse of SetupForSymmetry)

**[[ExtractSubpose|ExtractSubposeMover]]** - (Developer release only) Extracts a subset of a symmetric pose without modifying the original

**[[ExtractAsymmetricPose|ExtractAsymmetricPoseMover]]** - (similar to ExtractAsymmetricUnit) Turns symmetric pose into nonsymmetric pose

**[[SymPackRotamersMover]]** and SymRotamerTrialsMover - Symmetric versions of PackRotamers and RotamerTrials

**[[SymMinMover]]** - Symmetric version of MinMover

**[[TaskAwareSymMinMover]]** - (developer release only) Similar to SymMinMover, but allows minimization of only certain residues

### Kinematic Closure Movers

**[[Generalized Kinematic Closure (GeneralizedKIC)|GeneralizedKICMover]]** - Loop closure and conformational sampling 

### Parametric Backbone Generation

**[[MakeBundle|MakeBundleMover]]** - Uses the Crick equations to create a helix of helices or beta barrel

**[[BundleGridSampler|BundleGridSamplerMover]]** - Creates a helix of helices or beta barrel by sampling parameters and choosing the one with the lowest energy

**[[PerturbBundle|PerturbBundleMover]]** - Performs iterative Monte Carlo searches of Crick parameter space 

### Other Pose Manipulation

**[[MutateResidue|MutateResidueMover]]** - Changes a residue to a different type

**[[AlignChain|AlignChainMover]]** - Align the Calpha atoms of chains in two different poses

**[[BluePrintBDR|BluePrintBDRMover]]** - Make a centroid structure from a PDB file

**[[ModifyVariantType|ModifyVariantTypeMover]]** - Adds or removes variant types of a set of residues

**[[MotifGraft|MotifGraftMover]]** - Grafts a motif into pose(s)

**[[LoopCreationMover]]** - (developer release only) Build loops to bridge gaps in a structure

**[[SegmentHybridize|SegmentHybridizeMover]]** - Closes loops using fragment insertion and cartesian minimization

**[[Disulfidize|DisulfidizeMover]]** - Finds potential disulfide bond positions based on Calpha - Cbeta distance

**[[Dssp|DsspMover]]** - Calculates secondary structure using dssp

**[[AddChain|AddChainMover]]** - Adds a PDB file to an existing pose

**[[AddChainBreak|AddChainBreakMover]]** - Add a break at a specific position

**[[FoldTreeFromLoops|FoldTreeFromLoopsMover]]** - Defines a fold tree based on the end points of a loop

**[[Superimpose|SuperimposeMover]]** - Superimpose the current pose on another stored pose

**[[SetSecStructEnergies|SetSecStructEnergiesMover]]** - Biases the score toward particular secondary structural elements

**[[SwitchChainOrder|SwitchChainOrderMover]]** - Reorders (or removes) the chains in a pose 

**[[LoadPDB|LoadPDBMover]]** - Replaces current PDB with another

**[[LoopLengthChange|LoopLengthChangeMover]]** - Changes the length of a loop

**[[MakePolyX|MakePolyXMover]]** - Converts a pose into a polymer of a single amino acid type

**[[MembraneTopology|MembraneTopologyMover]]** - Inserts membrane topology from a membrane span file into a pose

**[[Splice|SpliceMover]]** - (developer release only) Various methods of splicing segments into the current pose

**[[SwitchResidueTypeSetMover]]** - Toggles between centroid and full atom modes

**[[FavorNativeResidue|FavorNativeResidueMover]]** - Constrains the residue type by favoring the type present when applied

**[[FavorSequenceProfile|FavorSequenceProfileMover]]** - Constrains the residue type using one of several profiles

**[[SetTemperatureFactor|SetTemperatureFactorMover]]** - Sets the temperature factor column in a PDB file

**[[PSSM2Bfactor|PSSM2BfactorMover]]** - Sets the temperature factor column in a PDB file based on PSSM score

**[[RigidBodyTransMover]]** - Translates a chain along an axis

**[[RollMover]]** - Rotates pose a given angle over a given axis

**[[RemodelMover]]** (including building disulfides) - Loop building and refinement using Remodel

**[[SetupNCS|SetupNCSMover]]** - Sets up non crystallographic symmetry between residues and forces residues to maintain conformation and type

**[[StoreTask|StoreTaskMover]]** - (Developer release only) Creates and stores a packer task in the current pose

**[[StoreCompoundTaskMover]]** - (Developer release only) Constructs compound logical tasks and stores them in the current pose

**[[VirtualRoot|VirtualRootMover]]** - Create virtual residue and reroot pose foldtree on the new residue

## Computational 'affinity maturation' movers

**[[RandomMutation|RandomMutationMover]]** - Introduce a random mutation in a re-designable position

**[[GreedyOptMutationMover]]** - Introduces mutations, scores them, combines them and accepts the combinations based on score

## Loop Modeling Movers

See [[RosettaScriptsLoopModeling]] for an overview.

**[[LoopModeler|LoopModelerMover]]** - Performs a standard loop modeling simulation

**[[LoopBuilder|LoopBuilderMover]]** - Builds backbone atoms for loops with missing residues

**[[LoopProtocol|LoopProtocolMover]]** - Optimizes the backbone of a loop region via a Monte Carlo simulation

**[[KicMover]]** - Generates backbone conformations using the kinematic closure algorithm 

**[[RepackingRefiner|RepackingRefinerMover]]** - Refines the sidechains around a loop using the standard repacker

**[[RotamerTrialsRefiner|RotamerTrialsRefinerMover]]** - Refines the sidechains in and around a loop using rotamer trials

**[[MinimizationRefiner|MinimizationRefinerMover]]** - Refines loop backbone and sidechains via gradient minimization

**[[PrepareForCentroid|PrepareForCentroidMover]]** - Converts a pose to centroid mode

**[[PrepareForFullatom|PrepareForFullatomMover]]** - Converts a pose to fullatom mode

## Protein Interface Modeling, Design, and Analysis Movers

These movers are at least somewhat specific to the design of protein-protein interfaces. Attempting to use them with, for example, protein-DNA complexes may result in unexpected behavior.

**[[PatchdockTransform|PatchdockTransformMover]]** - Modifies the pose configuration using a Patchdock file

**[[ProteinInterfaceMS|ProteinInterfaceMSMover]]** - Protein interface design where the bound state is compared to the unbound state and the unbound unfolded state

**[[InterfaceAnalyzerMover]]** - Calculates metrics for evaluating protein interfaces

**[[Docking|DockingMover]]** - Performs docking in centroid or fullatom mode

**[[DockWithHotspotMover]]** - Performs docking in centroid mode with constraints

**[[Prepack|PrepackMover]]** - Minimizes and repacks protein complexes

**[[RepackMinimize|RepackMinimizeMover]]** - Design/repack and minimization for protein complexes

**[[DesignMinimizeHBonds|DesignMinimizeHBondsMover]]** - Similar to RepackResidues, but with a definable set of target residues

**[[build_Ala_pose|BuildAlaPoseMover]]** - Turns interface residues to alanine in preparation for design steps

**[[SaveAndRetrieveSidechains|SaveAndRetrieveSidechainsMover]]** - Saves the side chain data lost when switching residue types

**[[AtomTree|AtomTreeMover]]** - Connects residues on two different chains with an AtomTree

**[[SpinMover]]** - Allows random spin around an axis defined by an atom tree

**[[TryRotamers|TryRotamersMover]]** - Produces a set of rotamers for a given residue or residues

**[[BackrubDD|BackrubDDMover]]** - Backrub-style backbone and sidechain sampling

**[[BestHotspotCst|BestHotspotCstMover]]** - Removes constraints from all but the best residues to avoid problems with minimization

**[[DomainAssembly|DomainAssemblyMover]]** (Not tested thoroughly) - Performs domain assembly sampling via fragment insertion

**[[LoopFinder|LoopFinderMover]]** - Finds loops in the current pose and saves them for later use

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

