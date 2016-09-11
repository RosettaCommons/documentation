#Stepwise options classes

# Inheritance Structure
-----------------------
```
 StepWiseBasicOptions      StepWiseMoveSelectorOptions
     |           |          |
     |           v          v
     |          StepWiseMonteCarloOptions
     v
  StepWiseBasicModelerOptions  StepWiseProteinModelerOptions StepWiseRNA_ModelerOptions
     |                _______________|_______________________________|
     |               |
     v               v
  StepWiseModelerOptions
```
<sub>*Yes I know about potential issues with multiple inheritance, but I think they're avoided here, and the alternative solutions requires remembering to copy a huge number of options from class to class.</sub>

### Note on spawning a `StepWiseModelerOptions` from `StepWiseMonteCarloOptions`
------------------------------------------------------------------------
Some default values are different for `StepWiseModelerOptions` when it is created in `StepWiseMonteCarlo` vs. when it is needed for its original enumeration role in stepwise assembly (SWA). To handle this, `StepWiseMonteCarloOptions` can generate the appropriate `StepWiseModelerOptions` through the function `setup_modeler_options()` -- you've got to be a little careful that these are setup correctly.

There are also some options redundant between StepWiseModelerOptions and StepWiseMonteCarloOptions that might be better grouped into a more basic class -- not too hard to do, just have to be careful about it.


# Current Smorgasbord of Options
--------------------------------
This is sloppy, but following is snapshot of command_line options for options_rosetta.py 
**must reformat**
**must annotate**
```
	# step-wise assembly options
	Option_Group( 'stepwise',
		Option( 's1', 'StringVector',desc="input file(s)"),
		Option( 's2', 'StringVector',desc="input file(s)"),
		Option( 'silent1', 'StringVector',desc="input file"),
		Option( 'silent2', 'StringVector',desc="input file"),
		Option( 'tags1', 'StringVector',desc="input tag(s)"),
		Option( 'tags2', 'StringVector',desc="input tag(s)"),
		Option( 'slice_res1', 'IntegerVector',desc='Residues to slice out of starting file',default=[]),
		Option( 'slice_res2', 'IntegerVector',desc='Residues to slice out of starting file',default=[]),
		Option( 'input_res1', 'IntegerVector',desc='Residues already present in starting file',default=[]),
		Option( 'input_res2', 'IntegerVector',desc='Residues already present in starting file2',default=[]),
		Option( 'backbone_only1', 'Boolean', desc="just copy protein backbone DOFS, useful for homology modeling"),
		Option( 'backbone_only2', 'Boolean', desc="just copy protein backbone DOFS, useful for homology modeling"),
		Option( 'fixed_res', 'IntegerVector', desc='Do not move these residues during minimization.', default=[] ),
		Option( 'test_encapsulation', 'Boolean', desc="Test ability StepWiseRNA Modeler to figure out what it needs from just the pose - no JobParameters", default="false" ),
		Option( 'choose_random', 'Boolean', desc="ask swa residue sampler for a random solution", default="false" ),
		Option( 'num_random_samples', 'Integer', desc="In choose_random/monte-carlo mode, number of samples from swa residue sampler before minimizing best", default="20" ),
		Option( 'num_pose_minimize','Integer', desc='optional: set_num_pose_minimize by Minimizer', default='0' ),
		Option( 'atr_rep_screen', 'Boolean', desc='In packing, screen for contacts (but no clash) between partitions before packing',default='true' ),
		Option( 'align_pdb', 'String', desc='PDB to align to. Default will be -native, or no alignment', default='' ),
		Option( 'enumerate', 'Boolean', desc="For SWM. Force enumeration (SWA-like) instead of random", default="false" ),
		Option( 'preminimize', 'Boolean', desc="For SWM. Just prepack and minimize", default="false" ),
		Option( 'dump', 'Boolean', desc="Dump intermediate silent & PDB files",default="false" ),
		Option( 'VERBOSE', 'Boolean', desc= "VERBOSE", default='false' ),
		Option( 'use_green_packer', 'Boolean', desc= "use packer instead of rotamer trials for side-chain packing and O2' optimization", default='false' ),
		Option( 'rmsd_screen', 'Real', desc="keep sampled residues within this rmsd from the native pose",default="0.0" ),
		Option( 'skip_minimize', 'Boolean', desc="Skip minimize, e.g. in prepack step",default="false" ),
		Option( 'sampler_silent_file', 'String', desc='In StepWiseConnectionSampler, where to output all poses that pass filters', default='' ),
    Option( 'superimpose_over_all', 'Boolean', desc='In final superimposition, do not keep any domains fixed, superimpose over everything',default="false" ),
		Option( 'move', 'StringVector', desc="For SWM. Format: 'ADD 5 BOND_TO_PREVIOUS 4'", default=[] ),
		Option( 'min_type', 'String', desc="Minimizer type",default="dfpmin_armijo_nonmonotone" ),
		Option( 'min_tolerance', 'Real', desc="Minimizer tolerance",default="0.000025" ),
    Option( 'vary_polar_hydrogen_geometry', 'Boolean', desc='Optimize hydrogens that form hydrogen bonds', default='false' ),
		Option_Group( 'monte_carlo',
			Option( 'verbose_scores', 'Boolean', desc= "Show all score components", default='false' ),
			Option( 'skip_deletions', 'Boolean', desc= "no delete moves -- just for testing", default='false' ),
#			Option( 'erraser', 'Boolean', desc= "Use KIC sampling", default='true' ),
			Option( 'allow_internal_hinge_moves', 'Boolean', desc= "Allow moves in which internal suites are sampled (hinge-like motions)", default='true' ),
			Option( 'allow_internal_local_moves', 'Boolean', desc= "Allow moves in which internal cutpoints are created to allow ERRASER rebuilds", default='false' ),
			Option( 'allow_skip_bulge', 'Boolean', desc= "Allow moves in which an intervening residue is skipped and the next one is modeled as floating base", default='false' ),
			Option( 'from_scratch_frequency', 'Real', desc= "Allow modeling of 'free' dinucleotides that are not part of input poses", default='0.1' ),
			Option( 'allow_split_off', 'Boolean', desc= "Allow chunks that do not contain fixed domains to split off after nucleating on fixed domains.", default='true' ),
			Option( 'cycles', 'Integer', desc= "Number of Monte Carlo cycles", default='50' ),
			Option( 'temperature', 'Real', desc= "Monte Carlo temperature", default='1.0' ),
			Option( 'add_delete_frequency', 'Real', desc= "Frequency of add/delete vs. resampling", default='0.5' ),
			Option( 'intermolecular_frequency', 'Real', desc= "Frequency of intermolecular (docking) vs. intramolecular folding moves", default='0.2' ),
			Option( 'minimize_single_res_frequency', 'Real', desc= "Frequency with which to minimize the residue that just got rebuilt, instead of all", default='0.0' ),
			Option( 'allow_variable_bond_geometry', 'Boolean', desc= "In 10% of moves, let bond angles & distance change", default='true' ),
			Option( 'switch_focus_frequency', 'Real', desc= "Frequency with which to switch the sub-pose that is being modeled", default='0.5' ),
			Option( 'just_min_after_mutation_frequency', 'Real', desc= "After a mutation, how often to just minimize (without further sampling the mutated residue)", default='0.5' ),
			Option( 'local_redock_only', 'Boolean', desc='In ResampleMover, docking partners can change anywhere across connected chains. Force the new partners to be close to the old ones.', default='true' ),
			Option( 'make_movie', 'Boolean', desc= "create silent files in movie/ with all steps and accepted steps", default='false' ),
		  Option( 'recover_low', 'Boolean', desc="Output lowest energy model in monte carlo, not the last frame", default='true' ),
		  Option( 'save_times', 'Boolean', desc="Save modeling time for each model", default='false' ),
		), # -stepwise:monte_carlo
		Option_Group( 'rna',
			Option( 'sampler_num_pose_kept', 'Integer', desc="set_num_pose_kept by ResidueSampler )", default='108' ),
			Option( 'native_edensity_score_cutoff', 'Real', desc= "native_edensity_score_cutoff", default='-1.0' ), #Fang's electron density code,
			Option( 'o2prime_legacy_mode', 'Boolean', desc="complete virtualization of O2' hydrogen during sampling, and then complete restoration and packing", default='false' ),
#			Option( 'allow_virtual_o2prime', 'Boolean', desc= "allow O2' to be virtualized during packing.", default='false' ),
			Option( 'sampler_perform_phosphate_pack', 'Boolean', desc= "perform terminal phosphate packing inside StepWiseRNA_ResidueSampler", default='true' ),
			Option( 'distinguish_pucker', 'Boolean', desc= "distinguish pucker when cluster:both in sampler and clusterer", default='true' ),
			Option( 'finer_sampling_at_chain_closure', 'Boolean', desc= "Samplerer: finer_sampling_at_chain_closure", default='false' ), #Jun 9, 201,
			Option( 'PBP_clustering_at_chain_closure', 'Boolean', desc= "Samplerer: PBP_clustering_at_chain_closure", default='false' ),
			Option( 'sampler_allow_syn_pyrimidine', 'Boolean', desc="sampler_allow_syn_pyrimidine", default='false' ), #Nov 15, 2010
			Option( 'sampler_extra_chi_rotamer', 'Boolean', desc="Samplerer: extra_syn_chi_rotamer", default='false' ),
			Option( 'sampler_extra_beta_rotamer', 'Boolean', desc="Samplerer: extra_beta_rotamer", default='false' ),
			Option( 'sampler_extra_epsilon_rotamer', 'Boolean', desc="Samplerer: extra_epsilon_rotamer", default='true' ), #Change this to true on April 9, 2011
			Option( 'force_centroid_interaction', 'Boolean', desc="Require base stack or pair even for single residue loop closed (which could also be bulges!)", default='false' ), #for SWM
			Option( 'virtual_sugar_legacy_mode', 'Boolean', desc="In virtual sugar sampling, use legacy protocol to match Parin's original workflow", default='false' ),
			Option( 'erraser', 'Boolean', desc="Use KIC sampling", default='false' ),
			Option( 'centroid_screen', 'Boolean', desc="centroid_screen", default='true' ),
			Option( 'VDW_atr_rep_screen', 'Boolean', desc="classic VDW_atr_rep_screen", default='true' ),
			Option( 'minimize_and_score_native_pose', 'Boolean', desc="minimize_and_score_native_pose ", default='false' ), #Sept 15, 2010
			Option( 'rm_virt_phosphate', 'Boolean', desc="Remove virtual phosphate patches during minimization", default='false' ),
			Option( 'VDW_rep_screen_info', 'StringVector', desc="VDW_rep_screen_info to create VDW_rep_screen_bin ( useful when building loop from large poses )", default=[] ), #Jun 9, 2010
			Option( 'VDW_rep_alignment_RMSD_CUTOFF', 'Real', desc="use with VDW_rep_screen_info", default='0.001' ), #Nov 12, 2010
			Option( 'VDW_rep_delete_matching_res', 'StringVector', desc="delete residues in VDW_rep_pose that exist in the working_pose", default=[] ), #Feb 20, 2011
			Option( 'VDW_rep_screen_physical_pose_clash_dist_cutoff', 'Real', desc="The distance cutoff for VDW_rep_screen_with_physical_pose", default='1.2' ), #March 23, 2011
			Option( 'integration_test', 'Boolean', desc=" integration_test ", default='false' ), #March 16, 2012
			Option( 'allow_bulge_at_chainbreak', 'Boolean', desc="Allow sampler to replace chainbreak res with virtual_rna_variant if it looks have bad fa_atr score.", default='true' ),
			Option( 'parin_favorite_output', 'Boolean', desc=" parin_favorite_output ", default='true' ), #Change to true on Oct 10, 2010
			Option( 'reinitialize_CCD_torsions', 'Boolean', desc="Samplerer: reinitialize_CCD_torsions: Reinitialize_CCD_torsion to zero before every CCD chain closure", default='false' ),
			Option( 'sample_both_sugar_base_rotamer', 'Boolean', desc="Samplerer: Super hacky for SQUARE_RNA", default='false' ),
			Option( 'sampler_include_torsion_value_in_tag', 'Boolean', desc="Samplerer:include_torsion_value_in_tag", default='true' ),
			Option( 'sampler_assert_no_virt_sugar_sampling', 'Boolean', desc="sampler_assert_no_virt_sugar_sampling", default='false' ), #July 28, 2011
			Option( 'sampler_try_sugar_instantiation', 'Boolean', desc="for floating base sampling, try to instantiate sugar if it looks promising", default='false' ), #July 28, 2011
			Option( 'do_not_sample_multiple_virtual_sugar', 'Boolean', desc=" Samplerer: do_not_sample_multiple_virtual_sugar ", default='false' ),
			Option( 'sample_ONLY_multiple_virtual_sugar', 'Boolean', desc=" Samplerer: sample_ONLY_multiple_virtual_sugar ", default='false' ),
			Option( 'allow_base_pair_only_centroid_screen', 'Boolean', desc="allow_base_pair_only_centroid_screen", default='false' ), #This only effect floating base sampling + dinucleotide.. deprecate option
			Option( 'minimizer_rename_tag', 'Boolean', desc="Reorder and rename the tag by the energy_score", default='true' ), #March 15, 2012
			Option( 'minimize_res', 'IntegerVector', desc='alternative to fixed_res', default=[] ),
			Option( 'alignment_res', 'StringVector', desc="align_res_list", default=[] ),
			Option( 'native_alignment_res', 'IntegerVector', desc="optional: native_alignment_res ", default=[] ),
			Option( 'rmsd_res', 'IntegerVector', desc="residues that will be use to calculate rmsd ( for clustering as well as RMSD to native_pdb if specified )", default=[] ),
			Option( 'missing_res', 'IntegerVector', desc='Residues missing in starting pose_1, alternative to input_res',default=[] ),
			Option( 'missing_res2', 'IntegerVector', desc='Residues missing in starting pose_2, alternative to input_res2',default=[] ),
			Option( 'job_queue_ID', 'Integer', desc="swa_rna_sample()/combine_long_loop mode: Specify the tag pair in filter_output_filename to be read in and imported ( start from 0! )", default='0' ),
			Option( 'minimize_and_score_sugar', 'Boolean', desc="minimize and sugar torsion + angle? and include the rna_sugar_close_score_term ", default='true' ),
			Option( 'global_sample_res_list', 'IntegerVector', desc="A list of all the nucleotide to be build/sample over the entire dag.",default=[] ),
			Option( 'filter_output_filename', 'File', desc="CombineLongLoopFilterer: filter_output_filename", default="filter_struct.txt" ),
			Option( 'combine_long_loop_mode', 'Boolean', desc=" Sampler: combine_long_loop_mode ", default="false" ),
			Option( 'combine_helical_silent_file', 'Boolean', desc="CombineLongLoopFilterer: combine_helical_silent_file", default="false" ),
			Option( 'output_extra_RMSDs', 'Boolean', desc="output_extra_RMSDs", default="false" ),
			Option( 'protonated_H1_adenosine_list', 'IntegerVector', desc="optional: protonate_H1_adenosine_list", default=[] ),
			Option( 'native_virtual_res', 'IntegerVector', desc=" optional: native_virtual_res ", default=[] ),
			Option( 'simple_append_map', 'Boolean', desc="simple_append_map", default="false" ),
			Option( 'allow_fixed_res_at_moving_res', 'Boolean', desc="mainly just to get Hermann Duplex modeling to work", default="false" ),
			Option( 'force_user_defined_jumps', 'Boolean', desc="Trust and use user defined jumps", default="false" ),
			Option( 'jump_point_pairs', 'StringVector', desc="optional: extra jump_points specified by the user for setting up the fold_tree ", default=[] ),
			Option( 'add_virt_root', 'Boolean', desc="add_virt_root", default="false" ),
			Option( 'floating_base', 'Boolean', desc=" floating_base ", default="false" ),
			Option( 'floating_base_anchor_res', 'Integer', desc="If we want floating base to be connected via a jump to an anchor res (with no intervening virtual residues), specify the anchor.", default="0" ),
			Option( 'allow_chain_boundary_jump_partner_right_at_fixed_BP', 'Boolean', desc="mainly just to get Hermann nano - square RNA modeling to work", default="false" ),
			Option( 'bulge_res', 'IntegerVector', desc="optional: residues to be turned into a bulge variant", default=[] ),
			Option( 'rebuild_bulge_mode', 'Boolean', desc="rebuild_bulge_mode", default="false" ),
			Option( 'virtual_sugar_keep_base_fixed', 'Boolean', desc="When instantiating virtual sugar, keep base fixed -- do not spend a lot of time to minimize!", default="true" ),
			Option( 'virtual_sugar_do_minimize', 'Boolean', desc="When instantiating virtual sugar, minimize (as in original SWA code) -- takes extra time!", default="true" ),
			Option( 'sampler_max_centroid_distance', 'Real', desc="max centroid distance of moving base to reference in floating base sampler", default='0.0' ), #Nov 12, 2010
			Option( 'filter_user_alignment_res', 'Boolean', desc=" filter_user_alignment_res ", default="true" ),
			Option( 'tether_jump', 'Boolean', desc="In rigid body moves, keep moving residue close to (jump-connected) reference residue  (8.0 A) and force centroid interaction between them", default="true" ),
			Option( 'turn_off_rna_chem_map_during_optimize', 'Boolean', desc="When using rna_chem_map, only score with this after minimizing (takes too long to compute during optimizing).", default="true" ),
		), # -stepwise:rna
		Option_Group( 'protein',
			Option( 'global_optimize', 'Boolean', desc="In clustering, packing, minimizing, use all residues.",default="false" ),
			Option( 'disable_sampling_of_loop_takeoff', 'Boolean', desc="For KIC protein loop closure, disallow sampling of psi at N-terminus and phi at C-terminus takeoff residues",default="false" ),
			Option( 'sample_beta', 'Boolean', desc="sample beta strand pairing -- later need to specify parallel/antiparallel",default="false" ),
			Option( 'ghost_loops', 'Boolean', desc="Virtualize loops in centroid screening",default="false" ),
			Option( 'centroid_screen', 'Boolean', desc="Centroid Screen",default="false" ),
			Option( 'centroid_score_diff_cut', 'Real', desc="If doing -centroid_screen, only keep poses whose energies are within this energy of reference..",default="20.0" ),
			Option( 'centroid_weights', 'String', desc="weights for centroid filter",default="score3.wts" ),
			Option( 'score_diff_cut', 'Real', desc="score difference cut for clustering",default="10.0" ),
			Option( 'filter_native_big_bins', 'Boolean', desc="Figure out various terms for score12",default="false" ),
			Option( 'cluster_by_all_atom_rmsd', 'Boolean', desc="cluster by all atom rmsd",default="false" ),
			Option( 'centroid_output', 'Boolean', desc="output centroid structure during screening",default="false" ),
			Option( 'n_sample', 'Integer', desc="number of samples per torsion angle",default="18" ),
			Option( 'nstruct_centroid', 'Integer', desc="Number of decoys to output from centroid screening",default="0" ),
			Option( 'ccd_close', 'Boolean', desc="Close loops with CCD",default="false" ),
			Option( 'bridge_res', 'IntegerVector', desc="instead of enumerative sampling of backbone torsions, combine silent files that contains pieces of loops", default=[] ),
			Option( 'cart_min', 'Boolean', desc="Use cartesian minimizer",default="false" ),
			Option( 'move_jumps_between_chains', 'Boolean', desc="Move all jumps",default="false" ),
			Option( 'use_packer_instead_of_rotamer_trials', 'Boolean', desc="Use packer instead of rotamer trials in residue sampling",default="false" ),
			Option( 'expand_loop_takeoff', 'Boolean', desc="expand -sample_res loop to include connection to previous/next residues",default="false" ),
			Option( 'skip_coord_constraints', 'Boolean', desc='Skip first stage of minimize with coordinate constraints',default='false' ),
			Option( 'allow_virtual_side_chains', 'Boolean', desc='In packing, allow virtual side chains',default='true' ),
			Option( 'protein_prepack', 'Boolean', desc='In packing, prepack separate partitions',default='true' ),
		), # -stepwise:protein
	), # -stepwise

	################################
	# full_model_info --> may replace stepwise stuff above.
	Option_Group( 'full_model',
		Option( 'cutpoint_open',   'ResidueChainVector',desc='open cutpoints in full model',default=[]),
		Option( 'cutpoint_closed', 'ResidueChainVector',desc='closed cutpoints in full model',default=[]),
		Option( 'other_poses', 'StringVector',desc='list of PDB files containing other poses'),
		Option( 'extra_min_res', 'ResidueChainVector', desc= "specify residues other than those being built that should be minimized", default=[] ),
		Option( 'jump_res', 'ResidueChainVector', desc= "optional: residues for defining jumps -- please supply in pairs", default=[] ),
		Option( 'root_res', 'ResidueChainVector', desc= "optional: desired root res (used in SWM move testing)", default=[] ),
		Option( 'virtual_sugar_res', 'ResidueChainVector', desc= "optional: starting virtual sugars (used in SWM move testing)", default=[] ),
		Option( 'virtual_res', 'ResidueChainVector', desc="optional: residues for defining virtual residues", default=[] ),
		Option( 'sample_res', 'ResidueChainVector', desc="residues to build (for SWA, the first element is the actual sample res while the other are the bulge residues)", default=[] ),
		Option( 'calc_rms_res', 'ResidueChainVector', desc="residues over which to calculate rms for SWA. Not in wide use anymore.", default=[] ),
		Option( 'working_res', 'ResidueChainVector', desc="residues that are being built [by default will be set from sample_res and any input pdbs]", default=[] ),
		Option_Group( 'rna',
			Option( 'terminal_res', 'ResidueChainVector', desc="optional: residues that are not allowed to stack during sampling", default=[] ),
			Option( 'force_syn_chi_res_list', 'ResidueChainVector', desc="optional: sample only syn chi for the res in sampler.", default=[] ),
			Option( 'force_north_sugar_list', 'ResidueChainVector', desc="optional: sample only north sugar for the res in sampler.", default=[] ),
			Option( 'force_south_sugar_list', 'ResidueChainVector', desc="optional: sample only south sugar for the res in sampler.", default=[] ),
		), # -full_model:rna
	), # -full_model

```

---
Go back to [[StepWise Overview|stepwise-classes-overview]].

##See Also

* [[Options overview]]: Overview of options in Rosetta
* [[Stepwise]]: The StepWise MonteCarlo application
* Applications for deterministic stepwise assembly:
  * [[Stepwise assembly for protein loops|swa-protein-main]]
    * [[Additional documentation|swa-protein-long-loop]]
  * [[RNA loop modeling with Stepwise Assembly|swa-rna-loop]]
* [[Structure prediction applications]]: Includes links to these and other applications for loop modeling
* [[RosettaScripts]]: The RosettaScripts home page
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files