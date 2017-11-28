#Fixed backbone design application, "fixbb"

Metadata
========

This document was edited Oct 2015 by Jared Adolf-Bryfogle. The `       fixbb      ` application is maintained by Brian Kuhlman's lab. Send questions to (bkuhlman@email.unc.edu)

Code and Demo
=============

See `       rosetta/main/tests/integration/tests/fixbb      ` for an example of fixed backbone design protocol and input files. A production run can be made from the `       command      ` file by adding the flags -ex1 and -ex2 for the fullatom run. The centroid-mode run is already a "production run" in that it cannot be made to take more time than it does already.

The majority of the classes for the fixbb application live in `       rosetta/main/source/src/core/pack      ` . The main interface class is the `       PackerTask      ` which lives in `       rosetta/main/source/src/core/pack/task      ` . Rotamers are held in instances of class `       RotamerSet      ` which are in turn held in an instance of class `       RotamerSets      ` ; these classes live in `       rosetta/main/source/src/core/pack/rotamer_set      ` . Rotamer-pair energies are held in one of several "interaction graph" classes, which live in namespace `       core::pack::interaction_graph      ` . The annealer classes live in `       rosetta/main/source/src/core/pack/annealer      ` The application itself lives in `       rosetta/main/source/src/apps/public/design/fixbb.cc      ` and invokes the `       PackRotamersMover      ` that lives in `       rosetta/main/source/src/protocols/moves/PackRotamersMover.cc      `

References
==========

We recommend the following articles for further studies of RosettaDesign methodology and applications:

-   Design of a novel globular protein fold with atomic-level accuracy. Kuhlman B, et al.Science. 2003 Nov 21;302(5649):1364-8.
-   A large scale test of computational protein design: folding and stability of nine completely redesigned globular proteins. Dantas G, et al. J Mol Biol. 2003 Sep 12;332(2):449-60.
-   High-resolution design of a protein loop. Hu X, Wang H, Ke H, Kuhlman B. Proc Natl Acad Sci U S A. 2007 Nov 6;104(45):17668-73. Epub 2007 Oct 30
-   Rotamer-Pair Energy Calculations using a Trie Data Structure. A. Leaver-Fay, B. Kuhlman, and J.S. Snoeyink. In WABI 2005. 500-511.
-   An Adaptive Dynamic Programming Algorithm for The Side Chain Placement Problem. A. Leaver-Fay, B. Kuhlman, and J.S. Snoeyink. In PSB 2005. 17-28.
-   On-The-Fly Rotamer Pair Energy Evaluation in Protein Design. A. Leaver-Fay, J.S. Snoeyink, and B. Kuhlman. In ISBRA 2008. 343–354.

Application purpose
===========================================

This application will attempt to optimize sidechain-rotamer placement on a fixed backbone. It may be used to optimize the sidechain positions of an input structure, or to create a new sequence of amino acids that fit upon the original backbone.

Algorithm
=========

The combinatorial optimization problem fixed-backbone repacking (or design) presents is NP-Complete [Pierce & Winfree, 2002]; the algorithm used here is a stochastic simulated annealing approach and does not guarantee optimality of the placed sidechains. However, its running time is quite good; the slow part of a fixed backbone redesign is the precomputation of all rotamer pair energies. Rosetta uses the trie-vs-trie algorithms for computing rotamer pair energies rapidly [Leaver-Fay et al. 2005]; it is currently the only protein-design package to take advantage of the performance boost this algorithm provides. Rotamer-pair-energy precomputation may be traded for on-the-fly energy calculation at a significant speedup with a 95% reduction in memory use [Leaver-Fay et al. 2008].

There are many ways to control the way rotamers are sampled and at which positions design should be attempted. There are several command line flags that apply to all residues. In addition, a "resfile" can specify the way particular residues are to be treated. By default, `       fixbb      ` will attempt to redesign all residues using all amino acids.

Fixed-backbone design works best when paired with a softened Lennard-Jones term [Dantas et al. 2003] which helps overcome the problem of discrete rotamer building (not default). The score function used may be controlled on the command line by specifying a weights file (or both a weights file and a weights-patch file). 

Limitations
===========

There are three serious limitations worth considering: 1) fixed backbone design does not sample backbone conformation space, and therefore cannot guarantee that the new sequence will fold into the desired backbone conformation; 2) since the underlying combinatorial optimization problem is NP-Complete, and our approximation of it is stochastic, the output from separate `       fixbb      ` jobs will vary; 3) the score function used is imperfect such that even the best-scoring designs might not express or fold.

Input Files
===========

1) Structures

At least one input pdb file must always be given. A list of pdbs can be specified on the command line, or in a list file:

-s \<pdb1\> \<pdb2\> \<pdb3\> ...

or

-l \<listfname\>

where listfname is a simple text file that has one pdb file name per line. The fixbb application will apply the PackRotamersMover to each of the input structures given.

2) Control of repacking and design: the Resfile

By default, fixbb will attempt a global redesign of the protein, allowing all residues to change to new amino acid identities. If the option `-packing:repack_only` is given, then design will be turned off, and all positions will be allowed to repack, but will not change residue identities.

The most flexible way to control how fixxbb repacks/designs the protein is with a resfile. A single resfile may be specified on the command line with the -resfile \<fname\> flag. This resfile will be used for all structures that are input. If a resfile cannot be applied to all the structures, then the job should be split up. The resfile format is described here [[Resfile syntax and conventions|resfiles]] Resfile.

Options
=======

Input file specification:

```
-s <pdb> <pdb2>       A list of one or more pdbs to run fixbb upon.
-l <listfile>         A file that lists one or more pdbs to run fixbb upon.
-resfile <fname>      The resfile that is to be used for this job
-packing:repack_only  Turn off all design and only repack residues
-nstruct <int>        The number of iterations to perform per input structure; e.g. with 10 input structures
                      and an -nstruct of 10, 100 trajectories will be performed.
```

Interaction Graph (Default is to precompute all rotamer pair energies)

```
-linmem_ig <int>     Activate the linear-memory interaction graph [Leaver-Fay et al. 2008]
-lazy_ig             Activate the lazy interaction graph
```

Rotamers

```
-ex1                 Increase chi1 rotamer sampling for buried* residues +/- 1 standard deviation
-ex1aro              Increase chi1 rotamer sampling for buried* aromatic** residues +/- 1 standard deviation
-ex2                 Increase chi2 rotamer sampling for buried* residues +/- 1 standard deviation
-ex2aro              Increase chi2 rotamer sampling for buried* aromatic** residues +/- 1 standard deviation
-ex3                 Increase chi3 rotamer sampling for buried* residues +/- 1 standard deviation
-ex4                 Increase chi4 rotamer sampling for buried* residues +/- 1 standard deviation
-ex1:level <int>     Increase chi1 sampling for buried* residues to the given sampling level
-ex1aro:level <int> : Increase chi1 sampling for buried* aromatic residues to the given sampling level
-ex2:level <int>     Increase chi1 sampling for buried* residues to the given sampling level
-ex2aro:level <int> : Increase chi1 sampling for buried* aromatic residues to the given sampling level
-ex3:level <int>     Increase chi1 sampling for buried* residues to the given sampling level
-ex4:level <int>     Increase chi1 sampling for buried* residues to the given sampling level
-preserve_input_cb   Do not idealize the CA-CB bond vector -- instead, use the CB coordinates of the input pdb.
-use_input_sc        Include the side chain from the input pdb.  False by default.  Including the input sidechain
                     is "cheating" if your goal is to measure sequence recovery, but a good idea if your goal is
                     to redesign the input sequence for eventual synthesis.
```

Buried residues are those with \#CBeta-neighbors \>= threshold (default 18) within 10 Angstroms. This threshold can be controlled by the -extrachi\_cutoff flag.

```
-extrachi_cutoff <int> : Set the number of cbeta neighbors (counting its own) at which a residue is considered buried.
                         A value of "1" will mean that all residues are considered buried for the purpose of rotamer building.
```

Aromatic residues are HIS, TYR, TRP, and PHE. Note: Including both -ex1 and -ex1\_aro does not increase the sampling for aromatic residues any more than including only the -ex1 flag. If however, both -ex1 and -ex1\_aro:level 4 are included on the command line, then aromatic residues will have more chi1 rotamer samples than non aromatic residues. Note also that -ex1\_aro can *only increase* the sampling for aromatic residues beyond that for non-aromatic residues. -ex1:level 4 and -ex1\_aro:level 1 together will have the same effect as -ex1:level 4 alone.

Annealer

(Default is the original annealer used in [Kuhlman et al. 2003])

```
-multi_cool_annealer <int>   Use an alternate annealer that spends more time at low temperatures.
                             This annealer produces consistently lower energies than the standard annealer.
```

Other

```
-database <path/to/rosetta/main/database>     Specify the location of the rosetta_database (required)

-overwrite             Overwrite the output files, even if they already exist.

-minimize_sidechains   Follow the packing phase with gradient-based minimization of the sidechains for
                       residues that were either repacked or designed in the packing phase.

-min_type <string>     When combined with the -minimize_sidechains flag, specifies the line-search algorithm to use
                       in the gradient-based minimization . "dfpmin" by default.

-score:weights <wts_file>           Set the weights file to be used.
-score:weights_patch <patch_file>   Set the weights patch file to be used.
```

If neither the -score:weights nor the -score:weights\_patch flags are used, then "score12" will be used by default.

```
-constant_seed         Fix the random seed
-jran <int>            Specify the random seed; if unspecified, and -constant_seed appears on the command line,
                       then the seed 11111111 will be used
```

Tips
====

-   The flags -ex1 and -ex2 are recommended to get well-packed output structures.
-   A two-line resfile where the first line is "NATAA" and the second line is "start" is sufficient to say "only repack the input sequence"
-   If you are redesigning with many rotamers (\>6K) then using the linear-memory interaction graph will save both time and memory. Win/win.

Expected Outputs
================

The structure from the end of the execution will be written out to a .pdb file, and the score for that structure will be written to the score file, score.sc. The .pdb file will be named with the input file + job number.pdb. "-s 1ubq.pdb" produces the output file 1ubq\_0001.pdb.

Because the `       fixbb      ` application uses the JD2 job-distributor, it respects all of the jd2 flags that control output.

Post Processing
===============

The fixbb application is commonly used for sequence-recovery tests; the python script pdb2fasta.py [APL: working on getting this file in trunk] converts a pdb file to a fasta file for ease of sequence comparison.

New Features In Rosetta3.2
==========================

Rosetta3.2 includes the Lazy Interaction Graph which had not yet been ported from Rosetta++ in version 3.1.

New Features in Rosetta 3.8
===========================

Rosetta 3.8 includes various design-centric score terms, such as [[aa_composition|AACompositionEnergy]] (which penalizes devations froma desired amino acid composition), [[netcharge|NetChargeEnergy]] (which penalizes deviations from a desired net charge), and [[hbnet|HBNetEnergy]] (which provides an energetic bonus for hydrogen bond networks).  These can be used with the fixbb application to guide the design process, to promote desired features.  See the documentation for each of these score terms for more details.

##See Also

* Fixbb can be run with the [[ hpatch score term| fixbb-with-hpatch ]] to prevent the development of surface hydrophobic patches
* [[Rosetta Design Server (external link)|http://rosettadesign.med.unc.edu/]]: Web-based server for fixed backbone design
* [[Design applications | design-applications]]: other design applications
* [[PackRotamersMover]]: RosettaScripts mover for rotamer repacking/design
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
* [[AACompositionEnergy]]: Guides the Rosetta packer to solutions with a desired amino acid composition.
* [[NetChargeEnergy]]: Guides the Rosetta packer to solutions with a desired net charge.
* [[HBNetEnergy]]:  Guides the Rosetta packer to solutions with hydrogen bond networks.
