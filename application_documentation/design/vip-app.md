#RosettaVIP - Void Indentification and Packing application

Metadata
========

Author: Jim Havranek

Feb. 2012 by Jim Havranek (havranek [at] genetics.wustl.edu).

Code and Demo
=============

This code uses the RosettaHoles approach to identify problematic buried cavities, and suggests a set of mutations that are predicted to improve stability as determined by improves RosettaHoles and Rosetta fullatom energy scores. The central code is in the *vip* application in `       src/protocols/vip/VIP_Mover.cc      ` and in `       src/protocols/vip/VIP_Report.cc      ` .

For the full workflow check out:

`       demos/public/vip      `

For a 'minimal' demo example (that omits the post-mutation relaxation step), see

`       tests/integration/tests/vip/      `

References
==========

Borgo, B., Havranek, J.J. (2012), "Automated selection of stabilizing mutations in designed and natural proteins", Proc. Natl. Acad. Sci. USA, v.109(5) pp.1494-99.

Application purpose
===========================================

This code is intended to take a pdb file with the coordinates for a structural model of a protein with poor hydrophobic packing, and to return a list of mutations that are predicted to fill cavities in the protein core. This has been found to result in improved chemical and thermal stability.

Algorithm
=========

This application implements an iterative cycle with three steps. First, cavities and neighboring residue positions are identified. Second, at each of these positions, a single-site design of hydrophobic residues is performed with a simplified score function that assesses geometric complementarity of each side chain with neighboring cavities. Finally, the most promising mutations are imposed in silico, structural relaxtion is performed, and the best mutation as judged by the Rosetta fullatom score function is retained (unless no favorable mutations are identified). This procedure is repeated until no cavities are found, or no new beneficial mutations are identified.

Limitations
===========

-   Computational validation against test sets of characterized mutations as well as our own characterization of predicted mutations suggests a false positive rate of \~25%. As a result, mutations must be tested to verify that they are stabilizing.

-   The method scales poorly to large system sizes. This can be partially dealt with by restricting the scope of the relaxation step with the -cp:local\_relax option described below.

-   Cavity finding is done via RosettaHoles version 1, which is stochastic, so: 1) if it finds no cavities, run it again and it probably will and 2) separate runs can result in a different sequence of mutations.

Modes
=====

There is only one mode to run the vip application at present.

Input Files
===========

You only need a pdb file of the structure for which you desire suggested mutations, passed to the executable with the -s commandline option described below.

Options
=======

-   -s input\_file.pdb - This specifies the pdb file for which you want to find mutations.

-   -cp:ncycles (Size) - This will run the iterative protocol (find point mutations, relax, output best relaxed pose) a fixed number of times. If you don't use this option it will continue to run until it no longer finds favorable mutations. The latter option can take a while for large proteins.

-   -cp:cutoff (real, suggested value 6.0) - This is the cutoff for choosing mutatable residues (i.e., distance from cavity ball to a non-bb, non-surface atom on the residue). The smallest cutoff you can use is best since that will mutate the smallest number of residues that line the cavity.

-   -sasa\_calculator\_probe\_radius (real, suggested value 1.0) - Increasing this will likely give you surface clefts in addition to buried voids.

-   -cp:pack\_sfxn (score function) (e.g. -cp:pack\_sfxn score12\_full) - Allows you to use a different score for the point mutant trials

-   -cp:relax\_sfxn (score function) - Allows you to use a different score for the relax stage.

-   -cp:skip\_relax - This causes the protocol to skip the relax step, which is pretty important for the algorithm. This option is useful if all you want is a list of possible mutations for (e.g.) library construction for directed evolution.

-   -cp:local\_relax - This restricts the scope of the relaxation protocol for possible mutations to neighbor residues, as determined by the EnergyGraph.

-   -cp:output - This option specifies the name of the final output model with all suggested mutations (default is "final\_mutant.pdb").

-   -cp:print\_reports - This generates a file (reports.txt ) that tells you which mutations were identified by the simple geometric screen, and which mutations still look good after relaxation.

-   -cp:print\_intermediate\_pdbs - This option outputs a fullatom pdb for each accepted mutation, named "vip\_iter\_1.pdb", with the number incremented for each pass through. The pdb for the final iteration will be the same as the final pdb.

Command Line
============

The app can be run as follows:

-   ./(executables\_path)/vip.(arch)(mode) -database (database\_path) -s (input\_file).pdb -cp:ncycles 3 -cp:cutoff 6.0 -sasa\_calculator\_probe\_radius 1.0 -run:silent

Expected Outputs
================

The accepted mutations are printed to standard output. A structural model containing all accepted mutations is output as specified by the -cp:output option. If requested by the -cp:print\_reports options, a file title "reports.txt" is output that lists the mutations that were found during the single-site design step and the relaxation step, which the improvements in scoring functions noted for each. If requested by the -cp:print\_intermediate\_pdbs option, a pdb will be printed after each traversal of the iterative cycle.

New things since last release
=============================

This application is new as of Rosetta 3.4.

##See Also

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
