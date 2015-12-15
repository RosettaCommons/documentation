## Overview
RNA *de novo* modeling was originally written into Rosetta by R. Das in late 2006, back when it was `rosetta++`, and gradually accreted additional functionalities, such as post-fragment-modeling minimization (fragment assembly of RNA with full-atom minimization, FARFAR). A bit of the code was put into object-oriented form in 2010-2011 with the migration to Rosetta 3 ('minirosetta') and tests of a `coarse_rna` modeling scheme (never published). But the code was due for a reorganization as additional functions started to be introduced or envisioned – e.g., chemical shift scoring, general 'chunk' fragments (not contiguous in sequence), modeling or refinement of sub-poses of larger poses – and as better practices for Rosetta coding were established. 

In 2015-2016, the Das lab seeks to test an integration of stepwise modeling with [[FARNA/FARFAR|rna-denovo]]. This has required encapsulation of FARNA functionality into a single class and has presented an opportunity to organize sub-functionalities into different sub-namespaces/sub-directories. 

This document outlines the [current organization](##The classes) for developers, including notes on anticipated additions including handling of RNA/protein interfaces & job specification using the much cleaner flags & setup functions developed for `stepwise` (see [To Do](###To do) at bottom of this document).

## The classes
### Two wrappers `FARNA_Optimizer` and `RNA_DeNovoProtocol`


### Core protocol: 

### Sub-namespaces
####`base_pairs/`
This directory is meant to handle information on where base pairs and
base pair steps are located in the pose for FARNA runs.

+ `RNA_BasePairHandler` handles locations in pose of base pairs, base_pair_steps, any chain_connections (two segments that are supposed to have a pair between them somewhere). Also handles `setup_base_pair_constraints()`.
Note: Would be great to have a proper RNA secondary structure information object specifiable by user and stored in the pose (see To Do below) -- at that point, this class would handle the conversion from that class into parameters used by FARNA.
 
+ `BasePairStep.cc` holds information on an object like this:
```
 5'-- ( i )     --   ( i+1) -- 3'
        |               |
        |               |
 3'-- (j+q+1)         ( j ) -- 5'
          \           /
            n - n - n
      allowing bulges (n's) on the second strand
```
One side has to involve two contiguous nucleotides. 
The other side involves nucleotides with a maximum separation of 3 nucleotides.
The pairs that bracket the step do not have to be Watson-Crick.
I was testing whether storage of these steps drawn from the crystallographic database
would allow for rapid recognition of motifs (it does, but you have to know which
residues are paired).
Note: not unified with `core::rna::BasePair`, i.e. no storage of Watson-Crick edges or orientations. Keeping track of that information leads to very sparse databases.

#### `fragments`
+ `FullAtomRNA_Fragments`
+ `RNA_Fragments`

#### `libraries`
+ `BasePairStepLibrary`
+ `ChunkSet`
+ `RNA_ChunkLibrary`
.//libraries/RNA_JumpLibrary.cc
.//libraries/RNA_LibraryManager.cc
.//movers/RNA_FragmentMover.cc
.//movers/RNA_JumpMover.cc
.//movers/RNA_LoopCloser.cc
.//movers/RNA_Minimizer.cc
.//movers/RNA_Relaxer.cc
.//options/RNA_BasicOptions.cc
.//options/RNA_DeNovoProtocolOptions.cc
.//options/RNA_FragmentMonteCarloOptions.cc
.//options/RNA_MinimizerOptions.cc
.//RNA_DeNovoProtocol.cc
.//RNA_FragmentMonteCarlo.cc
.//secstruct/RNA_SecStructInfo.cc
.//setup/RNA_DeNovoParameters.cc
.//setup/RNA_DeNovoPoseSetup.cc
.//util.cc

### To do
#### FARNA
* **Important** Proper RNA_SecStructInfo objects, including noncanonical pairings and setup of base pair steps inside Rosetta
* change default FARNA setup to stepwise setup (incl. -in:file:silent stored in FullModelInfo or FullModelParameters?). There is an issue discussion thread [here](https://github.com/RosettaCommons/main/issues/25).
*A good time to do this might be when Kalli generalizes FARNA to include RNA-protein lo-res potential. Rebuilding an RNA pair within the MS2 test case is a good example.*
* native RMSD screen in FARNA (to more stringently test idea that stepwise -lores can offer better sampling than classic FARNA) *Again, Kalli's work on RNP lores modeling offers good test case.*
* test on more complex cases (e.g., tectoRNA, riboswitches) *Will test when Clarence/Caleb have MOHCA-seq benchmark set up. Note that we need a bunch of integration tests; see issue thread [here](https://github.com/RosettaCommons/main/issues/18)*
* Fix bulge BPS databases, which now require filtering for wrong fold-tree entries.
* setup ‘long-distance’ BPS (>3 intervening nts)

#### Stepwise-lores  *(low priority since not seeing many wins compared to FARNA)*
* Make sure base-pair-step setup decides on the number of intervening residues based on PDBinfo or full_model_info (if defined).
* 'focus' fragments near site of stepwise addition/deletion (low priority)
* setup move to add triples and resample based on a triplet database.
* autorecognition of long stretches of sequence identity (e.g., >5 nts) — hold NR2015 as silent files in the database.
