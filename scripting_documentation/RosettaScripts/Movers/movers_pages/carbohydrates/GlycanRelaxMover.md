GlycanRelaxMover
================

[[_TOC_]]

MetaData
========

Mover/Application created by Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com) and Dr. Jason Labonte (JWLabonte@jhu.edu), in collaboration with Dr. Sebastian Raemisch (raemisch@scripps.edu)

PIs: Dr. William Schief (schief@scripps.edu) and Dr. Jeffrey Gray (jgray@jhu.edu)


Description
===========

Glycan Relax aims to sample potential conformational states of carbohydrates, either attached to a protein or free.  It is extremely fast.  Currently, it uses a few strategies to do so, using statistics from various papers, the CHI (CarboHydrate Intrinsic) energy term, and a new framework for backbone dihedral sampling. Conformer statistics adapted from Schief lab Glycan Relax app, originally used/written by Yih-En Andrew Ban.

It can model glycans from ideal geometry, or refine already-modeling glycans.  This is still an in-development application.

See [[Working With Glycans | WorkingWithGlycans ]] for more.

<!--- BEGIN_INTERNAL -->

Algorithm
=======
See [[GlycanRelax]] (application documentation) for the current algorithm.

Usage
=====

```
<GlycanRelaxMover residue_selector= selector/>
```


### Common Settings

```
rounds &size
  default = 75
  desc = Number of rounds to use for Glycan Relax. 
         Total rounds is this # times number of glycan residues in movemap

scorefxn &score
  default = always the rosetta_default (Currently Talaris1014)
  desc = Particular scorefunction to use.  
         Passing -include_sugars to Rosetta, will add sugar-specific terms to the default score funciton.
         If you are passing your own scorefxn, make sure to add these (currently only sugar_bb at a weight of 1.

ref_pose_name &name
  desc = Set a specific refpose name to use. Useful if trimming protein as well as building up or down glycans.


```

### Residue Selection

```
task_operations & operations
  default = Glycan OH groups and Neighbor protein residues
  desc = Set a particular set of task operations to use for packing.  Yes, design is actually possible here.
  
  
residue_selector &selector_name
  default  = All Glycan Residues
  desc = Use residue selectors to select residues for which we will model.  
 
MoveMap & mm
  default = All Glycan Residues
  desc = Use a MoveMap to select residues for which we will model.

branch &string
branches &string,&string&string
  default = All Glycan Residues
  desc = Specify a particular resnum for which we will model everything 'out' from this for that glycan(s)  
         Still useful, but much functionality has been superseeded by the
         GlycanResidueSelector in combination with the GlycanTreeSelector 
 
```



### Starting Glycans
```
random_start &bool
  default = false
  desc = Randomize the starting glycans set to move before the protocol.  Used to create increased diversity.  
         This is recommended if doing de-novo glycan modeling, 
         or you have just glycosylated using the SimpleGlycosylateMover.

sugar_bb_start &bool
  default = false
  desc = Randomize the starting glycans using sugar bb data before the protocol.  
         Results in generally better structures than random start, but lower quantity of great poses.  
         IE - less crap, but less enrichment of super-great structures.
```

### Fine Control

```
kt &real
  default = 2.0
  desc = KT for GlycanRelaxMover
  
pymol_movie &bool
  default = false
  desc = Make a movie of accepts and trials by outputing frames 
         (as pymol does not currently recieve the needed LINK/CONNECT records when 
         sent through the pymol mover/observer system). 
  
final_min &bool
  default = true
  desc = Do a final minimization of glycans after glycan relax protocol?
```

<!--- END_INTERNAL -->

## See Also
* [[WorkingWithGlycans]]

 - ### Apps
* [[GlycanRelax]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
* [[GlycanInfo]] - Get information on all glycan trees within a pose
* [[GlcyanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.

 - ### RS Components
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
