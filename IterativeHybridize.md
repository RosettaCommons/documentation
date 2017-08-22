#Iterative Hybridize: protein model refinement protocol

## Metadata

Documentation by Hahnbeom Park (hahnbeom@u.washington.edu)

## Purpose

This protocol brings large scale structure refinement starting from a pool of homology model structures or relatively converged de novo ab initio models.

## References

[Protein structure determination using metagenome sequence data]
(http://science.sciencemag.org/content/355/6322/294)

Sergey Ovchinnikov, Hahnbeom Park, Neha Varghese, Po-Ssu Huang, Georgios A. Pavlopoulos, David E. Kim, Hetunandan Kamisetty, Nikos C. Kyrpides, David Baker. 
Science 2017, 355:294-298.

## Algorithm

At a high-level, the algorithm consists of a long Monte Carlo trajectory starting from a randomly-chosen template.  The MC trajectory employs the following moves: a) fragment insertion in unaligned regions, b) replacement of a randomly-chosen segment with that from a different template structure, and c) Cartesian-space minimization using a smooth (differentiable) version of the Rosetta [[centroid|centroid-vs-fullatom ]] energy function.  Finally, this is followed by all-atom optimization.

## Running the IterativeHybridize protocol

Step 0. Generate "relatively" diverse models (i.e. share same topology but not too close)
- This is not part of this documentation since there could be various methods for doing this 

Step 1. iterate below process N times (typically n~50)
- Select Parents among structure pool
- Hybridize given parents
- Select next pool from Parent pool + 

Step 2. Select representative model

### Step 1: IterativeHybridization

* IterationMaster.py: Python wrapper script for running iterative process
(TBA)

* Model selection from diverse initial structures (at the beginning of first iteration)

* Generating adaptive restraints from pool of structures

* Model selection from Parent + New structures (after every iteration)





### Step 2: Select representative model


### Post Processing

See [[Analyzing Results]]: Tips for analyzing results generated using Rosetta

### Other tips

**How can I model with multiple chains?**

In the input fasta file, separate sequences of individual chains with a '/' character.


## See Also

* [[RosettaScripts]] documentation
* [[RosettaCM]] : Rosetta homology modeling protocol
* [[HybridizeMover]]: The Hybridize Mover used by RosettaCM
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files