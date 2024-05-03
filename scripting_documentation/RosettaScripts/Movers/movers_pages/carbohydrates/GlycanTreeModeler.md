GlycanTreeModeler
================

[[_TOC_]]

MetaData
========

Mover created by Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com), Dr. Sebastian Raemisch (raemisch@scripps.edu) and  Dr. Jason Labonte (JWLabonte@jhu.edu)

PIs: Dr. William Schief (schief@scripps.edu) and Dr. Jeffrey Gray (jgray@jhu.edu)

Reference
=========

**Growing Glycans in Rosetta: Accurate de novo glycan modeling, density fitting, and rational sequon design**
Jared Adolf-Bryfogle, J. W Labonte, J. C Kraft, M. Shapavolov, S. Raemisch, T. Lutteke, F. Dimaio, C. D Bahl, J. Pallesen, N. P King, J. J Gray, D. W Kulp, W. R Schief
_bioRxiv_ 2021.09.27.462000; [[https://doi.org/10.1101/2021.09.27.462000]] 

Description
===========
This mover is created to do denovo modeling and refinement of glycans.  It does this through iteratively sampling and building out the glycan trees from their roots. By default (without a passed residue selector), it selects ALL glycan residues in the pose.  Please see the [[GlycanResidueSelector]] for selecting particular glycan trees and the [[GlycanLayerSelector]] for particular glycan layers.

**Note that the defaults used internally by the modeler are now the optimal defaults found in the upcoming paper.  The plethora of options here are mostly for benchmarking.  The only two options you should need are `-residue_selector` and `scorefxn` (and optionally `-refine` for re-modeling glycans)**
 
Details
=======

[[include:mover_GlycanTreeModeler_type]]


## See Also
- [[WorkingWithGlycans]]

- ### RosettaCarbohydrate Apps and Components

- #### Movers
 - [[SimpleGlycosylateMover]] - Glycosylate poses with glycan trees such as man5, man9, or other complex trees.  
 - [[GlycanSampler | GlycanRelaxMover]] - Component used in GlycanTreeRelax to do the torsional and side-chain sampling.

- #### Residue Selectors
 - [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest or whole trees/branches.
 - [[GlycanLayerSelector]] - Select glycan layers
 - [[RandomGlycanFoliageSelector | rs_RandomGlycanFoliageSelector_type]] - Randomly select a set of glycan residues 

- #### Applications
 - [[GlycanInfo]] - Get information on all glycan trees within a pose
 - [[GlycanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.


- #### Other
 - [[Application Documentation]]: List of Rosetta applications
 - [[Running Rosetta with options]]: Instructions for running Rosetta executables.
 - [[Comparing structures]]: Essay on comparing structures
 - [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
 - [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
 - [[Commands collection]]: A list of example command lines for running Rosetta executable files
