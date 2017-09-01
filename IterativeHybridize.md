#Iterative Hybridize: protein model refinement protocol

## Metadata

Documentation by Hahnbeom Park (hahnbeom@u.washington.edu)

## Purpose

This protocol brings large scale structure refinement starting from a pool of 
* homology model structures or 
* relatively converged de novo ab initio models.

In overall iterative global energy optimization process, HybridizeMover becomes the basic sampling unit. Objective function for global optimization is Rosetta all-atom energy by default, but user-defined restraints can be also incorporated, for instance co-evolution restraints and so on.

## References

[Protein structure determination using metagenome sequence data]
(http://science.sciencemag.org/content/355/6322/294). 
Sergey Ovchinnikov, Hahnbeom Park, Neha Varghese, Po-Ssu Huang, Georgios A. Pavlopoulos, David E. Kim, Hetunandan Kamisetty, Nikos C. Kyrpides, David Baker. 
Science 2017, 355:294-298.

Protein homology model refinement by large scale energy optimization. 
Hahnbeom Park, Sergey Ovchinnikov, David E Kim, Frank DiMaio, and David Baker. Submitted.

## Algorithm

** Overview of Genetic algorithm (carried out by master python wrapper script)
The composite of Rosetta app and python master script here carries out genetic-algorithm-inspired structural refinement. Key concepts in genetic algorithm are a) Parent selection, b) Crossover or mutational (structural) operations for generating new offspring structural pools from those parents, c) Pool control after new structure generations, and d) optionally, logics for preventing from early convergence, that is, maintaining enough structural diversity during the procedure. The app and script contains logics brought from Conformational Space Annealing (CSA) such as annealing distance-threshold for clustering as iteration proceeds, parent selection based on number of times used without discovering new competative structure (nuse), which improves a,c,d) over typical genetic algorithms. Structural operations, b), mostly rely on HybridizeMover, which is optimized for cross-over style structural operations for homology modeling problems.

## Running the IterativeHybridize protocol

Step 0. Generate "relatively" diverse models (i.e. share same topology but not too close)
: not part of this documentation since there could be various methods for doing this 

Step 1. iterate below process N times (typically n~50)
- Select Parents among structure pool
- Hybridize given parents
- Select next pool from Parent + Newly generated structure pools

### Step 1: IterativeHybridization

#### IterationMaster.py: Python wrapper script for running iterative process
(TBA)

#### Model selection from diverse initial structures 
Required to begin the first iteration. Command line using Rosetta public app:

    $ROSETTA/main/source/bin/iterhybrid_selector.linuxgccrelease \
    -in:file:silent $1 -in:file:template_pdb $2 -cm:similarity_cut $3 \
    -out:file:silent picked.out -out:nstruct $4 \
    -silent_read_through_errors -in:file:silent_struct_type binary -out:file:silent_struct_type binary -mute core basic \

    (optional.1 for rescoring) -score:weights ref2015_cart -cst_fa_file fa.cst -set_weights atom_pair_constraint 1.0
    (optional.2 for dumping adaptive cst) -constraint:dump_cst_set cen.pair.cst
    (optional.3 for deformation penalty) -cm:refsimilarity_cut $5 
    (optional.4 for quota setup for each input silent, should match number of input silents) -cm:quota_per_silent 0.7 0.3 

* $1: list of silent files containing diverse models
* $2: input "reference" structure (necessary)
* $3: minimum mutual distance for selected structures, range from 0(identical) to 1(completely different), where formula is 1 - Sscore; Sscore is metric inverse to RMSD and has very similar scale to TM-score
* $4: number of structures to select
* $5, optional: estimated Similarity-To-ReferenceStructure in GDT-HA scale, puts penalty if any structure gets dissimilar to reference structure than this value

#### Generating adaptive restraints from pool of structures

See optional.2 above. 

#### Model selection from Parent + New structures (after every iteration)

Command line using Rosetta public app:

    $ROSETTA/main/source/bin/iterhybrid_selector.linuxgccrelease \
    -in:file:silent $1 \
    -in:file:template_pdb $2 \
    -in:file:template_silent $6 -similarity_cut $3 -cm:similarity_limit 0.2 \
    -out:nstruct $4 -out:file:silent sel.out \
    -out:prefix iter.$niter \
    -silent_read_through_errors -in:file:silent_struct_type binary -out:file:silent_struct_type binary -mute core basic

    (optional.1 for rescoring) -score:weights ref2015_cart -cst_fa_file fa.cst -set_weights atom_pair_constraint 1.0
    (optional.2 for dumping adaptive cst) -constraint:dump_cst_set cen.pair.cst
    (optional.3 for deformation penalty) -cm:refsimilarity_cut $5 
    (optional.4 for parent information update) -cm:seeds $7

* $1 ~ $5: same description with "Model selection from diverse initial structures"; here $1 is parent pool
* $6: the newly generate structure pool in silent format
* $7: update what structures in Parent pool have been served as Parents; should have column "poolid" in the silent parent file ($1) in order to invoke this option
* $niter: next iteration index (e.g. iter2)

### Post Processing

Output models after each iteration are always clustered and sorted based on their energy (+restraint, if provided) thus picking the lowest index model(s) in the output silent is most direct way of selecting representative models.

See [[Analyzing Results]]: Tips for analyzing results generated using Rosetta

### Other tips

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