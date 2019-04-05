# SimpleGlycosylateMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SimpleGlycosylateMover

[[_TOC_]]

MetaData
========

Mover created by Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com) and  Dr. Jason Labonte (JWLabonte@jhu.edu)

PIs: Dr. William Schief (schief@scripps.edu) and Dr. Jeffrey Gray (jgray@jhu.edu)


Description
===========

The SimpleGlycosylateMover allows one to glycosylate poses with the glycan of interest at specified positions.  This is incredibly useful, as most glycans are unresolved in crystal structures.
This is usually the starting point for modeling carbohydrates attached to proteins.  It is extremely quick, and can be used right before the [[GlycanRelaxMover]] in order to both create and model the glycans in a single Rosetta run.

If a glycan is already present, we will delete the glycan before building the new glycan.  Currently, we do not copy any torsions onto the new glycan.  This is being worked on.

The mover can deal with a few different types of glycan names including full IUPAC names, files with the full IUPAC names, and short common names such as 'man9' or 'man5'. 

Multiple names can be passed to the mover (with an optional set of weights), where for each position, we will sample on the possible glycosylations.  This can be useful for heterogeneous positions, such as those found in the HIV envelope protein.  

The Glycans should be modeled after glycosylation.  One can idealize the torsions of the carbohydrate residues during glycosylation using conformer data we use for Glycan Relax.  This option is 'idealize_glycosylations'.  Even with this idealization, the structure will still need to be modeled properly.  See [[GlycanRelaxMover]] for more information on modeling the resulting glycan.
 


See [[Working With Glycans | WorkingWithGlycans ]] for more.



Details
=======

[[include:mover_SimpleGlycosylateMover_type]]


## See Also
- [[WorkingWithGlycans]]

### RosettaCarbohydrate Apps and Components
- #### Movers
 - [[GlycosyltransferaseMover]] - An alternative method for glycosylating a `Pose` that uses sequons and cosubstrates for specific biological enzymes.
 - [[GlycanTreeModeler]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
 - [[GlycanSampler | GlycanRelaxMover]] - Used in GlycanTreeRelax for sampling carbohydrate torsions and side-chains from structural data.

- #### Residue Selectors
 - [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest or specific trees/branches.
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
