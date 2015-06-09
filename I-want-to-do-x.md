"I want to do _x_. How do I do _x_?"
===========

Typically, users come to an input structure with the notion that they want to perform a particular type of sampling, whether via running an application or using a RosettaScripts mover.
Here, we have categorized Rosetta's major applications and RosettaScripts-enabled movers by the type of structural perturbation they perform.


Structure determination via fragment substitution
-------------
-	AbinitioRelax app
-	AbscriptLoopCloserCM mover  
	handles loop closure in ab initio relax circumstances
-	AbscriptMover mover


, AddChain, AddChainBreak, AddConstraintsToCurrentConformationMover, AddEncounterConstraintMover, AddFoldUnit, AddHydrogens, AddJobPairData, AddMPLigandMover, AddMembraneMover, AddOrRemoveMatchCsts, AddSidechainConstraintsToHotspots, AlignChain, AlignEnds, AnchoredGraftMover, AntibodyDesignMover, AntibodyDesignProtocol, AtomCoordinateCstMover, AtomTree, Auction, BBGaussian, BackboneGridSampler, BackboneSampler, BackboneTorsionPerturbation, BackboneTorsionSampler, Backrub, BackrubDD, BackrubSidechain, BestHotspotCst, BfactorFitting, BluePrintBDR, BoltzmannRotamerMover, BridgeChains, BuildSheet, BundleGridSampler, CAcstGenerator, CCDEndsGraftMover, CCDLoopCloser, CCDLoopClosureMover, CDRDihedralConstraintMover, CartesianMD, CartesianSampler, ChangeAndResetFoldTreeMover, CircularPermutation, ClearConstraintsMover, CloseFold, CoMTrackerCM, CompoundTranslate, ComputeLigandRDF, ConformerSwitchMover, ConnectJumps, ConsensusDesignMover, ConstraintFileCstGenerator, ConstraintPreparer, ConstraintSetMover, ContactMap, ContingentAccept, CoordinateCst, CoupledMover, CreateAngleConstraint, CreateDistanceConstraint, CreateTorsionConstraint, CutOutDomain, DeclareBond, DefineMovableLoops, DeleteChainsMover, DeleteRegionMover, DensityMorphing, DesignMinimizeHbonds, DesignProteinBackboneAroundDNA, DetectSymmetry, DisulfideInsertion, DisulfideMover, Disulfidize, DnaInterfaceMinMover, DnaInterfaceMultiStateDesign, DnaInterfacePacker, DockSetupMover, DockWithHotspotMover, Docking, DockingInitialPerturbation, DockingProtocol, DomainAssembly, Dssp, DumpPdb, DumpStatsSS, Environment, EnzRepackMinimize, EnzdesRemodelMover, ExtendedPoseMover, ExtractAsymmetricPose, ExtractAsymmetricUnit, ExtractSubposeMover, FastDesign, FastRelax, FavorNativeResidue, FavorNonNativeResidue, FavorSequenceProfile, FavorSymmetricSequence, , FindConsensusSequence, FitBfactors, FitSimpleHelix, FlexPepDock, FlipMover, FlxbbDesign, FoldTreeFromLoops, , FragmentCM, FragmentJumpCM, FragmentLoopInserter, FusePosesNtoCMover, GeneralizedKIC, GenericMonteCarlo, GenericSimulatedAnnealer, GenericSymmetricSampler, GreedyOptMutationMover, GridInitMover, GrowLigand, GrowPeptides, HamiltonianExchange, HighResDocker, HotspotDisjointedFoldTree, HotspotHasher, Hybridize, Idealize, IdealizeHelices, InitializeByBins, InsertPoseIntoPoseMover, InsertZincCoordinationRemarkLines, InsertionSiteTestMover, InterfaceAnalyzerMover, InterfaceRecapitulation, InterfaceScoreCalculator, InterlockAroma, InverseRotamersCstGenerator, InvrotTreeCstGenerator, IteratedConvergence, IterativeLoophashLoopInserter, JumpRotamerSidechain, KeepRegionMover, KicMover, LegacyKicSampler, LigandDesign, LoadDensityMap, LoadPDB, LoadVarSolDistSasaCalculatorMover, LoadZnCoordNumHbondCalculatorMover, LocalRelax, LoopBuilder, LoopCM, LoopCreationMover, LoopFinder, LoopHash, LoopHashDiversifier, LoopHashLoopClosureMover, LoopLengthChange, LoopModeler, LoopMoverFromCommandLine, LoopMover_Perturb_CCD, LoopMover_Perturb_KIC, LoopMover_Perturb_QuickCCD, LoopMover_Perturb_QuickCCD_Moves, LoopMover_Refine_Backrub, LoopMover_Refine_CCD, LoopMover_Refine_KIC, LoopMover_SlidingWindow, LoopOver, LoopProtocol, LoopRefineInnerCycleContainer, LoopRelaxMover, LoopRemodel, LoophashLoopInserter, LoopmodelWrapper, MPDockingMover, MPDockingSetupMover, MPFastRelaxMover, MPSymDockMover, MSDMover, MakeBundle, MakeBundleHelix, MakePolyX, MakeStarTopology, MapHotspot, MatDesGreedyOptMutationMover, MatchResiduesMover, MatcherMover, MembranePositionFromTopologyMover, MembraneTopology, MetricRecorder, MetropolisHastings, MinMover, MinPackMover, MinimizationRefiner, MinimizeBackbone, ModifyVariantType, ModulatedMover, MonteCarloRecover, MonteCarloReset, MonteCarloTest, MotifDnaPacker, MotifGraft, MultipleOutputWrapper, MultiplePoseMover, MutateResidue, NcbbDockDesign, NormalModeMinimizer, NtoCCstGenerator, OopCreatorMover, OopDockDesign, OptimizeThreading, PDBReload, PDBTrajectoryRecorder, PSSM2Bfactor, PackRotamersMover, PackRotamersMoverPartGreedy, ParallelTempering, ParatopeEpitopeConstraintMover, ParatopeSiteConstraintMover, ParetoOptMutationMover, ParsedProtocol, PatchdockTransform, PeptideStubMover, PeriodicBoxMover, PerturbBundle, PerturbBundleHelix, PerturbByBins, PerturbChiSidechain, PerturbRotamerSidechain, PlaceOnLoop, PlaceSimultaneously, PlaceStub, PlaceSurfaceProbe, PlacementMinimization, PredesignPerturbMover, Prepack, PrepareForCentroid, PrepareForFullatom, ProteinInterfaceMS, PyMolMover, RBIn, RBOut, RampingMover, RandomConformers, RandomMover, RandomMutation, RandomOmegaFlipMover, RandomTorsionMover, RecomputeDensityMap, RemodelMover, RemoveCsts, RenderGridsToKinemage, RepackMinimize, RepackTrial, RepackingRefiner, RepeatPropagation, ReplaceRegionMover, ReportEffectivePKA, ReportFSC, ReportToDB, ResetBaseline, ResidueTypeConstraintMover, ResidueVicinityCstCreator, RestrictRegion, RigidBodyPerturbNoCenter, RigidBodyTransMover, RigidChunkCM, RingConformationMover, RollMover, RotamerRecoveryMover, RotamerTrialsMinMover, RotamerTrialsMover, RotamerTrialsRefiner, Rotate, Rotates, SaneMinMover, SaveAndRetrieveSidechains, SavePoseMover, ScaleMapIntensities, SchemePlaceMotifs, ScoreMover, ScriptCM, SeedFoldTree, SeedSetupMover, SegmentHybridizer, SeparateDnaFromNonDna, SetAACompositionPotential, SetCrystWeight, SetMembranePositionMover, SetRefinementOptions, SetSecStructEnergies, SetTemperatureFactor, SetTorsion, SetupCoiledCoilFoldTreeMover, SetupForDensityScoring, SetupForSymmetry, SetupHotspotConstraints, SetupHotspotConstraintsLoops, SetupNCS, SetupPoissonBoltzmannPotential, Shear, ShearMinCCDTrial, SheetCstGenerator, ShortBackrubMover, ShoveResidueMover, Sidechain, SidechainMC, SilentTrajectoryRecorder, SimulatedTempering, SingleFragmentMover, SlideTogether, Small, SmallMinCCDTrial, SpinMover, Splice, StapleMover, StartFresh, StartFrom, StoreCombinedStoredTasksMover, StoreCompoundTaskMover, StoreTaskMover, StructPerturberCM, Subroutine, Superimpose, SwapSegment, SwitchChainOrder, SwitchResidueTypeSetMover,, SymDofMover, SymFoldandDockMoveRbJumpMover, SymFoldandDockRbTrialMover, SymFoldandDockSlideTrialMover, , SymPackRotamersMover, , SymmetricAddMembraneMover, Symmetrizer, TagPoseWithRefinementStats, TaskAwareCsts, TaskAwareMinMover, , TempWeightedMetropolisHastings, TopologyBrokerMover, TrajectoryReportToDB, Transform, TransformIntoMembraneMover, Translate, TrialCounterObserver, TryRotamers, Tumble, UnbiasedRigidBodyPerturbNoCenter, UniformRigidBodyCM, UpdateEnzdesHeader, UpdateSolvent, VLB, VirtualRoot, VisualizeEmbeddingMover, VisualizeMembraneMover, WriteLigandMolFile, build_Ala_pose, ddG, load_unbound_rot, profile,

Structure optimization
-------------
-	idealize_jd2 app  
IdealizeMover  
Replace every residue with a version with bond lengths and angles from the database.
Add constraints to maintain original hydrogen bonds.
Then, minimize every side-chain and backbone dihedral (except proline phi) using dfpmin.
-	minimize app
-	FinalMinimizer mover
-	TaskAwareSymMinMover mover  
SymMinMover mover  
minimize with symmetry

Backbone degrees of freedom
-------------
-	backrub app  
A particular form of backbone movement intended to coordinate with maintaining particular side chain positions.

Sidechain degrees of freedom
-------------
-	SetChiMover
-	SymRotamerTrialsMover

Docking
-------------
-	DARC app  
Via a ray casting algorithm particularly fast on GPUs
-	FlexPepDocking app  
Concurrently samples backbone degrees of freedom on the peptide
-	UBQ_E2_thioester app  
UBQ_Gp_CYD-CYD app  
UBQ_Gp_LYX-Cterm app  
Docking given a chemical constraint between the two partners 
-	SymDock app  
SymDockProtocol mover  
Symmetric oligomer docking

Chemical connectivity
-------------
-	ForceDisulfides mover

Design
-------------
-	EnzdesFixBB app
Fixed backbone, intended for enzyme design


Analysis
-------------
InterfaceAnalyzer app



FastGap app
FloppyTail app
FragsToAtomDist app
LoophashFilter app
MSA_design app
MakeRotLib app
PeptideDeriver app
RescorePDDF app
RescoreSAXS app
SymDock app
TestTopologySampler app
UnfoldedStateEnergyCalculator app
VIP_app app
add_membrane app
aln_to_disulf app
analyze_casp9 app
analyze_rtmin_failures app
angle_recovery_stats app
angles app
antibody_H3 app
antibody_designer app
antibody_graft app
antibody_legacy app
antibody_metrics app
assemble_domains_jd2 app
assemble_placed_fragments app
b3a_distro_kinemage app
backrub app
backrub_pilot app
batch_distances app
batchrelax app
bb_cluster app
beta_peptide_modeling app
bou-min-ubo-nrg-jump app
build_a3b app
buried_polar_finder app
ca_to_allatom app
cal_nonoverlap_scores app
cal_overlap_scores app
calibrate_pdb_via_sidechain_optimization app
cenrot_jd2 app
cloud_app app
cluster app
cluster_alns app
cluster_hotspot_docking app
cnl_env_lost_hbs app
combine_silent app
compute_Irmsd app
constel app
contactMap app
convert_to_centroid app
coupled_moves app
create_clash-based_repack_shell app
crossaln app
cryst_design app
cs_rosetta_rna app
cst_quality app
cstmin app
david_align_and_recompute_score_and_rmsd app
david_align_append_and_recompute_score_and_rmsd app
david_fill_gaps app
david_find_best_contact_pocket app
david_find_best_pocket app
david_find_complex_contacts app
david_find_contacts app
david_find_exemplar app
david_find_pocket_exemplar app
david_find_pocket_stabilizing_mutations app
david_find_surface_residues app
david_open_pocket app
david_pocket2PDB app
david_pocket_align_and_save app
david_pocket_compare app
david_recompute_score_and_rmsd app
david_rotation_experiment app
ddg_benchmark app
ddg_monomer app
debug_labontes_current_work app
decoy_features app
density_tools app
design_contrast_and_statistic app
design_tight_clusters app
detect_tight_clusters app
distances app
dna_motifs_collector app
dna_test app
dock_glycans app
docking_prepack_protocol app
docking_protocol app
domain_assembly_jd2 app
doug_dock_design_min_mod2_cal_cal app
ensemble_analysis app
ensemble_generator_score12_sidechain_ver2 app
enzyme_design app
erraser_minimizer app
evalFullLength app
exposed_strand_finder app
extended_chain app
extract_CA_coords app
extract_atomtree_diffs app
extract_atomtree_diffs_jd1 app
extract_motifs app
extract_pdbs app
fast_clustering app
feature_schema_generator app
features_database_schema app
find_buns app
fit_helixparams app
fix_alignment_to_match_pdb app
fixbb app
foldptn app
format_converter app
fragment_picker app
fragment_rmsd app
fragmentpicker_integration_demo app
full_length_model app
gen_apo_grids app
gen_lig_grids app
gen_rna_pharmacophore app
generate_ligand_start_position_file app
generate_matcher_constraints app
get_dihedral_b3aa app
get_pharmacophore_without_bound_rna app
get_rna_pharmacophore app
get_rna_pharmacophore_with_water app
get_rna_ring_sasa app
hbonds_test app
hbs_creator app
hbs_design app
hbs_dock_design app
hierarchical_clustering app
holes app
holes_daball_input app
homodimer_design app
homodimer_maker app
hotspot_hash app
hotspot_stub_constraint_test app
hshash_utils app
idealize_jd2 app
identify_cdr_clusters app
ig_dump app
incorporate_motifs app
interface_statistics app
inv_kin_lig_loop_design app
jcluster app
jd2test app
jdock app
jrelax app
jscore app
karen_compare_different_proteins app
karen_compare_pocket_rmsd app
karen_pocket_compare app
karen_pocket_save app
ld_converter app
lig_low_sasa app
lig_polar_sat app
ligand_dock app
ligand_dock_jd1 app
ligand_rpkmin app
ligand_rpkmin_jd1 app
ligands_to_database app
list_cnl_ngbs app
load_membrane_pose app
loophash app
loophash_createdb app
loophash_createfiltereddb app
loopmodel app
loops_from_density app
lowresdock_patchdock_hotspot_cst app
make_blueprint app
make_exemplar app
make_ray_files app
match app
measure_catalytic_geometry app
medal app
medal_exchange app
membrane_abinitio2 app
membrane_relax app
membrane_symdocking app
mg_pdbstats app
mg_test app
mike_linker_test app
min_pack_min app
min_test app
minimize app
minimize_ppi app
minimize_with_cst app
minirosetta app
minirosetta_graphics app
mm_params app
mmt_msd app
motif_dna_packer_design app
motif_loop_build app
mp_find_interface app
mp_mutate_relax app
mp_quick_relax app
mp_relax_partners_separately app
mp_rsd_energies app
mpdocking app
mpdocking_setup app
mpfolding app
mpframework_test app
mpframework_test1 app
mpi_msd app
mpi_refinement app
mr_protocols app
multidomain_switch app
multistate_idea app
nrg_res_set app
nucleobase_sample_around app
number_of_residuetypes app
oop_conformations app
oop_creator app
oop_design app
oop_dock_design app
optE_parallel app
outputAbego app
outputSasa app
pH_protocol app
packstat app
params_tester app
partial_thread app
pdb_gen_cryst app
pdb_to_map app
pepspec app
pepspec_anchor_dock app
peptoid_design app
per_residue_energies app
per_residue_features app
performance_benchmark app
pilot app
place_fragments_into_density app
pmut_scan_parallel app
pocket_measure app
pocket_relax app
pocket_suggest_target_residues_by_ddg app
r_broker app
r_cst_tool app
r_dock_tempered app
r_frag_quality app
r_noe_assign app
r_pdb2top app
r_play_with_etables app
r_rmsf app
r_score_rdc app
r_tempered_sidechains app
r_trjconv app
ragul_calculate_ligand_rmsd app
ragul_darc_minimize app
ragul_find_all_hbonds app
ragul_get_connolly_surface app
ragul_get_ligand_hbonds app
ragul_get_ligand_sasa app
ragul_get_molecular_surface app
ragul_rosetta_dump_pdb app
rama app
recces_turner app
relax app
remodel app
report_hbonds_for_plugin app
residue_energy_breakdown app
revert_design_to_native app
rna_cluster app
rna_database app
rna_denovo app
rna_design app
rna_extract app
rna_features app
rna_graft app
rna_helix app
rna_minimize app
rna_predict_chem_map app
rna_score app
rna_suitename app
rna_test app
rna_thread app
roc_optimizer app
rosettaDNA app
rosetta_scripts app
rotamer_recovery app
sarah_get_pharmacophores app
sasa_interface app
sc app
scaffold_matcher app
score app
score_aln app
score_aln2 app
score_hotspot_cst app
score_jd2 app
score_nonlocal_frags app
score_protein_ligand_interactions app
screen_phosphates app
sec_struct_finder app
sel_hbonds app
select_best_unique_ligand_poses app
select_best_unique_ligand_poses_jd1 app
sequence_recovery app
sequence_tolerance app
shobuns app
silent2frag app
simple_dna_regression_test app
snugdock app
spanfile_from_pdb app
star_abinitio app
stepwise app
strand_pairings app
super_aln app
supercharge app
superdev app
surface_docking app
swa_protein_main app
swa_rna_main app
swa_rna_util app
sweep_respair_energies app
sym_multicomp_test app
template_features app
test app
test1 app
test_C-terminal_conjugation app
test_CCD_loop_closure app
test_CarbohydrateInfo app
test_ResidueProperties app
test_RingConformationMover app
test_bbmc app
test_carbohydrate_scoring app
test_sugar_torsion_getters_and_setters app
test_surf_vol app
tmalign_cluster app
torsional_potential_corrections app
transform_into_membrane app
validate_database app
validate_silent app
version_mpscorefxn app
version_scorefunction app
view_membrane_protein app
vip app
zinc2_homodimer_design app
zinc2_homodimer_setup app
zinc_heterodimer_design app
zn_match_symmdock app
