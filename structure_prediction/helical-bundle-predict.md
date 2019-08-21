# Helical Bundle Structure Prediction (helical_bundle_predict) Application

Back to [[Application Documentation]].

Created 21 August 2019 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).<br/><br/>
<b><i>This application is currently unpublished!  If you use this application, please include the developer in the list of authors for your paper.</i><br/>

[[_TOC_]]

## Description

Rosetta's most widely-used structure prediction application, [[Rosetta ab initio|abinitio-relax]], relies on fragments of proteins of known structure to guide the search of the conformation space, and to limit the conformational search to the very small subset of the space that resembles known protein structures.  This works reasonably well for natural proteins, but prevents the prediction of structures built from non-natural building blocks.  In 2015, we introduced the [[simple_cycpep_predict]] application to allow the prediction of structures of small heteropolymers built from any mixture of chemical building-blocks, without any known template sequences.  The [[simple_cycpep_predict]] application uses the [[generalized kinematic closure|GeneralizedKIC]] algorithm to confine the search to closed conformations of a macrocycle, effectively limiting the search space without relying on databases of known structures.  Unfortunately, this only works for relatively small molecules (less than approx. 15 residues), molecules with regions of known secondary structure (less than approx. 10 residues of loop), or molecules with internal symmetry (less than approx. 8 residues in the repeating unit), and absolutely requires covalent linkage between the ends of the molecule.  A prediction strategy for larger, linear heteropolymers built from non-natural building-blocks is needed.

The helical_bundle_predict application was created to fill this niche.  Based on the hypothesis that fragments are primarily useful for sampling allowed bends of known secondary structures (which can be sampled using [[parametric approaches|MakeBundleMover]], given heteropolymer secondary structures that can be predicted _a priori_) or allowed loop conformations (which can be sampled using random perturbations or [[kinematic approaches|GeneralizedKIC]]), this application carries out a Monte Carlo search of conformation space in which allowed moves include:
- Randomization of a loop position (biased by the Ramachandran map for that residue).
- Small random perturbation of a loop position.
- Nucleation of a turn of helix (using the [[MakeBundle mover|MakeBundleMover]]).
- Elongation of a helical region (with possible merger of two helical regions).
- Contraction of a helical region.
- Small random perturbation of the Crick parameters describing a given helix (using the [[PerturbBundle mover|PerturbBundle]]), to allow helices to bend and supercoil.

![Allowed moves in the Monte Carlo search performed by the helical_bundle_predict application.](helical_bundle_predict_allowed_moves.png)

Note that, because strands are special cases of helices in which the turn per residue is about 180 degrees, this approach should be sufficiently general for any protein or heteropolymer secondary structure.

## See also
- [[Rosetta ab initio application|abinitio-relax]] -- Fragment-based protein structure prediction.
- [[Rosetta simple_cycpep_predict application|simple_cycpep_predict]] -- Structure prediction of macrocycles built from canonical or non-canonical building-blocks.
- [[Generalized kinematic closure|GeneralizedKIC]] -- A mover to sample conformations of a closed chain of atoms, without fragments.
- [[MakeBundle mover|MakeBundleMover]] -- A mover that generates a coiled-coil protein or heteropolymer parametrically, using the Crick equations.
- [[PerturbBundle mover|PerturbBundle]] -- A mover that alters Crick parameter values to perturb the conformation of a coiled-coil.
- [[BundleGridSampler mover|BundleGridSampler]] -- A mover that grid-samples Crick parameter space to identify favourable coiled-coil conformations.

## Full options list

|                        Option |          Default Setting  |Type|  Description            |      
|-------------------------------|---------------------------|----|------------------------|
|                    in:file:fasta |                           | File | Fasta-formatted sequence file. |
|                    in:file:native |                           |   File | Native PDB filename. |
|                       out:nstruct |                         1 |   Int | Number of structures to generate.  (Number of structure prediction attempts) |
|     helical_bundle_predict:helix_assignment_file |                           |   File | A file containing information about the helix types and helical regions within a helical bundle. |
| helical_bundle_predict:num_steps_per_simulated_annealing_round_centroid |    1000 |   Int| Number of steps in each round of simulated annealing in centroid mode.|
| helical_bundle_predict:num_simulated_annealing_rounds_centroid |                3 |   Int | Number of rounds of simulated annealing in centroid mode. |
      centroid_max_temperature |                        50 |   R| The maximum temperature 
                               |                           |    |  during simulated annealing 
                               |                           |    |  rounds in centroid mode.
      centroid_min_temperature |                      0.62 |   R| The minimum temperature 
                               |                           |    |  during simulated annealing 
                               |                           |    |  rounds in centroid mode.
  do_final_fullatom_refinement |                           |   B| If true, the initial 
                               |                           |    |  centroid model is 
                               |                           |    |  converted to a full-atom 
                               |                           |    |  model and relaxed with the 
                               |                           |    |  FastRelax protocol.  Other 
                               |                           |    |  refinement steps, such as 
                               |                           |    |  finding disulfides, may 
                               |                           |    |  also be carried out.  True 
                               |                           |    |  by default.
             fast_relax_rounds |                         3 |   I| The number of rounds of 
                               |                           |    |  FastRelax that will be 
                               |                           |    |  applied.  Does nothing if d
                               |                           |    |  o
                               |                           |    |  _final_fullatom_refinement 
                               |                           |    |  is false.  Set to 3 by 
                               |                           |    |  default.
               find_disulfides |                           |   B| If true, the full-atom 
                               |                           |    |  refinement steps include 
                               |                           |    |  trying disulfide 
                               |                           |    |  permutations.  Does 
                               |                           |    |  nothing if d
                               |                           |    |  o
                               |                           |    |  _final_fullatom_refinement 
                               |                           |    |  is false.  True by 
                               |                           |    |  default.
                               |                           |    |
             cyclic_peptide:   |                           |    | 
        MPI_processes_by_level |                           | (I)| The number of processes at 
                               |                           |    |  each level of the parallel 
                               |                           |    |  communications hierarchy, 
                               |                           |    |  used only by the MPI 
                               |                           |    |  version.  For example, '1 
                               |                           |    |  10 100' would mean that 
                               |                           |    |  one emperor would talk to 
                               |                           |    |  10 masters, which would 
                               |                           |    |  talk to 100 slaves 
                               |                           |    |  (implying that each master 
                               |                           |    |  is assigned 100 slaves).  
                               |                           |    |  Similarly, '1 100' would 
                               |                           |    |  mean that one master would 
                               |                           |    |  talk directly to 100 
                               |                           |    |  slaves.  Required for the 
                               |                           |    |  MPI version.
        MPI_batchsize_by_level |                           | (I)| The number of jobs sent at a 
                               |                           |    |  time by each communication 
                               |                           |    |  level to its children.  
                               |                           |    |  Given N levels, N-1 values 
                               |                           |    |  must be specified.  For 
                               |                           |    |  example, given 3 
                               |                           |    |  communications levels, 
                               |                           |    |  '100 10' would mean that 
                               |                           |    |  the emperor sends 100 jobs 
                               |                           |    |  at a time to each master, 
                               |                           |    |  which sends 10 jobs at a 
                               |                           |    |  time to each slave.  Must 
                               |                           |    |  be specified for the 
                               |                           |    |  simple_cycpep_predict 
                               |                           |    |  application in MPI mode.
                   MPI_sort_by |                    energy |   S| The MPI version of the 
                               |                           |    |  simple_cycpep_predict app 
                               |                           |    |  has the option of writing 
                               |                           |    |  out the top N% of 
                               |                           |    |  solutions.  This 
                               |                           |    |  determines the sort 
                               |                           |    |  metric.
            MPI_choose_highest |                     false |   B| When outputing the top N% of 
                               |                           |    |  solutions, should I choose 
                               |                           |    |  the ones with the higest 
                               |                           |    |  score for the metric 
                               |                           |    |  chosen (energy, rmsd, 
                               |                           |    |  hbonds, etc.) or lowest?  
                               |                           |    |  Default false (chose 
                               |                           |    |  lowest).
           MPI_output_fraction |                         1 |   R| The fraction of total 
                               |                           |    |  structures that will be 
                               |                           |    |  written out.  This is used 
                               |                           |    |  in conjunction with 
                               |                           |    |  'MPI_sort_by' to output 
                               |                           |    |  the top N% of job outputs. 
                               |                           |    |  For example, 
                               |                           |    |  '-MPI_output_fraction 0.05 
                               |                           |    |  -MPI_sort_by rmsd' means 
                               |                           |    |  that the 5% of structures 
                               |                           |    |  with the lowest RMSD 
                               |                           |    |  values will be written 
                               |                           |    |  out.
           MPI_stop_after_time |                           |   I| If this option is used, the 
                               |                           |    |  emperor node will send a 
                               |                           |    |  stop signal after an 
                               |                           |    |  elapsed period of time, 
                               |                           |    |  given in seconds.  Slaves 
                               |                           |    |  jobs currently running 
                               |                           |    |  will continue, but 
                               |                           |    |  intermediate masters will 
                               |                           |    |  not assign any more work.  
                               |                           |    |  Useful on HPC clusters 
                               |                           |    |  with time limits, to 
                               |                           |    |  ensure that jobs completed 
                               |                           |    |  are collected at the end.  
                               |                           |    |  Unused if not specified.
              MPI_pnear_lambda |                       0.5 |   R| In MPI mode a 
                               |                           |    |  goodness-of-funnel metric 
                               |                           |    |  is automatically 
                               |                           |    |  calculated at the end 
                               |                           |    |  (PNear).  This value may 
                               |                           |    |  be thought of as the 
                               |                           |    |  probability, from 0 to 1, 
                               |                           |    |  of the peptide being in 
                               |                           |    |  the target conformation at 
                               |                           |    |  any given time.  The 
                               |                           |    |  parameter lambda controls 
                               |                           |    |  the bredth of the Gaussian 
                               |                           |    |  (in RMSD units -- 
                               |                           |    |  Angstroms) that is used to 
                               |                           |    |  determine whether a state 
                               |                           |    |  is native-like or not.  
                               |                           |    |  Default 0.5 A.
                 MPI_pnear_kbt |                         1 |   R| In MPI mode a 
                               |                           |    |  goodness-of-funnel metric 
                               |                           |    |  is automatically 
                               |                           |    |  calculated at the end 
                               |                           |    |  (PNear).  This value may 
                               |                           |    |  be thought of as the 
                               |                           |    |  probability, from 0 to 1, 
                               |                           |    |  of the peptide being in 
                               |                           |    |  the target conformation at 
                               |                           |    |  any given time.  The 
                               |                           |    |  parameter kbt is the 
                               |                           |    |  Boltzmann temperature that 
                               |                           |    |  determines the extent to 
                               |                           |    |  which higher energy states 
                               |                           |    |  are likely to be sampled.  
                               |                           |    |  Default 1.0 Rosetta energy 
                               |                           |    |  units.
             threads_per_slave |                         1 |   I| In the multi-threaded MPI 
                               |                           |    |  compilation, this is the 
                               |                           |    |  number of threads to 
                               |                           |    |  launch per slave process.  
                               |                           |    |  Note that emperor and 
                               |                           |    |  master-layer processes do 
                               |                           |    |  not launch threads.  A 
                               |                           |    |  value of 1 (the default) 
                               |                           |    |  means that only standard 
                               |                           |    |  hierarchical process-based 
                               |                           |    |  parallelism will be used.  
                               |                           |    |  In non-MPI or non-threaded 
                               |                           |    |  compilations, this option 
                               |                           |    |  is unused.
--------------------------------------------------------------------------
