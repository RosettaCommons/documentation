About
=====
App created by Dr. Jared-Adolf-Bryfogle (jadolfbr@gmail.com); Lab of Dr. William Schief (schief@scripps.edu), in collaboration with Dr. Sebastian Raemisch (raemisch@scripps.edu) and Dr. Jason W. Labonte (JWLabonte@JHU.edu); Lab of Dr. Jeff Gray (jgray@jhu.edu) 

The app is currently in development and only accessible to developers.  July 2016



Description
===========

A pilot app specifically for glycan clashes which quantifies clashes between specified glycan branches and other chains and glycan branch - glycan branch clashes.  Does not count clashes for intra glycan branch.  Does not echo input files, adds info to output scorefile to allow for MPI runs.

<!--- BEGIN_INTERNAL -->

Clash Definition
============

 Atom is clashing if it clashes with ANY other atom
 Count up clashes (hard and soft) per-residue

 - Hard:
  - distance <= LJ1 + LJ2
 - Soft:
  - distance <= (LJ1 + LJ2) * (1 - S).  S is between 0 and 1. Here, we use .33 as default.

-> Intuitive definition, easily conceptualized, still quantitative


Relevant Options:
======
```
-glycan_branches, vector
 - Required. Vector of glycan branches.  Rosetta Residue numbering or PDB like RosettaScripts

-chech_chains, vector
 - Required. A list of [glycan or protein] chains to compute chain-based clashes.  If not given, will only compute glycan-glycan clashes!

-ignore_hydrogens, boolean
 - Should we calculate only heavy-heavy atom clashes?

-soft_clash, Real
  - When we calculate atom-atom distances using LJ distances, clash if distance < (atomI_LJ + atomJ_LJ)*(1 - soft_clash)
```

<!--- END_INTERNAL -->

##See Also

 - ### Apps
* [[GlycanRelax]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
* [[GlycanInfo]] - Get information on all glycan trees within a pose

 - ### RosettaScript Components
* [[GlycanRelaxMover]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
* [[SimpleGlycosylateMover]] - Glycosylate poses with glycan trees.  
* [[GlycanTreeSelector]] - Select individual glcyan trees or all of them
* [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest.

 - ### Other
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files