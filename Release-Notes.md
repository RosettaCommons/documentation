# Release Notes

<!---BEGIN_INTERNAL-->

## Rosetta 3.14

* Numerous changes have been made to support the [open repository](https://github.com/RosettaCommons/rosetta) for Rosetta.

* The worst9mer filter in RosettaScripts has been renamed to [[Worst9mer]]. 

New tools and apps:
* [[SewAnything]]
* [[rosetta_scripts_jd3]]
* [[atom_energy_breakdown]]
* [[parcs_ccs_calc]]
* [[SID_ERMS_prediction]]
* [[loodo]] -- https://onlinelibrary.wiley.com/doi/10.1002/prot.25445
* [[transform_loodo]] -- https://onlinelibrary.wiley.com/doi/10.1002/prot.25445
* [[cl_complex_rescore]] rescore docked models using covalent labeling data obtained from mass spectrometry 
* [[ligand_discovery_search_protocol]] motifs-based ligand docking
* [[identify_ligand_motifs]] motifs-based ligand discovery
* [[HDXEnergy]] scores how well a pose (pdb) agree with given HDX data 

New Movers, Filters, etc:
* [[JumpForResidue Selector]]
* [[FilterValueMetric]] now accessible from XML
* New score term [[depc_ms]] for diethylpyrocarbonate covalent labeling MS data
* [[ConstraintsMetric]] metric for reporting constraint information
* Added the asymmetric EZ potential from Schramm et al 2012; DOI 10.1016/j.str.2012.03.016. 
* [[TrueFalseFilter]] to enable control-flow of RosettaScripts using script_vars
* [[SequenceMover]] is now RosettaScriptable
* [[CycpepRigidBodyPermutationMover]] to superimpose a cyclic peptide on itself with cyclic permutation
* [[ConfChangeMover]] to sample a variety of conformation changes.
* [[lk_dome]] energy for water interaction
* [[SixDoFGridDockMover]]
* [[ShakeStructureMover]]
* [[DEEROptimizeCoordsMover]]
* [[ProteinMPNNMover]]
* [[SecretionOptimizationMover]] a.k.a. [[Degreaser]]
* [[Chemistry]] objects, which modify ResidueTypes:
    * [[ApplyChemistyMover]] applies a Chemistry to a pose
    * [[PatchChemistry]] apply a PatchOperation
* [[CrankshaftFlipMover]]
* [[LipidMemGrid]] a RosettaLigand scoring grid for docking lipid residues
* [[MixedMonteCarlo]] - a hybrid MonteCarlo method that will take in both low-resolution (centroid) and high-resolution (full-atom) pose
* Expose [[BalancedKicMover]] to RosettaScripts
* [[BFactorSelector]]
* [[EMERALD]] a density-guided ligand docking protocol
* [[PTMPredictionMetric]] a SimpleMetric for predicting 18 different post-translational modifications using ANNs 
* Various metrics and movers for working with machine learning language models [[Working with PerResidueProbabilitiesMetrics]]
    * [[PerResidueEsmProbabilitiesMetric]]
    * [[PseudoPerplexityMetric]]
    * [[ProteinMPNNProbabilitiesMetric]]
    * [[SaveProbabilitiesMetricMover]]
    * [[LoadedProbabilitiesMetric]]
    * [[RestrictAAsFromProbabilities]]
    * [[SampleSequenceFromProbabilities]]
    * [[CurrentProbabilityMetric]]
    * [[AverageProbabilitiesMetric]]
    * [[ProbabilityConservationMetric]]
    * [[BestMutationsFromProbabilitiesMetric]]
    * [[MIFSTProbabilitiesMetric]]	

Performance:

* `-never_rerun_filters` option to avoid final rerun of options with RosettaScripts
* Bin transitions (e.g. for [[GenKIC]]) are laziliy loaded in a threadsafe manner
* Only generate and validate the XML schema once
* Load ScoreFunctions from disk once, lazily and in a threadsafe manner.
* PDB loading was optimized
    * Numerous fixes to speed loading in the default case
    * `-in:obey_ssbond` skips disulfide detection and assumes SSBOND records are correct
    * `-fast_restyping` uses a faster method for assigning residue types which may work for simple cases (e.g. just protein residues)

Updates:
* Additional and improved citations
* Improved error messages
* Updates to the included Chemical Components Dictionary from the wwwPDB
* Performance improvements and generalization to [[Jacobi loop closure]] algorithm
* JumpSelector option added to [[DdgFilter]] and [[ShapeComplementarityFilter]]
* New [[BuriedUnsatisfiedPolarsCalculator]] options, improved error handling
* Numerous updates to [[GALigandDock]]
* Membrane
    * Membrane solvation derivative updates.
    * Add membrane options for cartesian_ddg
    * Add support for additional membrane geometries such as micelles, bicelles, vesicles and double vesicles.
    * Add membrane protein support to ensemble docking protocol
* Glycans
    * Add patch for exocyclic branching from aldofuranoses
    * Add a new scoring column for aglycosylated variants for the glycomutagenesis app
    * Muramic acid (Mur) annotated as O3_LACTYL_SUGAR
    * Add methylated, thiolated & propargyl sugars to database
    * Add glycolylated amino sugars
    * Enable bidirectional glycosicdic linkages
    * Add butyryl acylation patch
* Improvements to mol2genparams.py
    * Add --comment_bonds flag
* Improvements to molfile_to_params_polymer.py
* Update parameters for phenylserine (BB8) 
* Allow residues in PDB input to be split into multiple residues based on database information
* Allow [[RandomizeBBByRamaPrePro]] to be used without a residue selector
* Various updates to [[SapConstraintEnergy]], [[AddSapConstraintMover]], [[AddSapMathConstraintMover]]
* Allow [[helical_bundle_predict]] to take a PsiPred file as an alternative to a helix definition file, for canonical amino acid prediction
* Additional options related to fragment store handling for [[ConnectChainsMover]], [[FixAllLoopsMover]], [[NearNativeLoopCloser]], [[Worst9mer]], [[StructProfileMover]]
* Additional PSSM options for StructProfileMover
* Add -edensity::periodicity option for periodic boundary conditions in density
* Various impovements for [[MultistageRosettaScripts]]
* Add better support for noncanonicals to the [[SimpleThreadingMover]]
* Ensure that the [[energy_based_clustering]] app writes out the filenames or other descriptors of poses that it clusters.
* Added sort_scorefxn option to [[Disulfidize]]
* Added logic option to [[CompoundStatement]] to use instead of subelements.
* Add detect_disulfides option to [[DeleteRegionMover]]
* Add logic option to [[IfMover]]
* [[RandomMover]] now has the option of repeats for each mover
* Add dir option to [[dumpPDB]] mover
* Add residue_selector capability for [[mergePDBmover]]
* Adding new score weights for [[ReplicaDock2.0]] protocol
* Generalize the virtual residue patch 
* Add Thioether lariat structure prediction to [[simple_cycpep_predict]] and [[SimpleCycpepPredictApplication]]
* Add support for other crosslink types to [[CrosslinkerMover]]
* Add "db_file_name" option to [[SampleRotamersFromPDB]]
* Allow [[RDKitMetric]] to take a multiple-residue chain (e.g. cyclic peptide).
* Add a symmetric check for [[MergePDBMover]] when using residue_selectors
* Add support for beta-amino acids in macrocycle structure prediction
* Adjust improper torsion definitions for cart_bonded such that Rosetta can fix mislabeled Q/N H-atoms
* Add in ability to measure disorder directly from structure [[ResidueDisorder]]
* Enable [[NamedAtomPairConstraints]] in constraint file
* Allow [[PARCS]] to read silent files too
* Allow Dunbrack probability cutoffs to be changed on a per-packer run basis
* Update version of RDKit being used.
* Add support for -density_zscores option on [[density_tools]] application
* Add -bbamide flag to [[per_residue_solvent_exposure]] application
* Add -alternative_score_file option to [[energy_based_clustering]] for custom scoring
* Add `metric_to_bfactor` option to [[RunSimpleMetricsMover]] to assign a per residue metric to the Bfactor
* Add `use_pose_name` option to [[DumpPDB]] mover
* Add `delta_metrics` option to [[InterfaceAnalyzerMover]]
* Custom torsions can now be controlled with the [[DihedralConstraintGenerator]]
* Tar file support added for params file reading.
* The franklin2019 scorefunction has been updated according to [Samanta & Gray](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10327106/)
* The integration with [[BCL]] has been updated to use the most recent version of BCL.

Bugfixes:
* Avoid errant 0 return on rmsfitca2() 
* Fix bugs related to use of abs()/std::abs()
* Numerous bugfixes to [[GALigandDock]]
* Fix crash of [[DEEREnergy]] during derivative calculations
* Fix [[map_symmetric_res_pairs]] to work properly with non-cyclic symmetries
* Fix reading silent files with multiple remarks
* Fixed truncation/rounding of values in [[SidechainNeighborCountMetric]]
* Fix error in hbnet if find_only_native_networks does not find networks
* Fix overflow in utility::decode6bit() for binary silent file reading.
* Fixing undefined behavior in FArrays
* Fix bug in [[simple_cycpep_predict]] with terminal disulfide
* Fix handling of IMGT antibody numbering scheme
* Fix segfaults for sincle chain interfaces in [[Interface]], [[InterfaceInfo]], and [[InterchainPotential]]
* Fix spurious error in [[helical_bundle_predict]] when PsiPred predicts a single isolated residue of helix 
* Better handling of virtual residues in [[ReferenceEnergy]], [[BuriedUnsatPenalty]], [[VoidsPenalty]], [[HydroxylTorsionPotential]] and [[RamaPrePro]]
* Generalize the SequenceSymmetricAnnealer to work with noncanonical residues
* Make [[HybridizeProtocol]] constructor more robust to -fix_disulf option settings
* Fix bug in [[TotalEnergyMetric]] that was missing non-pairwise-decomposable terms
* [[NamedDihedralConstraint]] bug fix
* Bug fix and additions to [[GlycanSequonSelector]]
* Better bounds checking in [[NearNativeLoop closure]]
* Fix nullpointer access in [[SeqprofConsensus]]
* Fix the [[PNear]] calculator for cases in which absolute values of energies are large.
* Fix NaN issue when rama_prepro map has 0 for any probability entry
* Fix a bug in multi state design background long-range energy calc
* Fix DEER IO, for epr_deer_score energy term
* Fix an index bound check in [[KeepRegionMover]]
* Fix typo of `oob_mode` setting in [[SliceResidueSelector]]
* Fix a case where [[cartesian_ddg]] did not exit
* Fix a [[simple_cycpep_predict]] bug in cis-trans sampling with lariats
* Make [[SymmetricalResidueSelector]] always output symmetric selections
* Fix the oxygen atom placement in the AcetylatedProteinNtermConnection patch.
* Fixing foldtree vertex error in [[stepwise]]
* Remove possible divide-by-zero in [[CartesianMD]]
* Fix how PDB output calculates residues for SSBOND records.
* Adjust [[Transform]] mover to accumulate best ligand across repeats
* Fix issue with PDB_ROTAMERS and patched polymeric residues
* Make [[DdgFilter]] obey the repack_unbound option

Build System:
* Compilation fixes for newer operating systems and compilers
    * Apple Silicon (M1) Macs are now supported
    * Linux arm64 should now be supported
* Added `extras=pytorch` and `extras=pytorch_gpu` builds for integration of PyTorch-based machine learning models
* Less header inclusion for speeder compile

Other:
* Added [[GlycanDock]] scientific benchmark
* Added [[RosettaNMR]] tests to scientific benchmarks
* Added [[cartesianddG]] for membranes scientific benchmark.
* Updated [[protein_data_bank_diagnostic]] scientific test for expanded PDB

<!---END_INTERNAL-->

## Rosetta 3.13

New tools and apps:
* Scientific benchmarking system rejuvenated (and submitted for publication)
* trRosetta available in C++ Rosetta now.  A TensorFlow build (extras=tensorflow or extras=tensorflow_gpu) supports this.
     * [[trRosetta application|trRosetta]] for one-and-done structure prediction from sequence or multiple sequence alignment.
     * [[trRosettaProtocol mover|trRosettaProtocol]] for structure prediction from sequence or multiple sequence alignment in the context of a larger protocol.  (Accessible to RosettaScripts, PyRosetta, or C++ code.)
     * [[trRosettaConstraintGenerator]] for applying trRosetta constraints based on sequence or multiple sequence alignment in the context of a larger protocol.  (Accessible to RosettaScripts, PyRosetta, or C++ code.)
* Support for new Mac M1 chipset
* RosettaSurf (protein surfaces)
* PyMOL-Rosetta hookup can now be "bounced" off a Gray lab server to allow viewing of Rosetta trajectories when the trajectory source is insufficiently configurable
* epr/deer handling
* NDM-1 peptide macrocycle design scripts (via RosettaScripts subrepo)
* [[helical_bundle_predict|helical-bundle-predict]] -- Fragment-free structure prediction of helical bundle assemblies.  Experimental.
* auto-DRRAFTER
* Major updates to [[Updating-RosettaScripts]] RosettaScripts - in particular APPLY_TO_POSE no longer exists.
* [[CitationManager]] -- A Rosetta module to track which modules were used in a protocol, and to write information to the tracer at the end indicating which papers should be cited.
* Jacobi loop closure protocol and Jacobian analysis modules
* [[restype_converter]]
*  https://crash.rosettacommons.org/ and a user-assistant script meant to report to it (Rosetta cannot report anything on its own)


New Movers, Filters, etc:
* [[ShapeSimilarity]], [[ElectrostaticSimilarity]] (RosettaSurf)
* [[SideChainNeighborCountMetric]]
* [[BuriedUnsatHbonds2]]
* [[RemoveMetalConnectionsMover]]
* [[LogicResidueSelector]]
* [[SapScore]], as a SimpleMetric or score term
* [[SimpleMetricSelector]]
* [[CavityVolumeFilter]]
* [[hrf_dynamics]]
* [[FavorCouplingTensor]]
* SimpleMetric and Filter for internal hbonds in a peptide
* [[FoldTreeFromMotif]]
* [[TargetClashEnergy]]
* [[trRosettaProtocol mover|trRosettaProtocol]] -- Run trRosetta structure prediction inside a larger RosettaScripts, PyRosetta, or C++ protocol.
* [[trRosettaConstraintGenerator]] -- Add trRosetta structural constraints inside a larger RosettaScripts, PyRosetta, or C++ protocol.
* [[PeptideInternalHbondsMetric]] and [[PeptideInternalHbondsFilter]] -- Count or filter based on number of internal hydrogen bonds within a pose, chain, or selection. 
* [[NTerminalAcetyltransferaseMover]]


Database:
* Carbohydrates: lactyl, triose, tetrose, Aldohexofuranosyls, Modified Aldohexofuranoses, to4 / to7 / to9-Neuraminic acid, Ketopentofuranosyls, Quivonose, Ketohexopyranosyls, Aldopentofuranosyls; GLYCAM codes; many other additions to the database
* Centroid params files for AIB, ORN, DAB, and DAP (common noncanonicals)


Updated or bugfixed classes and modules:
* molfile_to_params.py
* [[GALigandDock]], [[GenericBondedPotential]]
* [[RosettaAntibodyDesign]]
 * disulfides
 * Cycle optimization of fullatom stage
 * other fixes
* CitationManager (try the -info flag with RosettaScripts -- for example, "Rosetta/main/source/bin/rosetta_scripts.default.linuxgccrelease -info FastDesign".)
* RosettaScripts:
 * access to the native pose
 * single_random
 * ' in addition to "
 * option to not reload XML per-structure
 * Removal of APPLY_TO_POSE
* most classes now use selector logic through their `selector=` option in a tag.
* SimpleMetrics: more reporting options
 * Can be run directly from PROTOCOLS section of XML
* [[DEEROverlapMethod]]
* [[DsspMover]], [[LayerSelector]] work better with symmetry
* glycomutagenesis: disulfides
* [[LinearPenaltyFunction]]
* Better adherence to lbfgs_armijo_nonmonotone as the default minimizer type across more of Rosetta
* [[SwitchChainOrderMover]]
* Backrub compatible with MoveMap specification
* [[InteractionGraphSummaryMetric]]
* Handling of D-amino acids
* [[SequenceSymmetricAnnealer]]
* [[CrosslinkerMover]] and [[simple_cycpep_predict]]
* Cartesian ddG
* [[SeqprofConsensusOperation]]
* [[AddConstraintsToCurrentConformationMover]]
* Scorefunction stuff
 * [[RamachandranEnergy]]
 * Cartesian minimization with Ramachandran
* [[EPRSpinLabel]]
* [[AlignChainMover]]
* [[FragmentScoreFilter]]
* Memory use in ligand docking improved
* [[AtomicDistanceFilter]]
* RNA
 * [[RNA_BasePairHandler]]
 * idealization mover
 * monomer sampler
 * Ligand flexibility in FARFAR2


* [[MutateResidue]] now stronger than a disulfide
* [[DeclareBond]]
* [[MoverFilterPair]]
* [[TimingProfileMetric]]
* [[HybridizeMover]]
* [[NormalModeRelaxMover]]
* [[DisulfidizeMover]]
* [[approximate_buried_unsat_penalty]]
* [[PeptideStubMover]]
* [[HbondMetric]]
* [[IndexSelector]]
* [[ResidueTypeLinkingConstraint]]
* ATOM and HETATM output handling
* packing performance improvements
* [[ApproximateBuriedUnsatPenalty]]
* [[MinimizationRefiner]]
* [[Multistage RosettaScripts]]
* [[StoredRotamerLibrarySpecification]]
* [[SmartAnnealer]]
* [[BuildingBlockInterface]]
* [[TaskAwareSymmMinMover]]
* [[GlycanTreeModeler]]
* [[FullAtomDisulfideEnergy]]
* [[SelectedResiduesPyMOLMetric]]
* [[RepackWithoutLigand]]
* [[ShuffleFileDistributor]]
* [[HybridizeFoldTreeDynamic]]
* [[FlexPepDock]]
* [[SSElementSelector]]
* [[PeptideStubMover]]
* [[PoseFromSequenceMover]]
* [[SequenceSymmetricAnnealer]]
* [[WaterMediatedHbondMetric]]
* [[FastDesign]]
* [[FastRelax]]

Other:
* No more noncannonical spelling of "noncanonical" 
* Toned down the famous "Inaccurate G!" error message.  It's still bad but now it yells about it less.
* Non-recursive coordinate update algorithm replaces old recursive version.  Useful when multithreading, because stack space for non-primary threads may be limited.  Faster and more efficient in general.
* ResidueTypes have been updated with an eye towards properties for ML
* Several general fixes for DNA
* EnzymaticMovers: Adding parsing of nucleic acid sequences to the EnzymaticMover system


## Rosetta 3.12

New apps:
* [[constel]]
* [[restype_converter]] A simple utility to convert between residue representations
* application for finding the lowest energy hydrophobic thickness
* [[simple_cycpep_predict]] companions:
    * [[count-cycpep-sequences]] for counting unique sequences
    * Fragment-free structure prediction for cyclic peptides


New tools:
* Rosetta produces a ROSETTA_CRASH.log file on errors. RosettaCommons now collects these reports at <https://crash.rosettacommons.org>, and the script source/scripts/python/public/report_crashes.py can be used to automatically send such files.
    * Also improved several termination messages
* More new RelaxScripts - [[MonomerDesign2019]] and friends
* [[SliceResidueSelector]]
* [[AcceptToBestMover]] - replicates the accept_to_best command from inside FastRelax
* [[SequenceSymmetricAnnealer]]
* [[ContactMolecularSurface]]
* [[stepwise]] sampler and infrastructure for general polymers
* [[DumpTrajectoryEnergy]] extended to work with the packer
* [[ResidueType]] split off [[MutableResidueType]] to support chemical modification on the fly

Performance:
* multithreaded packing is available.  Note that you must build in multithreaded mode.

Updates and bugfixes:
* [[FastRelax]]
* [[GreenPacker]]
* [[helical_bundle_predict]] and [[simple_cycpep_predict]]
* Deprecation of APPLY_TO_POSE in RosettaScripts
* [[TryDisulfidePermutations]]
* make_symmdef_file.pl updates for fibers and apolar helical symmetries
* RNA scoring weights
* PDB segmentID tweaks
* scientific tests development
* JD3's MPIJobDistributor
* XML objects converted to have less dependency on Poses at parsing time:
    * use ResidueSelectors internally
    * [[baseEtableEnergy]] get_count_pair_function_trie
* [[InterfaceAnalyzer]]
* [[RMSDMetric]]
* [[StructProfileMover]]
* [[MotifGraft]]
* Fixes to the glycan chirality constraints in cart_bonded.
* remodel disulfide builder
* multiple matcher bugs
* [[MonteCarlo]] better support for mismatching a pose's total score with the score being judged
* [[Residue]] co-orientation logic and other changes to [[MutableResidueType]]
* ResidueAtomTreeCollection
* [[CompoundFilter]]
* ligand docking [[FinalMinimizer]] and [[HighResDocker]]
* [[TCRmodel]]
* [[LoadDensityMapMover]]
* [[HybridizeMover]]
* Ferreted out some integer division bugs, at least one of which affected hydrogen bonding math
* The stored-in-Rosetta copy of the wwPDB components file (users are always welcome to update from the wwPDB directly!)
    * Also updates to make it play more nicely with D amino acids and proper protonation states of ATP (the one in wwPDB is wrong)
* [[beta_nov16]] statistical water protocols
* some python2->3 fixes
* [[ApproximateBuriedUnsat]]
* [[FragmentStore]]
* [[mhc_epitope]]
* PDB reading
* [[RollMover]]
* [[ddG_filter]]
* [[RosettaAntibodyDesign]]
* SnugDock
* [[PDBInfoLabel]]
* [[PhiSelector]]
* After only 10 years of angst, -jd2:delete_old_poses defaults to true
* [[PruneBuriedUnsats]] still does not support symmetry, but it fails politely if you try
* [[VirtualRootMover]]
* [[graftswitchmover]]
* Better mmTF IO support
* [[SasaMetric]] - polar or hydrophobic SASA
* [[ParatopeSiteConstraintMover]]
* [[ParatopeEpitopeSiteConstraintMover]]
* [[NmerRefEnergy]]
* site.settings.release

## Rosetta 3.11

### New applications

* shotgun glycomutagenesis, using the [[GlycosyltransferaseMover]].
* [[TCRmodel]] (T Cell Receptor)
* create_clash-based_repack_shell (Ahem)
* An experimental application to generate mainchain potentials for noncanonicals has been added (called make_mainchain_potential).
* [[ERRASER2]]
* [[MultistageRosettaScripts]]
* Added [[count_cycpep_sequences|count-cycpep-sequences]] application, to compute the number of unique sequences there are for a cyclic peptide with a given symmetry, accounting for cyclic permutations.
* [[cartesian_ddg]]

### Improvements to applications:
* Non-canonical design conventions (in all applications) have been made consistent with canonical design conventions: task operations can only be used to _disable_ residue types, not to _enable_ them.  [[PackerPalettes|PackerPalette]] have been introduced as an interface element to define the default set of residue types with which to design in the absence of any task operation, allowing non-canonical designers to specify an expanded set of building blocks with which to work.
* Support for peptoid macrocycle structure prediction in the [[simple_cycpep_predict]] application.
* [[GALigandDock]]: density scoring
* [[AntibodyModelerProtocol]]: [[LoopModeler]] compatibility
* The [[energy_based_clustering_application]] can now report the number of unique Ramachandran bin strings observed in the clusters produced.
* [[RosettaScripts]]: Output poses are only rescored automatically if the OUTPUT block says to; otherwise the last scoring data is left intact and reported.  Improved behavior in both cases.
* Silent files now work with [[hbnet]] , [[PyRosetta]], and [[SimpleMetrics]]
* FARFAR#
* [[RosettaAntibodyDesign]] nanobody compatibility
* [[mp_domain_assembly]]
* Implemented a [[Rosetta thread manager|RosettaThreadManager]] to facilitate multithreaded protocol development and to avoid thread explosions when nested requests for multithreaded code execution are made.  (Note that this only affects the threaded builds of Rosetta, built with the `extras=cxx11thread` option.)

###New tools and scorefunctions
* [[pHVariantTaskOperation]] for -pH_mode
* [[franklin2019]], for implicit membranes (https://www.biorxiv.org/content/10.1101/630715v1)
* [[TautomerizeAnomerMover]]
* [[EnzymaticMover]] (tools that make PTMs based on local sequence): better grammar for identifying what sequences should be acted upon
 * [[GlycosyltransferaseMover]]
 * There's a kinase
* silent files compatible with [[PDBInfoLabels]]
* [[RingConformerSet]] now allows aromatic ring conformers
* [[GraftSwitchMover]]
* [[mmTF]] support
* The `mhc_epitope` scoreterm, implemented using [[MHCEpitopeEnergy]], allows packer-compatible de-immunization of proteins using ProPred or pre-computed database epitope predictors.  The latter can be generated for IEDB and NetMHCII databases using [[mhc-energy-tools]].  Local de-immunization can be performed with [[AddMHCEpitopeConstraintMover]].  Integration with nmer/NMerSVMEnergy will be implemented in the next release.
* [[NMerSVMEnergy]]
* PDB output now has header sections and options for author cards and further details
 * SEQRES lines in PDB file IO available
* Tools to export [[InteractionGraph]] to external code, so that the packing step can be done with QUANTUM COMPUTERS OH MY GOD IT'S THE FUTURE

* A disulfide optimization mover
* Serialized Poses as a more formal serialization than the silent file
* [[RotamerSetsObjects]] framework
** [[PruneBuriedUnsatsOperation]]

* New [[ResidueSelectors]]
 * [[ResiduePropertySelector]]

* New [[SimpleMetrics]]
 * [[ElectrostaticComplementarityMetric | simple_metric_ElectrostaticComplementarityMetric_type ]]
 * [[ResidueSummaryMetric]]
 * [[InteractionEnergyMetric]]
 * [[PerResidueClashMetric]]
 * [[SequenceRecoveryMetric]]
 * [[PerResidueGlycanLayerMetric| simple_metric_PerResidueGlycanLayerMetric_type]]
 * [[ProtocolSettingsMetric]]

###Improvements/bugfixes to classes:
* [[JD3]] and its ecosystem
* [[RingPlaneFlipMover]]
* [[NubInitioMover]]
* [[CoupledMoves]]: [[RosettaScripts]] compatibility and new features
* [[AtomicContactCount]]
* [[AntibodyDesignMover]]
* [[BuriedUnsatisfiedHBonds]] or [[BuriedUnsatHbondFilter]]
* [[approximate_buried_unsat_penalty]] or [[approximate_buried_unsat_energy]]
* [[SetSecStructEnergies]]
* [[NearNativeLoopClosure]]
* [[StructureProfile]]
* [[ForceDisulfidesMover]]
* [[RandomMutationMover]]
* [[CovalentLabelingEnergy]]
* [[MotifGraft]]
* Bugfix to loading residues from the PDB Chemical Components Database
* [[SimpleMetrics]] work in PyRosetta
* [[ForceDisulfideMover]]
* [[ShapeGrid]]
* The [[RamaPrePro]] energy term received some efficiency tweaks.
* [[InterfaceAnalyzerMover]]
* [[HBnet]]
* [[ReadResfileFromDB]]
* [[ProteinProteinInterfaceUpweighter]]
* [[MathVectors]]
* [[LinearMemoryInteractionGraph]]
* [[GlycanTreeModeler]]
* [[PrimarySequenceNeighborhoodSelector]]
* [[SSPredictionFilter]]
* The [[SequenceMetric]] now has options to allow one-letter (_e.g._ `S`), three-letter (_e.g._ `DSE`), basename (_e.g._ `DSER`), or full name (_e.g._ `DSER:phosphorylation`) output.
* [[BoltzmannRotamerMover]]
* [[CoupledMovesProtocol]]
* [[SnugDock]]
* [[DDGMover]]
* [[DDGFilter]]
* [[RandomTorsionMover]]
* [[xyzStripeHash]]
* [[SugarBBEnergy]]
* Interface hydrogen bonds and salt bridges filter
* [[structure_store]]
* [[SwitchChainOrderMover]]
* [[BackboneMover]] (so venerable)
* [[DisulfideInsertionMover]]
* [[ShapeComplementarityFilter]]
* [[ConservativeDesignOperation]]
* [[SymmetricEnergies]]
* [[SymmetricConformation]]
* [[MinMover]]
* [[MoveMapFactory]]
* [[DensityFitMetric]]
* [[DensityFitSelector]]
* [[PerResidueEnergyMetric]]
* [[TotalEnergyMetric]]
* [[RMSDMetric]]
* [[HolesFilter]]
* [[ReplaceRegionMover]]
* [[InsertPoseIntoPoseMover]]
* [[AtomLevelHBondGraph]]
* [[AtomicDepth]]
* [[ResidueIndexDescription]]
* The [[FastRelax|FastRelaxMover]] and [[FastDesign|FastDesignMovers]] now have a `RelaxScriptManager`, to ensure that relax scripts are read from disk once and once only, on first demand, and in a threadsafe manner.  (The `RelaxScriptManager` has no user-facing interface.)

###Miscellaneous:
* Scientific tests revivification drive
* General improvements to centralize disk use and remove repeat access, especially w/r/t scoring.  This makes Rosetta more usable on ultra-high-processor-count supercomputers without disk hammering when all threads try to grab scorefunction data at once.
* Jack Maguire did some serious profiling to hunt for inner-loop slowdowns and garnered several a-few-percent performance gains.
* Threadsafety improvements, especially for the options system
* Moving towards Python3 everywhere
* The Npro atom type was incorrectly listed as a hydrogen bond donor
* Cadmium has been added to the Rosetta database.
* Added support for linking Rosetta against Tensorflow (`extras=tensorflow` option during compilation) to facilitate development of machine learning-based protocols.
* Considerable refactoring of polycubic interpolation code to fix bugs and permit greater generality.

###General bugfixes:
* We know "Cannot normalize xyzVector of length() zero" is cryptic, it annoys us too.  There has been work to catch and re-throw this error with extra data so we can better track down the cause.  (The best understood cause is 3 colinear atoms, whose incalculable dihedral causes this error).
* Rosetta's error handling and reporting system has matured to print debugging backtraces less aggressively for better understood crashes, and dump them to disk when appropriate instead of to terminal.
* Dunbrack sidechain potentials now properly interpolate well locations as angles (eliminating problems at the -180/180 wraparound point).  This is still polylinear interpolation, but could easily be switched to Catmull-Rom splines in the future.
* Rosetta's option system has been refactored for better thread-safety.
* Bugfixes for N-methyl amino acids.  Support that had been temporarily removed for this modification has now been restored.

## Rosetta 3.10

### New applications
* [[GALigandDock]]

### Scoring function improvements
* [[gen_bonded|Updates-beta-genpot]] - newest results of the Seattle energy function development initiative
* New [[design-centric guidance scoreterms|design-guidance-terms]]:
     * [[hbnet|HBNetEnergy]], to promote hydrogen bond networks during design
     * [[buried_unsatisfied_penalty|BuriedUnsatPenalty]], to promote fully satisfied buried hydrogen bond donors and acceptors during design

### New features
* [[SimpleMetrics]] are coming online to replace the use of no-action Movers and Filters that were used to calculate values
* Huge stability improvements to the PDB and mmCIF readers
* Database directory of [[RelaxScripts]].  The RosettaCON2018 RelaxScript is under consideration as the next default script - it improves design quality and runs faster to boot.
* Protein ensembles in small molecule docking
* [[Splice|SpliceMover]] updates
* [[InterfaceAnalyzerMover]] compatible with ligands and generally more stable
* [[DensityFitResidueSelector|rs_DensityFitResidueSelector_type]]
* [[InterfaceHydrophobicResidueContacts]] filter
* [[RosettaDock|docking-protocol]] gains adaptive conformer selection and motif dock score
* [[SEWING]] refactor and new needles (ok, ok, new sub-applications).  I don't think it's multithreaded yet.
* [[FindGlycanSeqonsMover]]
* The [[simple_cycpep_predict]] application now supports new cyclization chemistries, including side-chain isopeptide bonds (lariats).
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

#### Oligoureas
* Support for oligourea design
* Support for oligourea structure prediction with the [[simple_cycpep_predict]] application

#### Metals
* [[CrosslinkerMover]] can now place octahedral, tetrahedral, square pyramidal, square planar, trigonal planar, and trigonal pyramidal metals.
* Improvements for [[auto_setup_metals|Metals]] - particularly it works with centroid mode, and can be invoked from the new [[SetupMetalsMover]] within RosettaScripts protocols.

### Updates
* Rosetta's core and database modules are now threadsafe, permitting development of multi-threaded protocols.  Rosetta is not broadly multithreaded (some specialty protocols are) and will not be any time soon.
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
* Major refactor of the parametric code underlying the [[MakeBundle|MakeBundleMover]], [[BundleGridSampler|BundleGridSamplerMover]], and [[PerturbBundle|PerturbBundleMover]] movers.

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
* [[simple_cycpep_predict]] application
* [[RotamerSetFactory]]
* [[StrandCurvatureByLevels]]
* [[EnzScoreFilter]]

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
* [[GenKIC|GeneralizedKIC]] bugfixes
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
* [[voids_penalty design-centric guidance term|VoidsPenaltyEnergy]] - nature abhors a vacuum, but Rosetta tends to ignore them.  VoidsPenalty detects underpacked regions in protein cores and favors rotamers to fill those gaps.
* [[netcharge design-centric guidance term|NetChargeEnergy]] - a superclass of the older "supercharge" idea, this score term lets you target a desired net charge for your design.
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