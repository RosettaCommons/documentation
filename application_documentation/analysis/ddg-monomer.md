#ddg\_monomer application

Metadata
========

Author: Andrew Leaver-Fay and Elizabeth Kellogg

The documentation was last updated March 26th, 2015, by Shane Ó Conchúir. Questions about this documentation should be directed to David Baker: (dabaker@u.washington.edu).

Code and Demo
=============

The ddg\_monomer application lives in rosetta/main/source/src/apps/public/ddg/ddg\_monomer.cc (This file had previously been named "fix\_bb\_monomer\_ddg.cc", but has been renamed since it now moves the backbone). This file houses the main() function. The central subroutines invoked by this file live in the ddGMover class defined in rosetta/main/source/src/protocols/moves/ddGMover.hh and rosetta/main/source/src/protocols/moves/ddGMover.cc.

A helper application, minimize\_with\_cst, lives in rosetta/main/source/src/apps/public/ddg/minimize\_with\_cst.cc.

A helper script for generating one of the input files needed by the ddg\_monomer application lives in rosetta/main/source/src/apps/public/ddg/convert\_to\_cst\_file.sh.

An integration test for this application lives in rosetta/main/tests/integration/tests/ddG\_of\_mutation/. The test in this directory runs a shortened trajectory for predicting the wild-type and mutant energies. To turn this into a production-run example, set the value for the "-ddg:iterations" flag given in the file "rosetta/main/tests/integration/tests/ddG\_of\_mutations/flags" to 50.

References
==========

The new algorithm for performing limited relaxation of the backbone was published in:

E. Kellogg, A. Leaver-Fay, and D. Baker, (2011) "Role of conformational sampling in computing mutation-induced changes in protein structure and stability", Proteins: Structure, Function, and Bioinformatics. V 79, pp 830–838.

The older, fixed-backbone, soft-repulsive scorefunction algorithm (analogous to that described in row 4 of [Kellogg 2011] but with weights trained towards recapitulating alanine-scanning mutation experiments. weights are in rosetta/main/database/scoring/weights/ddg\_monomer.wts) was published in:

Kortemme et al. (2002) "A simple physical model for binding energy hot spots in protein-protein complexes", PNAS 22, 14116-21

Purpose
===========================================

The purpose of this application is to predict the change in stability (the ddG) of a monomeric protein induced by a point mutation. The application takes as input the crystal structure of the wild-type (which must be first pre-minimized), and generates a structural model of the point-mutant. The ddG is given by the difference in rosetta energy between the wild-type structure and the point mutant structure. More precisely, 50 models each of the wild-type and mutant structures should be generated, and the most accurate ddG is taken as the difference between the mean of the top-3-scoring wild type structures and the top-3-scoring point-mutant structures.

Rosetta follows the convention that negative ddG values indicate increased stability _i.e._ ddG = mutant energy - wildtype energy.

Algorithm
=========

There are two main ways that this application should be used: a high-resolution and a low-resolution way. They are nearly as accurate as each other with correlation coefficients of 0.69 and 0.68 on a set of 1210 mutations. These are described by the protocols on rows 16 and 3 of [Kellogg,2011], respectively.

A) High Resolution Protocol:

This protocol allows a small degree of backbone conformational freedom. The protocol optimizes both the initial input structure for the wild-type and the generated structure for the point mutant in the same way, for the same number of iterations (recommended 50). It begins by optimizing the rotamers at all residues in the protein using Rosetta's standard side-chain optimization module (the packer). It follows this initial side-chain optimization with three rounds of gradient-based minimization, where the repulsive component of the Lennard-Jones (van der Waals) term is downweighted in the first iteration (10% of its regular strength), weighted at an intermediate value in the second iteration (33% of its regular strength), and weighted at its standard value in the third iteration. This repacking followed by minimization is run several times, always starting from the same structure. Scores and optionally PDBs are written out.

Distance Restraints: The high-resolution protocol relies on the use of Calpha-Calpha distance restraints as part of the optimization to prevent the backbone from moving too far from the starting conformation. These distance restraints may be generated externally before the protocol may be run. If not specified, constraints will be automatically generated based on the input structure, but the results obtained in the published paper utilized constraints based on the high-resolution crystal structure. The constraints used in the generation of data for row 16 in [Kellogg2011] were given as distance restraints between all Calpha pairs within 9 Angstroms of each other in the wild type structure; for each harmonic restraint, the ideal value for the restraint was taken as the distance in the original crystal structure (not the pre-minimized structure which should be given as input) and the standard-deviation on the harmonic constraint was set to 0.5 Angstroms. For example, the distance restraint between the c-alpha of residue 1 and the c-alpha of residue 2 of the PDB 1hz6 is described in the input constraint file by the line "AtomPair CA 2 CA 1 HARMONIC 3.79007 0.5".

distance restraints can be generated through the use of this shell script:

```
./convert_to_cst_file.sh mincst.log > input.cst
```

this shell script simply takes the output of the minimization log (from pre-minimization of the input structure) and converts it to the appropriate constraint file format. ( see below to obtain minimization log )

Preminimization of the Input Structures: The experimentally determined structure of the wildtype (only crystal structures have been used) should be preminimized to reduce collisions that otherwise introduce large amounts of noise into the relaxation process. Structures are backbone-and-sidechain minimized with the use of harmonic distance constraints on all c-alpha atoms within 9 Angstrom in the crystal structure. Usually, one generates a set of constraints based on the crystal structures, uses these constraints for the initial minimization as well as for the ddg backbone-and-sidechain minimization later on.

the command to perform pre-minimization is as follows (add flags to modify the scorefunction as appropriate):

```
/path/to/minimize_with_cst.linuxgccrelease -in:file:l lst  -in:file:fullatom -ignore_unrecognized_res -fa_max_dis 9.0 -database /path/to/rosetta/main/database/ -ddg::harmonic_ca_tether 0.5 -ddg::constraint_weight 1.0 -ddg::out_pdb_prefix min_cst_0.5 -ddg::sc_min_only false > mincst.log
```

this application will only take in a list of pdb structures, designated by -in:file:l lst the resulting minimized structures will have a prefix designated by -ddg::out\_pdb\_prefix. In this case the structures will have a prefix "min\_cst\_0.5" followed by the original input pdb name.

as explained in the previous section, in order to obtain constraints based on the crystal structure, run the shell script: ./convert\_to\_cst\_file.sh on the log-file output (mincst.log)

B) Low Resolution Protocol:

This protocol only allows sidechain conformational flexibility. It optimizes the rotamers for the residues in the neighborhood of the mutation; those with CBeta atoms within 8 Angstroms of the CBeta atom of the mutated residue (or Calpha for glycine). The same set of residues is optimized for both the wild-type and mutant structures. The optimization is performed a recommended 50 times for both the wildtype and point-mutant, and the scores (and optional PDBs) are written out.

Limitations
===========

The high-resolution protocol is designed to limit the amount of conformational flexibility allowed to protein backbones as the amount of noise that seeps into the protocol from increased flexibility tends to drown out the signal that might be gained by searching a larger region of conformation space. The result is that this protocol is probably not well suited to model several mutations simultaneously where backbone motion would be expected.

Input Files
===========

PDB Numbering:

All PDBs should be renumbered so that their first residue is residue 1 and number consecutively so that, if there are missing residues in the structure (due maybe to missing density) that these residues are simply skipped in the residue numbering. The numbering of all residues in both the distance-restraint file and the mutation-list file should follow this numbering.

There are two main input files: a) Restraint / constraint files for calpha atom pairs, and b) Mutation-list files, describing which set of point mutations to entertain for an input backbone.

a) Restraint / constraint files for calpha atom pairs

The constraint file should list all calpha atom pairs within 9 Angstroms, giving the distance measured from the original (non-pre-minimized) experimental structure. Each line should appear as follows:

```
AtomPair CA <res1> CA <res2> HARMONIC <xtal-distance> 0.5
```

e.g., here are a few lines from a real input distance-constraint file

```
AtomPair CA 2 CA 1 HARMONIC 3.79007 0.5
AtomPair CA 3 CA 1 HARMONIC 6.65019 0.5
AtomPair CA 3 CA 2 HARMONIC 3.80767 0.5
AtomPair CA 4 CA 1 HARMONIC 8.66838 0.5
AtomPair CA 4 CA 2 HARMONIC 6.2647 0.5
```

b) Mutation list files the files which specify mutations can follow either of two formats.

1.  mutations can follow resfile format (described at [[Resfile syntax and conventions|resfiles]]). Each mutation specified will be performed as a single mutant. For example, a resfile like the following

```
1 A PIKAA AWTL
```

will mutate residue 1 to alanine, then will mutate residue 1 to tryptophan, and so on.

if you say something like

```
1 A NONPOLAR
```

it will mutate residue 1 to all non-polar residues.

If, for example, ALLAA is specified at a certain position, the position will be mutated into the 19 other amino acids and the ddg for each of these 19 mutations will be calculated. EX 1 and EX 2 keywords have no effect on how the structures are refined.

you can pass in the resfile in the normal way, by saying -resfile my\_input\_resfile

If you need to specify more than one mutation at a time, you may use the alternative format for specifying mutations.

```
total 3 #this is the total number of mutations being made.
2 # the number of mutations made
G 1 A # the wild-type aa, the residue number, and the mutant aa
W 6 Y # the wild-type aa, the residue number, and the mutant aa
1 #the number of mutations
F 10 Y # the wild-type aa, the residue number, and the mutant aa
```

the total and the wild-type amino acid are redundant sources of information but are used to double-check the user's specification and to prevent errors.

the way one passes in this alternative format is by saying -ddg::mut\_file my\_input\_mutfile

Options
=======

A) High Resolution Protocol Flags:

The following flags are required / recommended to generate the proper behavior out of this executable to make it behave as the protocol in row 16 of [Kellogg2011].

```
-in:file:s <pdbfile of the preminimized wildtype structure> # the PDB file of the structure on which point mutations should be made
-ddg::mut_file <mutfile> # the list of point mutations to consider in this run
-ddg:weight_file soft_rep_design # Use soft-repulsive weights for the initial sidechain optimization stage
-ddg:minimization_scorefunction <weights file> # optional -- the weights file to use, if not given, then the current default scorefunction will be used.
-ddg::minimization_patch <weights patch file > # optional -- the weight-patch file to apply to the weight file; does not have to be given
-database /path/to/rosetta/main/database #the full oath to the database is required
-fa_max_dis 9.0 # optional -- if not given, the default value of 9.0 Angstroms is used.
-ddg::iterations 50 # 50 is the recommended number of iterations
-ddg::dump_pdbs true # write out PDB files for the structures, one for the wildtype and one for the pointmutant for each iteration
-ignore_unrecognized_res # optional -- if there are residues in the input PDB file that Rosetta cannot recognize, ignore them instead of quitting with an error message
-ddg::local_opt_only false # recommended: local optimization restricts the sidechain optimization to only the 8 A neighborhood of the mutation (equivalent to row 13)
-ddg::min_cst true # use distance restraints (aka constraints) during the backbone minimization phase
-constraints::cst_file <cbeta-distance-constraint-file> # the set of constraints to use during minimization which should reflect distances in the original (non-pre-relaxed) structure
-ddg::suppress_checkpointing true # don't checkpoint LIZ DOES CHECKPOINTING WORK AT ALL?
-in::file::fullatom # read the input PDB file as a fullatom structure
-ddg::mean false # do not report the mean energy
-ddg::min true # report the minimum energy
-ddg::sc_min_only false # do not minimize only the backbone during the backbone minimization phase
-ddg::ramp_repulsive true # perform three rounds of minimization (and not just the default 1 round) where the weight on the repulsive term is increased from 10% to 33% to 100%
-mute all # optional -- silence all of the log-file / stdout output generated by this protocol
-unmute core.optimization.LineMinimizer # optional -- unsilence a particular tracer
-ddg::output_silent true # write output to a silent file
```

B) Flags for the Low Resolution Protocol

The following flags are required / recommended to generate the proper behavior out of this executable to make it behave as the protocol in row 3 of [Kellogg2011].

```
-in:file:s <pdbfile of the preminimized wildtype structure> # the PDB file of the structure on which point mutations should be made
-ddg::mut_file <mutfile> # the list of point mutations to consider in this run
-ddg:weight_file soft_rep_design # Use soft-repulsive weight set
-database /path/to/rosetta/main/database #the full oath to the database is required
-fa_max_dis 9.0 # optional -- if not given, the default value of 9.0 Angstroms is used.
-ddg::iterations 50 # 50 is the recommended number of iterations
-ddg::dump_pdbs true # write out PDB files for the structures, one for the wildtype and one for the pointmutant for each iteration
-ignore_unrecognized_res # optional -- if there are residues in the input PDB file that Rosetta cannot recognize, ignore them instead of quitting with an error message
-ddg::local_opt_only true # repack the residues in an 8 Angstrom shell around the site of the point mutation
-ddg::suppress_checkpointing true # don't checkpoint
-in::file::fullatom # read the input PDB file as a fullatom structure
-ddg::mean true # do not report the mean energy
-ddg::min false # report the minimum energy
-mute all # optional -- silence all of the log-file / stdout output generated by this protocol
-ddg::output_silent true # write output to a silent file
```

Tips
====

Expected Outputs
================

The output of the ddg protocol is a 'ddg\_predictions.out' which contains, for each mutation, the total predicted ddg and a breakdown of all the score components which contribute to that total. Furthermore, output structures are dumped either in silent-file or pdb format. If silent-files are output, the following naming convention is used. All wild-type structures are dumped into wt\_\<WT\_AA\>\<RESIDUE\_NUM\>\<MUTANT\_AA\>.out The reason wild-type structures are always dumped is because if local optimization around the site of mutation is being done, the wild-type structures can potentially be different from one another due to different constraint definitions or different packing definitions. Mutant structures follow a similar convention: mut\_\<WT\_AA\>\<RESIDUE\_NUM\>\<MUTANT\_AA\>.out For example, if you made a A to Q mutation at residue 123, you would see two silent-files as output: wt\_A123Q.out and mut\_A123Q.out this is done regardless of the protocol used.

Post Processing
===============

Protocol capture
================

A protocol capture for the protocol from row 16 of the Kellogg et al. paper can be downloaded from the [[Macromolecular modeling and design benchmarks|https://kortemmelab.ucsf.edu/benchmarks/captures/DDG]] website. The [[ΔΔG  page|https://kortemmelab.ucsf.edu/benchmarks/benchmarks/DDG]] also lists the expected performance for different classes of mutation.

New things since last release
=============================

This application is being released for the first time with Rosetta3.3


##See Also

* [[Analysis applications | analysis-applications]]: other design applications
* [[Point mutation scan| pmut-scan-parallel ]]: Parallel detection of stabilizing point mutations using design
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
