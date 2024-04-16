GlycanResidueSelector
==================

MetaData
========

Authors: Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com), Dr. Jason Labonte (JWLabonte@jhu.edu), and Dr. Sebastian Rämisch (raemisch@scripps.edu)

PIs: Dr. William Schief (schief@scripps.edu) and Dr. Jeffrey Gray (jgray@jhu.edu)

Reference
=========
**Growing Glycans in Rosetta: Accurate de novo glycan modeling, density fitting, and rational sequon design**
Jared Adolf-Bryfogle, J. W Labonte, J. C Kraft, M. Shapavolov, S. Raemisch, T. Lutteke, F. Dimaio, C. D Bahl, J. Pallesen, N. P King, J. J Gray, D. W Kulp, W. R Schief
_bioRxiv_ 2021.09.27.462000; [[https://doi.org/10.1101/2021.09.27.462000]]


[[include:rs_Glycan_type]]


## See Also
- [[WorkingWithGlycans]]

### RosettaCarbohydrate Apps and Components
- #### Movers
 - [[GlycanTreeModeler]] - The optimal way to model glycan trees.  Uses GlycanRelax internally.
 - [[SimpleGlycosylateMover]] - Glycosylate poses with glycan trees such as man5, man9, or other complex trees.  
 - [[GlycanSampler | GlycanRelaxMover]] - Component used in GlycanTreeRelax to do the torsional and side-chain sampling.

- #### Residue Selectors
 - [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest.
 - [[GlycanLayerSelector]] - Select glycan layers
 - [[RandomGlycanFoliageSelector | rs_RandomGlycanFoliageSelector_type]] - Randomly select a set of glycan residues 

- #### Applications
 - [[GlycanInfo]] - Get information on all glycan trees within a pose
 - [[GlycanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.


- ### Other
 - [[Application Documentation]]: List of Rosetta applications
 - [[Running Rosetta with options]]: Instructions for running Rosetta executables.
 - [[Comparing structures]]: Essay on comparing structures
 - [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
 - [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
 - [[Commands collection]]: A list of example command lines for running Rosetta executable files
