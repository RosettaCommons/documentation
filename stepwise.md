#stepwise: StepWise Monte Carlo for modeling small RNA & protein motifs

Metadata
=============

Author: Rhiju Das

Written in August 2014.

Code and Demo
=============

A useful 20-minute description of the basis and conceptual framework of stepwise monte carlo is available here:

[![GCAA tetraloop animation on Youtube](http://img.youtube.com/vi/WtbTh9rFznY/0.jpg)](http://www.youtube.com/watch?v=WtbTh9rFznY)

Slides are also available in keynote format [here](https://dl.dropboxusercontent.com/u/21569020/Das_SWM_RosettaDevMeetingTalk2014_keynote_format.zip). 

The central code for the *stepwise* application is in ` src/apps/public/stepwise/stepwise.cc   ` with all important classes in `   src/protocols/stepwise      ` .

For 'minimal' demo examples, including input files, of the stepwise macromolecular modeling protocol, see:

`       rosetta/demos/public/stepwise_monte_carlo_rna     `

`        rosetta/demos/public/stepwise_monte_carlo_rna_multiloop    `  

`        rosetta/demos/public/stepwise_monte_carlo_protein     `

Links to movies below illustrate these demos.

Additional useful command-lines are available as integration tests in directories with names like

`       rosetta/main/tests/integration/tests/swm_*     `


References
==========
Stepwise monte carlo is unpublished at the time of writing -- this documentation is intended to allow developers to test and expand the protocol while the Das lab is completing final benchmarks for RNA motifs. However, the method is an expansion of stepwise assembly, which has been described in previous references:

Sripakdeevong, P., Kladwang, W., and Das, R. (2011) "An enumerative stepwise ansatz enables atomic-accuracy RNA loop modeling", PNAS 108:20573-20578. [for loop modeling] [Paper](http://www.stanford.edu/~rhiju/Sripakdeevong_StepwiseAnsatz_2011.pdf) [Link](http://dx.doi.org/10.1073/pnas.1106516108)

Das, R. (2013) "Atomic-accuracy prediction of protein loop structures enabled by an RNA-inspired ansatz", PLoS ONE 8(10): e74830. doi:10.1371/journal.pone.0074830 [Link](http://dx.doi.org/10.1371/journal.pone.0074830).


Application purpose
===========================================

The stepwise monte carlo code is intended to give three-dimensional de novo models of RNA and protein motifs, with the prospect of reaching high accuracy. It differs from fragment assembly approaches in not relying on the database of known structures, and therefore is appropriate for problems that need to be modeled 'ab initio'. 

Stepwise monte carlo is slower than fragment-based approaches, but appears comparable in speed to KIC-based loop modeling, and is much faster and easier to run than the original stepwise enumeration methods. The code has been written in a modular fashion so as to allow its testing to new problems by Rosetta developers, including non-natural backbones, cyclic peptides/nucleotides, disulfide-bonded proteins, and ligand docking.


Algorithm
=========

This monte carlo minimization method builds up models by moves that involve sampling and minimization of single residues, what we've previously termed a 'stepwise ansatz'. Unlike other modes of Rosetta, moves include the deletion and addition of single residues. Because these moves are concentrated at termini, they are accepted frequently and allow deep optimization of an all-atom energy function.  For some problems, poses can also be split and merged, and separate chains can be docked or undocked. This same stepwise framework and application also reimplements enumerative sampling, following a recursion relation described previously (the 'stepwise assembly' method); in future releases, the older code will be removed.

Limitations
===========

-   This method is not guaranteed to give an exhaustive search of a physically realistic subspace of RNA/protein conformations, which was a nice feature of the original stepwise assembly work. Instead, like nearly all Rosetta protocols (KIC modeling, etc.) the sampling can return different solutions starting from different starting seeds, and you should check for convergence from independent runs.

-  The method is acutely sensitive to the assumed energy function. This is in contrast to other Rosetta protocols that either transit through low-resolution ('centroid') stages or make use of database fragments; both strategies 'regularize' the search but preclude solution of problems in which low-resolution energy functions are not trustworthy or the fragment database is too sparse. 

-  The method is intended to obey detailed balance, albeit on a perturbed energy landscape where each conformation's energy is mapped to the energy of the closest local minimum. In problems involving multiple chains that are dock/undocked or chains closed/broken, the current move implementations do not quite obey detailed balance due to incorrect move schedule and omission of a Jacobian ratio, respectively. Both issues are fixable, and will be fixed in future releases.

Modes
=====

-   By default, the code runs Stepwise Monte Carlo. 

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
-   Align pdb file, if one desires to keep the modeilng constrained to be close to this structure. [Note that this can be different from the native pdb file, if desired.]

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

`       rosetta/demos/public/stepwise_monte_carlo_rna     `

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
** THIS IS NOT FILLED IN YET**

Mini-proteins built from scratch
--------------------------------
For both RNA and proteins stepwise monte carlo can also build models 'from scratch' (this feature will be optimized in the future so that you won't have to build, e.g., RNA helices). An example command line is:


`stepwise -fasta rosetta_inputs/2jof.fasta -native rosetta_inputs/2jof.pdb -score:weights stepwise/protein/protein_res_level_energy.wts -silent swm_rebuild.out -cycles 2000 -nstruct 50`

Here's a movie:
[![Trp cage (2jof) animation on Youtube](http://img.youtube.com/vi/MRYZjEoVs5Q/0.jpg)](http://www.youtube.com/watch?v=MRYZjEoVs5Q)

Most of the simulation may be spent flickering bits of secondary structure -- in the future, we will probably setup some precomputation of these bits so that computation can be focused on build up of the complete mini-protein structure.

One interesting thing to note is that the packing of protein side-chains in stepwise monte carlo uses the new `allow_virtual_side_chains` setting and a score term `free_side_chain` that gives a bonus to residues for being virtualized (equal to 0.5 kcal times the number of side-chain torsions). This means that the side-chains only get instantiated if they can pack or form hydrogen bonds, and the results is a rather smoother conformational search.


Options
=======
** THIS IS NOT UPDATED YET**
```
Required:
-in:database                                     Path to rosetta databases. [PathVector]
-in:fasta                                        Fasta-formatted sequence file. [FileVector]

Commonly used:
-out:file:silent                                 Name of output file [scores and torsions, compressed format]. default="default.out" [String]
-params_file                                     RNA params file name.[String]. For Example: -params_file chunk002_1lnt_.prm
-in:native                                       Native PDB filename. [File].
-out:nstruct                                     Number of models to make. default: 1. [Integer]
-minimize_rna                                    High resolution optimize RNA after fragment assembly.[Boolean]
-vary_geometry                                   Vary bond lengths and angles (with harmonic constraints near Rosetta ideal) for backbone and sugar degrees of freedom [Boolean]

Less commonly used, but useful
-cycles                                          Number of Monte Carlo cycles.[default 10000]. [Integer]
-filter_lores_base_pairs                         Filter for models that satisfy structure parameters. [Boolean]
-output_lores_silent_file                        If high resolution minimizing, output intermediate low resolution models. [Boolean]
-dump                                            Generate pdb output. [Boolean]
-vall_torsions                                   Source of RNA fragments. [default: 1jj2.torsions]. [Boolean]
-jump_library_file                               Source of base-pair rigid body transformations if base pairs are specified.
                                                   [default: 1jj2_RNA_jump_library.dat] [String]
-close_loops                                     Attempt closure across chainbreaks by cyclic coordinate descent after fragment moves [Boolean]
-cst_file                                        Specify constraints (typically atom pairs) in Rosetta-style constraint file. [String]
-output_lores_silent_file                        if doing full-atom minimize, also save models after fragment assembly but before refinement (file will be called *.LORES.out) [Boolean]
-dump                                            output pdbs that occur during the run, even if using silent file output.

Advanced [used in rna_assembly]
-in:file:silent                                  List of input files (in 'silent' format) that specify potential template structures or 'chunks'
-chunk_res                                       Positions at which 'chunks' are applied. If there is more than one chunk file, specify indices for
                                                   the first file and then the second file, etc.
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
** THIS IS NOT UPDATED YET**
```
***Energy interpreter for fullatom silent output:
score                                            Final total score
fa_atr                                           Lennard-jones attractive between atoms in different residues
fa_rep                                           Lennard-jones repulsive between atoms in different residues
fa_intra_rep                                     Lennard-jones repulsive between atoms in the same residue
lk_nonpolar                                      Lazaridis-karplus solvation energy, over nonpolar atoms
hack_elec_rna_phos_phos                          Simple electrostatic repulsion term between phosphates
hbond_sr_bb_sc                                   Backbone-sidechain hbonds close in primary sequence
hbond_lr_bb_sc                                   Backbone-sidechain hbonds distant in primary sequence
hbond_sc                                         Sidechain-sidechain hydrogen bond energy
ch_bond                                          Carbon hydrogen bonds
geom_sol                                         Geometric Solvation energy for polar atoms
rna_torsion                                      RNA torsional potential.
atom_pair_constraint                             Harmonic constraints between atoms involved in Watson-Crick base pairs
                                                 specified by the user in the params file
angle_constraint                                 (not in use)

[Following are provided if the user gives a native structure for reference]
missing                                          number of residues not yet built in the structure
rms                                              all-heavy-atom RMSD to the native structure of built residues.
```

Expected Outputs
================

You will typically use the protocol to produce a silent file – how do you get the models out?

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

