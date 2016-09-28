GlycanRelaxMover
================

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

```
/// @brief A mover for glycosylation of biological glycosylations.
///  Currently glysolylation is done based on string, not from PDB.
///  Use GlycanRelax to model the resulting glycosylation!.
///
/// @details
///  Single Glycosylation:
///    If a single glycosylation is passed, it will glycosylate all positions set with this glycan.
///
///  Multiple Glycosylations:
///    If multiple glycosylations are passed, will randomly select from these on apply to sample glycan hetergenecity.
///
///  The site should be ASN for N-linked glycosylations OR SER/THR for O-linked glycosylations
///    If a glycan already exists, will strip off the current glycan by default.
///
///  Will randomly select from set positions and glycosylate all positions set.
///
///  Glycosylations:
///    1) If your name ends with .iupac or .gws (GlycoWorkBench), will try to load the file
///
///    2) Next, it will check the short names in the Rosetta database for your string.
///       If the string is in common_names.txt, will load the paired iupac sequence.
///       See database/chemical/carbohydrates/common_glycans/common_names.txt for accepted short names.
///     Names include man3, man5, and man9.
///
///    3)
///      If the name is not found, will attempt to build the glycan as an iupac sequence from the string.
```

<!--- BEGIN_INTERNAL -->


Usage
=====

```
<SimpleGlycosylateMover glycosylation=man5 positions=10A,15B,200/>
```


### Required Settings

```
glycosylation &string
glycosylations &string,&string,&string
  desc = Set the glycosylation(s) (short name or IUPAC or file with IUPAC)
         See database/chemical/carbohydrates/common_glycans for common names.
         Names include man3, man5, and man9.

position &string
positions &string,&string,&string
  desc = Set the position(s) we will be glycosylating.  PDB (10A) or pose (1-N) numbering just like the rest of RosettaScripts.

MoveMap &mm
  desc = Alternative way of specifiying which residues we will be glycosylating.


```

### Options

```
ref_pose_name &name
  desc = Set a specific refpose name to use. Useful if trimming protein as well as building up or down glycans.
  
strip_existing &bool
  default = true
  desc = Strip the existing glycan off if already in teh position requested.
         If this is false, we will skip this position instead of stripping it.
 
idealize_glycosylation &bool
  default = false
  desc = Idealize the carbohydrate backbone torsion angles after glycosylation? 
         Not that this is NOT garanteed to produce good structures, this is just a starting point.
         You will still want to use GlycanRelaxMover or something else to model the glycans.
          
```



<!--- END_INTERNAL -->

## See Also
* [[WorkingWithGlycans]]

- ### Apps
* [[GlycanRelax]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
* [[GlycanInfo]] - Get information on all glycan trees within a pose
* [[GlcyanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.

- ### RS Components
* [[GlycanRelaxMover]] - Glycosylate poses with glycan trees.  
* [[GlycanTreeSelector]] - Select individual glcyan trees or all of them
* [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest.

- ### Other
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
