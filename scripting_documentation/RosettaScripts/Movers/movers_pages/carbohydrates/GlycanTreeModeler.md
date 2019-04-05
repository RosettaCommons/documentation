GlycanTreeModeler
================

[[_TOC_]]

MetaData
========

Mover created by Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com), Dr. Sebastian Raemisch (raemisch@scripps.edu) and  Dr. Jason Labonte (JWLabonte@jhu.edu)

PIs: Dr. William Schief (schief@scripps.edu) and Dr. Jeffrey Gray (jgray@jhu.edu)

NOTE: This is and in-development, unpublished application.  If you use this in any publication, please email the authors. 

Description
===========
This mover is created to do denovo modeling and refinement of glycans.  It does this through iteratively sampling and building out the glycan trees from their roots. By default (without a passed residue selector), it selects ALL glycan residues in the pose.  Please see the [[GlycanResidueSelector]] for selecting particular glycan trees and the [[GlycanLayerSelector]] for particular glycan layers.

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
