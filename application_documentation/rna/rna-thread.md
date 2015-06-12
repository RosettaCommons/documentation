#Documentation for RNA threading and mutation: *rna\_thread*

Metadata
========

Author: Rhiju Das

Added to documentation: June 2013

Code and Demo
=============

The central code for the *rna\_thread* application is in `       apps/public/rna/rna_thread.cc      `

For a 'minimal' demo example of RNA threading:

`       demos/public/rna_thread      `

of the simpler RNA mutation:

`       demos/public/rna_mutate      `

References
==========

This threading code is currently not described in any publication.

Application purpose
===========================================

This code is intended to thread new sequences onto previously solved RNA coordinates ('templates') for RNA homology modeling.

Algorithm
=========

Limitations
===========

-   Within Rosetta, this code does not preserve the fold-tree
-   The code has not been optimized for speed and is not encapsulated into a class yet.

Input Files
===========

Required files
-------------

-   The template PDB file. Must be in Rosetta RNA format (see [[Documentation for RNA 3D structure modeling|rna-denovo]] )
-   An alignment fasta file. Example:

```
> GIR1 group-I like ribozyme in I-DirI gene from D. iridis
gguuggguugggaaguaucauggcuaaucaccaugaugcaaucggguugaacacuuaau----------------------uggguuaaa-acgg-----------------------------------ugggggacgaucccguaacauccguccuaa---------------------------------cggcgacagacugcacggcccu----------------------------------------------gccucuuagguguguucaau---gaacagucguucc------------------gaaaggaagcauccgguaucccaagacaauc

>3bo3_REARRANGE.pdb
----------------------------------------gccgugugccuugc-----gccgggaaaccaga-------uggugucaaauucggcgaaaccuaagcgcccgcccgggcguauggcaacg---------------------ccgagccaagcuucgcagccauugcacuccggcugcgaugaagguguagagacuagacggcacccaccuaaggcaaacgcuauggugc---------------------------------gcaaggcauaaggcauaguccagggaguggcgaagccacacaa----accag---acggcc-------------
```

If you just want to mutate sequence, can supply this on command line by -seq; see below rna\_mutate.

How to run with this file.
---------------------------

```
rna_thread.<exe> -in:file:fasta 3bo3_REARRANGE_to_GIR1.fasta -s 3bo3_REARRANGE.pdb  -o 3bo3_REARRANGE_to_GIR1_thread.pdb -seq_offset 63
```

This demo threads a group I intron crystallographic structure (3bo3\_REARRANGE) into the group-I-like branching ribozyme GIR1, and was used in the fifth RNA puzzle trial.

Options
=======

```
-in:file:s                     Name of single PDB file with template coordinates
-in:file:fasta                 Name of alignment file in FASTA format. First sequence should be
                                target sequence, and second sequence should template sequence
-o                             Name of output PDB file
-seq_offset                    [optional] Integer to be added to residue numbers for output. [default=0]
-seq                           [alternative to -in:file:fasta] sequence of output PDB. Must have
                                same number of residues as template PDB.
```

Other
=====

If you just want to mutate some positions in an RNA and don't want to create a fasta file, you can run a command line like:

```
rna_thread -s rosetta_inputs/1zih_RNA.pdb  -seq gggcgcgagccu -o 1zih_A7G.pdb
```

##See Also

* [[RNA applications]]: List of RNA applications
* [[Utilities Applications]]: List of utilities applications
* [[Application Documentation]]: Home page for application documentation
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Fixbb]]: App commonly used for design and/or threading with proteins
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files