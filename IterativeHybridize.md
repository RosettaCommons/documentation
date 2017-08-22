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

Protein homology model refinement by large scale energy optimization
Hahnbeom Park, Sergey Ovchinnikov, David E Kim, Frank DiMaio, and David Baker. Submitted.

## Algorithm

At a high-level, the algorithm consists of a long Monte Carlo trajectory starting from a randomly-chosen template.  The MC trajectory employs the following moves: a) fragment insertion in unaligned regions, b) replacement of a randomly-chosen segment with that from a different template structure, and c) Cartesian-space minimization using a smooth (differentiable) version of the Rosetta [[centroid|centroid-vs-fullatom ]] energy function.  Finally, this is followed by all-atom optimization.

## Running the IterativeHybridize protocol

Step 0. Generate "relatively" diverse models (i.e. share same topology but not too close)
- This is not part of this documentation since there could be various methods for doing this 

Step 1. iterate below process N times (typically n~50)
- Select Parents among structure pool
- Hybridize given parents
- Select next pool from Parent + Newly generated structure pools

Step 2. Select representative model

### Step 1: IterativeHybridization

* IterationMaster.py: Python wrapper script for running iterative process
(TBA)

* Model selection from diverse initial structures (at the beginning of first iteration)

$ROSETTA/main/source/bin/iterhybrid_selector.linuxgccrelease \
-in:file:silent $1 \
-in:file:template_pdb $2 -cm:similarity_cut $3 \
-mute core basic \
-out:file:silent picked.out \
-out:nstruct $4 \
-silent_read_through_errors -in:file:silent_struct_type binary -out:file:silent_struct_type binary \
(optional.1 for rescoring) -score:weights ref2015_cart -cst_fa_file fa.cst -set_weights atom_pair_constraint 1.0 \
(optional.2 for dumping adaptive cst) -constraint:dump_cst_set cen.pair.cst
(optional.3 for deformation penalty) -cm:refsimilarity_cut $5 
(optional.4 for quota setup for each input silent, should match number of input silents) -cm:quota_per_silent 0.7 0.3 

$1: list of silent files containing diverse models
$2: input "reference" structure (necessary)
$3: minimum mutual distance for selected structures, range from 0(identical) to 1(completely different), where formula is 1 - Sscore; Sscore is metric inverse to RMSD and has very similar scale to TM-score
$4: number of structures to select
$5, optional: estimated Similarity-To-ReferenceStructure in GDT-HA scale, puts penalty if any structure gets dissimilar to reference structure than this value

* Generating adaptive restraints from pool of structures

See optional.2 above. 

* Model selection from Parent + New structures (after every iteration)

~/Rosetta/main/source/bin/iterhybrid_selector.linuxgccrelease \
-in:file:silent $1 \
-in:file:template_pdb $2 \
-in:file:template_silent ref.out -refsimilarity_cut $1 -similarity_cut $2 \
-cm:seeds $3 -cm:similarity_limit 0.2 \
-mute core basic \
-out:file:silent sel.out \
-out:nstruct 30 -out:prefix $4 \
-silent_read_through_errors -in:file:silent_struct_type binary -out:file:silent_struct_type binary \
-beta_cart -cst_fa_file fa.cst -set_weights atom_pair_constraint 1.0 \



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