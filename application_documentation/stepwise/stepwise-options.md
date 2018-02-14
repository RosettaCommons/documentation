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
<sub>\*Yes I know about potential issues with multiple inheritance, but I think they're avoided here, and the alternative solutions requires remembering to copy a huge number of options from class to class.</sub>

### Note on spawning a `StepWiseModelerOptions` from `StepWiseMonteCarloOptions`
------------------------------------------------------------------------
Some default values are different for `StepWiseModelerOptions` when it is created in `StepWiseMonteCarlo` vs. when it is needed for its original enumeration role in stepwise assembly (SWA). To handle this, `StepWiseMonteCarloOptions` can generate the appropriate `StepWiseModelerOptions` through the function `setup_modeler_options()` -- you've got to be a little careful that these are setup correctly.

There are also some options redundant between StepWiseModelerOptions and StepWiseMonteCarloOptions that might be better grouped into a more basic class -- not too hard to do, just have to be careful about it.


# Current Smorgasbord of Options
--------------------------------
The following is just a subset of the options that are technically *available* to your use; this list has been curated based on what has been well-validated. Some options that mostly played a role with legacy code or extra debugging output have also been omitted.

  * `-stepwise:` options
    * `-stepwise:fixed_res` -- A selection of residues, provided as integers, that must not be allowed to move during minimization
    * `-stepwise:num_random_samples` -- How many random samples should be taken forward to minimization from the StepwiseSampleAndScreen process? Default is 20.
    * `-stepwise:max_tries_multiplier_for_ccd` -- By what factor should stepwise multiply the above option value for moves requiring CCD loop closure (i.e., proteins)? Default is 10.
    * `-stepwise:atr_rep_screen` -- Do we want to screen generated conformations to ensure that distinct partitions (for example, starting residues vs. those being built) have some minimal amount of good attractive interactions but no clashes? Default true.
    * `-stepwise:atr_rep_screen_for_docking` -- The same as atr_rep_screen, but only applies to docking moves
    * `-stepwise:align_pdb` -- A structure that typically contains a subset of the native structure, to which to constrain the modeling problem (using coordinate constraints on each atom, leaving un-penalized any distance up to `-rmsd_screen`) 
    * `-stepwise:new_align_pdb` -- Similar to the above, but the penalty is based on the all-atom RMSD to the `-new_align_pdb` structure, resulting in a penalty that grows much more gently and naturally. Use with `-set_weights alignment 1.0` to turn on the scoring term that enforces this constraint.
    * `-stepwise:enumerate` -- Force enumeration on every move instead of the selection of `-stepwise:num_random_samples` random samples (default false).
    * `-stepwise:preminimize` -- Only performn the premininimization stage (intended as a quick check; default false)
    * `-stepwise:skip_preminimize` -- Totally skip preminimization (default false) but otherwise proceed through the simulation as normal
    * `-stepwise:minimize_waters` -- In the stepwise mode that explicitly models and hydrates any magnesium ions present, pre-minimizes the waters (default false)
    * `-stepwise:test_all_moves` -- Quickly test all possible moves coming from the starting pose, recursing through additions (default false)
    * `-stepwise:use_green_packer` -- By default stepwise uses 'rotamer trials' to pack sidechains or O2' hydrogens; with this flag true, it will use a packer
    * `-stepwise:rmsd_screen` -- In the presence of `-align_pdb`, `-new_align_pdb`, or `-native`, this option controls the tightness (in Angstroms) of either all-atom coordinate constraints or a direct evaluation of a penalty function on the RMSD.
    * `-stepwise:skip_minimize` -- Skips initialminimization, but still prepacks (default false)
    * `-stepwise:superimpose_over_all` -- Superimposes over all residues (all input plus all built residues); default true
    * `-stepwise:alignment_anchor_res` -- If you pass `-superimpose_over_all false`, you should supply this option: a residue (as chain:resnum) that defines an input domain over which superposition should happen.
    * `-stepwise:move` -- A single move to execute in Stepwise Monte Carlo. Format is like 'ADD A:5 BOND_TO_PREVIOUS A:4'
    * `-stepwise:output_minimized_pose_list` -- Output all minimized poses after each move. Default to true in stepwise assembly legacy code, but false for SWM.
    * `-stepwise:virtualize_free_moieties_in_native` -- Virtualize any groups in the native pose that aren't making any detectable contacts. This omits them from RMSD calculations.
    * `-stepwise:lores` -- Instead of minimizing after every move, do fragment insertion moves with the coarse-grained energy function. Also adds a bunch of base pairs as submotifs to the SubMotifLibrary. Default false.
    * `-stepwise:definitely_virtualize` -- Specified by integer seqpos, particular residues from the native that should be virtualized *even if* they are making contacts. (This helps sometimes to compare slightly dissimilar stepwise runs.)

  * `stepwise:monte_carlo:` options
    * `-stepwise:monte_carlo:cycles` -- Number of Monte Carlo cycles to conduct (default 50). 'Production' runs should probably use 200-2000 depending on problem difficulty. Very large problems may require 5-10000.
    * `-stepwise:monte_carlo:temperature` -- Temperature of Monte Carlo simulation (default 1.0).
    * `-stepwise:monte_carlo:skip_deletions` -- For testing, skip any delete moves (default false)
    * `-stepwise:monte_carlo:allow_internal_hinge_moves` -- Allow moves where internal residues are sampled freely, causing a hinge like motion in an entire chain (default true).
    * `-stepwise:monte_carlo:allow_internal_local_moves` -- Allow internal moves where residues are sampled then closed with KIC (default true).
    * `-stepwise:monte_carlo:allow_skip_bulge` -- Allow moves that skip possibly 'bulged residues' instead modeling the subsequent residue as being connected by a jump (default false).
    * `-stepwise:monte_carlo:skip_bulge_frequency` -- The rate at which 'skip bulge' moves are proposed, as a fraction of 'normal' add moves (default 0.0)
    * `-stepwise:monte_carlo:from_scratch_frequency` -- Allows modeling of 'free' dinucleotides, thereby creating a new 'other_pose' (default 0.1).
    * `-stepwise:monte_carlo:allow_split_off` -- Allow the separation of chunks of instantiated RNA into a new 'other_pose' (default true).
    * `-stepwise:monte_carlo:add_proposal_density_factor` -- Increase/decrease the proposal_density_ratio for add moves by this factor (default 1.0).
    * `-stepwise:monte_carlo:add_delete_frequency` -- Controls the relative frequency of add/delete moves versus resample moves (default 0.5).
    * `-stepwise:monte_carlo:docking_frequency` -- The frequency of moves to dock different domains versus sample folding (intramolecular) degrees of freedom (default 0.2)
    * `-stepwise:monte_carlo:submotif_frequency` -- The frequency to add a 'submotif', which is essentially a pre-made ideal segment of RNA whose addition can be detected from sequence alone, e.g., a UA_handle (default 0.2).
    * `-stepwise:monte_carlo:allow_submotif_split` -- Allow submotifs to be split (so, for example, one residue can be deleted with the other remaining). This breaks detailed balance (default false).
    * `-stepwise:monte_carlo:force_submotif_without_intervening_bulge` -- Only add submotifs if both ends can be chain-connected immediately (one attachment; one closed cutpoint); do not permit a bulge to follow one residue (default false).
    * `-stepwise:monte_carlo:use_first_jump_for_submotif` -- Stepwise `-lores` reads in a bunch of jumps for the `SubMotifLibrary`; this flag ensures that only the first conformation for every base pair can be selected. Helps get more submotif moves for base pairs that are slightly less common (default false).
    * `-stepwise:monte_carlo:exclude_submotifs` -- Exclude specific submotifs from the list in `database/sampling/rna/submotif/submotifs.txt`; useful if you want to do a retrospective modeling challenge where you want to use submotifs, but nothing taken from the PDB you're modeling
    * `-stepwise:monte_carlo:minimize_single_res_frequency` -- Frequency to minimize only the added residue rather than all minimization-active residues (default 0.0).
    * `-stepwise:monte_carlo:allow_variable_bond_geometry` -- Allow bond angles and distances to change in 10% of moves (default true, but only available through legacy minimizer).
    * `-stepwise:monte_carlo:switch_focus_frequency` -- Frequency at which we change which input chunk of RNA is being actively modeled (default 0.5)
    * `-stepwise:monte_carlo:just_min_after_mutation_frequency` -- For mutation moves, how frequently should dof sampling be skipped (default 0.5)
    * `-stepwise:monte_carlo:local_redock_only` -- The ResampleMover can change which residues, between two docked chains, are assigned as the jump partners. This flag (default true) ensures that the new residues have to be within 8.0A of the old ones.
    * `-stepwise:monte_carlo:make_movie` -- Output the trial and accepted state for every cycle of Monte Carlo into 'movie' output files (default false).
    * `-stepwise:monte_carlo:recover_low` -- Output the lowest energy model sampled, rather than the last frame (default true).
    * `-stepwise:monte_carlo:use_precomputed_library` -- Makes FROM_SCRATCH moves sample dinucleotide conformations from a library on disk rather than explicitly (default true).
    * `-stepwise:monte_carlo:vary_loop_length_frequency` -- So, if you have a stretch of M 'n's in your fasta file (that is, you're doing design on M residues), in theory maybe you are okay with *up to* M residues for that loop. `-vary_loop_length_frequency allows these loops to shorten (default 0.0).
    * `-stepwise:monte_carlo:designing_with_noncanonicals` -- If 'n' can mean more than just four nucleotides, we need to work through a very different code-path, so this possibility has to be specified (there is a hardcoded possible universe of noncanonicals to work with). This needs work; ideally, we would just use resfile language here.
    * `-stepwise:monte_carlo:checkpointing_frequency` -- Controls how often to output `.checkpoint` files. The default (every 100 cycles) is probably fine.
    * `-stepwise:monte_carlo:full_model_constraints` -- Constraints that only make sense in the context of the full model pose. These constraints are read in by the `StepWiseModeler` every cycle and applied if and only if the residue 'already exists'.
    * `-stepwise:monte_carlo:csa:` options (these control the special Conformational Space Annealing job distributor and don't do anything unless it is active)
      * `-stepwise:monte_carlo:csa:csa_bank_size` -- Providing this flag activates the CSA job distributor, and instructs it to keep a 'bank' of this many models (default 0).
      * `-stepwise:monte_carlo:csa:csa_rmsd` -- RMSD cutoff below which two `Pose`s are considered 'the same' (thereby keeping only the lower energy example in the bank) (default 1.0).
      * `-stepwise:monte_carlo:csa:csa_output_rounds` -- Output silent files at intermediate stages (all the integral multiples of the `-csa_bank_size`) (default false). 
      * `-stepwise:monte_carlo:csa:annealing` -- Actually do RMSD annealing, per the original concept of CSA, rather than obeying the fixed `csa_rmsd`. The original papers suggested using 10 rounds to move from half the average distance between the models that filled the first bank to one-fifth of that distance (default false).
            
  * `stepwise:polar_hydrogens:` options
    * `stepwise:polar_hydrogens:vary_polar_hydrogen_geometry` -- Optimize the bond geometry of any hydrogens forming hydrogen bonds (default false).
    * `stepwise:polar_hydrogens:bond_angle_sd_polar_hydrogen` -- If the above is true, what should be the constraint minimum for the hydrogen bond angle? (default 60.0).
    * `stepwise:polar_hydrogens:bond_torsion_sd_polar_hydrogen` -- If the above is true, what should be the constraint minimum for the hydrogen bond torsion? (default 30.0).
    * `stepwise:polar_hydrogens:fix_lengths` -- Don't let bond lengths move at all (default false).
    * `stepwise:polar_hydrogens:fix_angles` -- Don't let bond angles move at all (default false).
    * `stepwise:polar_hydrogens:fix_torsions` -- Don't let bond torsions move at all (default false).
    * `stepwise:polar_hydrogens:disallow_pack_polar_hydrogens` -- Don't initially pack polar hydrogens before minimizing (default false).
    * `stepwise:polar_hydrogens:disallow_vary_geometry_proton_chi` -- Omit the 2'-OH from the above considerations (default false), i.e., just do base polar hydrogens.

  * `stepwise:protein:` options
    * `-stepwise:protein:global_optimize` -- Always cluster/pack/minimize over all residues (default false).
    * `-stepwise:protein:disable_sampling_of_loop_takeoff` -- Do'nt sample psi of the N-terminal residue or phi of the C-terminal residue relative to a loop of moving residues.
    * `-stepwise:protein:n_sample` -- Number of samples on every backbone torsion angle (default 18). Because RESAMPLE moves can affect multiple residues, setting this much higher than 36 becomes explosively slow.
    * `-stepwise:protein:cart_min` -- Use the cartesian minimizer (it's recommended to have `-set_weights cart_bonded 1.0 ring_close 0.0 pro_close 0.0` on your command line for your scoring function if you do this)
    * `-stepwise:protein:use_packer_instead_of_rotamer_trials` -- Much as `-use_green_packer` for RNA, this flag ensures that sidechains are packed using a proper packer algorithm rather than rotamer trials (default false)
    * `-stepwise:protein:expand_loop_takeoff` -- Also sample an additional pair of residues on each side of the loop.
    * `-stepwise:protein:allow_virtual_side_chains` -- On proteins, SWM allows the virtualization of side chains, since these artificial loop problems often lead to highly penalized exposed residues. Bad per-residue scores makes it hard to get residues added with reasonable reference energies. Letting side chains be virtual when they're not making any contacts helps this a lot (default true). 

  * `full_model:` options (generally have to do with designation of specific residues from the "full modeling problem" to have special behaviors; specify all residues for these cases as chain:resnum)
    * `-full_model:global_seq_file` -- A fasta-formatted file with the 'global sequence.' Essentially, the full target modeling problem may nonetheless be a subset extracted from a larger RNA structure like a whole ribosome, for speed. But if you want to calculate the secondary structure partition function you want to use the whole, monomeric RNA. This lets you do that.
    * `-full_model:cutpoint_open` -- Residues that, even once the model will be finished, will be *open* cutpoints. For example, all chain endings have this trait by defailt.
    * `-full_model:cutpoint_closed` -- Residues that, even once the model will be finished, will be *closed* cutpoints. Places where numbering jumps because a loop has been closed with a shorter length than before might have this property.
    * `-full_model:cyclize` -- Pairs of residues: the first is a 3' terminus of one chain, and the second is the 5' terminus of that same chain. They are given closed cutpoint variants and scored by the chainbreak scoring terms.
    * `-full_model:twoprime` -- Pairs of residues: the first is any residue with a free 2' OH, and the second is the 5' terminus of some chain. They are given closed cutpoint variants (well, essentially) and scored by a scoring term analagous to chainbreak. 
    * `-full_model:fiveprime_cap` -- Residues that need to have a 5' cap applied with a corresponding 7-methyl guanosine.
    * `-full_model:jump_res` -- Explicit residue specification of good places for jumps (rigid body offsets)
    * `-full_model:disulfide_res` -- Explicit residue specification of where disulfides might need to form during the course of simulation (useful for protein and peptide modeling problems).
    * `-full_model:extra_min_res` -- Residues (other than those that are being built) that should be reminimized every cycle.
    * `-full_model:extra_min_jump_res` -- Jumps (specified by their residue termini) that should be reminimized every cycle.
    * `-full_model:root_res` -- Specify a preferred root for your modeling problem (testing only).
    * `-full_model:sample_res` -- Specify residues that must be sampled. Useful when you are providing a starting structure with residues you would nonetheless like to see deleted and resampled.
    * `-full_model:calc_rms_res` -- The residues over which RMSD should be calculated. Not in wide use outside of SWA; which usually overrides this with its own impression of what's reasonable (depending on the situation, it's "all moving residues" or based on `-superimpose_over_all`)
    * `-full_model:working_res` -- All residues that are going to be built. By default, this is all input PDBs plus all sample_res (which would include everything listed in the fasta file, too).
    * `-full_model:motif_mode` -- Ensures for fixed residue problems that the closing base pair of every helix is `-extra_minimize_res` and that stacking is disabled for any terminal residues. Defaults to false, but passing this flag is a good starting point for a 'trial run'; you may then want to refine your own personalized selection of `-extra_minimize_res`, `-terminal_res`, and `-block_stack_*_res`.
    * `-full_model:allow_jump_in_numbering` -- Doesn't assume a cutpoint in cases where residue numbers are nonconsecutive; particularly useful for design scenarios (default false).
    * `-full_model:rna:` options
    * `-full_model:rna:terminal_res` -- Residues that cannot stack during sampling, in either direction
    * `-full_model:rna:block_stack_above_res` -- Residues to which special 'repulsive-only' atoms are added to prevent stacking 'above' the base. The 3'-most residue of a helix that does not make a coaxial stack could have this variant.
    * `-full_model:rna:block_stack_below_res` -- Residues to which special 'repulsive-only' atoms are added to prevent stacking 'below' the base. The 5'-most residue of a helix that does not make a coaxial stack could have this variant.
    * `-full_model:rna:force_syn_chi_res_list` -- Residues whose chi1 (the glycosidic torsion) must be 'syn'. Anti samples are just omitted by the sampler.
    * `-full_model:rna:force_anti_chi_res_list` -- Residues whose chi1 (the glycosidic torsion) must be 'anti'. Syn samples are just omitted by the sampler.
    * `-full_model:rna:force_north_sugar_list` -- Residues whose sugar pucker is forced to be 'north'.
    * `-full_model:rna:force_south_sugar_list` -- Residues whose sugar pucker is forced to be 'south'.
    * `-full_model:rna:bulge_res` -- Residues that should be made into a 'bulge variant' rather than built explicitly.
    * `-full_model:rna:sample_sugar_res` -- Residues that, despite having been provided as a fixed chunk of RNA, have sugars that should be resampled.

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
