#Point mutant ("pmut") scan application, pmut\_scan\_parallel

Metadata
========

This document was last edited on 11/2/12 by Steven Lewis. The code was written by Ron Jacak. The corresponding PI is Brian Kuhlman (bkuhlman@email.unc.edu).

Code and Demo
=============

The code for the pmut scan protocol lives primarily in `       rosetta/main/source/src/protocols/pmut_scan      ` in the classes PointMutScanDriver and Mutant. The Mutant class is a helper class which holds information about single, double (or higher order) mutants and their respective mutations. The PointMutScanDriver class is responsible for determining which mutants to make, distributing the jobs to all available CPUs and scoring all the structures. The protocol is started via the pmut\_scan\_parallel application, the code for which can be found in `       rosetta/main/source/src/apps/pilot/ronj/pmut_scan_parallel      ` . Unit tests for the protocol can be found at `       rosetta/main/source/test/protocols/pmut_scan      ` . Integration tests for the protocol can be found at `       rosetta/main/tests/integration/tests/pmut_scan      ` .

References
==========

We recommend the following articles for further understanding of the RosettaDesign methodology:

-   [ROSETTA3: an object-oriented software suite for the simulation and design of macromolecules.](http://www.ncbi.nlm.nih.gov/pubmed/21187238) A. Leaver-Fay, et al. Methods Enzymol. 2011;487:545-74.
-   [Design of a novel globular protein fold with atomic-level accuracy.](http://www.ncbi.nlm.nih.gov/pubmed/14631033) Kuhlman B, et al.Science. 2003 Nov 21;302(5649):1364-8.

Application purpose
===========================================

One of the most common goals in protein design/engineering is to increase the stability of a protein of interest. Previous studies have shown that redesigning native proteins can lead to significant increases in stability. However, these redesigns typically have large numbers of differences compared to the wild-type sequence. The purpose of this protocol is to increase the stability of a protein of interest with only single or double point mutants.

Algorithm
=========

The protocol works by first reading in the target protein structure (and alternate solutions of the same protein, if available). Then, it builds a list of all mutants that need to be scored. If a double mutant scan is being performed, only residues which are close enough to interact are tested. (Two residues must have one side-chain side-chain atom pair within 4.5 Angstroms to be considered close enough to interact.) Once the list of mutants has been built, each of the mutants are made and tested. The energies for mutants which are predicted to be stabilizing by 1 Rosetta energy unit or more are output.

**If compiled with MPI, the protocol will distribute the work of creating and scoring all mutants evenly across all available CPUs. This can be achieved by adding "extras=mpi" to the SCons build command.**

Limitations
===========

Mutants predicted to be stabilizing by the pmut scan protocol may not be stabilizing, and mutants which are stabilizing may be missed. The reasons for these outcomes are varied. The Rosetta energy function is imperfect. Thus, certain energetics which Rosetta does not account for can make a mutant predicted to be stabilizing actually destabilizing. Additionally, to model the mutations, the protocol assumes a fixed backbone conformation. Studies have shown that better results can be achieved using protocols that allow backbone flexibility. Refining the protocol based on the results of experimental characterization of predictions will be necessary to improve prediction accuracy.

Input Files
===========

Structures - REQUIRED
---------------------

At least one input PDB file must be specified on the command line, either with the -s or -l flag.

```
-s <pdb1> <pdb2>                                 A list of one or more PDBs to run the point mutant scan on
-l <listfile>                                    A file that lists one or more PDBs to run the point mutant scan on, one PDB per line
```

**IMPORTANT: If a list file is specified, the protocol assumes the structures are alternate solutions of the same proteins and tries to find mutations that are stabilizing across all solutions.**

Options
=======

Database location 
-----------------

```
-database <path/to/rosetta/main/database>     Specifies the location of the rosetta_database
```

Application Options
-------------------

```
-double_mutant_scan                              Look for double mutants that are stabilizing. By default, the protocol only looks for single mutants that are stabilizing. This mode looks for both double and single mutants. (default: false)
-mutants_list <file>                             Only make the mutants specified in the text file. Useful for combining mutants found during a scan into higher-order mutants. Not used by default.
-output_mutant_structures                        Output PDB files for each of the mutants predicted to be stabilizing. (default: false)
-DDG_cutoff                                      Filter output score lines to only print mutations with ddGs better than this.
-alter_spec_disruption_mode                      Search for mutations that destabilize an interface (see below)
```

Rotamers
--------

```
-ex1                                             Increase chi1 rotamer sampling for buried* residues +/- 1 standard deviation - RECOMMENDED
-ex1_aro                                         Increase chi1 rotamer sampling for buried* aromatic** residues +/- 1 standard deviation
-ex2                                             Increase chi2 rotamer sampling for buried* residues +/- 1 standard deviation - RECOMMENDED
-ex2_aro                                         Increase chi2 rotamer sampling for buried* aromatic** residues +/- 1 standard deviation
-ex3                                             Increase chi3 rotamer sampling for buried* residues +/- 1 standard deviation
-ex4                                             Increase chi4 rotamer sampling for buried* residues +/- 1 standard deviation

-ex1:level <int>                                 Increase chi1 sampling for buried* residues to the given sampling level***
-ex1_aro:level <int>                             Increase chi1 sampling for buried* aromatic residues to the given sampling level
-ex2:level <int>                                 Increase chi1 sampling for buried* residues to the given sampling level
-ex2_aro:level <int>                             Increase chi1 sampling for buried* aromatic residues to the given sampling level
-ex3:level <int>                                 Increase chi1 sampling for buried* residues to the given sampling level
-ex4:level <int>                                 Increase chi1 sampling for buried* residues to the given sampling level

-extrachi_cutoff <int>                           Set the number of Cbeta neighbors (counting its own) at which a residue is considered buried.
                                                 A value of "1" will mean that all residues are considered buried for the purpose of rotamer building.
                                                 Use this option when you want to use extra rotamers for less buried positions.

-preserve_input_cb                               Do not idealize the CA-CB bond vector -- instead, use the CB coordinates of the input PDB
-use_input_sc                                    Include the side chain from the input PDB.  (default: true)

-no_his_his_pairE                                Exclude the favorable pair term energy for HIS-HIS residue pairs - RECOMMENDED
-score:weights design_hpatch.wts                 Activate the hpatch score during scoring.
```

\* Buried residues are those with \>= threshold (default: 18) neighbors within 10 Angstroms (Cbeta-distance). This threshold can be controlled by the -extrachi\_cutoff flag.

\*\* Aromatic residues are HIS, TYR, TRP, and PHE. Note: Including both -ex1 and -ex1\_aro does not increase the sampling for aromatic residues any more than including only the -ex1 flag. If however, both -ex1 and -ex1\_aro:level 4 are included on the command line, then aromatic residues will have more chi1 rotamer samples than non aromatic residues. Note also that -ex1\_aro can *only increase* the sampling for aromatic residues beyond that for non-aromatic residues. -ex1:level 4 and -ex1\_aro:level 1 together will have the same effect as -ex1:level 4 alone.

\*\*\* More information about [[extra rotamer sampling levels|resfiles#Extra-Rotamer-Commands:]] , including recommended values, can be found on the [[resfile documentation page|resfiles]] .

Because of the large number of metal-coordinating structures in the PDB, the pair energy term, which is meant to favor electrostatic interactions, gives a bonus to HIS-HIS residue pairs. Adding the -no\_his\_his\_pairE flag removes the bonus given to HIS-HIS residue pairs and reduces the number of designed histidines.

Annealer
--------

By default, fixbb uses the standard annealer used in [Kuhlman et al. Science, 2003].

```
-multi_cool_annealer <int>                       Use an alternate annealer that spends more time at low temperatures. This annealer produces consistently lower energies than the standard annealer. Recommended value: 10.
```

Other options
-------------

```
-constant_seed                                   Fix the random seed
-jran <int>                                      Specify the random seed; if unspecified, and -constant_seed appears on the command line, then the seed 11111111 will be used
```

Tips
====

-   The flags -ex1 and -ex2 are recommended to get more accurate energies and output structures.

Example Command Lines
=====================

To run a scan for stabilizing **single (point) mutants** on the PDB 1ABC:

```
[mpirun -np 100] rosetta/main/source/bin/pmut_scan_parallel.macosgccrelease -database ~/rosettadb -s 1ABC.pdb.gz -ex1 -ex2 -extrachi_cutoff 1 -use_input_sc -ignore_unrecognized_res -no_his_his_pairE -multi_cool_annealer 10 -mute basic core
```

To run a scan for stabilizing **double** mutants on the PDB 1ABC:

```
[mpirun -np 100] rosetta/main/source/bin/pmut_scan_parallel.macosgccrelease -database ~/rosettadb -s 1ABC.pdb.gz -double_mutant_scan -ex1 -ex2 -extrachi_cutoff 1 -use_input_sc -ignore_unrecognized_res -no_his_his_pairE -multi_cool_annealer 10 -mute basic core
```

To run a scan for stabilizing double mutants on the PDB 1ABC and **output structures** for mutants found to be stabilizing:

```
[mpirun -np 100] rosetta/main/source/bin/pmut_scan_parallel.macosgccrelease -database ~/rosettadb -s 1ABC.pdb.gz -double_mutant_scan -output_mutant_structures -ex1 -ex2 -extrachi_cutoff 1 -use_input_sc -ignore_unrecognized_res -no_his_his_pairE -multi_cool_annealer 10 -mute basic core
```

To score a pre-determined **list of mutants** and create output structures for each of them:

```
[mpirun -np 100] rosetta/main/source/bin/pmut_scan_parallel.macosgccrelease -database ~/rosettadb -s 1ABC.pdb.gz -mutants_list mutants.txt -output_mutant_structures -ex1 -ex2 -ex3 -extrachi_cutoff 1 -use_input_sc -ignore_unrecognized_res -no_his_his_pairE -multi_cool_annealer 10 -mute basic core
```

To score a pre-determined list of mutants, create output structures for each of them, and do **increased sampling** around chi angles 1 and 2:

```
[mpirun -np 100] rosetta/main/source/bin/pmut_scan_parallel.macosgccrelease -database ~/rosettadb -s 1ABC.pdb.gz -mutants_list mutants.txt -output_mutant_structures -ex1 -ex1:level 3 -ex2 -ex2:level 3 -ex3 -extrachi_cutoff 1 -use_input_sc -ignore_unrecognized_res -no_his_his_pairE -multi_cool_annealer 10 -mute basic core
```

Mutant List file format
=======================

-   lines starting with \# are ignored
-   format is "chain current\_seq resnum[icode] new\_seq"
-   repeat that format as necessary for multiple mutants
-   each line is its own mutant

Examples:

```
# a single mutant
A N 1 G

# a double mutant
A N 1 G A S 13 N

# a double mutant with insertion codes on the residue numbers
A N 1E G A S 13G N
```

Expected Outputs
================

The only output from the protocol, by default, is the log file for the run. The log file will contain the predicted ddG and difference in average total energy for all mutants found to be stabilizing.
 If the option "-output\_mutant\_structures" was specified, a PDB file for each of the mutants found to be stabilizing will also be output. The PDB files will be named with the input file + a string representing the mutant. For example, the mutant histidine-1-glycine on chain A for structure 1l2y\_renameH.pdb will be output to a file named 1l2y\_renameH.A-H1G.pdb.

Altered Specificity
===================

This code has a second mode that serves as the first "disruption" step for the altered specificity (alter\_spec) protocol. Briefly, alter\_spec first finds a destabilizing mutation at a protein-protein interface, then finds compensatory mutations on the opposite chain, with the intention of designing new orthogonal pairs.

This mode changes a few things. First, the input poses must have an interface. All mutations are prescreened to ensure they occur at the interface. Mutations are also prescreened for distance (as before) and to ensure all pairs occur on the same chain.

The DDG sense is inverted in this mode: disruption is desired, so the mode reports the most *destabilizing* mutations. The log text does not reflect this (it shows - for +).

Post Processing
===============

The fields in the log file are whitespace-delimited, so it can be read into Excel for further analysis. Output structures can be viewed in a PDB viewer such as PyMOL.

New things since last release
=============================

The pmut scan protocol is being released for the first time with Rosetta v3.4. For 3.5, AlterSpecDisruptionMode added. Also, -double\_mutant\_scan now includes single mutants.


##See Also

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
