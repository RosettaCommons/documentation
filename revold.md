# RosettaEvolutionaryLigand (REvoLd)

# Purpose

RosettaEvolutionaryLigand (REvoLd) is an evolutionary algorithm to efficiently sample small molecules from fragment-based combinatorial make-on-demand libraries like Enamine REAL. It has been designed to optimize a normalized fitness score based on RosettaLigand, but can be used with any RosettaScript. Within 24 hours it can bring you from knowing nothing about potential ligands to a list of promising compounds. All you need is an input structure as a target, the combinatorial library definition and some idea about where the binding site is.

REvoLd is typically run multiple times with independent starts to sample the chemical space better. Each run finds different low-energy binders. A single run samples between 1,000 and 4,000 ligands. Depending on your available hardware and time, I suggest 10 to 20 runs.

# Reference

Eisenhuth, Paul, et al. "REvoLd: Ultra-Large Library Screening with an Evolutionary Algorithm in Rosetta." arXiv preprint arXiv:2404.17329 (2024). [[Preprint paper|https://arxiv.org/abs/2404.17329]]

# Installation

We highly recommend running REvoLd only with MPI support through mpirun/mpiexec/srun/etc. Depending on the size of your combinatorial library you might need 200-300GB RAM. We recommend using 50-60 CPUs per run.

### Compile

Make sure you cloned the latest Rosetta version and have a MPI compiler available (for example mpiCC).

```
# navigate into your local Rosetta clone
cd Path/to/rosetta/source
# overwrite compile settings
cp tools/build/site.settings.release tools/build/site.settings
# start compile
./scons.py -j <num of processors> revold mode=release extras=mpi
```

#### Troubleshooting

It might happen that you run into issues of mpi versions or that SCons is giving you an error “mpiCC not found”. In such cases, uncomment two lines in tools/build/site.settings under the "override" portion and change the path to your correct version of mpi:

```
"cxx" : "/path/to/mpicxx",
"cc"  : "/path/to/mpicc",
```

Additionally, make sure SCons tries to use the correct mpi compiler available on your machine. If you have mpicc available, but SCons tries to use mpiCC, it will crash. In that case, open tools/build/basics.settings and change all occurrences of mpiCC to mpicc.

# Input

REvoLd requires a single protein structure as target. Remember to [[prepare|rosetta_basics/preparation/preparing-structures]] it. Additionally, you need the definition of the combinatorial space to sample from. This requires two files, one defining reactions and one defining reagents (or fragments and rules how to link them). They can be obtained under a NDA from vendors like Enamine or from any other source including self made. The definition consists of two white-space separated files with header lines including the following fields:

1. reactions: reaction_id (a name or number to identify the reaction), components (number of fragments participating in the reaction), Reaction (smarts string defining the reaction or fragment coupling)

2. reagents: SMILES (defining the reagent), synton_id (unique identifier for the reagent), synton# (specifiyng the position when applying the SMARTS reaction, [1,...,components]), reaction_id (matching identifier to link the reagent to a reaction)

Lastly, REvoLd requires a RosettaScript which will be applied multiple times to each protein-ligand complex for docking and scoring. We are using the RosettaLigand script ([[xml file|rosettaligand-cleaned-dock]] [paper](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0132508)). The xml file is slightly changed from the original publication to fix some syntax errors and provide a binding site large enough to fit most small molecules. You might want to change [[box_size in the Tranform tag|scripting_documentation/RosettaScripts/Movers/movers_pages/TransformMover]] and [[width in the ScoringGrid tag|https://docs.rosettacommons.org/docs/wiki/scripting_documentation/RosettaScripts/RosettaScripts#rosettascript-sections_ligands_scoringgrids]] to suite your goals. 

# Command Line Options

You can use any Rosetta options on the command line or as a flags file. Following are the required options for REvoLd and its specific optional settings.

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
-ligand_evolution:options                Path to the REvoLd evolution options file, allows changing the evolutionary optimization, detailed below
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

**Important**: Never start multiple REvoLd runs in the same directory, as they will overwrite each others results.

# Results

After running REvoLd you will find several files in your run directory:

1. 1,000-4,000 pdb files with a numerical code as file names. These are the best scoring complexes calculated through your defined docking script for each ligand considered during optimization.
2. **ligands.tsv** - _This is the main result of REvoLd_. It contains all information about every ligand docked during optimization sorted by the main score term (default lid_root2). The numerical id corresponds to the pdb file name
3. population.tsv - This file can be ignored in most cases. It contains population information if someone tries to analyze the dynamics of the evolutionary optimization, but it is not straight forward to read as it is intended for dev purposes only. It is seperated into three blocks, each with their own header. First a map to turn the numerical ids of ligands (same as pdb) into ids of individuals. Second, edge information for the family tree and third a list of all populations existing during the optimization.

# Algorithm Description

Details can be found in the publication. In short, REvoLd starts with a population of ligands (default 200) randomly sampled from the combinatorial input space. Each ligand is added to a copy of the target pose and placed at the specified xyz position. The docking protocol is applied n_scoring_runs times (default 150). Each apply is followed by scoring the protein-ligand pose with the specified main scoring function. The resulting scores are used to calculate the REvoLd specific scores, further referred to as fitness scores:

1. total_REU: Rosetta energy of the entire complex
2. ligand_interface_delta: Difference between bound and unbound complex. The unbound complex energy is calculated by moving the ligand 500A away from the protein target and rescoring without additional relaxation.
3. ligand_interface_delta_EFFICIENCY: The ligand interface delta (lid) scores divided by the number of non-hydrogen atoms in the ligand
4. lid_root2: Same as efficiency, but the square-root of number of non-hydrogen atoms is used
5. lid_root3: Same as lid_root2, but cube-root instead square-root

The specified main term (default lid_root2) is used to select the fittest docking result for each ligand and the corresponding pose is written to file. It's score is also used as fitness for the ligand. After scoring each ligand, the population needs to be shrunk to simulate selective pressure (default to a size of 50 ligand). This is done through a selector (default tournament selection). Finally, the evolutionary optimization cycle starts and is repeated until the maximum number of generations is reached (default 30). After each generation all ligand information is saved.

Each generation starts with selecting individuals from the current population to produce offspring. This can be flexibly modified through combinations of selectors and offspring factories. The resulting offspring can be the same as their parents to preserve well fit ligands for future generations, mutations switching only a single fragment or crossover between two parents combining fragments from both.

# vHTS Option

REvoLd can also be used score a list of smiles distributed over multiple processors if the aforementioned options external_scoring and smiles_file are set. Each processor from the mpirun call will select its own equally sized chunk of smiles from the smiles_file, turn each smiles into a protein-ligand complex, place it at the specified xyz position and apply the specified RosettaScript n_scoring_runs times. No pdbs will be written during vHTS to reduce the disk space requirements, but each process will create a file called external_results_<procID>.csv. This file will contain as many lines as defined by external_scoring for each ligand corresponding to the n best results from docking. Each line looks like smiles;term1;term2;...;termN

# Evolutionary Script

REvoLd evolutionary optimization cycle is very modular and can be changed. However, this option is usually not important if you want to use REvoLd. The default settings are benchmarked and have shown reliable performance. However, if you want to change it, use -ligand_evolution:options to specify a xml file:

```xml
<Population main_selector="std_tournament" supported_size="50"/>
<PopulationInit init_type="random" size="200"/>
<PopulationInit init_type="best_loaded" size="25" selection="1000"/>

<Scorer similarity_penalty="0.5" similarity_penalty_threshold="0.95"/>

<Selector name="remove_elitist" type="elitist" size="15" remove="True"/>
<Selector name="std_tournament" type="tournament" size="15" remove="False" tournament_size="15" acceptance_chance="0.75"/>
<Selector name="std_roulette" type="roulette" size="15" remove="False" consider_positive="False"/>

<Factory name="std_mutator" type="mutator" size="30" reaction_weight="1.0" reagent_weight="2.0" min_similarity="0.6" max_similarity="0.99"/>
<Factory name="drastic_mutator" type="mutator" size="30" reaction_weight="0.0" reagent_weight="1.0" min_similarity="0.0" max_similarity="0.25"/>
<Factory name="reaction_mutator" type="mutator" size="30" reaction_weight="1.0" reagent_weight="0.0" min_similarity="0.6" max_similarity="0.99"/>
<Factory name="large_crossover" type="crossover" size="60"/>
<Factory name="std_identity" type="identity" size="15"/>

<!--order is important here-->
<EvolutionProtocol selector="std_roulette" factory="std_mutator"/>
<EvolutionProtocol selector="std_roulette" factory="large_crossover"/>
<EvolutionProtocol selector="std_roulette" factory="drastic_mutator"/>
<EvolutionProtocol selector="std_roulette" factory="reaction_mutator"/>
<EvolutionProtocol selector="remove_elitist" factory="std_identity"/>
<EvolutionProtocol selector="std_roulette" factory="std_mutator"/>
<EvolutionProtocol selector="std_roulette" factory="large_crossover"/>
```

The tags are explain in more detail:

* Population
    * Defines how selective pressure is applied when advancing generations
    * main_selector: Name of one of the defined selectors
    * supported_size: Maximum number of individuals to advance to the next generation
* PopulationInit
    * Defines an operator to generate the initial population
    * random: Draws <size> ligands randomly from the combinatorial library
    * best_loaded: Needs a sore_memory to be defined. First, it elects the <selection> best ligands from that list and then randomly samples <size> numbers of ligands from it
* Scorer
    * Defines how similarity between molecules will be penalized to enforce diverse molecules within each population
    * similarity_penalty: Flat penalty which will be added to the calculated fitness for each molecule with higher fitness surpassing the similarity_penalty_threshold (RDKit Fingerprint Tanimoto Similarity)
* Selector
    * Selects <size> individuals from a population to pass them into an offspring factory. If <remove> is true, the selected individuals are removed from the current population and can not produce offspring again.
    * elitist: Simply selects the best ligands
    * roulette: Each ligand has a chance proportional to its relative fitness, e.g. a ligand with lid_root2 of -4.0 is twice as likely to be selected than one with -2.0. <consider_positive> triggers a linear transformation of all scores into a negative range, but this can have undesired impact and should not be used.
    * tournament: Considers only the ranking of ligands instead of their relative score difference. <size> consecutive tournaments are played and each winner gets passed to the offspring factory. For a tournament <tournament_size> random ligands are selected to participate. Next, they are ordered by fitness and the first ligand gets offered to win. It has an acceptance chance of <acceptance_chance>. If the win is accepted, the tournament is over and the next starts with the last winner banned from participating. If the win is declined, it is offered to the second ligand, then to the third and so on.
* Factory
    * Receives a set of parent ligand which will be used to generate <size> new molecules without altering the parents
    * identity: Simply copies the parent ligand. This in combination with the elitist selector for example allows the best molecules to persist through generations.
    * mutator: Takes one parent and either changes the reaction or one of the fragments. <reaction_weight> and <reagent_weight> specify how likely which operation is. If the reaction is changed, the most similar reagents to the parent are searched in the new reaction. If a fragment is changed, all suitable replacements are considered as long as they are below <max_similarity> and above <min_similarity> to the parent
    * crossover: Combines fragment from two randomly paired parents to produce a new ligand
* EvolutionProtocol:
    * Each tag defines in order which selector will be applied to the current population and to which factory they will be passed. All offspring will be stored in a temporary population and replace the current population as soon as all protocol steps have finished.

There are extensive checks included when you parse a new evolutionary protocol including informative error outputs. We suggest to simply play around with this system if you are interested in writing your own protocol.

# See Also

* [[Structure prep|rosetta_basics/preparation/preparing-structures]]
* [[RosettaLigand|application_documentation/docking/ligand-dock]]
* [[Transform Mover|scripting_documentation/RosettaScripts/Movers/movers_pages/TransformMover]]
* [[HighRes Mover|scripting_documentation/RosettaScripts/Movers/movers_pages/HighResDockerMover]]
* [[Final Minimizer|scripting_documentation/RosettaScripts/Movers/movers_pages/FinalMinimizerMover]]
* [[InterfaceScoreCalculator|scripting_documentation/RosettaScripts/Movers/movers_pages/InterfaceScoreCalculatorMover]]