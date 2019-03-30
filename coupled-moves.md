#CoupledMoves

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

1. **Backbone move**
2. **Sidechain move**
3. **Monte Carlo accept/reject**
4. **Return to step 1**

The backbone move default is ShortBackrubMover, but can also be kinematic closure with fragments (see [\[7\] Advanced Backbone Usage](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-backbone-usage)).

The sidechain move is performed by BoltzmannRotamerMover:

**BoltzmannRotamerMover**

1. calculate boltzmann weighted probability for each rotamer
2. use probabilities to select one rotamer for each amino acid
3. calculate boltzmann weighted probabilities for each amino acid
4. use probabilities to select an amino acid
5. replace resnum_ with the selected rotamer / amino acid

----------------

# [4] Analysis (v. important to read)

During its design trajectory, Coupled Moves samples a variety of sequences. Each unique sequence will be saved and printed to a fasta file, my_pdb.fasta. When your jobs are complete, combine the fasta files for all nstruct. Because analysis is based on unique sequences sampled rather than final pdb, nstruct can be quite low. We recommend nstruct of 100-400, depending on the number of positions in the designable regions. 

Only designed positions will be included in the fasta file. Your resfile designable positions (ALLAA, PIKAA, NOTAA...) define the designed positions printed in the fasta file. Do not lose your resfile.

**For each position of interest, base your design decision on the frequency distribution of amino acid side chains observed on your combined fasta files, and the energetics of the more frequent amino acid side chains.**

For each position, look at all side chains modeled by CoupledMoves. Calculate the frequency of each side chain. And calculate the rank of the total_energy term compared to the other modeled side chains. **Choose side chains that are modeled with >33% frequency *and* in the 75th or above total energy percentile.**

----------------

# [5] Setup and Inputs

## [5.1] Input files
* Input PDB
* Resfile -- CoupledMoves is a design method
* Params file, one for each ligand (optional) (see [\[8\]Advanced Ligand Usage](https://www.rosettacommons.org/docs/wiki/coupled-moves#8-advanced-ligand-usage))
* Constraints file (optional) ([documentation](https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/constraint-file))

## [5.2] Input pdb preparation

* If your protein is not a simple monomer, put each protein in a separate chain.
* We strongly suggest renumbering the pdb starting from 1
* See [\[8\] Advanced Ligand Usage](https://www.rosettacommons.org/docs/wiki/coupled-moves#8-advanced-ligand-usage) for how to prepare a pdb containing ligands.
* Pre-relax? Maybe.

## [5.3] Resfile preparation

This section assumes familiarity with the resfile [documentation](https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/resfiles) and [manual](https://www.rosettacommons.org/manuals/archive/rosetta3.4_user_guide/d1/d97/resfiles.html). 

Manually define packable residues: To achieve adequate sampling in a limited number of trials, set all residues to NATRO except target designable residues, e.g. a ligand binding pocket's first shell residues, motif residues, or individual secondary structure elements. Consider setting second-shell residues to NATAA to allow rotamer sampling.

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

Automatically detect packable residues:

Use `-exclude_nonclashing_positions` flag to autodetect all positions that clash with designable positions. Start with a NATAA default resfile that defines designable positions. The CoupledMoves protocol will keep as NATAA only positions that clash with designable positions, while all other positions will be switched to NATRO.

Example resfile:

```
NATAA
START
216 A ALLAA
```

-------------------------

# [6] Basic Usage

## [6.1] Basic command-line

Coupled Moves has some powerful options, which are explained in the advanced sections. These basic examples rely on many defaults.

### [6.1.1] Command-line: Protein only

```
coupled_moves.default.linuxgccrelease
-s my.pdb
-resfile my.resfile
-ex1 -ex2 -extrachi_cutoff 0
-mute protocols.backrub.BackrubMover
-nstruct 60
```

### [6.1.2] Command-line: Protein with one ligand

The following lines enable ligand mode:

```
-s my.pdb # protein and ligand(s). 
   # NOTE: Ligand(s) must be last residues listed in pdb.
-extra_res_fa my_ligand.params # params file for ligand in my.pdb
-coupled_moves::ligand_mode true
```

* Benchmarks show that Fragment KIC performs as well and sometimes better than the default mover Backrub. We encourage users to read [\[7\] Advanced Backbone Usage](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-backbone-usage) below and explore using Fragment KIC CoupledMoves.

----------------

## [6.2] Basic XML: Protein with ligand

```
<ROSETTASCRIPTS>
    <SCOREFXNS>
        <ScoreFunction name="ref15" />
    </SCOREFXNS>
    <RESIDUE_SELECTORS>
        <Chain name="chainC" chains="C"/>
        <Chain name="chainD" chains="D"/>
        <Neighborhood name="CD_neighbors" distance="10.0">
            <Chain chains="C,D"/>
        </Neighborhood>
        <Or name="all_selectors" selectors="chainC,chainD,CD_neighbors"/>
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>
        <ReadResfile name="resfile" filename="firstshell_xc.res"/>
        <RestrictToRepacking name="restrict_to_repack"/>
    </TASKOPERATIONS>
    <MOVERS>
        <ConstraintSetMover name="cst" add_constraints="true" cst_file="constraints.cst"/>
        <CoupledMovesProtocol name="coupled_moves" task_operations="resfile"/>
        <WriteFiltersToPose name="writer" prefix="BuriedUnsats_"/>
    </MOVERS>
    <FILTERS>
        <BuriedUnsatHbonds
            name="buriedunsats_bb"
            report_bb_heavy_atom_unsats="true"
            residue_selector="all_selectors"
            scorefxn="ref15"
            cutoff="4"
            residue_surface_cutoff="20.0"
            ignore_surface_res="true"
            print_out_info_to_pdb="true"/>
        <BuriedUnsatHbonds 
            name="buriedunsats_sc"
            report_sc_heavy_atom_unsats="true"
            residue_selector="all_selectors"
            scorefxn="ref15"
            cutoff="0"
            residue_surface_cutoff="20.0"
            ignore_surface_res="true"
            print_out_info_to_pdb="true"/>
        <LigInterfaceEnergy
            name="liginterface" scorefxn="ref15"/>
        <MoveBeforeFilter
            name="movebefore_bb"
            mover_name="coupled_moves"
            filter_name="buriedunsats_bb"/>
        <MoveBeforeFilter
            name="movebefore_sc"
            mover_name="coupled_moves"
            filter_name="buriedunsats_sc"/>
        <MoveBeforeFilter
            name="movebefore_liginterface"
            mover_name="coupled_moves"
            filter_name="liginterface"/>

    </FILTERS>
    <PROTOCOLS>
        <Add mover_name="cst"/>
        <Add mover_name="writer"/>
        <Add mover_name="coupled_moves"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

----------------

# [7] Advanced Backbone Usage

This section assumed familiarity with [backrub](https://www.rosettacommons.org/docs/latest/application_documentation/structure_prediction/backrub) and [kinematic closure](https://www.rosettacommons.org/demos/latest/tutorials/GeneralizedKIC/generalized_kinematic_closure_1).

## [7.1] Changing the backbone mover

CoupledMoves can move the backbone with:
* Backrub
    ```
    -coupled_moves::backbone_mover backrub
    ```

* Kinematic closure (KIC)
    ```
    -coupled_moves::backbone_mover kic
    ```

### [7.1.1] Coupled Moves with ShortBackrubMover

CoupledMoves defaults to ShortBackrubMover. You can explicitly specify this default:
    ```
    -coupled_moves::backbone_mover backrub
    ```

Backrub segment length is hardcoded in ShortBackrubMover as 3-residue (or 4-residue if it hits a Proline).

### [7.1.2] Coupled Moves with KIC

If you are not familiar with KIC, please refer to the [documentation](https://www.rosettacommons.org/demos/latest/tutorials/GeneralizedKIC/generalized_kinematic_closure_1). During KIC's perturbation step, various algorithms can be used to perturb torsion angles. CoupledMoves currently (August 2018) supports two perturbers, Fragment and Walking.

#### [7.1.2.1] Fragment KIC

Fragment perturber substitutes fragments with identical sequences, resulting in updated torsion angles unrelated to the starting torsions. Fragment file generation is explained [here](https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/fragment-file).
    ```
    -coupled_moves::backbone_mover kic
    -coupled_moves::kic_perturber fragment
    -loops:frag_sizes 9 3
    -loops:frag_files my_pdb.200.3mers.gz, my_pdb.200.3mers.gz
    ```

#### [7.1.2.2] Walking KIC

Walking perturber "walks" along torsion angle space. Angles are modified by values from a distribution around a user-specified magnitude.
    ```
    -coupled_moves::backbone_mover kic
    -coupled_moves::kic_perturber walking # default='walking'
    -coupled_moves::walking_perturber_magnitude 2.0 # units of degrees; default=2.0
    ```

## [7.2] Controlling KIC loop size

* `-coupled_moves::kic_loop_size` only applies when using `-coupled_moves::backbone_mover kic`.
* KIC will try to change the torsion angles of a segment this many residues long. The rotamer of the middle residue will be designed, thus kic_loop_size must be an odd number so a middle residue exists. 
* "Loop" here doesn't refer to secondary structure, just to a segment of residues.
* (Backrub segment length is hardcoded in ShortBackrubMover as 3-residue, or 4-residue if it hits a Proline).

```
-coupled_moves::kic_loop_size <n> # default n=9
```

## [7.3] Backbone mover command-line options

Option | Type | Default | Description
------------ | ------------- | ------------- | -------------
backbone_mover | String | backrub | Which backbone mover to use. Current options are backrub (default) or kic. Backrub does not require additional flags, and uses ShortBackrubMover which is hardcoded for 3-residue segments (or 4-residue if it hits a Proline). Kic optionally takes extra flag -kic_perturber.' legal = [ 'backrub', 'kic' ]
kic_perturber | String | walking | Which perturber to use during kinematic closure (KIC). Current options are walking (default) or fragment. Walking perturber adjusts torsions by degrees, the magnitude of which can be set by -walking_perturber_magnitude. If you specify walking you MAY also specify -walking_perturber_magnitude. If you specify fragment you MUST also specify -loops::frag_files and -loops::frag_sizes. legal = [ 'walking', 'fragment' ]
walking_perturber_magnitude | Real | 2.0 | Degree parameter for coupled moves kic walking perturber
kic_loop_size | Real | 4 | Can be constant or random. CONSTANT - If you set loop_size to a positive whole number, the loop moved by coupled_moves::backbone_mover will be 1+2*loop_size. In other words, the loop is defined by first selecting resnum, then defining loopstart=resnum-loop_size and loopend=resnum+loop_size. RANDOM - If you set loop_size to 0, in each trial, loop_size will be random_range( 3, 7 ). [ NOTE: This option is for coupled_moves::backbone_mover=kic only. Backrub segment length is hardcoded in ShortBackrubMover as 3-residue (or 4-residue if it hits a Proline)

-------------------------------------

# [8] Advanced Ligand Usage

Coupled Moves was originally developed to design enzyme active sites, and has been extensively benchmarked on small-molecule binding site datasets. It is good for general design, but is especially highly recommended for designing small molecule binding sites.

### [8.1] Ligand command-line options

(See [6.1.2](https://www.rosettacommons.org/docs/wiki/coupled-moves#6-basic-usage_6-1-basic-command-line_6-1-2-command-line-protein-with-one-ligand) for basic ligand command-line.)

Option | Type | Default | Description | Expert usage recommendations
------------ | ------------- | ------------- | ------------- | -------------
number_ligands | Integer | 1 | number of ligands in the pose |
ligand_mode | Boolean | false | if true, model protein-ligand interaction | If set to 'true' and no ligand present, results in error. If set to 'false' and ligand present, protein-ligand interactions will not be considered.
ligand_weight | Real | 1.0 | weight for protein-ligand interactions | Recommend somewhere around 1.0 or 2.0 depending on dataset.

-------------------------------------

### [8.2] Ligand Preparation

* **The ligand chains must be the last chains in the PDB, or CoupledMoves can't find them.**
* Place each ligand in its own chain at the end of the pdb (we recommend the naming convention of chain X for the first ligand). 

* Preparation:
  1. Cut/paste relevant ligand HETATM lines from source PDB into new PDB.
  2. Add hydrogens using Babel
       `babel -h IPTG.pdb IPTG_withH.sdf`
  3. Open resulting file in Avogadro/PyMOL, and save as a .mol2 file.
  4. To get the .params files from the .mol2 files for each ligand, run the molfile_to_params.py script
      ```
      python ~/Rosetta/main/source/scripts/python/public/molfile_to_params.py -n name input_file.mol2
      ```
     OR
     if using -gen_bonded score term:
     ```
     python ~/Rosetta/main/source/scripts/python/public/mol2genparams.py -n name input_file.mol2
     ```
  5. The params script should generate a pdb file. Open this in a text editor, rename the chain, and put it back in the original PDB file with the protein.
  6. Make sure ligand placement is correct by aligning with original in PyMOL.



### [8.3] Command-line example: Advanced ligand usage

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

### [8.4] Explicit Waters

**Preparing explicit waters**
* Place water molecules in a separate chain, chain W. Use TP3/WAT residue types and crystallographic positions of oxygens. 
* Add the hydrogens by scoring: `~/Rosetta/main/source/bin/score.linuxgccrelease -database ~/Rosetta/main/database/ -s pdb_file -ignore_unrecognized_res -out:output`
* Waters do not need a params file because WAT/TP3 are already in the Rosetta database.

----------------

# [9] LinkResidues

IN THE NEAR FUTURE, Coupled Moves will support [LinkResidues](https://www.rosettacommons.org/docs/latest/scripting_documentation/RosettaScripts/TaskOperations/taskoperations_pages/LinkResidues). Code is finished, we are currently testing it before publishing it. 

LinkResidues specifies groups of residues that should be mutated together. For example, if one residue in the group is mutated to Cys, all the residues in that group will be mutated to Cys. This task operation is meant for situations where you want to design a homo-multimer, but you don't want to use symmetry mode (perhaps because your monomers aren't geometrically symmetrical).

## [8.1] Example XML

```
<ROSETTASCRIPTS>
    <SCOREFXNS>
        <ScoreFunction name="ref15" />
    </SCOREFXNS>
    <RESIDUE_SELECTORS>
        <Chain name="chainC" chains="C"/>
        <Chain name="chainD" chains="D"/>
        <Neighborhood name="CD_neighbors" distance="10.0">
            <Chain chains="C,D"/>
        </Neighborhood>
        <Or name="all_selectors" selectors="chainC,chainD,CD_neighbors"/>
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>
        <ReadResfile name="resfile" filename="firstshell_xc.res"/>
        <RestrictToRepacking name="restrict_to_repack"/>
        <LinkResidues name="linkres">
            <LinkGroup group="234,503"/>
            <LinkGroup group="235,504"/>
            <LinkGroup group="236,505"/>
        </LinkResidues>
    </TASKOPERATIONS>
    <MOVERS>
        <ConstraintSetMover name="cst" add_constraints="true" cst_file="constraints.cst"/>
        <CoupledMovesProtocol name="coupled_moves" task_operations="resfile"/>
        <WriteFiltersToPose name="writer" prefix="BuriedUnsats_"/>
    </MOVERS>
    <FILTERS>
        <BuriedUnsatHbonds
            name="buriedunsats_bb"
            report_bb_heavy_atom_unsats="true"
            residue_selector="all_selectors"
            scorefxn="ref15"
            cutoff="4"
            residue_surface_cutoff="20.0"
            ignore_surface_res="true"
            print_out_info_to_pdb="true"/>
        <BuriedUnsatHbonds 
            name="buriedunsats_sc"
            report_sc_heavy_atom_unsats="true"
            residue_selector="all_selectors"
            scorefxn="ref15"
            cutoff="0"
            residue_surface_cutoff="20.0"
            ignore_surface_res="true"
            print_out_info_to_pdb="true"/>
        <LigInterfaceEnergy
            name="liginterface" scorefxn="ref15"/>
        <MoveBeforeFilter
            name="movebefore_bb"
            mover_name="coupled_moves"
            filter_name="buriedunsats_bb"/>
        <MoveBeforeFilter
            name="movebefore_sc"
            mover_name="coupled_moves"
            filter_name="buriedunsats_sc"/>
        <MoveBeforeFilter
            name="movebefore_liginterface"
            mover_name="coupled_moves"
            filter_name="liginterface"/>

    </FILTERS>
    <PROTOCOLS>
        <Add mover_name="cst"/>
        <Add mover_name="writer"/>
        <Add mover_name="coupled_moves"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

----------------

# [10] Command-line Options

## [10.1] Command-line Options you might want to change

**Output files options**

Option | Type | Default | Description
------------ | ------------- | ------------- | -------------
output_prefix | String | default | prefix for output files | 
save_structures | Boolean | false | save structures for all unique sequences

**General algorithm options**

Option | Type | Default | Description | Recommendation
------------ | ------------- | ------------- | ------------- | -------------
ntrials | Integer | 1000 | number of Monte Carlo trials to run | Extensive benchmarking shows that more trials is not better. **Check results, try less than 1000**. 
initial_repack | Boolean | true | start simulation with repack and design step | Initial repack may result in lower diversity
min_pack | Boolean | false | use min_pack for initial repack and design step |

**Backbone options**

Option | Type | Default | Description
------------ | ------------- | ------------- | ------------- | -------------
backbone_mover | String | backrub | See [\[7.3\] Advanced Backbone Command-line Options](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-backbone-usage_7-3-backbone-mover-command-line-options)
kic_perturber | String | walking | See [\[7.3\] Advanced Backbone Command-line Options](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-backbone-usage_7-3-backbone-mover-command-line-options)
kic_loop_size | Real | 4 | See [\[7.3\] Advanced Backbone Command-line Options](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-backbone-usage_7-3-backbone-mover-command-line-options)
walking_perturber_magnitude | Real | 2.0 | See [\[7.3\] Advanced Backbone Command-line Options](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-backbone-usage_7-3-backbone-mover-command-line-options)


**Ligand options**

Option | Type | Default | Description
------------ | ------------- | ------------- | ------------- | -------------
number_ligands | Integer | 1 | See [\[8.1\] Advanced Ligand Command-line Options](https://www.rosettacommons.org/docs/wiki/coupled-moves#8-advanced-ligand-usage_8-1-ligand-command-line-options)
ligand_mode | Boolean | false | See [\[8.1\] Advanced Ligand Command-line Options](https://www.rosettacommons.org/docs/wiki/coupled-moves#8-advanced-ligand-usage_8-1-ligand-command-line-options)
ligand_weight | Real | 1.0 | See [\[8.1\] Advanced Ligand Command-line Options](https://www.rosettacommons.org/docs/wiki/coupled-moves#8-advanced-ligand-usage_8-1-ligand-command-line-options)
ligand_prob | Real | 0.1 | probability of making a ligand move. Recommend default

-------------------------------------

## [10.2] Command-line options you probably don't want to touch

**Algorithm options**

Option | Type | Default | Description
------------ | ------------- | ------------- | -------------
mc_kt | Real | 0.6 | value of kT for Monte Carlo when accepting/rejecting coupled side-chain and backbone moves
boltzmann_kt | Real | 0.6 | value of kT for Boltzmann weighted moves during side-chain design step
mm_bend_weight | Real | 1.0 | weight of mm_bend bond angle energy term
bias_sampling | Boolean | true | if true, bias rotamer selection based on energy
bump_check | Boolean | true | if true, use bump check in generating rotamers 
repack_neighborhood | Boolean | false | After the backbone move and rotamer move, repack sidechains within 5A of the design residue. Default false for behavior from Ollikainen 2015. Does not seem to make an impact on benchmark results, but adds significant time.
exclude_nonclashing_positions | Boolean | true | True = For each packable position, ClashBasedShellSelector iterates through rotamers to determine if the residue could clash with any designable positions. If a clash isn't possible, the packable position is changed from NATAA to NATRO. False = Perform side chain moves strictly as defined in resfile. Default true reproduces behavior from Ollikainen 2015.
fix_backbone | Boolean | false | Set to 'true' to prevent backbone moves. For debugging
uniform_backrub | Boolean | false | select backrub rotation angle from uniform distribution. Recommend default

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

---------------------------------

# [11] Benchmarking

To be added - contact Amanda for immediate questions

---------------------------------

# [12] See Also

* [[I want to do x]]: Guide to choosing a mover