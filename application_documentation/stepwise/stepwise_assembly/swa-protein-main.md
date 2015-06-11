#Enumerative building of a protein loop [part of Stepwise Assembly modeling]

Metadata
========

Author: Rhiju Das

Written in 2013. Last update: Apr. 2013 by Rhiju Das (rhiju [at] stanford.edu).

Code and Demo
=============

The central code for the *swa\_protein\_main* application is in `       src/apps/swa/protein/swa_protein_main.cc      ` and in several files in `       src/protocols/swa/      ` .

For a 'minimal' demo, see:

`       demos/public/swa_protein_main/      `

References
==========

Das, R. (2013) "Atomic-accuracy prediction of protein loop structures enabled by an RNA-inspired ansatz", PLoS ONE 8(10): e74830. doi:10.1371/journal.pone.0074830 [Link](http://dx.doi.org/10.1371/journal.pone.0074830)

See also:

Sripakdeevong, P., Kladwang, W., and Das, R. (2011) "An enumerative stepwise ansatz enables atomic-accuracy RNA loop modeling", PNAS 108:20573-20578. [Paper](http://www.stanford.edu/~rhiju/Sripakdeevong_StepwiseAnsatz_2011.pdf) [Link](http://dx.doi.org/10.1073/pnas.1106516108)

Application purpose
===========================================

This code is intended to give three-dimensional de novo models of protein segments at atomic accuracy without requiring input information from surrounding sidechains. Tested in applications to loop modeling in ab initio & comparative modeling. It is being extended to refining and finding alternative configurations for troublesome protein segments in crystallography, and to create de novo models of entire proteins.

**A faster & easier version of this method called stepwise monte carlo has been developed, described [[here|stepwise]]**

Algorithm
=========

The algorithm builds a loop de novo by enumerating through phi, psi, and omega angles; closing the chain by CCD; side-chain packing on all 'reasonable' configurations; and minimization of the resulting lowest energy, clustered configurations. Should give a complete backbone enumeration for a loop up to 5 residues in length.

Limitations
===========

-   This demo is for short loops (\<6 residues), in which the complete enumeration can be carried out in a single Rosetta job. Running 'StepWise Assembly' on a longer loop requires a more complex workflow that carries out buildup of the loop across all possible residue-by-residue build paths. This full workflow is described in separate documentation see [[Enumerative building of a protein loop through systematic recursion|swa-protein-long-loop]].

-   As with most other modes in Rosetta, the final ensemble of models is not guaranteed to be a Boltzmann ensemble. However the outputted models *are* expected to be a complete set of the lowest energy configurations stemming from a reasonably complete search of conformational space.

-   Minimization or sampling of tau [CA bond angle] is not being carried out.

Modes
=====

The following modes will be described:

-   Loop modeling [ `        -rebuild       ` ]. That's the main purpose of the application.

-   Clustering [ `        -cluster       ` ]. Useful in the final stage of modeling.

-   Prepacking (advanced). This mode prepares initial side-chains on side-chain-free starting models. This can be important if you want to compare energies and side-chain configurations between different loop modeling strategies – its best to start with the same initial prepacks.

Input Files
===========

Required file
-------------

You need only two input files to run `       swa_protein_main      ` loop modeling:

-   The [[fasta file]]: it is the sequence file for your full model (protein plus built loop).

-   The input PDB file. It is OK to input this without any sidechains and without loops. You can also include a starting loop (its bond lengths and angles will be used for all models).

Optional additional files:
--------------------------

-   Native pdb file, if CA rmsds, backbone rmsds, and all-heavy-atom rmsd's are desired.
-   Disulfide file. Important for side-chain packing! Each line should contain two numbers for each pair of disulfide-bonded residues.

How to include these files.
---------------------------

A sample command line is the following:

```
swa_protein_main -rebuild  -s1 noloop5-8_2it7_stripsidechain.pdb   -input_res1 1-4 9-28   -sample_res 5 6  -bridge_res 7 8  -cutpoint_closed 7 -superimpose_res 1-4 9-28  -fixed_res 1-4 9-28   -calc_rms_res 5-8  -jump_res 1 28  -ccd_close  -out:file:silent_struct_type binary  -fasta 2it7.fasta  -n_sample 18  -nstruct 400  -cluster:radius 0.100  -extrachi_cutoff 0  -ex1  -ex2  -score:weights score12.wts  -pack_weights pack_no_hb_env_dep.wts  -in:detect_disulf false  -add_peptide_plane  -native 2it7.pdb  -mute all  -out:file:silent 2it7_rebuild.out -disulfide_file 2it7.disulf
```

Note above that `       1-4 9-28      ` is allowed shorthand for `       1 2 3 4 9 10 11 ... 28      ` . Note that the numbering refers to the numbers in the overall model whose sequence if specified in the .fasta file.

The code takes about 2 minute to generate about 90 loop models. We get a 'silent file' with all the models, `       2it7_rebuild.out      ` .

To extract models from a silent file, you can use the usual Rosetta `       extract_pdbs      ` command:

```
extract_pdbs -in:file:silent 2it7_rebuild.out -tags S_0
```

Suppose we want to more coarsely cluster these models, e.g., at 1 Angstrom RMSD, which would be appropriate for atomic accuracy cases. Here's the command line:

```
swa_protein_main -cluster_test -in:file:silent 2it7_rebuild.out  -cluster:radius 1.0  -calc_rms_res 5-8 -out:file:silent 2it7_CLUSTERED.out  -score_diff_cut  20.000
```

The outfile has some REMARKS describing parent tags and the name of the clustered file. The way this clustering works is it simply goes through the models in order of energy, and if a model is more than the rmsd threshold than the existing clusters, it spawns a new cluster.

Expected Outputs
================

From the above run, we get a 'silent file' with all the models, `       2it7_rebuild.out      ` .

After clustering, we get a file `       2it7_CLUSTERED.out      `

Options
=======

```
Required:
-rebuild [or -cluster_test]                      Mode of loop building.
-fasta                                           Fasta-formatted sequence file. [File]
-s1  [or -silent1 and -tags1]                    Input PDB or decoy from silent file with starting model [File]
-input_res1                                      Which residues are given in input file. [IntegerVector]

Required for rebuilding internal loops:
-bridge_res                                      Residues whose phi, psi torsions will be optimized during loop closure.  [IntegerVector]
                                                 Must specify exactly 3 positions if using analytical loop closure (KIC-style).
-jump_res                                        Pair of residues across which to specify jump.  [IntegerVector]
                                                 First and last residues in protein are reasonable choices.

Recommended for -rebuild:
-ccd_close                                       Use CCD instead of analytical loop closure. Now strongly suggested!
-n_sample                                        Number of 'rotamers' in phi or psi torsion angles. Default is 18, corresponding to
                                                  360/18 = 20 degree increments [Integer]
-fixed_res                                       Residues that should not move upon backbone minimization.  [IntegerVector]
                                                  Typically give the non-loop residues here.
-out:file:silent                                 Name of output file [scores and torsions, compressed format]. default="default.out" [String]
-out:file:silent_struct_type                     You should specify this as "binary" for most modeling cases, to retain information on non-ideal bond
                                                  lengths and bond angles.
-nstruct                                         Maximum number of models to make. default: 400. [Integer]
-in:native                                       Native PDB filename. [File].
-superimpose_res                                 Which residues to superimpose over before calculating RMSD.  [IntegerVector]
-rmsd_res                                        Which residues to calculated RMSD over.  [IntegerVector]
-cluster:radius                                  How finely to cluster loops (based on backbone RMSD) before minimizing and again
                                                  before output. In Angstroms. Default 0.25 A, but use 0.1 A to reach atomic accuracy. [Real]
-extrachi_cutoff                                 How many neighbors a residue must have before using the full rotamer list ('extrachi').
                                                  suggest setting to zero to get complete sampling. [Integer]
-ex1                                             Generate extra rotamers to generate at chi1 level. Recommended.
-ex2                                             Generate extra rotamers to generate at chi2 level. Recommended.
-pack_weights                                    Energy function to use in side-chain packing and first energy filter. Recommended:
                                                   pack_no_hb_env_dep.wts, which lowers fa_rep, increases side-chain hbonds, and turns
                                                   off weaker Hbonds for surface-exposed residues. [File]
-score:weights                                   Energy function to use in minimization & final scoring. Recommended: score12.wts. [File]
-in:detect_disulf                                Specify as false to avoid weird errors with input proteins with potential disulfides.
-disulfide_file                                  Specify disulfide-bonded pairs explicitly, including any involving loop residues.
-add_peptide_plane                               Adds methyl group to N-terminal of second loop fragment to simulate preceding Calpha, and
                                                    carbon to C-terminal of first loop fragment to simulate next Calpha (acetylation).
                                                    These additions permit sampling and optimization of 'edge' phi and psi torsions.

Less commonly used:
-s2  [or -silent2 and -tags2]                    Input PDB or decoy from silent file with second starting model. These will be 'combined'
                                                   with models specified by -s1. [File]
-input_res2                                      Which residues are given in second input file. [IntegerVector]


Used in clustering:
-cluster_test                                    Cluster models [supply this instead of -rebuild]
-silent_read_through_errors                      Useful in big runs in the rare cases that silent files have some kind of errors due to concatenation.
-score_diff_cut                                  How far up to go in energy, compared to lowest energy model in file.

Used in prepack mode:
-use_packer_instead_of_rotamer_trials            Do full side-chain combinatorial optimization, not just one-by-one rotamer trials of residues.
```

Tips
====

What do the scores mean?
------------------------

The score components are those of the standard protein energy function ('score12'), with the following additions:

```
all_rms                                          all-heavy-atom RMSD to the native structure in loop (specified by -rms_res)
backbone_rms                                     RMSD over C, CA, N, O to the native structure in loop (specified by -rms_res)
rms                                              RMSD over CA to the native structure in loop (specified by -rms_res)
score_orig                                       Score before minimization [you probably won't use this.]
nclust                                           How many models went into cluster [not in use]
```

How do I prepack?
-----------------

If you take a PDB created outside Rosetta, very small clashes may be strongly penalized by the Rosetta all-atom potential. Instead of scoring, you should probably do a short minimize, run:

```
swa_protein_main  -rebuild  -s1 noloop5-8_2it7_stripsidechain.pdb   -input_res1 1-4 9-28  -superimpose_res 1-4 9-28  -fixed_res 1-4 9-28   -calc_rms_res 5-8  -jump_res 1 28   -out:file:silent_struct_type binary  -fasta 2it7.fasta  -n_sample 18  -nstruct 400  -cluster:radius 0.100  -extrachi_cutoff 0  -ex1  -ex2  -score:weights score12.wts  -pack_weights pack_no_hb_env_dep.wts  -in:detect_disulf false  -add_peptide_plane  -native 2it7.pdb  -mute all   -out:file:silent noloop5-8_2it7_prepack.out  -disulfide_file 2it7.disulf -use_packer_instead_of_rotamer_trials
```

Including constraints
---------------------

It can be useful for runs that refine a structure (e.g., the experimental structure) or for homology modeling to stay close to a starting structure. You can generate a constraint file as follows:

```
generate_CA_constraints.py 2it7.pdb -cst_res 5-8 -coord_cst -anchor_res 1 -fade > 2it7_coordinate2.0.cst
```

This python script is available in `       rosetta/tools/SWA_protein_python/generate_dag/      `

To incorporate into the loop modeling above, include in the `       swa_protein_main      ` command line a flag `       -cst_file2it7_coordinate2.0.cst      `

New things since last release
=============================

This documentation has been added at the same time as public release of the demo [after Rosetta 3.5].

* [[RNA loop modeling with Stepwise Assembly|swa-rna-loop]]
* [[Stepwise MonteCarlo application|stepwise]]
* [[Overview of Stepwise classes|stepwise-classes-overview]]
* [[Structure prediction applications]]: Includes links to these and other applications for loop modeling
* [[RosettaScripts]]: The RosettaScripts home page
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
