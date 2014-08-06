#RNA 3D structure modeling
==================================

**STILL BEING DRAFTED BY RHIJU**
**STILL BEING DRAFTED BY RHIJU**
**STILL BEING DRAFTED BY RHIJU**

Application purpose
===========================================

This code allow build-up of three-dimensional de novo models of RNAs of sizes up to ~300 nts, given secondary structure and experimental constraints, and some human curation of submodels along the build-up path.

Algorithm
=========

This documentation page emphasizes the easy setup of multiple jobs that permit the assembly of large RNAs. Each of the 'sub-jobs' is a helix creation, a run with the FARFAR (fragment assembly of RNA with full-atom refinement) de novo modeling application, or with the RNA comparative modeling application [rna_thread|rna-thread]. If desired, sub-models can be grafted together into bigger pieces. 

The input files, algorithm, etc. application are described [[here|rna denovo]], but a detailed understanding of those file formats is not necessary for modeling. 


Limitations
===========

-   This method has been developed to allow integrative modeling of complex RNA folds for which some parts can be modeled by homology and others by de novo modeling. It still relies on constraints for long-range contacts like pseudoknots as may be available from phylogenetic analysis or multidimensional chemical mapping approaches like MOHCA-seq or mutate-and-map.

-   The method is not yet a single automated pipeline.

Code and Demo
=============

The main wrapper code is available through installation of [[RNA tools|rna-tools]].

The RNA puzzles have offered useful testbeds of helix modeling, motif homology modeling, de novo modeling, and grafting to larger RNA structures. Examples of all four steps are available in:

`       rosetta_demos/public/rna_puzzle      `

References
==========
Most of the tools described here are unpublished but are being incorporated into manuscripts in preparation. One recent preprint with some of this information is:

Cheng, C., Chou, F.-C., Kladwang, W., Tian, S., Cordero, P. and Das, R. (2014)
"MOHCA-seq: RNA 3D models from single multiplexed proximity-mapping experiments." 
[Paper](http://biorxiv.org/content/early/2014/04/25/004556)


Input Files
===========

Required file
-------------

You need two input files to run RNA structure modeling:

-   The [[fasta file]]: it is a sequence file for your rna.
-   The [[secondary structure file]]: text file with secondary structure in dot-parentheses notation.

Optional additional files:
--------------------------
-   Any pdb files containing templates for threading.
-   Native pdb file, if all-heavy-atom rmsd's are desired. Must be in Rosetta's [PDB format for RNA](#File-Format).

Making models
===========
Step 1. Make helices
---------------------------

A sample command line is the following:

```
rna_helix.py
```

Step 2. Use threading to build sub-pieces
---------------------------

```
rna_thread
```

Step 3. De novo model loops, junctions, & tertiary contacts of unknown structure by FARFAR
---------------------------

Useful options for `rna_denovo_setup.py`

```
Required:
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
-in:database                                     Path to rosetta databases. Default is based on location of rosetta executables. [PathVector]
```


Step 4. Build-up larger pieces by grafting or by more FARFAR
---------------------------



Tips
====

File Format
------

Note that in older versions of Rosetta, the PDBs may have residue types marked as rA, rC, rG, and rU and unusual atom names. Versions of Rosetta released after 3.5 have residue and atom names matching BMRB/NDB standard nomenclature. If you have a "standard" PDB file, there is a python script available to convert it to current Rosetta format:

```
tools/rna_tools/bin/make_rna_rosetta_ready.py <pdb file>
```

Can I specify non-Watson-Crick pairs?
-------------------------------------

You can also specify base pairs that must be forced, even at the expense of creating temporary chainbreaks, in the params file, with a line like:

```
OBLIGATE PAIR 2 11 W W A
```

This also allows the specification of non-Watson-Crick base pairs. In the line above, you can change the W's to H (hoogsteen edge) or S (sugar edge); and the A to P (antiparallel to parallel). The base edges are essentially the same as those defined in the classification by Leontis & Westhof. The latter (A/P) are determined by the relative orientation of base normals. [The cis/trans classification of Leontis & Westhof would be an alternate to the A/P, but we found A/P more convenient to compute and to visually assess.] The base pairs are drawn from a library of base pairs extracted from the crystallographic model of the large ribosomal subunit 1JJ2.

When specifying pairs, if there are not sufficient CUTPOINT\_OPEN's to allow all the pairs to form, the code will attempt to choose a (non-stem) RNA suite to put in a cutpoint, which can be closed during fragment assembly with the -close\_loops option. If you want to pre-specify where this cutpoint will be chosen, add a line like

```
CUTPOINT_CLOSED 6
```

What do the scores mean?
------------------------

The most common question we get is on what the terms in the 'SCORE lines' of silent files mean. Here's a brief rundown, with more explanation in the papers cited above.

```
***Energy interpreter for low resolution silent output:
score                                              Final total score
rna_rg                                           Radius of gyration for RNA
rna_vdw                                          Low resolution clash check for RNA
rna_base_backbone                                Bases to 2'-OH, phosphates, etc.
rna_backbone_backbone                            2'-OH to 2'-OH, phosphates, etc.
rna_repulsive                                    Mainly phosphate-phosphate repulsion
rna_base_pair_pairwise                           Base-base interactions (Watson-Crick and non-Watson-Crick)
rna_base_pair                                    Base-base interactions (Watson-Crick and non-Watson-Crick)
rna_base_axis                                    Force base normals to be parallel
rna_base_stagger                     Force base pairs to be in same plane
rna_base_stack                                   Stacking interactions
rna_base_stack_axis                              Stacking interactions should involve parallel bases.
atom_pair_constraint                             Harmonic constraints between atoms involved in Watson-Crick base
                                                 pairs specified by the user in the params file
rms                                              all-heavy-atom RMSD to the native structure

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

N_WC                                             number of watson-crick base pairs
N_NWC                                            number of non-watson-crick base pairs
N_BS                                             number of base stacks

[Following are provided if the user gives a native structure for reference]
rms                                              all-heavy-atom RMSD to the native structure
rms_stem                                         all-heavy-atom RMSD to helical segments in the native structure, defined by 'STEM' entries in the parameters file.
f_natWC                                          fraction of native Watson-Crick base pairs recovered
f_natNWC                                         fraction of native non-Watson-Crick base pairs recovered
f_natBP                                          fraction of base pairs recovered
```

How do I just score?
--------------------

To get a score of an input PDB, you can run the 'denovo' protocol but ask there to be no fragment assembly cycles and no rounds of minimization:

```
rna_score.<exe> -database <path to database>  -s <pdb file> [<pdb file 2> ...] -out:file:silent SCORE.out  [-native <native pdb>]
```

If you want to minimize under the low resolution RNA potential (used in FARNA), add the flag '-score:weights rna\_lores.wts'. Then you can check the score in SCORE.out:

```
 grep SCORE SCORE.out
```

But this is not recommended if you are trying to score a model deposited in the PDB or created by other software – see next [How do I just minimize?](#How-do-I-just-minimize?)

How do I just minimize?
-----------------------

If you take a PDB created outside Rosetta, very small clashes may be strongly penalized by the Rosetta all-atom potential. Instead of scoring, you should probably do a short minimize, run:

```
rna_minimize.<exe> -database <path to database>  -s <pdb file> [<pdb file 2> ...] -out:file:silent MINIMIZE.out  [-native <native pdb>]
```

If you want to minimize under the low resolution RNA potential (used in FARNA), add the flag '-score:weights rna\_lores.wts'. Then check out the scores in MINIMIZE.out.

```
 grep SCORE MINIMIZE.out
```

You can extract models from silent files as described in [Extraction Of Models Into PDB Format](#Extraction-Of-Models-Into-PDB-Format), but you'll also get models with the same names as your input with the suffix '\_minimize.pdb'.

Other options
-------------

Check this section: [[RNA assembly with experimental pair-wise constraints|rna-assembly]] .

Expected Outputs
================

You will typically use the protocol to produce a silent file – how do you get the models out?

Post Processing
===============

Extraction Of Models Into PDB Format
------------------------------------

The models from the above run are stored in compressed format in the file test.out, along with lines representing the score components. You can see the models in PDB format with the conversion command.

```
rna_extract.<exe>  -in:file:silent test.out -in:file:silent_struct_type  rna -database <path to database>
```

Note that the PDBs have residue types marked as rA, rC, rG, and rU.

How can I cluster models?
-------------------------

There is one executable for clustering, it currently requires that all the models be in a silent file and have scores. (If you don't have such a silent file, use the rna\_score executable described in [How do I just score?](#How-do-I-just-score?) ). Here's the command line:

```
 rna_cluster.<exe>   -database <path to database>    -in:file:silent <silent file with models> -out:file:silent <silent file with clustered models>   [-cluster:radius <rmsd threshold>] [-nstruct <maximum number of clusters>]
```

The way this clustering works is it simply goes through the models in order of energy, and if a model is more than the rmsd threshold than the existing clusters, it spawns a new cluster.

New things since last release
=============================

Added applications rna\_minimize, rna\_helix, rna\_cluster. Updated torsional potential to be smooth.

Written in 2008. Last updates: Nov. 2011 and Aug. 2014 by Rhiju Das (rhiju [at] stanford.edu).
