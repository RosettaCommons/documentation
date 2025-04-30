#Backrub application

Metadata
========

Author: Colin A. Smith

This document was last updated August 10, 2010, by Colin A. Smith. The corresponding principal investigator is Tanja Kortemme (kortemme@cgl.ucsf.edu)

Code and Demo
=============

The code for the backrub application is in rosetta/main/source/src/apps/public/backrub.cc. An integration test and demo is located in rosetta/main/tests/integration/tests/backrub. Backrub moves are made with the BackrubMover. Side chain moves are made with the SidechainMover. Backbone phi/psi moves are made with the SmallMover.

The additional example below simulates loop 6 of triosephosphate isomerase. **Note that the resfile uses residue numbering from the PDB. The pivot residues are specified using absolute internal residue numbering.**

```
cat << END_RESFILE > 2YPI.resfile
NATRO
start
3   A NATAA
7   A NATAA
95  A NATAA
96  A NATAA
129 A NATAA
131 A NATAA
134 A NATAA
139 A NATAA
164 A NATAA
165 A NATAA
167 A NATAA
168 A NATAA
170 A NATAA
172 A NATAA
174 A NATAA
177 A NATAA
179 A NATAA
180 A NATAA
183 A NATAA
208 A NATAA
211 A NATAA
216 A NATAA
219 A NATAA
220 A NATAA
223 A NATAA
230 A NATAA
END_RESFILE
backrub -database /path/to/rosetta/main/database -s 2YPI.pdb -ignore_unrecognized_res -resfile 2YPI.resfile
        -pivot_residues 127 128 129 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178
```

References
==========

-   Smith CA, Kortemme T. Structure-Based Prediction of the Peptide Sequence Space Recognized by Natural and Synthetic PDZ Domains. *J Mol Biol* . [http://dx.doi.org/10.1016/j.jmb.2010.07.032](http://dx.doi.org/10.1016/j.jmb.2010.07.032)

-   Smith CA, Kortemme T. Backrub-like backbone simulation recapitulates natural protein conformational variability and improves mutant side-chain prediction. *J Mol Biol* . 2008 Jul 18;380(4):742-56. [http://dx.doi.org/10.1016/j.jmb.2008.05.023](http://dx.doi.org/10.1016/j.jmb.2008.05.023)

-   Friedland GD, Linares AJ, Smith CA, Kortemme T. A simple model of backbone flexibility improves modeling of side-chain conformational variability. *J Mol Biol* . 2008 Jul 18;380(4):757-74. [http://dx.doi.org/10.1016/j.jmb.2008.05.006](http://dx.doi.org/10.1016/j.jmb.2008.05.006)

-   Friedland GD, Lakomek NA, Griesinger C, Meiler J, Kortemme T. A correspondence between solution-state dynamics of an individual protein and the sequence and conformational diversity of its family. *PLoS Comput Biol* . 2009 May;5(5):e1000393. [http://dx.doi.org/10.1371/journal.pcbi.1000393](http://dx.doi.org/10.1371/journal.pcbi.1000393)

-   Davis IW, Arendall WB 3rd, Richardson DC, Richardson JS. The backrub motion: how protein backbone shrugs when a sidechain dances. *Structure* . 2006 Feb;14(2):265-74. [http://dx.doi.org/10.1016/j.str.2005.10.007](http://dx.doi.org/10.1016/j.str.2005.10.007)

-   Betancourt MR. Efficient Monte Carlo trial moves for polypeptide simulations. *J Chem Phys* . 2005 Nov 1;123(17):174905. [http://dx.doi.org/10.1063/1.2102896](http://dx.doi.org/10.1063/1.2102896)

Application purpose
===========================================

This application is useful for creating ensembles of protein backbones, modeling protein flexibility, modeling mutations, and detailed refinement of backbone/side chain conformations.

Algorithm
=========

The backrub algorithm rotates local segments of the protein backbone as a rigid body about an axis defined by the starting and ending atoms of the segment. It was inspired by observations made by Davis et al (Structure 2006) of alternate side chain/backbone conformations in high resolution crystal structures. Atoms branching of the main chain at the pivot points (side chains, hydrogens, carbonyl oxygens), are updated to minimize the bond angle strain incurred. These moves are accepted or rejected using the Metropolis criterion.

In addition to backrub moves, side chain conformations are sampled directly from the probability distributions described by the Dunbrack rotamer library, and not from a discrete set of chi angles, as is typically done by many side chain sampling algorithms. Side chain moves are also accepted or rejected using the Metropolis criterion.

Limitations
-----------

The backrub application does not sample either the backbone or side chain of proline residues. As long as a proline residue is specified as flexible, it can be part of backrub segments, but cannot be either the start or end pivot of a segment.

Differences From Published Version as Described In References
-------------------------------------------------------------

One of the primary differences between this implementation and the previous implementation is that backrub is now atom-centric rather than residue-centric. Instead of just CA atoms, any backbone atoms can be used as pivots. For continuity, only CA atoms are enabled as pivots by default.

This changes how the minimum and maximum segment sizes are specified. In the previous implementation, the smallest segment size was 2 residues, which corresponded to rotating the peptide bond (C and N atoms) between the two residues. In this implementation, that would correspond to a segment size of 4 atoms (CA, C, N, and CA). Because of the atom-centric implementation, the smallest possible size is now 3 atoms, which is the default. The previous default largest segment size, 12 residues, corresponds to the new default of 34 atoms. Because only CA atoms are enabled as pivots by default, the possible segments will be identical to those from the previous implementation.

Another difference is that this implementation uses continuous sampling of side chain chi angles instead of fixed rotamers. The angles are chosen according to the Dunbrack rotamer library probabilities. First, a rotamer well is chosen according to its probability of occurrence in the PDB. Second, the individual chi angles are chosen using gaussian distributed random angles with the means and standard deviations from the PDB.

Finally, backbone and side chain sampling are totally decoupled. They use different movers that are randomly chosen at each Monte Carlo step.

Prediction of the structures of mutations described in Smith and Kortemme (J Mol Biol 2008) and ensemble generation and design protocol described in Friedland et al (PLoS Comput Biol 2009) using Rosetta++ are implemented at: [http://kortemmelab.ucsf.edu/backrub](http://kortemmelab.ucsf.edu/backrub)

Input Files
===========

-   The starting structures must be in PDB format and can be specified using the -s or -l options. A custom fold tree can be specified on a single line of the PDB file using the silent file format. An overview of that format can be found in the [[fold tree documentation|foldtree-overview]] .

-   Side chain sampling is controlled using the -resfile command line option. If no resfile is specified, then all side chains are made flexibile by default. Please see the [[resfile documentation|resfiles]] for more information about how to create one. There are several things to note when using resfiles: First, because of current limitations with side chain sampling, proline resfiles are not sampled, even if specified in the resfile. Second, while it is possible to sample different amino acids using the backrub application, the fixed temperature Monte Carlo algorithm will bias the selected amino acids towards smaller residues such as alanine. **Lastly, the residue numbering in resfiles is based on the residue number and chain letter from the PDB file, which is different from the -pivot\_residues option** .

-   Simple phi/psi backbone moves can also be enabled by specifying a MoveMap file using the -movemap option and giving a greater than zero value to the -sm\_prob option. See the [[MoveMap documentation|movemap-file]] for more information.

Options
=======

You can run the backrub application with the following flags:

```
-database                 Database file input search paths
```

Structure Input
---------------

```
-s                        Name(s) of single PDB file(s) to process
-l                        File(s) containing list(s) of PDB files to process
-ignore_unrecognized_res  Do not abort if unknown residues are found in PDB
                          file; instead, ignore them.
```

If the PDB file contains a line beginning with FOLD\_TREE, then the fold tree specified by that line will be used. The same fold tree will be appended to all resulting structures using the same format. See the documentation for [[fold trees|foldtree-overview]] for more information.

Simulation Options
------------------

```
-nstruct                  number of independent simulations generating last 
                          and low output structures (default 1)
-backrub:ntrials          number of Monte Carlo trials to run (default 1000, 
                          10000 recommended)
-mc_kt                    value of kT for Monte Carlo (default 0.6, 0.3-0.4
                          recommended for > 100,000 step simulations)
-mm_bend_weight           weight of mm_bend bond angle energy term (default 1)
-cst_fa_weight            weight of the fullatom constraint terms (defualt 1)
-cst_fa_file              constraints filename(s) for fullatom. When multiple 
                          files are given a *random* one will be picked.
```

See the documentation about [[constraint files|constraint-file]] for more information.

Initial Repack/Minimization
---------------------------

```
-initial_pack             force a repack/minimization at the beginning 
                          regardless of whether mutations are set in the resfile
-minimize_movemap         MoveMap specifying degrees of freedom to be minimized 
                          after initial packing, occurs in three stages:
                          1. CHI only  2. CHI+BB  3. CHI+BB+Jump
```

Backrub Sampling
----------------

```
-pivot_residues           residues for which contiguous stretches can contain
                          segments, in absolute residue numbers (defaults to all
                          residues)
-pivot_atoms              main chain atoms usable as pivots (default CA)
-min_atoms                minimum backrub segment size in atoms (default 3)
-max_atoms                maximum backrub segment size in atoms (default 34)
```

Side Chain Sampling
-------------------

```
-resfile                  resfile filename(s). only the first is used.
-sc_prob                  probability of making a side chain move (default 0.25)
-sc_prob_uniform          probability of uniformly sampling chi angles (defualt
                          0.1)
-sc_prob_withinrot        probability of sampling within the current rotamer
                          (default 0.0)
```

Backbone Torsion Angle Sampling
-------------------------------

```
-movemap                  MoveMap file specifying flexible torsions
-sm_prob                  probability of making a small move (default 0)
```

Trajectory Recording
--------------------

```
-backrub:trajectory         record a trajectory
-backrub:trajectory_gz      gzip the trajectory
-backrub:trajectory_stride  write out a trajectory frame every N steps
```

For more information about other application flags, please check the [[full options list|full-options-list]]

Tips
====

To date, typical backrub ensemble generation has used 10,000 Monte Carlo steps at a temperature of 0.6. At this temperature, many structures will unfold if the number of Monte Carlo steps is increased significantly. Many structures remain stable in extended simulations at a temperature of 0.3-0.4.

The 10,000 step backrub simulations for a recent PDZ specificity prediction paper (Smith & Kortemme 2010) took an average of 110 seconds per simulation to generate a single structure. The simulations were each run on a single core of a heterogeneous cluster of 8 core Xeon workstations with E5345, E5430, and E5520 processors.

Expected Outputs
================

For each starting structure, an output tag will be generated from the input file name, suffix, prefix, and user tags, if applicable. The backrub application generates two files, output\_tag\_0001\_low.pdb and output\_tag\_0001\_last.pdb. The four digit index is incremented up to the number of structures specified by -nstruct. The "low" file contains the lowest energy structure found during the Monte Carlo simulation. The "last" file contains the last accepted structure during the Monte Carlo simulation. If a custom fold tree was given in the input file, it will be appended to each of the output files.

Post Processing
===============

A useful form of post processing is to calculate the RMSD of the output structures to the input structure.

New Features in Rosetta 3.2
===========================

-   In addition to repacking for specified mutations, the backrub application will now do an optional three stage minimization after packing. See -minimize\_movemap.

-   A third type of side chain move was added, in which the closest rotamer is determined and the chi angles are resampled within that rotamer. This increases sampling of low-probability, but energetically favored rotamers. See -sc\_prob\_withinrot.

-   Multi-model PDB trajectories can now be recorded for a backrub simulation. See -backrub:trajectory and associated options.

##See Also

* [[Fasta file]]: Fasta file format
* [[Fragment file]]: Fragment file format (required for abinitio structure prediction)
* [[BackrubMover]]: The RosettaScripts backrub mover
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
  * [[Abinitio relax]]: Application for predicting protein structures from sequences
    * [[Abinitio]]: More details on this application
  * [[NonlocalAbinitio]]: Application for predicting protein structure given some prior structural information
  * [[Membrane abinitio]]: Ab initio for membrane proteins.  
  - [[Comparative modeling|minirosetta-comparative-modeling]]: Build structural models of proteins using one or more known structures as templates for modeling (uses the minirosetta application).
    * [[Minirosetta]]: More information on the minirosetta application.
  * [[Metalloprotein ab initio|metalloprotein-abrelax]]: Ab inito modeling of metalloproteins.  
  - [[Floppy tail]]: Predict structures of long, flexible N-terminal or C-terminal regions.
  - [[Fold-and-dock]]: Predict 3-dimensional structures of symmetric homooligomers.  
  - [[Molecular replacement protocols|mr-protocols]]: Use Rosetta to build models for use in X-ray crystallography molecular replacement.  
    * [[Prepare template for MR]]: Setup script for molecular replacement protocols.  
  - [[Relax]]: "Locally" optimize structures, including assigning sidechain positions.
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
