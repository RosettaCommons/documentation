# Release Notes

<!--- BEGIN_INTERNAL -->
## _Rosetta 3.10 (draft notes)_

### New applications
* [[GALigandDock]] and [[gen_bonded]] - newest results of the SEATTLE ENERGY FUNCTION LINK THING
* Buried unsatisfied penalty scoreterm guides the packer to solutions with no buried unsatisfied hydrogen bond donors or acceptors.  LINKY LINKY

### New features
* [[SimpleMetrics]] are coming online to replace the use of no-action Movers and Filters that were used to calculate values
* Huge stability improvements to the PDB and mmCIF readers
* Database directory of [[RelaxScripts]].  The RosettaCON2018 RelaxScript is under consideration as the next default script - it improves design quality and runs faster to boot.
* Protein ensembles in small molecule docking
* [[Splice]] updates
* [[InterfaceAnalyzerMover]] compatible with ligands and generally more stable
* [[DensityFitResidueSelector]]
* [[InterfaceHydrophobicResidueContactsFilter]]
* Lariat modes for cyclic peptides
* [[RosettaDock]] gains adaptive conformer selection and motif dock score
* [[SEWING]] refactor and new needles (ok, ok, new sub-applications).  I don't think it's multithreaded yet.
* [[FindGlycanSeqonsMover]]
* Tricks to dump minimization trajectories
* common flag/config/option file support [Custom Configurations](https://www.rosettacommons.org/docs/latest/rosetta_basics/running-rosetta-with-options#common-options-and-default-user-configuration)

### Nonprotein chemistries
#### Glycans
* Method to output the IUPAC sequence for an individual glycan
* [[RingPlaneFlipMover]]
* Glycosylation of lipids and nucleotide diphosphates
* [[ShearMover]] works with glycans now
* [[Stepwise]] works better with sugars

#### RNA
* Parametrically generated RNA helices bugfixes
* RNA-protein ddG calculations.
* [[DRRAFTER]]

#### Metals
* [[CrosslinkerMover]] can now place octahedral, tetrahedral, square pyramidal, square planar, trigonal planar, and trigonal pyramidal metals.
* Improvements for auto_setup_metals - particularly it works with centroid mode

### Updates
* UBQ_Gp_LYX-Cterm compatible with a ResidueSelector from which to sample to choose LYX positions
* RosettaAntibody can take user-defined CDRs via a JSON input, useful for when the automated regex detection fails
* [[CoupledMoves]] and [[ClashBasedRepackShell]]
* [[UnsatSel]]
* `-output_ligands_as_separate_chains`, causes Rosetta to reassign chain ID of a ligand when it shares with a peptide chain.
* [[SnugDock]] no longer requires an L_HA chain pattern
* Enzdes use of PDB headers now more user friendly
* Cartesian mode minimization and [[cart_bonded]] is compatible with per-atom control (mainly used for IUPAC-nomenclature compatability of glycan Movemaps). Fixes for cyclic geometry, D-amino acids, and symmetric glycine behavior.
* [[BuriedUnsatisfiedHbondFilter]] gains ddG_style_dont_recalc_surface
* [[PyMOLMover]] hookup is python3 compatible
* [[WriteSSEMover]]
* [[SimpleThreadingMover]] works with symmetry

### Bugfixes
* [[BindingSiteConstraint]]
* 3D lattice docking and [[MakeLatticeMover]]
* BackrubDD XML parsing
* [[BuriedUnsatFilter]] or maybe [[BuriedUnsatisfiedHbondFilter]]
* [[EllipsoidalRandomizationMover]] and [[SnugDock]]
* [[GlycanRelax]] compatibility with [[Symmetry]]
* [[CoupledMoves]] had several edge-case segfaults removed
* [[PeptideStubMover]]
* [[SequenceMetric]]
* [[SimpleCycPepPredict]]
* [[RotamerSetFactory]]
* [[StrandCurvatureByLevels]]
* [[EnzScoreFilter]]

<!--- END_INTERNAL -->

## Rosetta 3.9

### Scorefunction changes
* We changed our default scorefunction to [[REF2015|Overview-of-Seattle-Group-energy-function-optimization-project]]. (http://pubs.acs.org/doi/abs/10.1021/acs.jctc.7b00125)

### API changes
* PyRosetta: xyzMatrix now have .xy properties bound as 'data' instead of set/get functions. So if your code accessed this methods directly you will need to refactor it as m.xx(m.xy()) --> m.xx = m.xy

### User friendliness
* Improved the output formatting for errors - in the vanishingly rare case that an error occurs with Rosetta, you are now more likely to get a useful and interpretable error message.
* Added **Common Flag Configurations** to make it easier to run Rosetta often and for a variety of use-cases. [[running-rosetta-with-options#common-options-and-default-user-configuration]]
* Reduced memory use in the most memory-intensive step of the build process.  You can now build Rosetta on slightly slimmer machines.  You probably should not try running Rosetta on those machines anyway.
* Exception handling rearranged so that Python users will see the string message in C++-thrown exceptions
* Long-desired, long-delayed tweaks to the 'released' code end users see.  The build system is tweaked to:
 * default to the faster release mode 
 * aggressively search for compilers/paths (no need to use .default. any longer)
 * Ignore warnings coming from compilers we've not tested on
* Made the python infrastructure that comes with the C++ code (not PyRosetta, but Rosetta's Python) more Python 2 vs 3 
tolerant

##New or updated features

###Applications
* [[JD3]] has gained:
  * A revived [[ResourceManager]]
  * RosettaScripts compatibility (will receive public release in next version)
  * [[MultistageRosettaScripts]]  
* [[RosettaAntibodyDesign]] Application released - preparing for published paper.  Pre-print available here: [https://www.biorxiv.org/content/early/2018/02/23/183350]

* [[dock_glycans]] bug fixes
* Protocols for explicit water:
  * [[Hydrate/SPaDES protocol]] include: solvent-protein interactions in a hybrid implicit-explicit solvation model.
  * RyanP what is that name of yours?
* [[interface_energy]] - distinct from [[InterfaceAnalyzer|interface-analyzer]], and also well documented
* [[RosettaCM]] / [[HybridizeMover]] - improvements to error handling for mismatched template lengths
* Antibody homology modeling works with only a heavy chain present
* [[RosettaES|mover_FragmentExtension_type]]
* [[shobuns]] - Buried UNSatisfied polar atoms for the SHO solvation model
* Multithreading has come to [[simple_cycpep_predict]]
* [[Functional Folding and Design|FunFolDes]]
* [[HBNet|HBNetMover]]
* [[energy_based_clustering|energy_based_clustering_application]]

###RosettaScripts tools
* RosettaScripts available from within PyRosetta - great for when you really, really, really don't want to think about Rosetta's C++ core
* [[RosettaScripts#rosettascript-sections_move_map_factories]] created to allow protocols to create MoveMaps at better (later) points in the trajectory, when the relevant data are at hand.  New documentation added to main RosettaScripts page for how to use this great tool.
* [[LayerDesign]] via ResidueSelectors now compatible with Boolean logic for easier use
*  ConstraintGenerators can now be specified in their own CONSTRAINT_GENERATORS block in a RosettaScript and can be passed to [[AddConstraintsMover]]using the constraint_generators option.  Constraint Generators are used to create constraints on the fly, without the need for constraint files. 
* [[DihedralConstraintGenerator | constraint_generator_DihedralConstraintGenerator_complex_type]] -  A cst generator that creates Dihedral constraints for specified residues using a residue selector. Uses CircularHarmonic constraints, since CircularGaussian func does not exist. By default, works on Protein and carbohydrate BackBone dihedrals (but this can be changed), in addition, CUSTOM ARBITRARY DIHEDRALS can also be set.
* Use of recursive script inclusion in RosettaScripts is now enormously faster
* [[WriteFiltersToPose]]
* [[SwitchChainOrderMover]] bugfix
* [[buried_apolar_area_filter]] - filters based on buried surface area
* a filter to compute the longest continuous stretch of polar residues in a pose or selection
* [[ResidueProbDesignOperation | to_ResidueProbDesignOperation_type]] (used originally for [[RosettaAntibodyDesign]] ) can now take a text file of residue probabilities per position and is available in RosettaScripts
* [[ReturnSidechainMover]] - works better with stuff like phosphorylated residues, and broadly produces more useful warnings/errors
* Metals:
    * [[MetalContactsConstraintGenerator]] adds distance, angle, and dihedral constraints between (optionally specified) contacts and a user-specified metal atom, either as a single ion or as part of a ligand.
    * [[LigandMetalContactSelector]] identifies and selects residues that form contacts with selected metal-containing residues.
    * [[SetupMetalsMover]]
* [[DockingSlideIntoContact]] updates
* [[NeighborhoodResidueSelector]] bugfix
* [[PerturbBundle]] updates
* [[RandomResidueSelector]] feature: select random clusters of residues close in 3-D space
* [[AlignChainMover]] feature: align to center of mass instead of a 2nd pose.
* [[SecondaryStructureCountFilter]] updates
* [[SelectResiduesByLayer]] bugfix
* [[BuriedSurfaceArea]] updates
* [[BondedResidueSelector]], which takes either an input residue selector or list of residue numbers and selects all residues with chemical bonds to the input set
* [[HBondSelector]] takes an input residue selector or list of residue numbers. If provided, it selects all residues that form hydrogen bonds with residues in the input set given that those hydrogen bonds meet a specified energy requirement (default -0.5 REU). If no selector is provided, all residues in the pose that form hydrogen bonds are selected. By default, backbone-backbone hydrogen bonds are ignored.
* [[ShearMover]] bugfix.  Yes, this was one of the very earliest Movers we wrote.  Imagine our shear disbelief at discovering there has been a bug in it for most of a decade.

* __More resfile commands__: We have 3 new resfile commands: CHARGED, AROMATIC, and PROPERTY.
The third is a general command that takes any ResidueProperty. Currently, it only works for Cannonicals, but perhaps that could be generalized int the future for NCs.

* [[ResfileCommandOperation | to_ResfileCommandOperation_type]] - Applies the equivalent of a resfile line (without the resnums) to residues specified in a residue selector.
* [[SequenceMotifTaskOperation | to_SequenceMotifTaskOperation_type]] -A TaskOp that takes a regex-like pattern and turns it into a set of design residues. 
* [[CreateSequenceMotifMover | mover_CreateSequenceMotifMover_type]] - Simple mover to Create a sequence motif in a region of protein using the SequenceMotifTaskOperation. Uses psueo-regular expressions to define the motif.

* [[TrueResidueSelector]] bugfix
* [[RmsdFromResidueSelectorFilter]] update
* [[SecondaryStructureSelector]]
* [[AtomPairConstraint]]
* [[SegmentedAtomPairConstraint]]
* [[ReleaseConstraintFromResidueMover]]
* [[UnsatSelector]] - symmetry compatibility
* [[AddHelixSequenceConstraintsMover]]
* [[ReadPoseExtraScoreFilter]]
* [[BuriedUnsatHbondsFilter]] updates



###Miscellaneous
* bugfixes to PDB->Pose construction logic arising from missing atoms at termini
* removed unimplemented fa_plane term.  A zero-weight fa_plane term was a feature of a large number of scorefunctions, which was planely wrong.  This may cause issues using legacy scoring weight sets with Rosetta 3.9: just remove the unused fa_plane term in your weights file.
* [[AlignmentAAFinderFilter]] filter -- Scans through an alignment, tests all possible amino acids at each position, and generates a file of passing amino acids.
* [[AlignmentGapInserterFilter]] filter -- Scans through an alignment and inserts gaps where positions in the alignment are not representative of the chemical environment of the pose sequence. Useful for removing epistasis from a MSA.
* [[NearNativeLoopCloser]] bugfix
* bugfixes to Cartesian minimization, the cart_bonded term, and especially those two with symmetric Poses
* symmetric disulfide scoring bugfix
* [[PolymerBondedEnergyContainer]] bugfix
* [[LoopModeler | LoopModelerMover]] optimize the support for fragment based sampling
* [[GenKIC]] bugfixes
* [[remodel]] bugfixes
* [[Backrub]] bugfix
* Improvements to silent file reading, enabling the reading of some slightly-corrupted silent files.  (There remains a lurking bug causing them to occasionally be written in a corrupted state).
* Compile fixes for GCC 7.1 and 4.9.
* ERRASER bugfix
* ScoringGrids and InterfaceScoreCalculator (for ligands) bugfixes
* Explicit unfolded state energy calculator bugfixes
* ABEGO bin scoreterm
* Implementation of mean-field algorithm to predict rotamer or amino acid probability. Can be used to [[predict specificity profile|GenMeanFieldMover]] for protein-protein or protein-peptide interactions.
* [[MonteCarloInterface]] allows users to set protein-protein interface ddG as the energy criterion in MonteCarlo.  This partially addresses the often-requested feature to favor binding energy, not total energy, in design operations.
* [[VoidsPenalty]] - nature abhors a vacuum, but Rosetta tends to ignore them.  VoidsPenalty detects underpacked regions in protein cores and favors rotamers to fill those gaps.
* [[NetCharge]] - a superclass of the older "supercharge" idea, this score term lets you target a desired net charge for your design.
* Old [[SEWING]] deprecated but still functional ahead of its replacement
* [[LoopAnalyzerMover]] bugfixes


###Nonprotein chemistries
* Major bugfixes for rotamer scoring for noncanonical sidechains
* Improvements to internal glycan handing and IO. (For PDB import use the options `-auto_detect_glycan_connections` and `-alternate_3_letter_codes pdb_sugar`.  For more information, please see [[WorkingWithGlycans]]
* The handling of non-polymeric chemical connections has been improved/simplified. This includes better handling of LINK records in PDB input, as well as removal of the BRANCH_LOWER_TERMINUS residue variant type.
* Improvements to both automatic and user-specified handling of metal ions
* A few more lipids are available for explicit membrane modeling (this is distinct from the implicit membrane scorefunction)
* Better and automatic writing of LINK records in PDB output
* Rosetta is more able to figure out missing chemistry data automatically:
    * It can guess at torsion parameters when otherwise missing when scoring the cart_bonded (Cartesian minimization) term
    * It is able to automatically generate centroid (nonpolymeric) residue types when the fullatom type is present - great for split centroid/fullatom protocols where the user has created only the fullatom params file for their ligand.
* Vikram Mulligan has been absolutely on fire adding nonprotein chemistries for cyclic peptides.  (He's now hard at work on fire-retardant peptides):
    * trimesic acid, a three-way crosslinker
    * cyclization via disulfide (instead of simply including disulfides)
    * Oligoureas
    * N-methyl amino acids, for getting rid of that pesky backbone hydrogen bond donor
    * 2-aminoisobutyric acid (AIB), a non-canonical, achiral alpha-amino acid that strongly favours helices (both left- and right-handed).  AIB is to ALA as bactrian is to dromedary.  (That makes glycine a horse).
* Glycan Relax - Version 2 [[GlycanTreeRelax]]

## Rosetta 3.8
###New RosettaScripts XML
The XML supporting RosettaScripts has been totally refactored.  Rosetta now validates input XML files against an "XML Schema", and can better determine at the start of a run if all XML options are legal and functional.  The XML reader can now pinpoint errors much more specifically and offers more helpful error messages.

You can now also get commandline help for XML-enabled classes with the -info flag; e.g. ```-info PackRotamersMover``` and a blank, formatted template rosetta script by running the `rosetta_script` application without giving the `-parser:protocol` option.  

A consequence of this refactoring is that pre-Rosetta3.8 XML scripts are usually no longer legal XML - we offer a tool to convert the old style, pseudo-XML into the current format at tools/xsd_xrw/rewrite_rosetta_script.py (this is in the tools toplevel folder, not the main code folder).  The vast majority of classes have complete documentation; when you find one that does not, complain to (doc feedbacks email) and let us know!

###JD3
A new Job Distributor, JD3, is ready for use.  This is mostly invisible to end users, but will allow more complex protocols to be crafted instead of as multi-step and multi-app instructions.  Look forward to cool JD3-enabled apps in future releases.

###support for more PDBs
Although most improvements were in Rosetta3.7, we continue to improve the fraction of unmodified PDBs Rosetta can handle.  (Don't worry - we've always been able to handle canonical protein well - but we are doing an ever-improving job with strange stuff like the GFP fluorophore, chemically concatenated ligands, glycans, RNA, etc).

###Cxx11 builds
Rosetta turned on Cxx11 features in its C++.  This deprecates the compatibility of a lot of older compilers. See <https://www.rosettacommons.org/docs/latest/build_documentation/Cxx11Support> for more information.

###Executable naming
We've tweaked the build system such that the built executables are named a little more simply.  The tripartite names (rosetta_scripts.default.linuxgccrelease) will work as before, but now the two-part names rosetta_scripts.linuxgccrelease) will always point towards the default build, instead of the most recent build.

###beta_nov15
We have a new scorefunction brewing!  It doesn't have its official name yet, but it is [published](https://www.ncbi.nlm.nih.gov/pubmed/27766851).  You can try it out with -beta_nov15 on command line and `<ScoreFunction name="beta_nov15" weights="beta_nov15">` in RosettaScripts in the meantime.  Note that the -beta_nov15 commandline flag is necessary for any use of the new scorefunction, since certain scoring-related objects must be initialized differently (meaning that it is not currently possible to score with talaris2014 _and_ beta_nov15 in the same session of Rosetta.)

###New Ramachandran potentials
Rosetta's Ramachandran scoring code has been greatly refactored.  The software now supports Ramachandran potentials for arbitrary amino acids.  These are lazily loaded, so they do not contribute to Rosetta's memory footprint unless they are needed.  The refactored Ramachandran code is now part of the `rama_prepro` score term in the beta_nov15 scorefunction.  The Ramachandran scoring also now allows different Ramachandran potentials for positions preceding proline residues and for positions that do not precede proline residues.

###New or updated features
####RosettaScripts tools
* [[ScoreTermValueBasedSelector|ResidueSelectors#other_scoretermvaluebased]]
* [[SecondaryStructureFilter]]
* [[LoopLengthChangeMover]]
* [[AddConstraintsToCurrentConformationMover]]
* [[ReturnResidueSubsetSelector|ResidueSelectors]]
* [[ConvertRealToVirtualMover]] Convert residues to _virtual_, which are not scored or output.
* [[ConvertVirtualToRealMover]] Convert virtual residues back to real ones.
* [[CloseContactResidueSelector|ResidueSelectors]]] identifies residues that have (any) atoms within a certain distance cutoff (usually neighbor detection depends on CB for speed)
* [[UnsatSelector|ResidueSelectors]]
* [[NeighborhoodResidueSelector|ResidueSelectors]] uses the neighbor-graph by default to greatly speed-up calculations
* [[BridgeChainsMover]]
* [[MutateResidue|MutateResidueMover]] gains ResidueSelector support
* [[MakePolyXMover]] gains ResidueSelector support
* [[ModifyVariantTypeMover]] gains ResidueSelector support
* [[SecondaryStructureFilter]] gains ResidueSelector support
* [[InterfaceAnalyzerMover]] (bugfix)
* [[Backrub]] now available in RosettaScripts
* [[FilterReportAsPoseExtraScoresMover]]
* [[LoopAnalyzerMover]] (updated with RosettaScripts compatibility) and [[LoopAnalyzerFilter]]
* [[DistanceConstraintGenerator]]
* [[HydrogenBondConstraintGenerator]]
* [[SSPredictionFilter]]/PsiPredInterface compatible with more versions of psipred
* [[HelixPairingFilter]]
* [[Disulfidize|DisulfidizeMover]] updated for noncanonical disulfide-forming moieties
* [[GeneralizedKIC]] gains options for symmetric sampling
* [[GlycanResidueSelector]] Select glycan residues
* [[GlycanPositionSelector]] Select specific glycan residues in trees
* [[RandomGlycanFoliageSelector]] Randomly select glycan foliage for modeling
* The Backrub-ensemble interface ddG protocol has been exposed via RosettaScripts.

####Miscellaneous
* Transform mover in ligand docking (bugfixes)
* JD2 MPIWorkPartitionJobDistributor (the better MPI choice for small MPI runs) splits jobs in a way that's more efficient for restarted runs
* Changes to Dunbrack library binary format caching.  As a consequence, do not install Rosetta 3.8 over an existing installation; you will want this library to be rebuilt on first run.
* mmCIF input and output
* Bugfix for constraint files affecting the numbering of PDB-numbered residues from chain A
* HELIX and SHEET record printing to PDBs (-out::file::output_secondary_structure)
* LINK record printing to PDBS (-out::file::write_pdb_link_records)
* Bugfix for resfiles with ligand docking
* Relax: bugfix to -constrain_relax_to_native_coords
* Code sanitizers and static analysis tools online (helps us write better, more error-proof code - should be invsible to the end-user)
* Updated SQLite backend; version to 3.16.2 from 3.7.4
* bugfixes for various not-specifically-supported compilers (gcc 5.4; gcc 6.2.0, clang 3.9.0, and ICC 14.0)

####Nonprotein chemistries
* The [[simple_cycpep_predict]] application has had various bugfixes, and now supports quasi-symmetric sampling for peptides with cN or cN/m symmetries.
* [[CycpepSymmetryFilter]] Filters based on whether a peptide has a desired cyclic (c2, c3, c4, etc.) or mirror cyclic (c2/m, c4/m, c6/m, etc.) symmetry.
* [[PeptideCyclizeMover]] bugfixes
* Glycans:
 * Updates to [[GlycanRelax]], and new methods for handling connectivity of branched glycans (GlycanTreeSet) - use with PyRosetta: `pose.glycan_tree_set()`

<!--- BEGIN_INTERNAL -->

## _Rosetta 3.7 (internal notes)_

_(This section in italics should remain hidden from the public wiki.)_

_3.7 will be Rosetta 2016.32, http://test.rosettacommons.org/revision?id=108&branch=release, https://github.com/RosettaCommons/main/commit/9005cc64587b4189882337bc87783ab96ead263f.  See also [https://wiki.rosettacommons.org/index.php/3.7_release_notes_workspace]_

### Rosetta 3.7 NOT included in release notes
* _These are items that will be omitted from the release notes as incomplete features, but should be listed once finished for 3.8 or whenever_
* _XML schema_ --> covered in 3.8 release notes
* _JD3_ --> covered in 3.8 release notes

<!--- END_INTERNAL -->

## Rosetta 3.7

### New and updated applications
* [[ERRASER|erraser]] updated: improved support for residues that are not canonical RNA
* [[GlycanRelax]] (see also [[WorkingWithGlycans]]). RosettaCarbohydrates paper [published](https://www.ncbi.nlm.nih.gov/pubmed/27900782)
* The RosettaAntibody protocol has been streamlined and is closer to being a single application instead of a constellation of scripts.  New [paper outlining the functionality](https://www.ncbi.nlm.nih.gov/pubmed/28125104)
    * Support for L4/H4 (DE loop)
    * Support for camelid antibodies
    * identify_cdr_clusters tool
    * packing_angle tool

* [[RosettaScripts]] now supports [[inclusion of script fragments in other scripts|RosettaScripts#options-available-in-the-xml-protocol-file_xml-file-inclusion]]
* [[simple_cycpep_predict]] - design of cyclic peptides
* [[FlexPepDock|flex-pep-dock]] - ligand compatibility
* [[ddg-monomer]] - ligand compatibility
* [[torsional-potential-corrections]], for [Conway P, DiMaio F. Improving hybrid statistical and physical forcefields through local structure enumeration. Protein Sci. 2016 May 30.](http://www.ncbi.nlm.nih.gov/pubmed/27239808)
* [pH_protocol](http://www.ncbi.nlm.nih.gov/pubmed/25501663) (link to paper)

### New features and classes
* A new introductory tutorial system has been added under the demos/tutorial/ directory. These can also be found online at <https://www.rosettacommons.org/demos/latest/>
    * The introductory tutorials cover both basic concepts (packing, minimization, fullatom/centroid) as well as demonstrations on how to use some of the most commonly used Rosetta protocols (ab inito, comparative modeling, loop modeling, design, protein-protein docking and protein-ligand docking).
    * Additional demos are now listed [thematically](https://www.rosettacommons.org/demos/latest/demos-by-category), to assist in locating relevant demos.
* Many new [[ResidueSelectors]]
* PDB reading can handle LINK records in most cases
* "Spell checking" for options: suggestions for the desired option if the user's options are invalid
* [[AACompositionEnergy]] takes fractional compositions in addition to counted-out compositions
* New score term to penalize peptide sequences that form aspartimide
* New script for setting up the [[pyrosetta]] environment, and the release of [PyRosetta-4](http://www.pyrosetta.org/news/pyrosetta-4released)

### Bugfixes

* `loops::restrict_kic_sampling_to_torsion_string` repaired (for [[KIC|next-generation-KIC]] loop modeling)
* [[BridgeChainsMover]] repaired to match publication

## Rosetta 3.6

After releasing Rosetta 3.5 in 2013, Rosetta transitioned to a weekly release system.  Rosetta 3.6 is weekly release v2016.13-dev58602.  We are marking it as 3.6 to meet the needs of users that require numbered releases instead of weeklies.  This large set of release notes collects changes released in weekly releases since their inception.

### New scorefunctions:

Since Rosetta 3.5, the default scorefunction was [updated](rosetta_basics/scoring/Scorefunction-History) two generations, to Talaris2013 and then to Talaris2014 .  
We’ve also updated the default minimizer to [LBGFS](https://en.wikipedia.org/wiki/Limited-memory_BFGS), which is expected to provide better performance on the average problem.

### New applications:
* [Remodel](application_documentation/design/rosettaremodel)
* [PeptiDerive](application_documentation/analysis/PeptiDerive)
* [Antibody suite](application_documentation/antibody/antibody-applications) (includes SnugDock, previously only in legacy Rosetta2)
* New tools for Rosetta comparative modeling ([RosettaCM](application_documentation/structure_prediction/RosettaCM))
* (More) tools for crystallographic refinement using Rosetta and PHENIX
Updates to [DARC](application_documentation/docking/DARC) docking
* Metal interface design:
    * Zinc homodimer design ([http://www.ncbi.nlm.nih.gov/pubmed/22092237](http://www.ncbi.nlm.nih.gov/pubmed/22092237), [http://www.ncbi.nlm.nih.gov/pubmed/22510088](http://www.ncbi.nlm.nih.gov/pubmed/22510088))
* [FARNA](farna-refactor), a refactor of Rosetta’s RNA code
    *  [Mg_modeler](application_documentation/rna/mg-modeler), for including magnesium 2+ ions into structures
* A new [framework](application_documentation/membrane_proteins/RosettaMP-GettingStarted-Overview) and suite of applications for modeling and designing membrane proteins (http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004398)
* Pocket docking (looks for druggable sites) ([make-exemplar](application_documentation/utilities/make-exemplar), [pocket-relax](application_documentation/utilities/pocket-relax), [pocket-suggest-targets](application_documentation/utilities/pocket-suggest-targets) )
* [SEWING](scripting_documentation/RosettaScripts/composite_protocols/sewing/SEWING) (http://www.ncbi.nlm.nih.gov/pubmed/27151863)
* [Simple_cycpep_predict](structure_prediction/simple_cycpep_predict): fragment-free peptide structure prediction for N-to-C cyclic peptides containing arbitrary mixtures of L- and D-amino acids (and glycine).  
* [[Surface-docking]] (Docking to mineral surfaces)
Enzyme specificity re-design (using coupled_moves) ([http://www.ncbi.nlm.nih.gov/pubmed/26397464](http://www.ncbi.nlm.nih.gov/pubmed/26397464))
* Design with Oligooxypiperizines (OOPs), hydrogen bond surrogates (HBS), and peptoid foldamers ([http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0067051](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0067051), [http://pubs.acs.org/doi/abs/10.1021/ja502310r](http://pubs.acs.org/doi/abs/10.1021/ja502310r), [http://pubs.acs.org/doi/abs/10.1021/ja503776z](http://pubs.acs.org/doi/abs/10.1021/ja503776z))


### New tools:
* [[Batch-distances]]
* [Residue_energy_breakdown](application_documentation/analysis/residue-energy-breakdown)
* Reference poses: [store a pose “snapshot”](scripting_documentation/RosettaScripts/Movers/movers_pages/StorePoseSnapshotMover) at a particular point in a protocol, and use the residue numbering in that pose to control behavior of modules at a downstream point, even if the residue numbering has changed (due to loop insertion, etc.).
* [Energy function weight optimization](application_documentation/utilities/opt-e-parallel-doc) (not suggested for end-user use, but if you’re brave…)
* A large number of RosettaScripts Movers, Filters, TaskOperations, etc. added.  These include:
    * [Disulfidize](scripting_documentation/RosettaScripts/Movers/movers_pages/DisulfidizeMover): Add disulfide bonds to a pose, trying all permutations to find best disulfide placement.
    * Perturb by torsion bins ([InitializeByBins](scripting_documentation/RosettaScripts/Movers/movers_pages/InitializeByBinsMover), [PerturbByBins](scripting_documentation/RosettaScripts/Movers/movers_pages/PerturbByBinsMover) movers): Perturb a conformation based on statistical probability of finding residue i in torsion bin B, and residue i+1 in bin B’.
    * [GeneralizedKIC](scripting_documentation/RosettaScripts/composite_protocols/generalized_kic/GeneralizedKIC) mover: general kinematics-based loop closure for arbitrary chains of atoms that can include stretches of canonical or noncanonical backbone, side-chains, ligands, etc.
    * Parametric design tools ([MakeBundle](scripting_documentation/RosettaScripts/Movers/movers_pages/MakeBundleMover), [PerturbBundle](scripting_documentation/RosettaScripts/Movers/movers_pages/PerturbBundleMover), and [BundleGridSampler](scripting_documentation/RosettaScripts/Movers/movers_pages/BundleGridSamplerMover) movers; [BundleReporter](scripting_documentation/RosettaScripts/Filters/filter_pages/BundleReporterFilter) filter): fragment-free sampling of coiled-coil tertiary structures.  Fully generalized for strands or helices made of canonical or noncanonical building-blocks.
    * LayerDesign and LayerSelector: design with different sets of residue types depending on burial and/or secondary structure.  [[LayerDesignOperation|scripting_documentation/RosettaScripts/TaskOperations/taskoperations_pages/LayerDesignOperation]], [[LayerSelector|ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layers]]
* [FeaturesReporter](https://www.rosettacommons.org/docs/latest/scripting_documentation/RosettaScripts/FeaturesReporter/Features-reporter-overview) framework for structural analysis using Rosetta (was in 3.5, but is a more complete system now)


### Miscellaneous new features:
* Rosetta’s Boost version updated from 1.46 - > 1.55
* Internal smart pointer model altered to match C++11, along with other changes looking forward to C++11
* Major updates to MR-Rosetta
* Loop Modeling:
    * Extension of KIC loop modeling to non-canonical backbones (beta amino acids, etc) with GeneralizedKIC (see above).
    * Continued development of next-gen KIC, including compatibility with fragments-based modeling
* Multiple refactorings in the chemistry layers, allowing:
    * Poses with carbohydrates
    * Better support for ribonucleoprotein
    * Support for all ligands in the PDB’s chemical dictionary (note you must [install that dictionary separately](build_documentation/Build-Documentation#setting-up-rosetta-3_obtaining-additional-files_pdb-chemical-components-dictionary))
    * Support for runtime manipulation of chemistry (adding/removing atoms)
    * Support for rotamer libraries with arbitrary numbers of backbone torsion dependencies
    * Automatic setup of bonds to [metal ions](rosetta_basics/non_protein_residues/Metals).  
* Much better support for [D-amino acids](rosetta_basics/non_protein_residues/D-Amino-Acids).  Mirror-image conformations now score identically with the talaris2013 and talaris2014 scoring functions.  D-residues use rotamer and scoring databases for their L-counterparts.
* Support for [mirror-image symmetry operations](rosetta_basics/structural_concepts/symmetry#symmetry-definitions_symmetries-with-mirror-operations) in symmetric poses, with proper conversion between D- and L-amino acid residue types.
* Support for [non-pairwise-decomposable score terms](rosetta_basics/scoring/AACompositionEnergy) during packing
* New non-pairwise-decomposable score term to guide design that penalizes deviations from a desired residue type composition.  
    * New “[sequence constraints](scripting_documentation/RosettaScripts/Movers/movers_pages/AddCompositionConstraintMover)” to control the residue type composition of a sub-region of a structure (e.g. a protein interface) during design.
* New neighbor radii for canonical amino acids
* ResidueSelector hierarchy as a selection syntax
* FloppyTail now compatible with symmetry
* Much better support for noncanonical residue linkages, such as N-to-C cylization, sidechain-backbone linkages, etc.
* Full [Database support](rosetta_basics/file_types/sql/Database-IO) and documentation (SQLITE3, MySQL, etc)

### Performance, usability improvements, bug fixes:
* 10% speed improvement in etable evaluation (faster scoring).  Reduced memory use.
* Automatic backtrace reporting upon crash, for better debugging
* Beautification: yes, we finally have a codebase-wide single style format, enforced by an external beautification script
* Repair of the longstanding “ResidueType explosion” malfeature, reducing memory use dramatically and improving Rosetta boot-up time
* SASA machinery completely overhauled.  Default SASA radii changed to the Reduce set, which include hydrogens by default.  It was previously using a radii set that was never published. SASA Calc settings can be changed through options system.
* New [documentation wiki](Home)


## Rosetta 3.5

Released Sunday, June 2, 2013

* Major updates to relational database support
* Many new Movers, Filters, TaskOperations, etc
* NGK "Next Generation" kinematic loop closure
* Updates to chemically_conjugated_docking apps UBQ_E2_thioester and neighbors (Saha A, Kleiger G, Lewis S, Kuhlman B, Deshaies RJ. Essential role for ubiquitin-ubiquitin-conjugating enzyme interaction in ubiquitin discharge from Cdc34 to substrate. Molecular Cell. In press.)
* LOOP_DEFINITIONS tag Loop specification within RosettaScripts
* OUTPUT tag Rescore-on-output option for RosettaScripts
* ERRASER package for RNA structure correction with or without experimental electron density (NOTE: collaboration with the PHENIX project; requires PHENIX liscenced and installed separately).
* ResourceManager allows for different command-line arguments and other centrally-managed resources with different jobs within one instantiation of Rosetta
* OpenCL support - notice only a very few algorithms feature GPU support; general GPU support is not yet present. previous CUDA support removed
* Updates to the FloppyTail app
* pmut_scan app upgraded to have support for Rosetta++ alter_spec mode - it scans for destabilizing rather than stabilizing mutations (particularly at protein-protein interfaces)
* Linear Memory Interaction Graph now works with symmetric poses
* Enzyme design at protein-protein interfaces
* Supercharge application (Lawrence MS, Phillips KJ, Liu DR. Supercharging proteins can impart unusual resilience. J Am Chem Soc. 2007 Aug 22;129(33):10110-2.)
* 3x1 metal-mediated interface design application (Der BS, Machius M, Miley MJ, Mills JL, Szyperski T, Kuhlman B. Metal-mediated affinity and orientation specificity in a computationally designed protein homodimer. J Am Chem Soc. 2012 Jan 11;134(1):375-85.)
* New demos ERRASER, favor_native_residue, Protocol captures
* Scoring
    * -use_bicubic_interpolation smooths issues with binned knowledge-based
    * phi-psi based terms (including Ramachandran, p_aa_pp, and Dunbrack (2002 only)
    * centroid radii bugfixes
    * New RNA scoring potentials, for use with ERRASER and PHENIX
    * -analytic_etable_evaluation (affects fa_rep, fa_atr, fa_sol, fa_intra_rep) offers a major memory reduction and removes a derivative discontinuity, at the cost of some speed
    * sasapack and avge scores from Rosetta++
    * Dunbrack 2010 (Dun10) library added. Dunbrack 2008 (Dun08) library deprecated and removed. Note that Dun10 is only available to academic users as part of the Rosetta download at this time; Dun10 must be separately liscenced for commercial users (LINKY). Feel free to contact us via the forums for assistance in installing the Dun10 library.
    * lbfgs minimizer - more efficient for minimization with many DOFs, especially Relax
    * cartesian minimizer - allows minimization of 3D coordinates instead of internal torsions, including minimization of bond lengths and angles
    * -bbdep_omega - backbone-dependent omega torsion scoring term
* Tools
    * Python scripts for Rosetta output processing (turning scorefiles into score v. RMSD plots, etc.)
    * pdb2vall package - generates a VALL fragment_picker template database from a specified PDB+chain
    * batch_molfile_to_params.py - used for creating large numbers of ligand paramter files (for virtual screening, etc.), script to load silent files directly into PyMOL.

## Rosetta 3.4

Released Sunday, March 25, 2012

* Point mutant scan application: The purpose of this protocol is to increase the stability of a protein of interest with only single or double point mutants.
* Non canonical amino acid utilities: This feature includes 2 applications:
    1. MakeRotLib - This application creates a noncanonical amino acid rotamer library
    2. UnfoldedStateEnergyCalculator - This application calculates the explicit unfolded state energies.
* RNA assembly with experimental pair-wise constraints: This code is intended to take an RNA sequence and secondary structure and then give three-dimensional de novo models of the helices and inter-helical motifs, and then build up the complete model from these parts.
* RNA 3D structure modeling: Added the applications: rna_cluster, rna_minimize and rna_helix
* RNA loop modeling with stepwise assembly: This method builds single-stranded RNA loops using a deterministic, enumerative sampling method called Stepwise Assembly.
* Remodeling RNA crystallographic models with electron density constraint: This code is used for improving a given RNA crystallographic model and reduce the number of potential errors in the model (which can evaluated by Molprobity), under the constraint of experimental electron density map.
* Chemically conjugated docking : These extensions of the UBQ_E2_thioester protocol allow modeling of chemically conjugated proteins (such as ubiquitin tagged to a target) via isopeptide, thioester, and disulfide linkages.
* RosettaVIP void identification and packing application: This code is intended to take a pdb file with the coordinates for a structural model of a protein with poor hydrophobic packing, and to return a list of mutations that are predicted to fill cavities in the protein core.
* Relax pdb with allatom constraints: hese scripts relax a pdb (minimize rosetta score) while keeping atoms as close as possible to the original positions in the crystal. It is designed to be used to prepare a structure for subsequent design in rosetta.
* Beta strand homodimer design: This code was written for a relatively singular application: finding proteins with surface exposed beta-strands, then trying to make and design a homodimer that will form via that beta-strand.
* DougsDockDesignMinimizeInterface: This protocol was used in the accompanying manuscript to redesign the protein/peptide interface of Calpain and a fragment of its inhibitory peptide calpastatin.

## Rosetta 3.3

Released Wednesday, August 31, 2011

* Includes comprehensive online documentation for users and for developers
* A library based object-oriented software suite
* Easy-to-use applications
* Flexible to incorporate your own protocols
* New Applications - Rosetta Antibody, Interface Analyzer, DDG Monomer, Multistate Design, Sequence Recovery, Fragment Picker, Interface Design, RosettaRNA, Pepspec Application.
* Includes the revolutionary new computer game Foldit in stand-alone version

## Rosetta 3.2.1

Released Friday, March 11, 2011

* New feature in Rosetta - RosettaDNA

## Rosetta 3.2

Released Friday, March 11, 2011

* Includes comprehensive online documentation for users and for developers
* A library based object-oriented software suite
* Easy-to-use applications
* Flexible to incorporate your own protocols
New Applications - Comparative Modeling, Flexible Peptide Docking, Symmetry Docking, RosettaMatch, Molecular Replacement, Boinc Minirosetta, Cluster Application.
* Includes the revolutionary new computer game Foldit in stand-alone version