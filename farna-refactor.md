## Overview
RNA *de novo* modeling was originally written in Rosetta by R. Das in late 2006, back when the code was in `rosetta++`. It gradually accreted additional functionalities, such as post-fragment-modeling minimization (fragment assembly of RNA with full-atom minimization, FARFAR). A bit of the code was put into object-oriented form in 2010-2011 with the migration to Rosetta 3 ('minirosetta') and tests of a `coarse_rna` modeling scheme (never published). But the code was due for a reorganization as additional functions started to be introduced or envisioned – e.g., chemical shift scoring, general 'chunk' fragments (not contiguous in sequence), modeling or refinement of sub-poses of larger poses – and as better practices for Rosetta coding were established. 

In 2015-2016, the Das lab seeks to test an integration of stepwise modeling with [[FARNA/FARFAR|rna-denovo]]. This has required encapsulation of FARNA functionality into a single class and has presented an opportunity to organize sub-functionalities into different sub-namespaces/sub-directories. 

This document outlines the [current organization](#the-classes) for developers, including notes on anticipated additions including handling of RNA/protein interfaces & job specification using the much cleaner flags & setup functions developed for `stepwise` (see [To Do](#to-do) at bottom of this document).

One semantic note: The terms *FARNA* and *FARFAR* are now preferred throughout the code to refer to the actual fragment assembly Monte Carlo protocol, which can now be accessed through `rna_denovo` but also through `stepwise` or, in principle, anywhere else in the code, e.g. for refinement of RNA pieces of poses. The term *RNA_DeNovo* or *rna_denovo* are retained in a few places to signify old wrapper code specific to the `rna_denovo.cc` application with `.params` input for the more specific use case of modeling RNA from extended chain.


## The classes of `protocols::farna`
### Two wrappers, `RNA_DeNovoProtocol` and `FARNA_Optimizer`
+ `RNA_DeNovoProtocol` is the 'classic' wrapper, itself setup by the `rna_denovo.cc` application. It loops over the `nstruct` poses that need to be built and kicks off instances of RNA_FragmentMonteCarlo, and then outputs those poses to silent files. It is also in charge of the input from `.params` files (hopefully to be deprecated soon). Note: this could/should be handled by a JobDistributor, and should migrate to `JD3` when that's ready.

+ `FARNA_Optimizer` is a more bare-bones wrapper that doesn't do any fancy silent file input/output. It was coded up for use within `stepwise` runs, testing the `-lores` flag where 100 cycles of FARNA are carried out. Briefly described on the [[stepwise|stepwise-lores]] page. Its the reasonable object to use to call FARNA within more complex workflows, including motif-by-motif refinement of big RNA poses (which doesn't exist yet).

### Core protocol: `RNA_FragmentMonteCarlo`
`RNA_FragmentMonteCarlo` is the main protocol setting up all libraries: 
+ It runs through each stage of fragment assembly. In classic runs, the fragment size increases from 1 to 2 to 3. Constraint strength and score terms that favor co-axial base pairs/stacks are gradually ramped up in weight. 
+ It actually carries out the three kinds of FARNA moves: fragment insertion, jump (base pair) moves, and 'chunk' moves. 
+ It checks filters at various stages (resetting if the filters fail).  
+ It also holds some functions for computing RMSD. Might be better to move those out somewhere.

There is one important/tricky concept in RNA_FragmentMonteCarlo, an object called `atom_level_domain_map`, which is a `protocols::toolbox::AtomLevelDomainMap`. This holds for each atom in the pose an assignment of where that residue came from, and demarcates where fragments/jumps/chunks can be inserted at atom level.  

The convention is as follows:   
+ 0 marks totally free atoms.  
+ 1,2,...998 marks atoms that came from fixed input domains (e.g, PDBs), with a different index for each PDB.  
+ 999 is special, marking absolutely fixed atoms that did not come from an input domain (e.g., virtual phosphates that don't need to get moved during FARNA)  
+ 1000 is special (ROSETTA_LIBRARY_DOMAIN) and marks atoms that are covered by a [BasePairStepLibrary](#BasePairStepLibrary)  

### Sub-namespaces, in order of importance
#### `protocols::farna::movers` namespace
+ `RNA_FragmentMover` holds a `RNA_Fragments` library and actually makes fragment moves on a `pose`.
Note: This is where we could put in functionality to, e.g., choose fragments of longer length if they have sequence-matches to the desired pose. This is also where we could put chemical-shift-based weighting of fragment choices. Would need to define weights for each possible fragment, and update random choice to reflect those weights, but that should be easy (there's some code in `stepwise::monte_carlo::mover::StepWiseMoveSelector` that we could share.) 

+ `RNA_JumpMover` holds an `RNA_JumpLibrary` and actually makes jump moves on a `pose`

+ `RNA_Minimizer` carries out 2'-OH packing and full-atom minimizing in two rounds. The first round prevents 'blow up' of FARNA conformations from clashes by coordinate constraints.

+ `RNA_LoopCloser` looks over a `pose` and applies CCD (cyclic coordinate descent) loop closure to any segments with chainbreaks and CUTPOINT_UPPER/CUTPOINT_LOWER variants (as specified by 'cutpoints_closed', or created during setup)

+ `RNA_Relaxer` is not really in use. Use at your own risk.

#### `protocols::farna::fragments` namespace
+ `RNA_Fragments` is a base class for reading fragments from a database on disk and storing torsions.

+ `FullAtomRNA_Fragments` is specific to Rosetta poses with `fa_standard`-type RNA residues.
It generates culled lists of, e.g., 1-residue, 2-residue fragments, for particular sequences 'just-in-time'. (Note that while the object is kept const during the run, the just-in-time info is stored in a mutable map -- kind-of a standard hack.)
Default library is `database/sampling/rna/RICHARDSON_RNA09.torsions`, but should be updated to `NR2015` from Motif Atlas.
Note: This class could be extended to hold LarmorD-predicted atom-level chemical shifts and nucleotide-level chemical reactivities (to DMS, SHAPE, etc.) for each database RNA structure.

These classes were developed separately from protein fragment classes whose definitions were in flux at the time of coding the RNA protocols; it might be worth unifying the two, although its hard to imagine use cases that demand it.

There is also a (largely deprecated) class called `protocols::coarse_rna::CoarseRNA_Fragments` that inherits from `RNA_fragments` for poses that use coarse-grained RNA residue types with 3 dummy chains on the backbone and 3 in the base.

Hey, maybe this should be a sub-namespace of libraries...

#### `protocols::farna::libraries` namespace
+ `RNA_LibraryManager` manages singletons of each library read from disk. Use it to read relevant libraries once.
In addition to holding the `RNA_Fragments`, its got `RNA_JumpLibrary` and `BasePairStepLibrary`, for now.

+ `RNA_JumpLibrary` holds jumps read from the Rosetta database of jumps. By default, only drawn from the 1jj2 ribosome for now? `database/sampling/rna/1jj2_RNA_jump_library.dat`, but this should minimally be updated to an RNA11 database (which exists in the database as `RNA11_full.jump`), or even to NR2015.
Note: should be general to RNA/protein too, but those jumps haven't been implemented.

+ `BasePairStepLibrary` holds coordinates of base pair steps (see [BasePairStep](#BasePairStep)) read from databases on disk. It actually just registers which files are on disk and then reads in the silent files 'just in time' during the run. Example file: `database/sampling/rna/base_pair_steps/general/bulge_1nt/ag_unu.out.gz` hold coordinates of 4 residues of two base pairs from a base pair step in which one strand has sequence `ag` and the other has sequence `unu` (`n` means any nucleotide).

+ `RNA_ChunkLibrary` is an important object in `RNA_FragmentMonteCarlo` that holds base pair steps and any coordinates from user-input PDBs or silent files. It also is responsible for creating the `AtomLevelDomainMap` (shared by numerous movers [above](##the-classes-of-protocols-farna_core-protocol-rna_fragmentmontecarlo)).

+ `ChunkSet`
Object that holds coordinates of input PDBs or base pair steps, in compact `MiniPose` format. 
Note: should be general to combined RNA/Protein chunks, but hasn't been tested.

#### `protocols::farna::options` namespace
Options are like a Russian doll of nested classes:
+ `RNA_BasicOptions` has the most basic options, e.g., `dump_pdb`

+ `RNA_MinimizerOptions` inherits from `RNA_BasicOptions` and adds minimizer-specific options.

+ `RNA_FragmentMonteCarloOptions` inherits  from `RNA_MinimizerOptions` and adds a bunch of fragment modeling options, including number of cycles `monte_carlo_cycles`, whether to minimize or not `minimize_structure`, filters like `filter_lores_base_pairs`, and names of input PDB files.

+ `RNA_DeNovoProtocolOptions` inherits from `RNA_FragmentMonteCarloOptions` and adds a few i/o options, including number of models `nstruct`.

####`protocols::farna::base_pairs` namespace
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


#### `protocols::farna::secstruct` namespace
+ `RNA_SecStruct` is meant to be a general class that stores actual pairings and can handle input/output of dot-paren notation like `(((....)))` for a hairpin. Its still a bit crude, in that its primary datum is a string and not a list of pairs, which would be more fundamental. It also cannot input/output arbitrary #'s of pseudoknots, just three layers as dictated by `(`,`)`; `[`,`]`; and `{`,`}`. See also [[rna-secondary-structure-file]].

+ `RNA_SecStructLegacyInfo` currently holds *1D* information on secondary structure
This class was derived to match Rosetta protein modeling (which holds 1D information on alpha-helix,beta-sheet, or loop). 


#### `protocols::farna::setup` namespace
+ `RNA_DeNovoSetup` allows FARNA to now bypass the legacy `.params`-file based input and instead directly take from command-line `-sequence`, `-secstruct`, `-obligate_pair`. (see [[RNA DeNovo docs|rna-denovo]])
+ `RNA_DeNovoPoseInitializer` holds code for taking `.params` information and creating a fold-tree and cutpoints for a new pose. (may become deprecated if we use build_full_model from stepwise to initialize the pose after `RNA_DeNovoSetup`). 
+ `RNA_DeNovoParameters` is responsible for reading in `.params` files (now legacy code).

## To do
#### FARNA setup
* change default FARNA setup to stepwise setup (incl. -in:file:silent stored in FullModelInfo or FullModelParameters?). There is an issue discussion thread [here](https://github.com/RosettaCommons/main/issues/25).  We're part way there after importing the functionality of `rna_denovo_setup.py` into the RNA_DeNovoSetup class, which handles residue mapping to subproblems. Now just need to run `build_full_model` to generate initial poses. *A good time to test this might be when Kalli generalizes FARNA to include RNA-protein lo-res potential. Rebuilding an RNA pair within the MS2 test case is a good example.*
* native RMSD screen in FARNA (to more stringently test idea that stepwise -lores can offer better sampling than classic FARNA) *Again, Kalli's work on RNP lores modeling offers good test case.*
* test on more complex cases (e.g., tectoRNA, riboswitches) *Will test when Clarence/Caleb have MOHCA-seq benchmark set up. Note that we need a bunch of integration tests; see issue thread [here](https://github.com/RosettaCommons/main/issues/18)* 

#### FARNA base-pair-step sampling (exploratory)
* Fix bulge BPS databases, which now require filtering for wrong fold-tree entries.
* setup ‘long-distance’ BPS (>3 intervening nts)

#### Stepwise-lores  *(low priority since not seeing many wins compared to FARNA)*
* Make sure base-pair-step setup decides on the number of intervening residues based on PDBinfo or full_model_info (if defined).
* 'focus' fragments near site of stepwise addition/deletion (low priority)
* setup move to add triples and resample based on a triplet database.
* autorecognition of long stretches of sequence identity (e.g., >5 nts) — hold NR2015 as silent files in the database.

#### Benchmarking
* Some notes on how to benchmark FARNA updates, and additional ideas for improving low-res assembly are in [this Das Lab google doc](https://docs.google.com/spreadsheets/d/1bARG3MlTCGeOvjQXr7lheyODoOH2FD7HxE6KX7_brJ0/edit#gid=5)