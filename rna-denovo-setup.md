#RNA 3D structure modeling
==================================

**STILL BEING DRAFTED BY RHIJU**
**STILL BEING DRAFTED BY RHIJU**
**STILL BEING DRAFTED BY RHIJU**

Application purpose
===========================================

This code allows build-up of three-dimensional de novo models of RNAs of sizes up to ~300 nts, given secondary structure and experimental constraints. It can be carried out reasonably automatically, but human curation of submodels along the build-up path may improve accuracy. A fully automated pipeline is also in preparation (a previous iteration of this is described in [[rna assembly]] documentation).

Algorithm
=========

This documentation page emphasizes the setup of multiple jobs that together permit the modeling of complex RNA folds. Each of the 'sub-jobs' is either a helix creation, a RNA comparative modeling job [rna_thread|rna-thread], or a run with the FARFAR (fragment assembly of RNA with full-atom refinement) de novo modeling application. If desired, sub-models can be grafted together into bigger pieces. 

The input files, algorithm, etc. for the FARFAR application are described separately [[here|rna denovo]], but a detailed understanding of those file formats is not necessary for modeling. 


Limitations
===========

-   This method has been developed to allow integrative modeling of complex RNA folds for which some parts can be modeled by homology and others by de novo modeling. It still relies on constraints for long-range contacts like pseudoknots as may be available from phylogenetic analysis or multidimensional chemical mapping approaches like MOHCA-seq or mutate-and-map.

-   The method is not yet a single automated pipeline.

Code and Demo
=============

The main wrapper code is available through installation of [[RNA tools|rna-tools]].

The RNA puzzles have offered useful testbeds of helix modeling, motif homology modeling, de novo modeling, and grafting to larger RNA structures. Examples of all four steps are available in:

`       demos/public/rna_puzzle      `

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

You need two input files to run structure modeling of complex RNA folds:

-   The [[fasta file]]: it is a sequence file for your rna.
-   The [[secondary structure file]]: text file with secondary structure in dot-parentheses notation.

Optional additional files:
--------------------------
-   Any pdb files containing templates for threading.
-   Native pdb file, if all-heavy-atom rmsd's are desired. Must be in Rosetta's [PDB format for RNA](#File-Format).

Making models
===========
Following are examples for a sequence drawn from RNA puzzle 11, a long hairpin with several submotifs. The fasta file `RNAPZ11.fasta` looked like this:

```
> RNAPZ11 (7SK RNA 5' hairpin)
gggaucugucaccccauugaucgccuucgggcugaucuggcuggcuaggcggguccc
```

and the secondary structure file `RNAPZ11.secstruct` for the whole problem looked like this:

```
((((((((((.((((...(((((((....))).)))).))..))...))))))))))
gggaucugucaccccauugaucgccuucgggcugaucuggcuggcuaggcggguccc
```

There are four helices, H1, H2, H3, and H4.

Step 1. Make helices
---------------------------

Helices act as connectors between motifs. It can be useful to pre-build these and keep them fixed during each motif run, as grafting (Step 4 below) requires superimposition between shared pieces of separately built motifs.

A sample command line is the following:

```
rna_helix.py  -o H2.pdb -seq cc gg -resnum 14-15 39-40
```

This application output the helix with chains A and B, but removing the chains prevents some confusion with later steps, so you can run:

```
replace_chain_inplace.py  H2.pdb 
```

To setup the above python scripts, follow the directions for setting up [[RNA tools|rna-tools]].
Example files and output are in:

`       demos/public/rna_puzzle/step1_helix/      `

Step 2. Use threading to build sub-pieces
---------------------------

In the problem above, there is a piece which is a well-recognized motif, the UUCG apical loop.

Let's model it by threading from an exemplar
of the motif from the crystallographic database. There is one here:

Download 1f7y.pdb from `http://pdb.org/pdb/explore/explore.do?structureId=1f7y`.

Slice out the motif of interest:
```
pdbslice.py  1f7y.pdb  -subset B:31-38 uucg_
```

Thread it into our actual sequence:
```
rna_thread -s uucg_1f7y.pdb  -seq ccuucggg -o uucg_1f7y_thread.pdb
```

Let's get the numbering to match our actual test case:

```
renumber_pdb_in_place.py uucg_1f7y_thread.pdb 24-31
```

Example files and output are in:

`       demos/public/rna_puzzle/step2_thread/      `

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


Expected Outputs
================

You will typically use the protocol to produce a silent file – how do you get the models out?
