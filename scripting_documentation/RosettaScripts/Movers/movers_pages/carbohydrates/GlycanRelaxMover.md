# GlycanSampler
*Back to [[Mover|Movers-RosettaScripts]] page.*
## GlycanSampler

[[_TOC_]]

MetaData
========

Mover/Application created by Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com) and Dr. Jason Labonte (JWLabonte@jhu.edu), in collaboration with Dr. Sebastian Rämisch (raemisch@scripps.edu)

PIs: Dr. William Schief (schief@scripps.edu) and Dr. Jeffrey Gray (jgray@jhu.edu)

This is still an in-development, unnpublished application.  If you use this in your publication, please email the authors!

[[include:mover_GlycanSampler_type]]

Details
=======

[[include:mover_GlycanTreeSampler_type]]


## See Also
- [[WorkingWithGlycans]]

- ### RosettaCarbohydrate Apps and Components
 - ### Movers
 - [[GlycanTreeModeler]] - The optimal way to model glycan trees.  Uses GlycanRelax internally.
 - [[SimpleGlycosylateMover]] - Glycosylate poses with glycan trees such as man5, man9, or other complex trees.  
 - [[GlycanRelaxMover]] - Component used in GlycanTreeRelax to do the torsional and side-chain sampling.
 - [[GlycanTreeMinMover]] - A version of the MinMover that randomly optimizes glycan foliage used in GlycanRelax.

- ### Residue Selectors
 - [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest or specific trees/branches
 - [[GlycanLayerSelecotr]] - Select glycan layers
 - [[GlycanPositionSelector]] - Select specific glycan postions, independant of PDB or Rosetta numbering.
 - [[RandomGlycanFoliageSelector]] - Randomly select a set of glycan residues 

- ### Applications
 - [[GlycanInfo]] - Get information on all glycan trees within a pose
 - [[GlcyanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.


- ### Other
 - [[Application Documentation]]: List of Rosetta applications
 - [[Running Rosetta with options]]: Instructions for running Rosetta executables.
 - [[Comparing structures]]: Essay on comparing structures
 - [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
 - [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
 - [[Commands collection]]: A list of example command lines for running Rosetta executable files