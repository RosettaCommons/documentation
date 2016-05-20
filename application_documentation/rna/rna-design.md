#RNA 3D design: *rna\_design*

Metadata
========

Author: Rhiju Das

This document updates documentation written in 2008 by Rhiju Das (rhiju [at] stanford.edu) into the latest documentation format. Last update: April 2011.

Code and Demo
=============

The central code for the *rna\_design* application is in `       apps/public/rna/rna_design.cc      ` with core routines run through the Rosetta packer.

For a 'minimal' demo example of RNA design:

`       demos/public/RNA_Design      ` [in the release version]

There is also a nice server available for this code at [rnaredesign.stanford.edu](http://rnaredesign.stanford.edu)

References
==========

 Yesselman, J.D., and Das, R. (2015) "RNA-Redesign: A web server for fixed-backbone 3D design of RNA." Nucleic Acid Research 43 (W1): W498 - W501. [Paper.](https://daslab.stanford.edu/site_data/pub_pdf/2015_Yesselman_NAR.pdf) [Link.](http://nar.oxfordjournals.org/content/43/W1/W498) [Server.](http://rnaredesign.stanford.edu)

Das, R., Karanicolas, J., and Baker, D. (2010), "Atomic accuracy in predicting and designing noncanonical RNA structure". Nature Methods 7:291-294. [Paper.](http://www.stanford.edu/~rhiju/DasKaranicolasBaker2010ALL.pdf) [Link.](http://www.nature.com/nmeth/journal/v7/n4/abs/nmeth.1433.html)

(Reprint available at [http://daslab.stanford.edu/pubs.html](http://daslab.stanford.edu/pubs.html) ).

Purpose
===========================================

This code is intended to carry out fixed backbone design of RNA sequences given an input backbone.

Algorithm
=========

This application carries out combinatorial optimization of nucleobase type and conformation along with 2'-OH torsions, in the context of a pre-specified RNA backbone. It is very similar to the Rosetta fixed-backbone protein design algorithm, and has been used to test the new Rosetta RNA potential. Unfortunately, it is not presently very optimized for speed; the precalculation of rotamer energies takes a while. Runs on RNA backbones longer than \~ten nucleotides take many minutes or hours; algorithm improvements implemented in future releases will greatly speed this up.

Limitations
===========

-   This method does not currently include any optimization of the backbone positions.
-   This method does not yet support the design of a subset of nucleotide positions.
-   For a preview of how to do both effectively, check out the new [[stepwise|stepwise]] framework.

Input Files
===========

Required file
-------------

Just the PDB file with desired backbone.

How to run with this file.
---------------------------

```
rna_design.<exe> -s chunk001_uucg_RNA.pdb   -nstruct 3  -ex1:level 4 -dump -score:weights farna/rna_hires.wts
```

This demo redesigns a 'UUCG' tetraloop on a single-base pair RNA 'helix', as a small 6-nucleotide test case. As illustration, only 3 designs are output. It takes about 15 seconds to run. The typical sequence output is cuuggg (native is cuucgg).

Options
=======

```
-in:file:s                                       Name(s) of single PDB file(s) to process. [FileVector]
-nstruct                                         Number of times to process each input PDB. [Integer]
-ex1:level <n>                                   Use extra chi1 sub-rotamers for all residues that pass
                                                 the extrachi_cutoff.
                                                 [Boolean]
                                                 The integers that follow the ex flags specify the pattern
                                                 for chi dihedral angle sampling.
                                                 There are currently 8 options; they all include the original
                                                 chi dihedral angle No. 4 means: EX_TWO_HALF_STEP_STDDEVS
                                                 [-1,-1/2,0,1/2,1 standard deviations].
-dump                                            Generate pdb output,default:false. [Boolean]
-score:weights farna/rna_hires.wts               Name of weights file, default is standard. [String]
-sample_chi                                      Sample chi (glycosidic torsion angle).
-disable_o2star_rotamers                         Turn off sampling of 2'-OH proton position.
-database                                        (Optional) Path to rosetta databases. Default is based on location of rosetta executables. [PathVector]
```

Tips
====

What do the scores mean?
------------------------

The most common question we get is on what the terms in the 'SCORE lines' of silent files mean. Here's a brief rundown, with more explanation in the papers cited above.

```
***Energy interpreter for fullatom silent output:
score                                            Final total score
fa_atr                                           lennard-jones attractive
fa_rep                                           lennard-jones repulsive
fa_intra_rep                                     Lennard-jones repulsive between atoms in the same residue
lk_nonpolar                                      lazaridis-karplus non-polar solvation energy
hack_elec_rna_phos_phos                          Simple electrostatic repulsion term between phosphates
hbond_sr_bb_sc                                   backbone-sidechain hbonds close in primary sequence
hbond_lr_bb_sc                                   backbone-sidechain hbonds distant in primary sequence
hbond_sc                                         sidechain-sidechain and sidechain-backbone hydrogen bond energy
ch_bond                                          Carbon hydrogen bonds
geom_sol                                         Geometric Solvation energy for polar atoms
rna_torsion                                      RNA torsional potential.
atom_pair_constraint                             Atom pair distance constraints score?
angle_constraint                                 (not in use)
rms                                              rmsd
```

Expected Outputs
================

If you use the sample flag files, there are also other output files generated.

```
start.pdb:                                       Idealized structure
S_000*.pdb:                                      Output of the rna denovo design.
chunk001_uucg_RNA.sequence_recovery.txt:         This is a simple report for design identity of each RNA residue and structure.
chunk001_uucg_RNA.pack.txt:                      Total score and sequence for each output model
chunk001_uucg_RNA.pack.out:                      Scores (with breakdown by score component) for each re-designed sequence
```

##See Also

* [[RNA applications]]: The RNA applications home page
* [[Design Applications]]: List of design applications
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Fixbb]]: Application for fixed-backbone protein design
* [[Application Documentation]]: Home page for application documentation
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [RiboKit](http://ribokit.github.io/): RNA modeling & analysis packages maintained by the Das Lab