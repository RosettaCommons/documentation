#Enumerative building of a protein loop through systematic recursion

Metadata
========

Author: Rhiju Das

Written in 2013. Last update: Apr. 2013 by Rhiju Das (rhiju [at] stanford.edu).

Code and Demo
=============

The central code for the *swa\_protein\_main* application is in `       src/apps/swa/protein/swa_protein_main.cc      ` and in several files in `       src/protocols/swa/      ` .

For a demo of the entire workflow and example files, see:

`       demos/public/swa_protein_long_loop/      `

References
==========

Das, R. (2013) "Atomic-accuracy prediction of protein loop structures enabled by an RNA-inspired ansatz", under review. [Preprint](http://dx.doi.org/10.1371/journal.pone.0074830) .

See also:

Sripakdeevong, P., Kladwang, W., and Das, R. (2011) "An enumerative stepwise ansatz enables atomic-accuracy RNA loop modeling", PNAS 108:20573-20578. [Paper](http://www.stanford.edu/~rhiju/Sripakdeevong_StepwiseAnsatz_2011.pdf) [Link](http://dx.doi.org/10.1073/pnas.1106516108)

Application purpose
===========================================

This code is intended to give three-dimensional de novo models of protein segments at atomic accuracy without requiring input information from surrounding sidechains. This documentation presents the workflow for loops longer than 4-5 residues. See [[Enumerative building of a protein loop [part of Stepwise Assembly modeling]|swa-protein-main]] for short loops.

Algorithm
=========

The algorithm builds a loop de novo by building fragments one residue at a time from the takeoff point and from the ending poiint, by complete backbone enumeration at each step. Models of the entire protein loop are created by exhaustively combining N-terminal and C-terminal fragments and subjecting to chain closure. Each single-residue rebuild or chain closure step is a Rosetta call to `       swa_protein_main      ` ; these calls are described in [[Enumerative building of a protein loop [part of Stepwise Assembly modeling]|swa-protein-main]]. The workflow is described as a directed acyclic graph (DAG) of Rosetta jobs with well-defined dependencies.

Limitations
===========

-   This method does not fully enumerate the entire conformational space of a loop, but instead the subspace that is reachable through residue-by-residue building in stages that are themselves low in energy [this is our working hypothesis, or StepWise Ansatz].

-   This method has been demonstrated to reach atomic accuracy for small motifs (12 residues or less), including cases that are not solvable by other Rosetta approaches such as fragment assembly or KIC loop modeling. However, in several cases it is one of the five lowest models that is atomically accurate, not the very lowest energy one. Problems in the Rosetta energy function become apparent in discriminating 'correct' loops when the conformational sampling is carried out exhaustively.

-   Carrying out full StepWise Assembly requires a master python script to setup the job, and another master python script to queue up the resulting computation, which is described as a directed acyclic graph. This full workflow is described in separate documentation [see [[Enumerative building of a protein loop through systematic recursion|swa-protein-long-loop]] ].

-   As with most other modes in Rosetta, the final ensemble of models is not guaranteed to be a Boltzmann ensemble. However the outputted models *are* expected to be a complete set of the lowest energy configurations stemming from a reasonably complete search of conformational space.

-   Minimization or sampling of tau [CA bond angle] is not being carried out.

-   This code is not fully integrated with RNA StepWise Assembly scripts [see [[RNA loop modeling (lock-and-key problem) with Stepwise Assembly|swa-rna-loop]] ], although their development stemmed from the original shared codebase. Python scripts for running the complete workflow are similar, but not the same. These codebases may potentially be unified in the near future to help tackle RNA/protein modeling such as the ribosome.

Modes
=====

Stepwise assembly can be carried out to rebuild an internal loop or, more simply, to rebuild a terminal loop. The first mode will be described here, as it is a more common use case.

Setup
=====

You need to define an environment variable \$ROSETTA with your Rosetta directory. Add to your .bashrc or .bash\_profile a line like:

```
export ROSETTA='/Users/rhiju/src/rosetta/'   [change to your Rosetta directory]
```

You also need your system to know where the python scripts are for generating the DAG and running the jobs:

```
PATH=$PATH:$ROSETTA/rosetta/tools/SWA_protein_python/generate_dag/
PATH=$PATH:$ROSETTA/rosetta/tools/SWA_protein_python/run_dag_on_cluster/
```

Input Files
===========

Required file
-------------

You need only two input files to run `       swa_protein_main      ` loop modeling:

-   The [[fasta file]]: it is the sequence file for your full model (protein plus built loop).

-   The input PDB file. It is OK to input this without any sidechains and without loops. You can also include a starting loop (its bond lengths and angles will be used for all models).

Optional additional files:
--------------------------

-   Native pdb file, if CA rmsds, backbone rmsds, and all-heavy-atom rmsd's are desired.

-   Disulfide file. Important for side-chain packing! Each line should contain two numbers for each pair of disulfide-bonded residues.

How to include these files.
---------------------------

Running StepWise assembly requires setting up a DAG (directed acyclic graph) of all the Rosetta commands that need to be run.

A sample command line to rebuilds residues 3-8 on the knottin scaffold 2it7 which has had the loop and all the protein's sidechains removed:

```
generate_swa_protein_dag.py  -loop_start_pdb noloop_2it7_stripsidechain.pdb  -native 2it7.pdb -fasta 2it7.fasta -cluster_radius 0.25 -final_number 1000   -denovo 1   -disulfide_file 2it7.disulf  -loop_res 3 4 5 6 7 8
```

All of these input files are available in the `       rosetta_inputs/      ` subdirectory of the rosetta demo directory above.

The outputs are:

-   `        protein_build.dag       ` text file outlining all the jobs, preprocessing and preprocessing script commands, and their dependencies. In condor DAGMAN format.

-   `        CONDOR/       ` directory with job definitions, in format similar to condor job definition format.

-   `        REGION_3_2/, REGION_4_2/, ...       ` directories that will hold outputs of each rosetta job. The numbers correspond to the N-terminal residue of the loop fragment reaching from the C-terminus endpoint of hte loop, and the C-terminal residue of the loop fragment reaching from the N-terminal takeoff of the loop. REGION\_3\_2 corresponds to models in which the loop fragments have met at the boundary between residues 2 and 3.

Running on a cluster
--------------------

On condor clusters, you can carry out the above DAG via the command:

```
condor_dagman protein_build.dag
```

We have found `       condor_dagman      ` to be extraordinarily slow, unfortunately. A further problem is that there is currently no good universal solution to running DAGs on clusters, although packages like Pegasus and newer versions of Hadoop appear promising.

For our own purposes, we have developed in-house python scripts [available in `       rosetta/tools/SWA_protein_python/run_dag_on_cluster/      ` ] to run the jobs by kicking off a master node that can queue jobs to slave nodes. Most recently, we have been using PBS/torque ('qsub') queueing, and you can run the jobs using 100 cores with the command:

```
 qsub README_QSUB
```

which will queue from a master node:

```
 SWA_pseudo_dagman_continuous.py -j 100 protein_build.dag  > SWA_pseudo_dagman_continuous.out 2> SWA_pseudo_dagman_continuous.err
```

Further development for LSF clusters and MPI queuing is also under way. Please contact rhiju [at] stanford.edu with questions, or suggestions for supporting more general queuing systems. Or if you want a post doc or collaboration figuring how to make this code easy to run on any cluster, optimizing its speed, and applying to a range of practical and fundamental protein structure prediction problems, contact us!

The code takes about 4 hours to generate loop models if you use 100 cores. We get a 'silent file' with all the models, `       2it7_rebuild.out      ` .

To extract models from a silent file, you can use the usual Rosetta `       extract_pdbs      ` command:

```
extract_pdbs -in:file:silent region_FINAL.out -tags S_0
```

Expected Outputs
================

From the above run, we get a 'silent file' with all the models, `       region_FINAL.out      ` .

Options
=======

Following are options

```
Required:
-fasta                                           Fasta-formatted sequence file. [File]
-start_pdb                                       Input PDB with starting model -- cannot have loop present.
-loop_res                                        Positions that need to be rebuilt.

Commonly used options
-native                                          Native PDB filename. [File].
-disulfide_file                                  Specify disulfide-bonded pairs explicitly, including any involving loop residues.
-loop_force_Nsquared                             In SWA buildup, model stages with partial fragments reaching from N-terminus and
                                                   from C-terminus. Default is to <em>not</em> do this, keeping models with buildup from one end
                                                   or from other end, but not both, and closing chain in middle -- cannot capture
                                                   'hairpin' like loops where contacts within loop are important. Turning
                                                   on -loop_force_Nsquared increases the number of stages as N^2 rather than N, where
                                                   N is the number of residues in the loop.
-rmsd_screen                                     Only keep models with backbone RMSD [N,CA,C,O] within this cutoff useful for
                                                  agressive sampling near PDB specified by -native.

Less commonly used options
-cst_file                                        Constraint file in classic Rosetta format for atom-pairs. Use 'global numbering'.
-cluster:radius                                  How finely to cluster loops (based on backbone RMSD) before minimizing and again
                                                  before output. In Angstroms. Default 0.25 A is reasonable for long loops.
-N_SAMPLE                                        Number of 'rotamers' in phi or psi torsion angles. Default is 18, corresponding to
                                                  360/18 = 20 degree increments
-nstruct                                         Maximum number of models to make. default: 400. [Integer]
-cst_file                                        Constraint file in classic Rosetta format for atom-pairs. Use 'global numbering'.
-no_ccd                                          Do not close chains with CCD moves.
-do_kic                                          Also try to close chains by analytical loop closure (KIC-like); does not appear
-disable_sampling_of_loop_takeoff                Do not sample psi at take off point or phi at end point. [use if trying to match
                                                  previous work with KIC loop modeling.]
                                                  effective compared to CCD above.
```

Including constraints
---------------------

It can be useful for runs that refine a structure (e.g., the experimental structure) or for homology modeling to stay close to a starting structure. You can generate a constraint file as follows:

```
generate_CA_constraints.py 2it7.pdb -cst_res 3-8 -coord_cst -anchor_res 1 -fade > 2it7_coordinate2.0.cst
```

This python script is available in `       rosetta/tools/SWA_protein_python/generate_dag/      ` , which should already be in your path.

To incorporate into the loop modeling above, include in the `       generate_swa_protein_dag.py      ` command line a flag `       -cst_file 2it7_coordinate2.0.cst      `

New things since last release
=============================

This documentation has been added at the same time as public release of the demo [after Rosetta 3.5].

##See Also

* [[Go back to the main protein Stepwise Assembly app page|swa-protein-main]]
* [[RNA loop modeling with Stepwise Assembly|swa-rna-loop]]
* [[Stepwise MonteCarlo application|stepwise]]
* [[Overview of Stepwise classes|stepwise-classes-overview]]
* [[Structure prediction applications]]: Includes links to these and other applications for loop modeling
* [[RosettaScripts]]: The RosettaScripts home page
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
