#Iterative Hybridize: protein model refinement protocol

## Metadata

Documentation by Hahnbeom Park (hahnbeom@u.washington.edu)

## Purpose

This protocol brings large scale structure refinement starting from a pool of 
* homology model structures or 
* relatively converged de novo ab initio models.

HybridizeMover works as basic sampling unit during overall iterative global energy optimization process. Objective function for global optimization is set as Rosetta all-atom energy by default, but user-defined restraints can be also incorporated -- for instance co-evolution restraints and so on -- as weighted sum to total score.

## References

[Protein structure determination using metagenome sequence data]
(http://science.sciencemag.org/content/355/6322/294). 
Sergey Ovchinnikov, Hahnbeom Park, Neha Varghese, Po-Ssu Huang, Georgios A. Pavlopoulos, David E. Kim, Hetunandan Kamisetty, Nikos C. Kyrpides, David Baker. 
Science 2017, 355:294-298.

[Protein homology model refinement by large scale energy optimization]
(http://www.pnas.org/content/115/12/3054).
Hahnbeom Park, Sergey Ovchinnikov, David E Kim, Frank DiMaio, and David Baker. 
Proc Natl Acad Sci USA 2018. 

## Algorithm

The composite of Rosetta app and python master script here carries out genetic-algorithm-inspired structural refinement. Key concepts in genetic algorithm are a) Parent selection, b) Crossover or mutational (structural) operations for generating new offspring structural pools from those parents, c) Pool control after new structure generations, and d) optionally, logics for preventing from early convergence, that is, maintaining sufficient structural diversity during the procedure. The app and script contains logics brought from Conformational Space Annealing (CSA) such as annealing distance-threshold for clustering as iteration proceeds, parent selection based on number of times used without discovering new competative structure (nuse), which improves a,c,d) over typical genetic algorithms. Structural operations, b), mostly rely on HybridizeMover, which is optimized for cross-over style structural operations for homology modeling problems.

## Running the IterativeHybridize protocol

### Overview

Step 0. Diversification stage
Generate "relatively" diverse models (i.e. share same topology but not too close)
: not part of this documentation since there could be various methods for doing this 

Step 1. Evolution stage
iterate below process N times (typically n~50)
- Select Parents among structure pool
- Hybridize given parents
- Select next pool from Parent + Newly generated structure pools

### Model selection from diverse initial structures 
Required to begin the first iteration. Command line using Rosetta public app:

    $ROSETTA/main/source/bin/iterhybrid_selector.linuxgccrelease \
    -in:file:silent $1 -in:file:template_pdb $2 -cm:similarity_cut $3 \
    -out:file:silent ref.out -out:nstruct $4 \
    -out:prefix iter0 -score:weights ref2015_cart \
    -silent_read_through_errors -in:file:silent_struct_type binary -out:file:silent_struct_type binary -mute core basic \

    (optional.1 for rescoring with restraints) -cst_fa_file fa.cst -set_weights atom_pair_constraint 1.0
    (optional.2 for dumping adaptive cst) -constraint:dump_cst_set cen.pair.cst
    (optional.3 for deformation penalty) -cm:refsimilarity_cut $5 
    (optional.4 for quota setup for each input silent, should match number of input silents) -cm:quota_per_silent 0.7 0.3 

* $1: list of silent files containing diverse models
* $2: input "reference" structure (necessary; this is usually a template-based model and required to restrict search around it
* $3: 0.2 is recommended; minimum mutual distance for selected structures ranging from 0(identical) to 1(completely different), where formula is 1 - Sscore; Sscore is metric inverse to RMSD and has very similar scale to TM-score
* $4: 30 to 50 is recommended; size of structural pool
* $5, optional: estimated Similarity-To-ReferenceStructure in GDT-HA scale, puts penalty if any structure gets dissimilar to reference structure than this value, default is 25.0

* IMPORTANT: **"-out:prefix iter0"** is necessary to reformat input silent readable by IterationMaster.py. Please check if you included this option correctly if you get failure message "ERROR: pdbs not extracted correctly!".
* NOTE: By adding "-constraint:dump_cst_set cen.pair.cst" the app generates a default restraints set for following iterative process, derived from converged regions in the structural pool, which is recommended for users not having own customized restraints file.

### Generating adaptive restraints from a pool of structures

See optional.2 above. 

### Running iterative process
All the python/bash scripts required for iterative process can be found at:

    $Rosetta/main/source/scripts/python/public/iterative_hybridize/

Copy over files at the directory to wherever convinient (say $SCRIPTDIR). 
Prepare these files and copy it to working directory; note that file names should EXACTLY MATCH.

    * init.pdb : Reference structure (e.g. homology model) in pdb format
    * input.fa : sequence in fasta format
    * t000_.3mers, t000_.9mers: Rosetta fragment library files
      (please refer to https://www.rosettacommons.org/docs/wiki/application_documentation/utilities/app-fragment-picker for picking fragments)

    * cen.cst, fa.cst : Rosetta restraint file used at centroid / full-atom stage
                        See above "Generating adaptive restraints from pool of structures". 
                        "fa.cst" is used for model ranking during process and can be ignored.

    * ref.out : Rosetta silent file containing pool of structures for evolutionary algorithm. 
                Size of pool during evolutionary process follows number of structures in this file.

Once files are prepared, run command line below (for default options):

    python $SCRIPTDIR/IterationMaster.py -iha [model accuracy] -nodefile [nodefile] >& iterhyb.log

    * model accuracy : % in GDT-HA scale; 
                      (20/40/60) mean (completely wrong / roughly correct / correct)
    * nodefile: a text file containing nodes to distribute; 
      using 4 cores at n001 will be like:

      n001
      n001
      n001
      n001

More options:

    -native [pdb]  # native structure for monitoring model accuracy during process
    -debug         # turn on debug mode
    -niter [int]   # number of iterations, default=50
    -simple        # run simpler protocol with predefined options
                   # used for Robetta server & refinement w/ co-evolution data
    -mulfactor_phase0 [int] # scale factor for number of sampling at initial phase; 
                            # default=2 (twice more at beginning) 
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

Output models after each iteration are always clustered and sorted based on their energy (+full-atom restraint if provided) thus picking the lowest index model(s) is most direct way of selecting representative models. These "model[1-5].pdb" can be found at "workdir/iter_[niter]/" if the whole process is normally finished.

Alternately, structure averaging on full trajectory can be performed:

    cat iter_*/gen.out > gen.total.out

    $ROSETTA/main/source/bin/avrg_silent.linuxgccrelease -database $ROSETTADB \
    -in:file:template_pdb iter_[niter]/model1.pdb -out:prefix avrg \
    -cm:similarity_cut 0.5 \
    -in:file:silent gen.total.out -silent_read_through_errors > avrg.log

"avrg.relaxed.pdb" generated after this command is structure-averaged + regularized model. -cm:similarity_cut takes the same structural distance metric described for iterhybrid_selector app; smaller the close structures are, and roughly 0.2 is family-level similarity, 0.6 is fold-level similarity.

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