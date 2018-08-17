#Coupled Moves documentation is coming soon! Check back Friday, Aug 17, 2018.

#This is just a draft! Don't read it. Check back Friday, Aug 17, 2018.

Last Doc Update: Aug 17, 2018

[[_TOC_]]

-------------------------
# [1] MetaData

Authors: 
Amanda Loshbaugh (aloshbau@gmail.com); Anum Azam Glasgow (anumazam@gmail.com); Noah Ollikainen (nollikai@gmail.com), PI: Tanja Kortemme

Noah Ollikainen, René M. de Jong, Tanja Kortemme. [Coupling Protein Side-Chain and Backbone Flexibility Improves the Re-design of Protein-Ligand Specificity, PLOS Computational Biology, 9/23/2015](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004335)

--------------------------

# [2] Overview

**Coupled Moves** is a flexible backbone design method meant to be used for designing small-molecule binding sites, protein-protein interfaces, and protein-peptide binding sites. It handles ligands and waters. It was originally developed for designing enzyme active sites. CoupledMoves is one of the primary flexible backbone design methods employed by Cyrus.

# [3] Algorithm

To understand the coupled algorithm, let's first look at a non-coupled flexible backbone Rosetta design protocol. Two examples are (1) FastDesign (relax respecting a resfile) and (2) generating a Backrub Ensemble then performing Fixed Backbone Design on members of the ensemble. 

Non-coupled protocols have the following framework:

1. Backbone move
2. Monte Carlo accept/reject
3. Sidechain move
4. Monte Carlo accept/reject

Resulting in a limitation where a backbone move might create a sidechain clash that is rejected in the first Monte Carlo step, even though it could have been rescued by the subsequent sidechain move. The coupled algorithm allows this to occur, enabling sampling of previously inaccessible sequence and backbone torsional space.

**Coupled Moves Algorithm**

**1. Backbone move**
**2. Sidechain move**
**3. Monte Carlo accept/reject**
**4. Return to step 1**

# [4] Setup and Inputs

## [4.1] Input files
* Input PDB
* Resfile -- CoupledMoves is a design method
* Params file, one for each ligand (optional) (see [Advanced Ligand Usage](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-ligand-usage))
* Constraints file (optional) ([documentation](https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/constraint-file))

## [4.2] Input pdb preparation

* If your protein is not a simple monomer, put each protein in a separate chain. For example, if you have a homodimer, put each monomer in its own chain.
* Use a pdb renumber script to renumber the pdb starting from 1 (important for later analysis)
* See [Advanced Ligand Usage](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-ligand-usage) for how to prepare a pdb containing ligands.
* Pre-relax? Maybe.

## [4.3] Resfile preparation

This section assumes familiarity with the resfile [documentation](https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/resfiles) and [manual](https://www.rosettacommons.org/manuals/archive/rosetta3.4_user_guide/d1/d97/resfiles.html). 

To achieve adequate sampling in a limited number of trials, set all residues to NATRO except a defined target set of designable residues, e.g. a ligand binding pocket's first shell residues, motif residues, or individual secondary structure elements. Consider setting second-shell residues to NATAA to allow rotamer sampling.

Example resfile:

```
NATRO
START
8 - 10 A ALLAA
87 - 90 A ALLAA
216 A ALLAA
277 - 279 B ALLAA
356 - 359 B ALLAA
9 A NATAA
11 A NATAA
```

-------------------------

# [5] Basic Usage

## [5.1] Basic command-line

Coupled Moves has some powerful options, which are explained in the advanced sections. These basic examples rely on many defaults.

### [5.1.1] Command-line: Protein only

```
coupled_moves.default.linuxgccrelease
-s my.pdb
-resfile my.resfile
-ex1 -ex2 -extrachi_cutoff 0
-mute protocols.backrub.BackrubMover
-nstruct 60
```

### [5.1.2] Command-line: Protein with one ligand

The following lines enable ligand mode:

```
-s my.pdb # protein and ligand(s). 
   # NOTE: Ligand(s) must be last residues listed in pdb.
-extra_res_fa my_ligand.params # params file for ligand in my.pdb
-coupled_moves::ligand_mode true
```

* Should I default users to FKIC?

----------------

## [5.2] Basic XML

### [5.2.1] XML: Protein only

### [5.2.2] XML: Protein with one ligand

----------------

# [6] Advanced Backbone Usage

This section assumed familiarity with [backrub](https://www.rosettacommons.org/docs/latest/application_documentation/structure_prediction/backrub) and [kinematic closure](https://www.rosettacommons.org/demos/latest/tutorials/GeneralizedKIC/generalized_kinematic_closure_1).

## [6.1] Changing the backbone mover

CoupledMoves can move the backbone with:
* Backrub
    ```
    -coupled_moves::backbone_mover backrub
    ```

* Kinematic closure (KIC)
    ```
    -coupled_moves::backbone_mover kic
    ```

* Which mover is suggested?

### [6.1.1] Coupled Moves with ShortBackrubMover

CoupledMoves defaults to ShortBackrubMover. You can explicitly specify this default:
    ```
    -coupled_moves::backbone_mover backrub
    ```

Backrub segment length is hardcoded in ShortBackrubMover as 3-residue (or 4-residue if it hits a Proline).

### [6.1.2] Coupled Moves with KIC

If you are not familiar with KIC, please refer to the [documentation](https://www.rosettacommons.org/demos/latest/tutorials/GeneralizedKIC/generalized_kinematic_closure_1). During KIC's perturbation step, various algorithms can be used to perturb torsion angles. CoupledMoves currently (August 2018) supports two perturbers, Fragment and Walking.

#### [6.1.2.1] Fragment KIC

Fragment perturber substitutes fragments with identical sequences, resulting in updated torsion angles unrelated to the starting torsions. Fragment file generation is explained [here](https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/fragment-file).
    ```
    -coupled_moves::backbone_mover kic
    -coupled_moves::kic_perturber fragment
    -loops:frag_sizes 9 3
    -loops:frag_files my_pdb.200.3mers.gz, my_pdb.200.3mers.gz
    ```

#### [6.1.2.2] Walking KIC

Walking perturber "walks" along torsion angle space. Angles are modified by values from a distribution around a user-specified magnitude.
    ```
    -coupled_moves::backbone_mover kic
    -coupled_moves::kic_perturber walking # default='walking'
    -coupled_moves::walking_perturber_magnitude 2.0 # units of degrees; default=2.0
    ```

## [6.2] Controlling KIC loop size

This setting is a bit complicated. The default should be fine for the vast majority of applications.

* `-coupled_moves::kic_loop_size` only applies when using `-coupled_moves::backbone_mover=kic`.
* The parameter set by `-coupled_moves::kic_loop_size` (hereafter *n*) is used to calculate the final *loop size* in residues.
* "Loop" here doesn't refer to secondary structure, just to a segment of residues.
* NOTE: *n* must be at least 3 for 3mers in fragment KIC. Shorter loops will not allow fragment substitution.

You may set a constant or random loop size:

* **Constant loop size** - If you set *n* to a positive whole number, *loop_size* = 1+2\**n*. In terms of residues, the loop is defined by first selecting resnum (the designable residue), then defining loopstart=resnum-*n* and loopend=resnum+*n*. 

* **Random loop size** - If you set *n*=0, in each trial, *n* will be a random integer in range( 3, 7 ).

```
-coupled_moves::kic_loop_size <n> # default n=4
```

## [6.3] Backbone mover command-line options

Option | Type | Default | Description
------------ | ------------- | ------------- | -------------
backbone_mover | String | backrub | Which backbone mover to use. Current options are backrub (default) or kic. Backrub does not require additional flags, and uses ShortBackrubMover which is hardcoded for 3-residue segments (or 4-residue if it hits a Proline). Kic optionally takes extra flag -kic_perturber.' legal = [ 'backrub', 'kic' ]
kic_perturber | String | walking | Which perturber to use during kinematic closure (KIC). Current options are walking (default) or fragment. Walking perturber adjusts torsions by degrees, the magnitude of which can be set by -walking_perturber_magnitude. If you specify walking you MAY also specify -walking_perturber_magnitude. If you specify fragment you MUST also specify -loops::frag_files and -loops::frag_sizes. legal = [ 'walking', 'fragment' ]
walking_perturber_magnitude | Real | 2.0 | Degree parameter for coupled moves kic walking perturber
kic_loop_size | Real | 4 | Can be constant or random. CONSTANT - If you set loop_size to a positive whole number, the loop moved by coupled_moves::backbone_mover will be 1+2*loop_size. In other words, the loop is defined by first selecting resnum, then defining loopstart=resnum-loop_size and loopend=resnum+loop_size. RANDOM - If you set loop_size to 0, in each trial, loop_size will be random_range( 3, 7 ). [ NOTE: This option is for coupled_moves::backbone_mover=kic only. Backrub segment length is hardcoded in ShortBackrubMover as 3-residue (or 4-residue if it hits a Proline)

-------------------------------------

# [7] Advanced Ligand Usage

Coupled Moves was originally developed to design enzyme active sites, and has been extensively benchmarked on small-molecule binding site datasets. It is good for general design, but is especially highly recommended for designing small molecule binding sites.

### [7.1] Ligand command-line options

(See [Section 1.1.2](https://www.rosettacommons.org/docs/wiki/coupled-moves#1-basic-usage_1-1-basic-command-line_1-1-2-command-line-protein-with-one-ligand) for basic ligand command-line.)

Option | Type | Default | Description | Expert usage recommendations
------------ | ------------- | ------------- | ------------- | -------------
number_ligands | Integer | 1 | number of ligands in the pose |
ligand_mode | Boolean | false | if true, model protein-ligand interaction | If set to 'true' and no ligand present, results in error. If set to 'false' and ligand present, protein-ligand interactions will not be considered.
ligand_weight | Real | 1.0 | weight for protein-ligand interactions | Recommend somewhere around 1.0 or 2.0 depending on dataset.

-------------------------------------

### [7.2] Ligand Preparation

* **NOTE: The ligand chains must be the last chains in the PDB, or CoupledMoves can't find them.**
* Place each ligand in its own chain at the end of the pdb (we recommend starting with chain X for the first ligand). 

* Preparation:
  1. Cut/paste relevant ligand HETATM lines from source PDB into new PDB.
  2. Add hydrogens using Babel
       `babel -h IPTG.pdb IPTG_withH.sdf`
  3. Ppen resulting file in Avogadro/PyMOL, and save as a .mol2 file.
  4. To get the .params files from the .mol2 files for each ligand, run the molfile_to_params.py script
      ```
      python ~/Rosetta/main/source/scripts/python/public/molfile_to_params.py -n name input_file.mol2
      ```
     OR
     if using -gen_bonded score term:
     ```
     python ~/Rosetta/main/source/scripts/python/public/mol2genparams.py -n name input_file.mol2
     ```
  5. The params script should generate a pdb file. Open this, rename the chain, and put it back in the original PDB file with the protein.
  6. Make sure ligand placement is correct by aligning with original in PyMOL.



### [7.3] Command-line example: Advanced ligand usage

```
coupled_moves.default.linuxgccrelease
-s my.pdb # protein and ligand(s). 
   # NOTE: Ligand(s) must be last residues listed in pdb.
-resfile my.resfile
-ex1 -ex2 -extrachi_cutoff 0
-coupled_moves::ligand_mode true
-coupled_moves::number_ligands 2
-extra_res_fa my_ligand.params # params file for ligand on chain X in my.pdb
-extra_res_fa my_ligand.params # params file for ligand on chain Y in my.pdb
-coupled_moves::ligand_weight 2.0 # upweight ligand-protein interactions
```

### [7.4] Explicit Waters

**Preparing explicit waters**
* Place water molecules in a separate chain, chain W. Use TP3/WAT residue types and crystallographic positions of oxygens. 
* Add the hydrogens by scoring: `~/Rosetta/main/source/bin/score.linuxgccrelease -database ~/Rosetta/main/database/ -s pdb_file -ignore_unrecognized_res -out:output`
* Waters do not need a params file because WAT/TP3 are already in the Rosetta database.

----------------

# [8] Linked residues for designing symmetric complexes

IN THE NEAR FUTURE, Coupled Moves will support linked residues. Code is finished, we are currently testing it before publishing it. These come in handy during design of asymmetric homodimers, where the sequence is identical but the structures may vary slightly. Using linked residues, when the sequence of a position changes, the sequence is also changed on the other members in the symmetric unit.

----------------

# [9] Analysis

During its design trajectory, Coupled Moves samples a variety of sequences. Each unique sequence will be saved and printed to a fasta file, my_pdb.fasta. When your jobs are complete, combine the fasta files for all nstruct. Because analysis is based on unique sequences sampled rather than final pdb, nstruct can be quite low (20-60). 

**NOTE:** Only designed positions will be included in the fasta file. Your resfile ALLAA positions define the designed positions printed in the fasta file. Do not lose your resfile.

For each position of interest, base your design decision on the frequency distribution of amino acids observed on your combined fasta files.

----------------

# [10] Command-line Options

## [10.1] Command-line Options you might want to change

**General options**

Option | Type | Default | Description | Recommendation
------------ | ------------- | ------------- | ------------- | -------------
ntrials | Integer | 1000 | number of Monte Carlo trials to run | Extensive benchmarking shows that more trials is not better. **Check results, try less than 1000**. 
initial_repack | Boolean | true | start simulation with repack and design step | Initial repack may result in lower diversity
min_pack | Boolean | false | use min_pack for initial repack and design step |
output_prefix | String | default | prefix for output files | 

**Backbone options**

Option | Type | Default | Description
------------ | ------------- | ------------- | ------------- | -------------
backbone_mover | String | backrub | See [6-3-backbone-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#6-advanced-backbone-usage_6-3-backbone-command-line-options)
kic_perturber | String | walking | See [6-3-backbone-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#6-advanced-backbone-usage_6-3-backbone-command-line-options)
kic_loop_size | Real | 4 | See [6-3-backbone-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#6-advanced-backbone-usage_6-3-backbone-command-line-options)
walking_perturber_magnitude | Real | 2.0 | See [6-3-backbone-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#6-advanced-backbone-usage_6-3-backbone-command-line-options)
fix_backbone | Boolean | false | Set to 'true' to prevent backbone moves. For debugging
uniform_backrub | Boolean | false | select backrub rotation angle from uniform distribution. Recommend default

**Ligand options**

Option | Type | Default | Description
------------ | ------------- | ------------- | ------------- | -------------
number_ligands | Integer | 1 | See [7-1-ligand-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-ligand-usage_7-1-ligand-command-line-options)
ligand_mode | Boolean | false | See [7-1-ligand-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-ligand-usage_7-1-ligand-command-line-options)
ligand_weight | Real | 1.0 | See [7-1-ligand-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-ligand-usage_7-1-ligand-command-line-options)
ligand_prob | Real | 0.1 | probability of making a ligand move. Recommend default

## [10.2] Command-line options you probably don't want to touch

**Algorithm options**

Option | Type | Default | Description
------------ | ------------- | ------------- | -------------
mc_kt | Real | 0.6 | value of kT for Monte Carlo when accepting/rejecting coupled side-chain and backbone moves
boltzmann_kt | Real | 0.6 | value of kT for Boltzmann weighted moves during side-chain design step
mm_bend_weight | Real | 1.0 | weight of mm_bend bond angle energy term
bias_sampling | Boolean | true | if true, bias rotamer selection based on energy
bump_check | Boolean | true | if true, use bump check in generating rotamers 
repack_neighborhood | Boolean | false | After the backbone move and rotamer move, repack sidechains within 5A of the design residue. Default false for legacy behavior. Does not seem to make an impact on benchmark results, but adds significant time.
legacy_task | Boolean | true | Default true for legacy behavior (Ollikainen 2015). True = use Clash Based Shell Selector to define repack residues around design residues from resfile, and perform Coupled Moves on these repack/design residues. False = Perform Coupled Moves on design/repack residues as defined in resfile.

**Output files options**

Option | Type | Default | Description | Expert usage recommendations
------------ | ------------- | ------------- | ------------- | -------------
trajectory | Boolean | false | record a trajectory | Prints pdbs during design trajectory. Useful for viewing trajectory but takes a lot of space, use wisely.
trajectory_gz | Boolean | false | gzip the trajectory |
trajectory_stride | Integer | 100 | write out a trajectory frame every N trials |
trajectory_file | String | 'traj.pdb' | name of trajectory file |
output_fasta | String | sequences.fasta | name of FASTA output file | Sequences for analysis
output_stats | String | sequences.stats | name of stats output file |
save_sequences | Boolean | true | save all unique sequences  |  Sequences for analysis
save_structures | Boolean | false | save structures for all unique sequences | 

-------------------------------------

---------------------------------

# [11] Benchmarking

to be added

---------------------------------

# [12] See Also

* [[I want to do x]]: Guide to choosing a mover