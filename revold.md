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
mpirun -np 20 bin/revold.mpi.linuxgccrelease               \
       -in:auto_setup_metals                               \
       -in:file:s 5ZBQ_0001_A.pdb                          \
       -parser:protocol docking_perturb.xml                \
       -ligand_evolution:xyz -46.972 -19.708 70.869        \
       -ligand_evolution:main_scfx hard_rep                \
       -ligand_evolution:reagent_file reagents_short.txt   \
       -ligand_evolution:reaction_file reactions_short.txt \
```

# Results

After running REvoLd you will find several files in your run directory:

1. 1,000-4,000 pdb files with a numerical code as file names. These are the best scoring complexes calculated through your defined docking script for each ligand considered during optimization.
2. **ligands.tsv** - _This is the main result of REvoLd_. It contains all information about every ligand docked during optimization sorted by the main score term (default lid_root2). The numerical id corresponds to the pdb file name
3. population.tsv - This file can be ignored in most cases. It contains population information if someone tries to analyze the dynamics of the evolutionary optimization, but it is not straight forward to read as it is intended for dev purposes only. It is seperated into three blocks, each with their own header. First a map to turn the numerical ids of ligands (same as pdb) into ids of individuals. Second, edge information for the family tree and third a list of all populations existing during the optimization.

# Algorithm Description

Details can be found in the publication. In short, REvoLd starts with a population of ligands (default 200) randomly sampled from the combinatorial input space. Each ligand is added to a copy of the target pose and placed at the specified xyz position. The docking protocol is applied n times (default 150). Each apply is followed by scoring the protein-ligand pose with the specified main scoring function. The resulting scores are used to calculate the REvoLd specific scores, further referred to as fitness scores:

1. total_REU: Rosetta energy of the entire complex
2. ligand_interface_delta: Difference between bound and unbound complex. The unbound complex energy is calculated by moving the ligand 500A away from the protein target and rescoring without additional relaxation.
3. ligand_interface_delta_EFFICIENCY: The ligand interface delta (lid) scores divided by the number of non-hydrogen atoms in the ligand
4. lid_root2: Same as efficiency, but the square-root of number of non-hydrogen atoms is used
5. lid_root3: Same as lid_root2, but cube-root instead square-root

The specified main term (default lid_root2) is used to select the fittest docking result for each ligand and the corresponding pose is written to file. It's score is also used as fitness for the ligand. After scoring each ligand, the population needs to be shrunk to simulate selective pressure (default to a size of 50 ligand). This is done through a selector (default tournament selection). Finally, the evolutionary optimization cycle starts and is repeated until the maximum number of generations is reached (default 30). After each generation all ligand information is saved.

Each generation starts with selecting individuals from the current population to produce offspring. This can be flexibly modified through combinations of selectors and offspring factories. The resulting offspring can be the same as their parents to preserve well fit ligands for future generations, mutations switching only a single fragment or crossover between two parents combining fragments from both.

# vHTS Option

# Evolutionary Script

# See Also

RosettaLigand