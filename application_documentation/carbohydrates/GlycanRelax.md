GlycanRelax
===========

[[_TOC_]]

MetaData
========

Application created by Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com) and Dr. Jason Labonte (JWLabonte@jhu.edu), in collaboration with Dr. Sebastian Rämisch (raemisch@scripps.edu)

PIs: Dr. William Schief (schief@scripps.edu) and Dr. Jeffrey Gray (jgray@jhu.edu)


Description
===========

App: glycan_relax


Glycan Relax aims to sample potential conformational states of carbohydrates, either attached to a protein or free.  It is extremely fast.  Currently, it uses a few strategies to do so, using statistics from various papers, the CHI (CarboHydrate Intrinsic) energy term, and a new framework for backbone dihedral sampling. Conformer statistics adapted from Schief lab Glycan Relax app, originally used/written by Yih-En Andrew Ban.

It can model glycans from ideal geometry, or refine already-modeling glycans.

See [[Working With Glycans | WorkingWithGlycans ]] for more.

<!--- BEGIN_INTERNAL -->

Algorithm
=======

Each round optimizes either one residue for BB sampling, linkage, or multiple for minimization. The overall total number of rounds is scaled linearly with the number of residues to sample.

By default, we optimize all glycan trees of pose. 

Currently uses a random sampler with a set of weights to each mover for sampling.  The packing of OH groups and surrounding residues is done intermittantly.  A final round of pack/min/pack is done at the end of the protocol. 

Full Description:
```
///@brief Main mover for Glycan Relax, which optimizes glycans in a pose.
/// Each round optimizes either one residue for 
       BB sampling, linkage, or multiple for minimization.
/// Currently uses a random sampler with a set of weights to each mover for sampling.
///
/// Weights are currently as follows:
///  .40 Phi/Psi Sugar BB Sampling
///  .20 Linkage Conformer Sampling
///  .30 Small BB Sampling - equal weight to phi, psi, or omega
///    -> .17 +/- 15 degrees
///    -> .086 +/- 45 degrees
///    -> .044 +/- 90 degrees
///  .05 MinMover
///  .05 PackRotamersMover
///
```

Options
=======

 - Option Group: ```carbohydrates:GlycanRelax```
 
```

-glycan_relax_test, 'Boolean',
    default = false
    desc = Indicates to go into testing mode for Glycan Relax.  
           Will try all torsions in a given PDB in a linear fashion
    

-glycan_relax_rounds, 'Integer'
        default = 75
	desc = Number of rounds to use for Glycan Relax. 
               Total rounds is this # times number of glycan residues in movemap
	

-pack_glycans, 'Boolean',
        default = false
	desc = Pack Glycan OH groups during Glycan Relax. Currently time consuming
	
	
-final_min_glycans, Boolean
        default = true
	desc = 'Do a final minimization of glycans after glycan relax protocol?
	
	
-glycan_relax_movie, Boolean
	desc = Make a movie of accepts and trials (send to pymol)
	default = false

-glycan_relax_kt, Real
        default = 2.0
	desc = KT for GlycanRelaxMover
	

-glycan_relax_random_start, Boolean
        default = false
	desc = Randomize the starting glycans set to move before the protocol.  
                Used to create increased diversity.
	

-glycan_relax_sugar_bb_start, Boolean
        default = false
	desc = "Randomize the starting glycans using sugar bb data before the protocol.
	

```

Tips
====
The runtime of the protocol scales with the number of glycans.  The number of total rounds is the product of ```-glycan_relax_rounds``` * total_glycan_residues.
We have observed that for most uses, 75 base rounds is results in well optimized structures.  
The option ```-glycan_relax_random_start``` generally is recommended if doing de-novo design.  This option increases the diversity of the resulting glycans.

In terms of decoys, one should try to produce between 10,000 and 100,000 decoys (or increase the number of rounds) if possible.  We realize that as the number of glycans increase, this number of decoys becomes
relatively unattainable.  Development is ongoing to combine fragment-based methods with our GlycanRelax methodology to overcome this issue for some circumstances.

Typical Use
===========
Here is an example modeling an already-glycosylated pose.

```
glycan_relax.default.macosclangrelease -include_sugars -write_pdb_link_records \
-s glyco_pose.pdb -nstruct 10000 -glycan_relax_rounds 75 -glycan_relax_random_start
```

Scripting
=========
This application is itself a mover and can be called directly within RosettaScripts. See [[GlycanRelaxMover]] for more.  

It is also available in PyRosetta:
```
from rosetta import *
from rosetta.protocols.carbohydrates import GlycanRelaxMover
rosetta.init('-include_sugars -write_pdb_link_records')

p = Pose("my_glycosylated_pose")
glycan_relax = GlycanRelaxMover()
glycan_relax.apply(p)

print p
```
This will model all glycans using Rosetta's default scorefunction.  Optionally, a movemap, scorefunction, and taskfactory can be specified.  Most command-line options can be set via the object as well.  Any not set, can be set in rosetta.init() function of PyRosetta:
```
glycan_relax.set_movemap(mm)
glycan_relax.set_scorefunction(scorefxn)
glycan_relax.set_taskfactory(tf)

glycan_relax.set_rounds(100)
glycan_relax.set_kt(5.0)
```

<!--- END_INTERNAL -->

## See Also
* [[WorkingWithGlycans]]

- ### Apps
* [[GlycanInfo]] - Get information on all glycan trees within a pose
* [[GlycanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.

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