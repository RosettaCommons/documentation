#RNA assembly with experimental pair-wise constraints

Metadata
========

Author: Rhiju Das

Nov. 2011 by Rhiju Das (rhiju [at] stanford.edu).

Code and Demo
=============
**IMPORTANT NOTE: a more efficient tertiary assembly pipeline is now available, briefly described in the Supplementary Information  of the MOHCA-seq paper [here](http://dx.doi.org/10.7554/eLife.07600) and in the Methods in Enzymology chapter [here](https://daslab.stanford.edu/site_data/pub_pdf/2015_Cheng_MethEnzym.pdf). See also [[rna-denovo-setup]].**


This code allows the modeling of large RNAs with multiple helices, by assembling models of helices and noncanonical motifs in a sort of hierarchical buildup strategy. The central code is in the *rna\_denovo* and *rna\_helix* applications are in `       src/protocols/rna/RNA_DeNovoProtocol.cc      ` and in `       src/protocols/rna/RNA_HelixAssembler.cc      ` .

For the full workflow check out:

`       rosetta_demos/public/RNA_Assembly      `

NOTE: This pipeline is largely deprecated; a new one, based on use of MOHCA-seq data and experience in the RNA puzzles trials, will be documented soon. Some info here: [[http://biorxiv.org/content/early/2014/04/25/004556]].

References
==========

Kladwang, W., VanLang, C.C., Cordero P., and Das, R. (2011) "A two-dimensional mutate-and-map strategy for non-coding RNA structure", Nature Chemistry 3: 954-962. [Paper](http://www.stanford.edu/~rhiju/KladwangVanlangCorderoDas_NatChem_2011_ALL.pdf) [Link](http://www.nature.com/nchem/journal/v3/n12/abs/nchem.1176.html)

Application purpose
===========================================

This code is intended to take an RNA sequence and secondary structure and then give three-dimensional de novo models of the helices and inter-helical motifs, and then build up the complete model from these parts.

Algorithm
=========

This method pipelines FARFAR (Rosetta denovo modeling) for noncanonical interhelical motifs and a fast helix buildup method to an assembly procedure (also using the Rosetta de novo modeling code) to create large RNA 3D models.

Limitations
===========

-   The protocol is a bit inflexible in that the motifs are modeled separately from each other – if a loop/loop interaction occurs in the final global model it will not really be modeled correctl by the isolated loops. We are working on iterative methods to tackled this global de novo assembly question. For now the protocol seems to work well if there are experimental constraints that e.g., connect the loops.

-   Currently the method works best (helix-level resolution, \~6-9 A rmsd) when given experimental pair-wise constraints; it was therefore first published making use of the Das lab's mutate-and-map information-rich chemical probing methodology for RNAs.

-   The assumed secondary structure must be non-nested (any pseudoknot interactions will not be modeled, unless specified as constraints during global assembly; note that this has not yet been tested extensively).

-   Due to memory limitations, the number of models for each submotif is limited to a few thousand. When they are assembled, this can lead to a paucity of good structures that satisfy all constraints, and an apparent 'overconvergence' in the final assembly job. It is therefore recommended to do at least two totally independent runs of the motif jobs and assembly jobs. Future versions will likely avoid this by using an iterative rebuild-and-refine procedure.

Modes
=====

There is only one mode to run RNA Assembly at present.

Input Files
===========

Required file
-------------

You need two files:

-   The [[fasta file]]: it is a sequence file for your rna. The fasta file has the RNA name on the first line (after \>), and the sequence on the second line. Valid letters are a,c,g, and u. The example fasta file is available in `        main/tests/integration/tests/rna_denovo/       ` .

-   The secstruct secondary structure file: the secondary structure that you are assuming. This file needs to be a text file with one line, giving the RNA secondary structure in dot bracket notation. For example '((....))' denotes a hairpin structure in which the first two and last two bases are paired.

Optional additional files:
--------------------------

-   A [[constraint file]]. This can specify bases that should make contact, based on experimental or phylogenetic information. See below for an example.
-   Native pdb file, if all-heavy-atom rmsd's are desired. Must be in Rosetta's PDB [[Format|rna-denovo#File-Format]] for RNA.

How to run the job
------------------

The general workflow can be setup through a python script, available in the rosetta\_demos/RNA\_Assembly/ directory.

```
  python scripts/setup_rna_assembly_jobs.py  add.fasta add_secstruct.txt 1y26_RNA.pdb  add_mutate_map_threetertiarycontacts.cst
```

The first two arguments are required – the sequence\_file and the secondary structure file [either in dot/bracket notation, or specifying Watson/Crick base pairs as pairs of numbers]. The last two arguments are optional; they supply the native pdb and any constraints, here derived from a high-throughput "mutate-and-map" strategy for RNA structure determination.

You may need to change the path to your rosetta executable in setup\_rna\_assembly\_jobs.py [in which case you should get a warning!]

Then run the Rosetta commands in :

```
 README_STEMS  [creates helical stems]
 README_MOTIFS  [creates interhelical noncanonical motifs]
 README_ASSEMBLE [assembles the stems and motifs]
```

You can see examples of these files and their output in example\_output/. Please note that you can reduce or increase the number of models per motif with the 'nstruct' models; for a quick run through, you could change these to 2. In reality you will want to make 2000-4000 MOTIF models, and then several thousand ASSEMBLE models. [You can just use one STEM model per helix, as that is supposed to be an ideal helix.] The helical stem building should take only a few seconds per helix. The motif modeling will take longer – about 1 minute per model. The final assembly jobs will take 2-3 minutes per model for a 100-nt RNA, and longer for larger molecules.

Command-lines in some more detail.
---------------------------

The above workflow should work, but its worth looking at the rosetta command-lines in the README files to see what's going on. First, ideal A-form helices can be created with the command line:

```
rna_helix.<exe> -database <path to database> -nstruct 1 -fasta stem2_add.fasta -out:file:silent stem2_add.out
```

where the file stem2\_add.fasta contains the sequence of the P2 helix, as determined by your secondary structure. It looks like:

```
>stem2_add.fasta
uccuaauuggga
```

Then, for each RNA loop or junction motif that interconnects these helices, 4,000 models will be created with FARFAR. For example, in the adenine riboswitch, two loops (L2 & L3) and the adenine-binding junction are the non-helical motif portions. The command line for building L2 onto the P2 helix is:

```
rna_denovo.<exe> -database  <path to database> -native motif2_1y26_RNA.pdb -fasta motif2_add.fasta -params_file motif2_add.params -nstruct 100 -out:file:silent motif2_add.out -cycles 5000 -mute all -close_loops -close_loops_after_each_move -minimize_rna -close_loops -in:file:silent_struct_type rna -in:file:silent  stem2_add.out -input_res  1-6 16-21
```

Here, the optional “-native” flag, inputting the crystallographic structure for the motif, permits rmsd calculations but is not used in building the model. The file motif2\_add.params defines the P2 stem within this motif-building run:

```
STEM    PAIR 6 16 W W A PAIR 5 17 W W A PAIR 4 18 W W A PAIR 3 19 W W A PAIR 2 20 W W A PAIR 1 21 W W A
OBLIGATE PAIR 1 21 W W A
```

Finally, the models of separately built motifs and helices are assembled through the FARNA Monte Carlo procedure. We do not carry out refinement here due to the expense for large RNAs. The most important thing to get an accurate structure are the constraints. Here is the command line:

```
rna_denovo.<exe> -database  <path to database> -native 1y26_RNA.pdb -fasta add.fasta -in:file:silent_struct_type binary_rna  -cycles 10000 -nstruct 200 -out:file:silent add_assemble.out -params_file add_assemble.params -cst_file add_mutate_map_threetertiarycontacts_assemble.cst -close_loops  -in:file:silent  stem1_add.out stem2_add.out stem3_add.out motif1_add.out motif2_add.out motif3_add.out -input_res   1-9 63-71 13-18 28-33 42-47 55-60 1-18 28-47 55-71 13-33 42-60
```

In the above command-line, the helix and loop definitions are given by add\_assemble.params:

```
CUTPOINT_CLOSED  9 18 47
STEM  PAIR 1 71 W W A  PAIR 2 70 W W A  PAIR 3 69 W W A  PAIR 4 68 W W A  PAIR 5 67 W W A  PAIR 6 66 W W A  PAIR 7 65 W W A  PAIR 8 64 W W A  PAIR 9 63 W W A
OBLIGATE PAIR 9 63 W W A

STEM  PAIR 13 33 W W A  PAIR 14 32 W W A  PAIR 15 31 W W A  PAIR 16 30 W W A  PAIR 17 29 W W A  PAIR 18 28 W W A
OBLIGATE PAIR 18 28 W W A

STEM  PAIR 42 60 W W A  PAIR 43 59 W W A  PAIR 44 58 W W A  PAIR 45 57 W W A  PAIR 46 56 W W A  PAIR 47 55 W W A
OBLIGATE PAIR 47 55 W W A
```

The constraint file add\_mutate\_map\_threetertiarycontacts\_assemble.cst encodes regions in tertiary contact (here including the short two-base-pair helix) inferred from the mutate-and-map data:

```
[ atompairs ]
N3 10 N3 39 FADE -100 10 2 -20.0
N3 10 N1 40 FADE -100 10 2 -20.0
N1 11 N3 39 FADE -100 10 2 -20.0
N1 11 N1 40 FADE -100 10 2 -20.0
N1 12 N1 40 FADE -100 10 2 -20.0
N3 10 N3 39 FADE -100 10 2 -20.0
N1 25 N3 49 FADE -100 10 2 -20.0
N1 25 N3 50 FADE -100 10 2 -20.0
N1 26 N3 48 FADE -100 10 2 -20.0
N1 26 N3 49 FADE -100 10 2 -20.0
N1 26 N3 50 FADE -100 10 2 -20.0
N3 27 N3 49 FADE -100 10 2 -20.0
N3 27 N3 50 FADE -100 10 2 -20.0
N3 35 N1 40 FADE -100 10 2 -40.0
N1 34 N3 41 FADE -100 10 2 -40.0
```

These constraints give a bonus of –20.0 kcal/mol if the specified atom pairs are within 8 Å; the function interpolates up to zero for distances by a cubic spline beyond 10.0 Å. Note that the Rosetta numbering here starts with 1 for the first nucleotide of the 71-nucleotide adenine binding domain, and is offset by 12 from the numbering in the crystal structure 1Y26.

Options
=======

Some options are similar to those in RNA de novo modeling, but they have not been tested extensively. See [[Documentation for RNA 3D structure modeling|rna-denovo]].

Expected Outputs
================

At the end of the protocol, your final models will be in a silent file called \*\_assemble.out. You can view scores, cluster, and extract pdb files. See [[Documentation for RNA 3D structure modeling|rna-denovo]].

New things since last release
=============================

This application is new as of Rosetta 3.4.

##See Also

* [[RNA Denovo]]: The main rna_denovo application page
* [[RNA applications]]: The RNA applications home page
* [[Structure Prediction Applications]]: List of structure prediction applications
* [[RNA applications]]: The RNA applications home page
* [[Structure Prediction Applications]]: List of structure prediction applications
* [[Application Documentation]]: Home page for application documentation
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files