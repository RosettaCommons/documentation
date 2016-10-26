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

Meta Movers don't do anything to the pose themselves, but combine or modify the application of other movers and filters.

### Combining Movers

**[[ParsedProtocol|ParsedProtocolMover]]** (formerly DockDesign) - Make RosettaScripts subroutines.

**[[MultiplePoseMover]]** - Allows "distribute and collect" from certain submovers.

**[[MultipleOutputWrapper|MultipleOutputWrapperMover]]** - Convert a single output mover to multiple output.

**[[Subroutine|SubroutineMover]]** - Run another XML file as a subroutine.

**[[ContingentAcceptMover]]** - Fail if a submover doesn't improve a filter value.

**[[IfMover]]** - Run different movers based on a filter value.

**[[RandomMover]]** - Randomly choose a mover from a weighted list.


### Looping/Monte Carlo Movers

**[[GenericMonteCarlo|GenericMonteCarloMover]]** - Repeatedly apply a mover in a Monte Carlo fashion.

**[[GenericSimulatedAnnealer|GenericSimulatedAnnealerMover]]** - Repeatedly apply a mover in a Monte Carlo fashion with ramped temperatures.

**[[IteratedConvergence|IteratedConvergenceMover]]** - Repeatedly apply a mover until a filter gives stable values. 

**[[LoopOver|LoopOverMover]]** - Repeatedly apply a mover.

**[[MonteCarloTest|MonteCarloTestMover]]** - Tests the Monte Carlo criterion of a mover 

**[[MonteCarloRecover|MonteCarloRecoverMover]]** - Recovers a pose from the generic monte carlo mover

**[[MonteCarloUtil|MonteCarloUtilMover]]** - (developer release only) Recovers the lowest energy pose of a given Monte Carlo object

**[[MetropolisHastings|MetropolisHastingsMover]]** - Performs Metropolis-Hastings Monte Carlo simulations

**[[RampMover]]** - Repeatedly apply a mover while changing a score term.


### Reporting/Saving

**[[AddJobPairData|AddJobPairDataMover]]** - Add a key:value pair to the current job for inclusion in output

**[[CstInfoMover]]** - Add details about constraint satisfaction to the scorefile

**[[DumpPdb|DumpPdbMover]]** - Save a pose to disk.

**[[FilterReportAsPoseExtraScoresMover]]** - Records Filter values to the scorefile

**[[MetricRecorder|MetricRecorderMover]]** - Record metrics in a text file

**[[PDBTrajectoryRecorder|PDBTrajectoryRecorderMover]]** - Records a multimodel PDB file

**[[PyMolMover]]** - Send a pose to PyMol

**[[RenderGridsToKinemage|RenderGridsToKinemageMover]]** - (for debugging) Creates a Kinemage file containing scoring grid(s)

**[[ReportToDB|ReportToDBMover]]** - Report structural data to a relational database.

**[[ResetBaseline|ResetBaselineMover]]** - Reset the baseline (not needed for MC)

**[[SavePoseMover]]** - Save or retrieve a pose for use in another mover/filter.

**[[SilentTrajectoryRecorder|SilentTrajectoryRecorderMover]]** - Records a trajectory in a silent file

**[[StorePoseSnapshot|StorePoseSnapshotMover]]** - Store a snapshot of the current residue numbering in the pose as a named reference pose, so that subsequent movers can use the current state's residue numbering even if residue numbering has changed.

**[[TrajectoryReportToDB|TrajectoryReportToDBMover]]** - Reports multiple structures to an output forming a trajectory

**[[WriteLigandMolFile|WriteLigandMolFileMover]]** - Create a V2000 mol file for each pose



### Setup Movers

**[[SetupPoissonBoltzmannPotential|SetupPoissonBoltzmannPotentialMover]]** - Runtime environment initialization for the PB solver (ddG mover)

## General Movers

These are movers that should be usable in most cases with most systems

### Analysis Movers

**[[ScoreMover]]** - Scores the pose

**[[LoopAnalyzerMover]]** - Computes protein loop-specific metrics

**[[InterfaceAnalyzerMover]]** - Computes protein-protein interface metrics

### Simple Sequence Design

**[[FixBB|FixBBMockMover]]** - Sequence design on a fixed backbone

**[[FlexibleBBdesign|FlexibleBBdesignMockMover]]** - Sequence design with backbone minimization

**[[FastDesign|FastDesignMover]]** - Sequence design with backbone minimization

### Backbone Movement

**[[Backrub|BackrubMover]]** - Makes local rotations around two backbone atoms

**[[BackboneGridSampler|BackboneGridSamplerMover]]** - Generates a residue chain and samples torsion angles

**[[InitializeByBins|InitializeByBinsMover]]** - Randomizes stretches of backbone based on torsion bins

**[[PerturbByBins|PerturbByBinsMover]]** - Perturbs stretches of backbone based on torsion bins

**[[SetTorsion|SetTorsionMover]]** - Sets torsion to a specified or random value

**[[Shear|ShearMover]]** - Makes shear-style torsion moves that minimize downstream propagation

**[[Small|SmallMover]]** - Makes small-move-style torsion moves (no propagation minimization)

**[[NormalModeRelax|NormalModeRelaxMover]]** - Brings concerted motion to backbones using Anisotropic Network Model (ANM)

**[[CartesianMD|CartesianMD]]** - Brings concerted motion to backbones using Cartesian-space molecular dynamics

### Comparative Modeling

**[[HybridizeMover]]** - Use single or multiple templates to generate a combined model.  Part of [[RosettaCM]].

**[[SimpleThreadingMover]]** - Thread sequences onto structures.  Nothing fancy here.

### Constraints

**[[CstInfoMover]]** - Add details about constraint satisfaction to the scorefile

**[[AddCompositionConstraintMover]]** - Adds constraints related to the amino acid composition, enforced by the aa_composition score term.

**[[AddConstraintsToCurrentConformationMover]]** - Adds constraints based on the current conformation

**[[AtomCoordinateCstMover]]** - Adds coordinate constraints for Relax

**[[ClearConstraintsMover]]** - Removes all constraints (geometric and sequence) from the pose

**[[ClearCompositionConstraintsMover]]** - Removes sequence constraints from the pose selectively.

**[[ConstraintSetMover]]** - Adds constraints to the pose using a constraints file

**[[FavorSymmetricSequence|FavorSymmetricSequenceMover]]** - Adds constraints to prefer symmetric sequences

**[[ResidueTypeConstraintMover]]** - Constrains residue type

**[[TaskAwareCsts|TaskAwareCstsMover]]** - Adds constraints to residues designated by task_operations

**[[AddConstraints|AddConstraintsMover]]** - Uses a constraint generator to add constraints to the pose

**[[RemoveConstraints|RemoveConstraintsMover]]** - Removes a set of constraints generated by a constraint generator from the pose

#### Constraint Generators

**[[AtomPairConstraintGenerator]]** - Generates distance constraints among residues in a subset

**[[CoordinateConstraintGenerator]]** - Generates coordinate constraints for residues in a subset

**[[DistanceConstraintGenerator]]** - Generates constraints to enforce a distance between residues in two subsets.

**[[FileConstraintGenerator]]** - Generates, adds, and removes constraints from a file

**[[HydrogenBondConstraintGenerator]]** - Generates constraints to enforce hydrogen bonding between residues

**[[SheetConstraintGenerator]]** - Generates constraints for proper hydrogen bonding in beta-sheets

**[[TerminiConstraintGenerator]]** - Generates atom pair constraints between N- and C- termini

### Docking/Assembly

**[[BridgeChains|BridgeChainsMover]]** - Connects chains using fragment insertion Monte Carlo

**[[DockingProtocol|DockingProtocolMover]]** - Performs full docking protocol with current defaults

**[[FlexPepDock|FlexPepDockMover]]** - Performs ab initio or refinement peptide docking


### Fragment Insertion

**[[SingleFragmentMover]]** - Performs a single fragment insertion

### Idealize/Relax

**[[Idealize|IdealizeMover]]** - Forces ideal bond lengths and angles

**[[FastRelax|FastRelaxMover]]** - Performs FastRelax all-atom refinement

**[[FastDesign|FastDesignMover]]** - Performs FastRelax all-atom refinement, but adds design-related features

### Insertion and Deletion; Grafting

**[[ReplaceRegionMover]]** -Replace a region of a pose with another of the same length.

#### Insertion

**[[AddChain|AddChainMover]]** - Adds a PDB file to an existing pose

**[[AnchoredGraftMover]]** - Grafts a region of one pose into another using the same method used for [[ The Anchored Design Protocol | anchored-design]].  Also used in the RabD Antibody Design Protocol. 

**[[CCDEndsGraftMover]]** - Grafts a region of one pose into another using superposition of insert ends and CCD arms to close the graft.  Used in the RabD Antibody Design Protocol. 

**[[InsertPoseIntoPoseMover]]** - Inserts one pose into another.  Does not do any structure optimization.  

**[[MotifGraft|MotifGraftMover]]** - Grafts a motif into pose(s)

**[[Splice|SpliceMover]]** - (developer release only) Various methods of splicing segments into the current pose


#### Deletion

**[[CutOutDomain|CutOutDomainMover]]** - Uses a template to remove specified residues

**[[DeleteRegionMover]]** - Delete a region/chain of a pose.

**[[KeepRegionMover]]** - Keep a region of the current pose, delete the rest.

**[[SwitchChainOrder|SwitchChainOrderMover]]** - Reorders (or removes) the chains in a pose 


### Kinematic Closure Movers

**[[Generalized Kinematic Closure (GeneralizedKIC)|GeneralizedKICMover]]** - Loop closure and conformational sampling, fully generalized for loops consisting of any arbitrary chain of atoms (canonical backbones, non-canonical backbones, disulfides and other side-chain linkages, artificial cross-linkers, *etc.*).


### Packing/Minimization

**[[ConsensusDesignMover]]** - Mutates residues to create a consensus of multiple sequences, while considering the scores of the residues

**[[ForceDisulfides|ForceDisulfidesMover]]** - Ensures that unrecognized disulfides are formed and bond geometry is correct

**[[MinMover]]** - Minimizes sidechains and/or backbone

**[[MinPackMover]]** - Packs and minimizes a side chain, calls Monte Carlo

**[[PackRotamersMover]]** - Repacks sidechains

**[[PackRotamersMoverPartGreedy|PackRotamersMoverPartGreedyMover]]** - Optimizes around target residues and repacks sidechains

**[[RotamerTrialsMover]]** - Cycles through residues to find the lowest energy rotamer for each

**[[RotamerTrialsMinMover]]** - Cycles through residues to find each lowest energy rotamer in the context of the current pose

**[[Sidechain|SidechainMover]]** - "off rotamer" sidechain-only moves

**[[SidechainMC|SidechainMCMover]]** - "off rotamer" sidechain-only Monte Carlo sampling

**[[TaskAwareMinMover]]** - Minimizes sidechains and/or backbone with positions specified by TaskOperations


### Parametric Backbone Generation

**[[MakeBundle|MakeBundleMover]]** - Uses the Crick equations to create a helix of helices or beta barrel, given user-specified parameter values.

**[[BundleGridSampler|BundleGridSamplerMover]]** - Creates a helix of helices or beta barrel by sampling user-defined parameter ranges and choosing the set of parameter values yielding the lowest-energy structure.

**[[PerturbBundle|PerturbBundleMover]]** - Takes a parametrically-generated helical bundle pose and alters the helical parameters slightly to perturb the bundle geometry.  Good for making moves as part of a Monte Carlo search of parameter space.



### Symmetry

See [[SymmetryAndRosettaScripts]] for details on using Symmetry with RosettaScripts.

**[[SetupForSymmetry|SetupForSymmetryMover]]** - Symmeterizes a pose based on a definition file

**[[DetectSymmetry|DetectSymmetryMover]]** - Symmeterizes a pose composed of symmetric chains

**[[ExtractAsymmetricUnit|ExtractAsymmetricUnitMover]]** - Turn symmetric pose into a nonsymmetric pose (inverse of SetupForSymmetry)

**[[ExtractSubpose|ExtractSubposeMover]]** - (Developer release only) Extracts a subset of a symmetric pose without modifying the original

**[[ExtractAsymmetricPose|ExtractAsymmetricPoseMover]]** - (similar to ExtractAsymmetricUnit) Turns symmetric pose into non symmetric pose

**[[SymDofMover]]** - Sets up symmetric systems of aligned structures

**[[SymPackRotamersMover]]** and SymRotamerTrialsMover - Symmetric versions of PackRotamers and RotamerTrials

**[[SymMinMover]]** - Symmetric version of MinMover

**[[TaskAwareSymMinMover]]** - (developer release only) Similar to SymMinMover, but allows minimization of only certain residues

**[[PeriodicBoxMover]]** - Mover that allows to run MC simulation in a periodic box, for instance liquid simulation.  

### Other Pose Manipulation

**[[AlignChain|AlignChainMover]]** - Align the Calpha atoms of chains in two different poses


**[[AddChainBreak|AddChainBreakMover]]** - Add a break at a specific position

**[[BluePrintBDR|BluePrintBDRMover]]** - Make a centroid structure from a PDB file

**[[CopyRotamer|CopyRotamerMover]]** - Copy a side-chain identity and/or conformation from one residue to another residue.

**[[Disulfidize|DisulfidizeMover]]** - Finds potential disulfide bond positions based on Calpha - Cbeta distance

**[[Dssp|DsspMover]]** - Calculates secondary structure using dssp

**[[FavorNativeResidue|FavorNativeResidueMover]]** - Constrains the residue type by favoring the type present when applied

**[[FavorSequenceProfile|FavorSequenceProfileMover]]** - Constrains the residue type using one of several profiles

**[[FlipChirality|FlipChiralityMover]]** - Mirrors a selection in pose

**[[FoldTreeFromLoops|FoldTreeFromLoopsMover]]** - Defines a fold tree based on the end points of a loop

**[[HBNet|HBNetMover]]** - (Developer release only) Methods for designing explicit hydrogen bond networks

**[[LoadPDB|LoadPDBMover]]** - Replaces current PDB with another

**[[LoopLengthChange|LoopLengthChangeMover]]** - Changes the length of a loop

**[[LoopCreationMover]]** - (developer release only) Build loops to bridge gaps in a structure

**[[MutateResidue|MutateResidueMover]]** - Changes a residue to a different type

**[[ModifyVariantType|ModifyVariantTypeMover]]** - Adds or removes variant types of a set of residues

**[[PeptideStubMover]]** - Add new residues to a pose

**[[PeptideCyclizeMover]]** - Closes two ends of a selection in a pose

**[[SegmentHybridize|SegmentHybridizeMover]]** - Closes loops using fragment insertion and cartesian minimization

**[[Superimpose|SuperimposeMover]]** - Superimpose the current pose on another stored pose

**[[SetSecStructEnergies|SetSecStructEnergiesMover]]** - Biases the score toward particular secondary structural elements

**[[SwitchChainOrder|SwitchChainOrderMover]]** - Reorders (or removes) the chains in a pose 

**[[TryDisulfPermutations|TryDisulfPermuationsMover]]** - Tries all possible permutations of disulfides for residue types that can form disulfides, and returns the lowest-energy permutation.

**[[MakePolyX|MakePolyXMover]]** - Converts a pose into a polymer of a single amino acid type

**[[MembraneTopology|MembraneTopologyMover]]** - Inserts membrane topology from a membrane span file into a pose

**[[SwitchResidueTypeSetMover]]** - Toggles between centroid and full atom modes

**[[SetTemperatureFactor|SetTemperatureFactorMover]]** - Sets the temperature factor column in a PDB file

**[[PSSM2Bfactor|PSSM2BfactorMover]]** - Sets the temperature factor column in a PDB file based on PSSM score

**[[RemodelMover]]** (including building disulfides) - Loop building and refinement using Remodel

**[[ReplaceRegionMover]]** -Replace a region of a pose with another of the same length.

**[[RigidBodyTransMover]]** - Translates a chain along an axis

**[[RigidBodyPerturbNoCenter]]** - Make a small, random translational and rotational move to move two parts of a pose relative to one another.

**[[RollMover]]** - Rotates pose a given angle over a given axis

**[[SetupNCS|SetupNCSMover]]** - Sets up non crystallographic symmetry between residues and forces residues to maintain conformation and type

**[[StoreResidueSubset|StoreResidueSubsetMover]]** - Creates a residue subset from a residue selector and stores it into the current pose under a given name.

**[[StoreTask|StoreTaskMover]]** - (Developer release only) Creates and stores a packer task in the current pose

**[[StoreCompoundTaskMover]]** - (Developer release only) Constructs compound logical tasks and stores them in the current pose

**[[VirtualRoot|VirtualRootMover]]** - Create virtual residue and reroot pose foldtree on the new residue



## Antibody Modeling and Design Movers

See Also: [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]], [[Antibody Feature Reporters | FeatureReporters#implemented-feature-reporters_antibody]], [[Grafting Movers | Movers-RosettaScripts#general-movers_insertion-and-deletion-grafting]]

### Constraints ###

**[[CDRDihedralConstraintMover]]** - Adds CDR Cluster or General dihedral constraints to specified CDRs of a renumbered antibody

**[[ParatopeSiteConstraintMover]]** - Adds SiteConstraints between the Paratope and a given antigen to keep the paratope in contact with the antigen.  

**[[ParatopeEpitopeSiteConstraintMover]]** - Adds SiteConstraints between the Paratope and the Epitope to keep both in contact during any rigid-body modeling. 

### Modeling ###

**[[AntibodyCDRGrafter]]** - Graft CDR loops from one structure to another, optionally optimize CDRs.


### Design ###

**[[AntibodyDesignMover]]**

**[[AntibodyDesignProtocol]]**


## Carbohydrate-specific Movers

**[[GlycanRelaxMover]]** - Glycosylate poses with glycan trees.
  
**[[SimpleGlycosylateMover]]** - Glycosylate poses with glycan trees. 


## Computational 'affinity maturation' movers

**[[GreedyOptMutationMover]]** - Introduces mutations, scores them, combines them and accepts the combinations based on score

**[[RandomMutation|RandomMutationMover]]** - Introduce a random mutation in a re-designable position


## DNA Interface Design Movers

**[[DnaInterfacePacker|DnaInterfacePackerMover]]** - Minimizes sidechains and calculates binding energy 



## Ligand-centric Movers

### Ligand docking

These movers replace the executable for ligand docking and provide greater flexibility to the user in customizing the docking protocol. An example XML file for ligand docking can be found in the demos directory under Rosetta/demos/protocol_capture/2015/rosettaligand_transform/. The movers below are listed in the order they generally occur in a ligand docking protocol.

**[[StartFrom|StartFromMover]]** - Moves a ligand to user-specified coordinates

**[[Transform|TransformMover]]** - Performs ligand docking moves using a Monte Carlo search and provided scoring grids

**[[Translate|TranslateMover]]** - Moves a small molecule in a random position within a specified sphere

**[[Rotate|RotateMover]]** - Performs random rotations and keeps poses based on a filter

**[[SlideTogether|SlideTogetherMover]]** - Ensures that rotated and translated ligands are close enough to the protein to complete high resolution docking

**[[HighResDocker|HighResDockerMover]]** - Uses rotamer trials, ligand perturbations, and repacking to complete docking

**[[FinalMinimizer|FinalMinimizerMover]]** - Performs gradient minimization of a docked pose

**[[InterfaceScoreCalculator|InterfaceScoreCalculatorMover]]** - Calculates interface score by subtracting that of the separated partners from that of the complex

**[[ComputeLigandRDF|ComputeLigandRDFMover]]** - Computes radial distribution functions using protein-protein or protein-ligand atom pairs


### Enzyme Design

**[[EnzRepackMinimize|EnzRepackMinimizeMover]]** - Design/repack and minimization for enzyme design

**[[AddOrRemoveMatchCsts|AddOrRemoveMatchCstsMover]]** - Adds or removes pairwise geometric constraints for a pose

**[[PredesignPerturbMover]]** - Perturbs a ligand in an active site, randomly rotates/translates, and accepts based on Boltzmann criteria


### Ligand design

**[[GrowLigand|GrowLigandMover]]** - Connects a random fragment to a growing ligand

**[[AddHydrogens|AddHydrogensMover]]** - Saturates incomplete connections

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

**[[LoopRemodel|LoopRemodelMover]]** - Samples loop conformations through perturbation and refinement

**[[LoopMoverFromCommandLine|LoopMoverFromCommandLineMover]]** - Uses various protocols to perturb and refine loops in a loop file

**[[DisulfideMover]]** - Creates disulfide bonds among set of target residues in an interface

**[[InterfaceRecapitulation|InterfaceRecapitulationMover]]** - Tests design movers for their ability to recover the native sequence

**[[VLB|VLBMover]]** (aka Variable Length Build) - Improves complex structures through 'computational affinity' methods

**[[HotspotDisjointedFoldTree|HotspotDisjointedFoldTreeMover]]** - Produces a disjointed foldtree for selected residue(s)

**[[AddSidechainConstraintsToHotspots|AddSidechainConstraintsToHotspotsMover]]** - Adds constraints to sidechain atoms in preparation for affinity maturation

**[[MSDMover|MSDMover]]** - Runs protein multistate design using the RECON protocol

**[[FindConsensusSequence|FindConsensusSequence]]** - Finds a consensus sequence from candidates generated by RECON protocol. To be used with MSDMover.


### Placement and Placement-associated Movers & Filters

See [[RosettaScriptsPlacement]] for more information.

**[[Auction|AuctionMover]]** - Auctions residues to hotspot sets 

**[[MapHotspot|MapHotspotMover]]** - Maps potential hotspot residues

**[[PlacementMinimization|PlacementMinimizationMover]]** - Performs rigid-body minimization

**[[PlaceOnLoop|PlaceOnLoopMover]]** - Performs loop remodeling with kinematic loop closure and handles hotspot constraint application

**[[PlaceStub|PlaceStubMover]]** - Placement of sidechains using the hot-spot method of protein-binder design

**[[PlaceSimultaneously|PlaceSimultaneouslyMover]]** - Similar to PlaceStub, but places residues simultaneously rather than iteratively

**[[RestrictRegion|RestrictRegionMover]]** - Allows for design of small sections of a pose without long range effects

**[[StubScore|StubScoreFilter]]** - Filters for hopeless configurations based on whether or not hotspot constraints are effective

**[[ddG|ddGMover]]** - Calculates overall or per-residue ddG

**[[ContactMap|ContactMapMover]]** - Produces contact maps for structure(s)

##SEWING movers

These movers are used as part of the [[SEWING]] protocol and have protocol-specific input files and command-line options:

* **[[MonteCarloAssemblyMover]]** - Builds an assembly of a user-specified size by MonteCarlo sampling of substructures.

* **[[AppendAssemblyMover]]** - Builds a protein by extending a user-specified starting structure. Often used for interface design (starting with a protein-binding peptide) or to incorporate specific motifs into designs.

* **[[RepeatAssemblyMover]]** - Used to design repeat proteins.

* **[[EnumerateAssemblyMover]]** - Builds all possible structures from a given SewGraph.

* **[[AssemblyConstraintsMover]]** - Used to favor native residues during refinement in assemblies produced using [[SEWING]].

##See Also

* [[Mover]]: An overview of Movers. 
* [[I want to do x]]: Guide to choosing a RosettaScripts mover