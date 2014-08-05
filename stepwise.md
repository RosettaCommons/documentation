#stepwise: StepWise Monte Carlo for modeling small RNA & protein motifs

Application purpose
===========================================

The stepwise monte carlo code is intended to give three-dimensional de novo models of RNA and protein motifs, with the prospect of reaching high accuracy. It differs from fragment assembly approaches in not relying on the database of known structures, and therefore is appropriate for problems that need to be modeled 'ab initio'. 

Stepwise monte carlo is slower than fragment-based approaches, but appears comparable in speed to KIC-based loop modeling, and is much faster and easier to run than the original stepwise enumeration methods. The code has been written in a modular fashion so as to allow its testing to new problems by Rosetta developers, including non-natural backbones, cyclic peptides/nucleotides, disulfide-bonded proteins, and ligand docking.

A useful 20-minute description of the basis and conceptual framework of stepwise monte carlo is available here:

[![GCAA tetraloop animation on Youtube](http://img.youtube.com/vi/WtbTh9rFznY/0.jpg)](http://www.youtube.com/watch?v=WtbTh9rFznY)

Slides are also available in keynote format [here](https://dl.dropboxusercontent.com/u/21569020/Das_SWM_RosettaDevMeetingTalk2014_keynote_format.zip). 


Algorithm
=========

This monte carlo minimization method builds up models by moves that involve sampling and minimization of single residues, what we've previously termed a 'stepwise ansatz'. Unlike other modes of Rosetta, moves include the deletion and addition of single residues. Because these moves are concentrated at termini, they are accepted frequently and allow deep optimization of an all-atom energy function.  For some problems, poses can also be split and merged, and separate chains can be docked or undocked. This same stepwise framework and application also reimplements enumerative sampling, following a recursion relation described previously (the 'stepwise assembly' method); in future releases, the older code will be removed.

Limitations
===========

-   This method is not guaranteed to give an exhaustive search of a physically realistic subspace of RNA/protein conformations, which was a nice feature of the original stepwise assembly work. Instead, like nearly all Rosetta protocols (KIC modeling, etc.) the sampling can return different solutions starting from different starting seeds, and you should check for convergence from independent runs.

-  The method is acutely sensitive to the assumed energy function. This is in contrast to other Rosetta protocols that either transit through low-resolution ('centroid') stages or make use of database fragments; both strategies 'regularize' the search but preclude solution of problems in which low-resolution energy functions are not trustworthy or the fragment database is too sparse. 

-  The method is intended to obey detailed balance, albeit on a perturbed energy landscape where each conformation's energy is mapped to the energy of the closest local minimum. In problems involving multiple chains that are dock/undocked or chains closed/broken, the current move implementations do not quite obey detailed balance due to incorrect move schedule and omission of a Jacobian ratio, respectively. Both issues are fixable, and will be fixed in future releases.

Code and Demo
=============

The central code for the *stepwise* application is in ` src/apps/public/stepwise/stepwise.cc   ` with all important classes in `   src/protocols/stepwise      ` .

For 'minimal' demo examples, including input files, of the stepwise macromolecular modeling protocol, see:

`       rosetta/demos/public/stepwise_monte_carlo_rna_loop     `

`        rosetta/demos/public/stepwise_monte_carlo_rna_multiloop    `  

`        rosetta/demos/public/stepwise_monte_carlo_protein_loop     `

`        rosetta/demos/public/stepwise_monte_carlo_mini_protein     `

Links to movies below illustrate these demos.

Additional useful command-lines are available as integration tests in directories with names like

`       rosetta/main/tests/integration/tests/swm_*     `


References
==========
Stepwise monte carlo is unpublished at the time of writing &ndash; this documentation is intended to allow developers to test and expand the protocol while the Das lab is completing final benchmarks for RNA motifs. However, the method is an expansion of stepwise assembly, which has been described in previous references:

Sripakdeevong, P., Kladwang, W., and Das, R. (2011) "An enumerative stepwise ansatz enables atomic-accuracy RNA loop modeling", PNAS 108:20573-20578. [for loop modeling] [Paper](http://www.stanford.edu/~rhiju/Sripakdeevong_StepwiseAnsatz_2011.pdf) [Link](http://dx.doi.org/10.1073/pnas.1106516108)

Das, R. (2013) "Atomic-accuracy prediction of protein loop structures enabled by an RNA-inspired ansatz", PLoS ONE 8(10): e74830. doi:10.1371/journal.pone.0074830 [Link](http://dx.doi.org/10.1371/journal.pone.0074830).



Modes
=====

-   By default, the code runs Stepwise Monte Carlo. Applications to RNA loops, mini-proteins, mixed RNA/protein, etc. are not different modes, but instead are defined by input sequences (see below). 

-   It is possible to run single specified moves given a starting structure, specified through `-move`. See 'Tips' below.

Input Files
===========

Required file
-------------

You typically will be using two input files:

-   The [[fasta file]] is a sequence file for all the chains in your full modeling problem. 
For ease of use, you can specify sequence numbering and chain IDs.
-   The [[pdb file]] or set of files provide any input starting structures for the problem. 
Residues in PDB files should have chain and residue numbers that represent their actual values in the full modeling problem.

Optional additional files:
--------------------------
-   Native pdb file, if rmsd computation is desired.
-   Align pdb file, if one desires to keep the modeling constrained to be close to this structure. [Note that this can be different from the native pdb file, if desired.]

Basic use for structure prediction
---------------------------
A sample command line is the following:

```
stepwise -fasta 1zih.fasta -s start_helix.pdb  -out:file:silent swm_rebuild.out
```
The code takes about 3 minutes to generate one model, using 50 cycles of stepwise monte carlo. Running more cycles (up to 500) essentially guarantees the solution of this problem, even on a single laptop. 

Here's an animation that reaches the known experimental structure. 

[![GCAA tetraloop animation on Youtube](http://img.youtube.com/vi/muTAOdPXkps/0.jpg)](http://www.youtube.com/watch?v=muTAOdPXkps)

Additional useful parameters:

 The flag `   -extra_min_res 4 9  ` would ask for the closing base pair of the starting helix to be minimized (but not subject to additions, deletions, or rotamer resampling) during the run. It is not obligatory, but allowing realxation of closing base pairs appears to generally improve convergence in this and other RNA cases.

For RNA cases, `  -score:rna_torsion_potential RNA11_based_new -chemical::enlarge_H_lj  ` are currently in use to test an updated RNA torsional potential and to help prevent overcompression of RNA helices. These may be turned on by default at the time of publication of the method, after completion of benchmarking.

Design
---------------------------
Design is accomplished simply by specifying n ('unknown nucleotide') in the fasta file instead of a specific sequence at any positions that should be varied.

```
stepwise -fasta NNNN.fasta -s start_helix.pdb  -out:file:silent swm_design.out  -cycles 500 -extra_min_res 4 9
```

Note the specification of additional cycles (500 instead of 50). This is necessary to ensure closed, convergent solutions, as the search conformation space is larger in design cases than pure structure prediction cases.

[![tetraloop design animation on Youtube](http://img.youtube.com/vi/5egRg78UR8Q/0.jpg)](http://www.youtube.com/watch?v=5egRg78UR8Q)

See following demo directory for input files & README:

`       rosetta/demos/public/stepwise_monte_carlo_rna_loop     `

Multiple loops
---------------------------
If you have an internal loop motif for an RNA, e.g, two strands connecting two helices,  there are two ways to setup the problem. 

If you do not know the relative rigid body orientations of the two end helices (this is the typical use case), specify those two chunks in different PDB files.

`stepwise -in:file:fasta 1lnt.fasta -s gu_gc_helix.pdb  uc_ga_helix.pdb -out:file:silent swm_rebuild.out -extra_min_res 2 15 7 10 -terminal_res 1 8 9 16 -nstruct 20  -cycles 1000  -score:rna_torsion_potential RNA11_based_new  -native native_1lnt_RNA.pdb`

The starting helices in this case came from the `rna_helix` application, which is briefly described [[here|rna-helix]]. The other new flag here is `-terminal_res`, which disallows stacking on those residues (its not really necessary here but prevents some silly moves). You'll see nucleotides being added to both helix starts, and eventually merging of the two 'sides' of the problem, as in this movie:


[![SRP modeling animation on Youtube](http://img.youtube.com/vi/CsXLyiyTcH4/0.jpg)](http://www.youtube.com/watch?v=CsXLyiyTcH4)


If you do have coordinates for the two end helices (this may happen in loop refinement problems, incl. RNA crystallographic refinement), specify those two chunks in the same PDB file:

`stepwise -in:file:fasta 1lnt.fasta -s start_native_1lnt_RNA.pdb -out:file:silent swm_rebuild.out -extra_min_res 2 15 7 10 -terminal_res 1 8 9 16 -nstruct 20  -cycles 1000  -score:rna_torsion_potential RNA11_based_new  -native native_1lnt_RNA.pdb`


See following demo directory for input files & README:

`       rosetta/demos/public/stepwise_monte_carlo_rna_multiloop     `

Protein loops
--------------------------------
Protein loops can be handled in a similar way to above RNA cases. [Under the hood, they are treated the same way as RNA.] 

An example command line for rebuilding a loop from a starting structure with that loop excised:

`stepwise -s noloop_mini_1alc_H.pdb -fasta mini_1alc.fasta -native mini_1alc.pdb -score:weights stepwise/protein/protein_res_level_energy.wts -silent swm_rebuild.out -from_scratch_frequency 0.0 -allow_split_off false -cycles 200 -nstruct 20`

Note that most loop modeling problems can be accelerated by cutting out a small 'sub-problem'; this was carried out by hand in the example above, but probably could be set up to happen automatically in Rosetta. Notes on additional flags: `-from_scratch_frequency 0.0 -allow_split_off false` turn off sampling of dipeptides that can be modeled free and merged into the loop; they are not so useful here, although they don't hurt. Last, not much work has been carried out on the energy function. The `protein_res_level_energy.wts` weights is an adaptation of score12.wts, as was carried out in [this paper](http://dx.doi.org/10.1371/journal.pone.0074830).

Input files & demo are in:

`       rosetta/demos/public/stepwise_monte_carlo_protein_loop     `

Animation coming soon... **NOTE AS OF AUG, 2014: THERE APPEARS TO BE A BUG THAT REDUCES CONFORMATIONAL SAMPLING EFFICIENCY FOR PROTEIN LOOPS, INTRODUCED DURING REFACTORING. I WILL REMOVE THIS WARNING WHEN I FIX THE BUG AND PUT IN THIS ANIMATION. -- Rhiju**
 
Mini-proteins built from scratch
--------------------------------
For both RNA and proteins stepwise monte carlo can also build models 'from scratch' (this feature will be optimized in the future so that you won't have to build, e.g., RNA helices). An example command line is:


`stepwise -fasta rosetta_inputs/2jof.fasta -native rosetta_inputs/2jof.pdb -score:weights stepwise/protein/protein_res_level_energy.wts -silent swm_rebuild.out -cycles 2000 -nstruct 50`

Here's an animation of a trajectory that achieves a low energy structure:

[![Trp cage (2jof) animation on Youtube](http://img.youtube.com/vi/MRYZjEoVs5Q/0.jpg)](http://www.youtube.com/watch?v=MRYZjEoVs5Q)

Most of the simulation may be spent flickering bits of secondary structure &ndash; in the future, we will probably setup some precomputation of these bits so that computation can be focused on build up of the complete mini-protein structure.

One interesting thing to note is that the packing of protein side-chains in stepwise monte carlo uses the new `allow_virtual_side_chains` setting and a score term `free_side_chain` that gives a bonus to residues for being virtualized (equal to 0.5 kcal times the number of side-chain torsions). This means that the side-chains only get instantiated if they can pack or form hydrogen bonds, and the results is a rather smoother conformational search.


Input files & demo are in:
`       rosetta/demos/public/stepwise_monte_carlo_mini_protein    `

Options
=======
```
Required:
-in:fasta                                        Fasta-formatted sequence file. [FileVector]

Commonly used:
-s                                               Any starting PDBs onto which motifs will be built [FileVector]
-cycles                                          Number of Monte Carlo cycles.[default 50]. [Integer]
-out:nstruct                                     Number of models to make. default: 1. [Integer]
-out:file:silent                                 Name of output file [scores and torsions, compressed format]. default="default.out" [String]
-native                                          Native PDB filename. [File].

**In following, ChainResidueVector means input like "4 5 6 9 10", "4-6 9-10", or "A:4-6 B:9-10" are all acceptable from command-line.**

Less commonly used, but useful
-extra_min_res                                   specify residues other than those being built that should be minimized [ChainResidueVector*]
-sample_res                                      residues to build (default is to build everything in FASTA that is not in starting PDBs) [ChainResidueVector*]
-score:weights                                   Weights file in database. [File]

Advanced 
-num_random_samples                              Number of samples that need to pass filters before before minimizing best (default:20)
-align_pdb                                       PDB to align to. Default will be -native, or any fixed residues in starting pose
-move                                            For running single move. Format: 'ADD 5 BOND_TO_PREVIOUS 4'
-enumerate                                       Use with -move. Force enumeration (SWA-like) instead of stochastic [Boolean] [default: false]
-jump_res                                        optional: residues for defining jumps -- please supply in pairs [ChainResidueVector*]
-root_res                                        optional: desired root res (used in SWM move testing) [ChainResidueVector*]
-virtual_sugar_res                               optional: starting virtual sugars (used in SWM move testing) [ChainResidueVector*]  
-cutpoint_closed                                 closed cutpoints in full model [ChainResidueVector*]
-cutpoint_open                                   open cutpoints in full model (redundant with FASTA readin) [ChainResidueVector*]
-in:file:silent                                  List of input files (in 'silent' format) that specify starting structure
-preminimize                                     Just prepack and minimize input poses
-stepwise:rna:erraser                            Use KIC sampling instead of CCD closure (default:false)
-bulge_res                                       optional: residues to keep uninstantiated
-terminal_res                                    optional: RNA residues that are not allowed to stack during sampling

Rarely used but listed with --help
-data_file                                       RDAT or legacy-format file with RNA chemical mapping data [File] (currently not in use, but will be soon)
-stepwise:atr_rep_screen                         In packing, screen for contacts (but no clash) between partitions before packing (**default:true**)
-allow_virtual_side_chains                       In packing, allow virtual side chains (**default:true**)
-temperature                                     Temperature for Monte Carlo Minimization (default: 1.0)
-input_res                                       Residues numbers in starting files. [ChainResidueVector*]
-overwrite                                       Overwrite any prior silent files. (default:false)
-full_model:other_poses                          list of PDB files containing other poses (this may be deprecated by -s)
-skip_deletions                                  no delete moves -- just for testing (default:false)
-add_delete_frequency                            Frequency of add/delete vs. resampling (default: 0.5)
-minimize_single_res_frequency                   Frequency with which to minimize the residue that just got rebuilt, instead  of all (default: 0.0)
-switch_focus_frequency                          Frequency with which to switch the sub-pose that is being modeled (default: 0.5)
-just_min_after_mutation_frequency               After a mutation, how often to just minimize (without further sampling the mutated residue) (default: 0.5)
-allow_internal_hinge_moves                      Allow moves in which internal suites are sampled (hinge-like motions) (default:true)
-allow_internal_local_moves                      Allow moves in which internal cutpoints are created to allow ERRASER rebuilds (default:**false**)
-allow_skip_bulge                                Allow moves in which an intervening residue is skipped and the next one is modeled as floating base (default:**false**)
-allow_variable_bond_geometry                    In 10% of moves, let bond angles & distance change (default:false) (**warning: this may not work anymore**)
-num_pose_minimize                               number of sampled poses to minimize within each stepwise move
-full_model:rna:force_syn_chi_res_list           optional: sample only syn chi for these res in sampler [ChainResidueVector*]
-force_centroid_interaction                      Require base stack or pair even for single residue loop closed (which could also be bulges!)
-rebuild_bulge_mode                              rebuild_bulge_mode (just for SWA backwards compatibility)
-corrected_geo                                   Use PHENIX-based RNA sugar close energy and bond geometry parameter files (default:true)
```

Tips
====

What if all the residues are not rebuilt?
------------------------
If the runs are returning many incomplete and different solutions, increase the number of cycles. If the run returns the same solution over and over again with say, a missing U, stepwise monte carlo is telling you that it thinks that the entropic cost of structuring that nucleotide is not compensated by packing/hydrogen-bonding interactions in any available structural solutions. There are ways to force that bulge to get built (see below) through post-processing.


Running specific moves
-------------
It is possible to run single specified moves given a starting structure, specified through `-move`. This is useful to 'unit test' specific moves, and also serves as a connection to the original stepwise enumeration. In particular, these moves are equivalent to the basic moves in the original stepwise assembly executables (swa_rna_main and swa_protein_main), but can have stochastic sampling of nucleotide/amino-acid conformations to minimize. Furthermore, use of the `-enumerate` flag recovers the original enumerative behavior. Example in ` tests/integration/tests/swm_rna_move_two_strands `. 

What do the scores mean?
------------------------
The score terms are similar to those in the standard Rosetta energy functions for protein or RNA (which themselves may be unified soon). For completeness, some additional terms relevant for stepwise applications are described here.
```
***Energy interpreter for silent output:
score                                            Final total score
fa_atr                                           Lennard-jones attractive between atoms in different residues
fa_rep                                           Lennard-jones repulsive between atoms in different residues
fa_intra_rep                                     Lennard-jones repulsive between atoms in the same residue
lk_nonpolar                                      Lazaridis-karplus solvation energy, over nonpolar atoms
hbond_sr_bb_sc                                   Backbone-sidechain hbonds close in primary sequence (i,i+1)
hbond_lr_bb_sc                                   Backbone-sidechain hbonds distant in primary sequence
hbond_sc                                         Sidechain-sidechain hydrogen bond energy
geom_sol_fast                                    Geometric solvation energy for polar atoms (environment-independent)
loop_close                                       Entropic cost for loops not yet instantiated but whose endpoints are fixed
ref                                              Cost for instantiation of a full RNA/protein residue, backbone + sidechain
free_suite                                       Bonus for freeing a terminal phosphate or sugar (may be unified with ref)
free_2HOprime                                    Bonus for freeing a 2'-OH hydroxyl (may be unified with ref)
intermol                                         Cost of bringing two chains together at 1 M (-conc flag can change this)
other_pose                                       Score of sister poses (if building off separate PDBs, prior to merge)
linear_chainbreak                                Closure term to keep chainbreaks together upon loop closure
atom_pair_constraint                             any pairwise distance constraints (not implemented yet)
coordinate_constraint                            any constraints to put atoms at specific coordinates (not implemented yet)

[RNA stuff]
fa_elec_rna_phos_phos                            Distance-dep. dielectric Coulomb repulsion term between phosphates
rna_torsion                                      RNA torsional potential.
rna_sugar_close                                  Distance/angle constraints to keep riboses as closed rings.
fa_stack                                         Extra van der Waals attraction for nucleobases, projected along base normal 
stack_elec                                       Electrostatics for nucleobase atoms, projected along base normal. 

[protein stuff]
pro_close                                        Distance/angle constraints to keep prolines as closed rings.
fa_pair                                          Lo-res propensity for protein side-chains to be near each other
hbond_*                                          Other h-bond terms, probably will all get unified
dslf_*                                           Disulfide geometry terms, unified in later score functions 
rama                                             Score for phi/psi backbone combination 
omega                                            Tether of protein backbone omega to 0° or 180°  
fa_dun                                           Protein side chain energy
p_aa_pp                                          -log P( aa | phi, psi ), enters into current bayesian formalism for score
free_side_chain                                  bonus (of 0.5 * nchi) for virtualizing a protein side chain

[Following are provided if the user gives a native structure for reference]
missing                                          number of residues not yet built in the structure
rms                                              all-heavy-atom RMSD to the native structure of built residues.
```

Post Processing
===============

Extraction Of Models Into PDB Format
------------------------------------

The models from the above run are stored in compressed format in files like `swm_rebuild.out` You can see the models in PDB format with the conversion command.

```
extract_pdbs  -in:file:silent swm_rebuild.out
```

New things since last release
=============================
This is a new executable as of 2014.