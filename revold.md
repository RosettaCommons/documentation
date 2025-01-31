# RosettaEvolutionaryLigand (REvoLd)

# Purpose

RosettaEvolutionaryLigand (REvoLd) is an evolutionary algorithm to efficiently sample small molecules from fragment-based combinatorial make-on-demand libraries like Enamine REAL. It has been designed to optimize a normalized fitness score based on RosettaLigand, but can be used with any RosettaScript. Within 24 hours it can bring you from knowing nothing about potential ligands to a list of promising compounds. All you need is an input structure as a target, the combinatorial library definition and some idea about where the binding site is.

REvoLd is typically run multiple times with independent starts to sample the chemical space better. Each run finds different low-energy binders. A single run samples between 1,000 and 4,000 ligands. Depending on your available hardware and time, I suggest 10 to 20 runs.

We highly recommend running REvoLd only with MPI support through mpirun/mpiexec/srun/... after compiling it with extras=mpi. 

# Reference

[[Preprint paper|https://arxiv.org/abs/2404.17329]]

# Input

REvoLd requires a single protein structure as target. Additionally, you need the definition of the combinatorial space to sample from. This requires two files, one defining reactions and one defining reagents (or fragments and rules how to link them). They can be obtained under a NDA from vendors like Enamine or from any other source including self made. The definition consists of two white-space separated files with header lines including the following fields:

1. reactions: reaction_id (a name or number to identify the reaction), components (number of fragments participating in the reaction), Reaction (smarts string defining the reaction or fragment coupling)

2. reagents: SMILES (defining the reagent), synton_id (unique identifier for the reagent), synton# (specifiyng the position when applying the SMARTS reaction, [1,...,components]), reaction_id (matching identifier to link the reagent to a reaction)

Lastly, REvoLd requires a RosettaScript which will be applied multiple times to each protein-ligand complex for docking and scoring.

# Command Line Options

### Required options

```
-in:file:s                      Protein structure used as target
-parser:protocol                RosettaScript used for refining and scoring protein-ligand complexes
-ligand_evolution:xyz           Centroid position for initial ligand placement
-ligand_evolution:reagent_file  Path to reagents file
-ligand_evolution:reaction_file Path to reactions file
-ligand_evolution:main_scfx     Name of the scoring function specified in the docking protocol which should be used for scoring compounds.
```

### Additional options

```
-ligand_evolution:options                Path to the options file, allows changing the evolutionary optimization, detailed below
-ligand_evolution:external_scoring       Triggers vHTS mode, detailed below
-ligand_evolution:smiles_file            Triggers vHTS mode, detailed below
-ligand_evolution:n_scoring_runs         How often should the scoring protocol be applied to each complex. Defaults to 150.
-ligand_evolution:ligand_chain           Name of the ligand chain used in the docking protocol. Defaults to X.
-ligand_evolution:pose_output_directory  Directory to which all calculated poses will be written. Defaults to the run directory.
-ligand_evolution:score_mem_path         Path to a former results file to load as score memory. Needs to be in REvoLd output format. REvoLd will check if a ligand is present in the memory file and use its score instead of docking it.
-ligand_evolution:main_term              Name of the main term used as fitness function. Defaults to lid_root2. Terms are detailed below.
-ligand_evolution:n_generations          For how many generations should REvoLd optimize. Defaults to 30.
```

# Example

```
mpirun -np 20 bin/revold.mpi.linuxgccrelease        \
       -in:auto_setup_metals                        \
       -in:file:s 5ZBQ_0001_A.pdb                   \
       -parser:protocol docking_perturb.xml         \
       -ligand_evolution:xyz -46.972 -19.708 70.869 \
       -main_scfx hard_rep                          \
       -reagent_file reagents_short.txt             \
       -reaction_file reactions_short.txt           \
```

# Results

# Algorithm Description

Different scores

# vHTS Option

# Evolutionary Script

# See Also

RosettaLigand