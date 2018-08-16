#Coupled Moves documentation is coming soon! Check back Friday, Aug 17, 2018.

#This is just a draft! Don't read it. Check back Friday, Aug 17, 2018.

Last Doc Update: Aug 17, 2018

[[_TOC_]]

-------------------------
# [1] MetaData

Authors: 
Amanda Loshbaugh (aloshbau@gmail.com); Anum Azam Glasgow (anumazam@gmail.com); Noah Ollikainen (nollikai@gmail.com), PI: Tanja Kortemme


[Coupling Protein Side-Chain and Backbone Flexibility Improves the Re-design of Protein-Ligand Specificity, PLOS Computational Biology, 9/23/2015](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004335)

Noah Ollikainen, René M. de Jong, Tanja Kortemme 

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

Resulting in a limitation where a backbone move might create a sidechain clash that is rejected in the first Monte Carlo step, even though it could have been rescued by the subsequent sidechain move.

**Coupled Moves Algorithm**

1. Backbone move
2. Sidechain move
3. Monte Carlo accept/reject
4. Return to step 1

# [4] Setup and Inputs

## [4.1] Input files
* Input PDB -- the only strictly required input file
* Resfile -- CoupledMoves is a design method
* Params file, one for each ligand (optional) (see [Advanced Ligand Usage](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-ligand-usage))
* Constraints file (optional) ([documentation](https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/constraint-file))

## [4.2] Input pdb preparation

* If your protein is not a simple monomer, put each protein in a separate chain. For example, if you have a homodimer, put each monomer in its own chain.
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

Coupled Moves has a large number of options, and running these basic  examples relies on many defaults, which are explained in the advanced sections.

### [5.1.1] Command-line: Protein only

```
coupled_moves.default.linuxgccrelease
-s my.pdb
-resfile my.resfile
-ex1 -ex2 -extrachi_cutoff 0
```

### [5.1.2] Command-line: Protein with one ligand

```
coupled_moves.default.linuxgccrelease
-s my.pdb # protein and ligand(s). 
   # NOTE: Ligand(s) must be last residues listed in pdb.
-resfile my.resfile
-ex1 -ex2 -extrachi_cutoff 0
-extra_res_fa my_ligand.params # params file for ligand contained in my.pdb
-coupled_moves::ligand_mode true
```

* Should I default users to FKIC?

----------------

## [5.2] Basic XML

### [5.2.1] XML: Protein only

### [5.2.2] XML: Protein with one ligand

----------------

# [6] Advanced Backbone Usage

This section assumed familiarity with documentation for [backrub](https://www.rosettacommons.org/docs/latest/application_documentation/structure_prediction/backrub) and [kinematic closure](https://www.rosettacommons.org/demos/latest/tutorials/GeneralizedKIC/generalized_kinematic_closure_1).

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

Coupled Moves defaults to ShortBackrubMover, e.g. Example #1.  If you want to explicitly specify this default, use
    ```
    -coupled_moves::backbone_mover backrub
    ```

Backrub segment length is hardcoded in ShortBackrubMover as 3-residue (or 4-residue if it hits a Proline).

### [6.1.2] Coupled Moves with KIC

If you are not familiar with KIC, please refer to the [documentation](https://www.rosettacommons.org/demos/latest/tutorials/GeneralizedKIC/generalized_kinematic_closure_1). During KIC's perturbation step, various algorithms can be used to perturb torsion angles. CoupledMoves currently (August 2018) supports two perturbers, Fragment and Walking.

#### [6.1.2.1] Fragment KIC

Fragment perturber substitutes fragments with identical sequences, resulting in updated torsion angles unrelated to the starting torsions. Fragment file generation is explained [here](https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/fragment-file).

**Example command-line**
    ```
    -coupled_moves::backbone_mover kic
    -coupled_moves::kic_perturber fragment
    -loops:frag_sizes 9 3
    -loops:frag_files my_pdb.200.3mers.gz, my_pdb.200.3mers.gz
    ```

#### [6.1.2.2] Walking KIC

Walking perturber "walks" along torsion angle space. Angles are modified by values from a distribution around a user-specified magnitude.

**Example command-line**
    ```
    -coupled_moves::backbone_mover kic
    -coupled_moves::kic_perturber walking # default='walking'
    -coupled_moves::walking_perturber_magnitude 2.0 # units of degrees; default=2.0
    ```

## [6.2] Controlling KIC loop size

This setting is a bit complicated. First, `-coupled_moves::kic_loop_size` only applies when using `-coupled_moves::backbone_mover=kic`. Second, the parameter set by `-coupled_moves::kic_loop_size` (hereafter *n*) is used to calculate the final *loop size* in residues. 

You may set a constant or random loop size:

* **Constant loop size** - If you set *n* to a positive whole number, *loop_size* = 1+2\**n*. In terms of residues, the loop is defined by first selecting resnum (the designable residue), then defining loopstart=resnum-*n* and loopend=resnum+*n*. 

* **Random loop size** - If you set *n*=0, in each trial, *n* will be a random integer in range( 3, 7 ).

```
-coupled_moves::kic_loop_size <n> # default n=4
```

* NOTE: *n* must be at least 3 for 3mers in fragment KIC. Shorter loops will not allow fragment substitution.

## [6.3] Backbone command-line options

Option | Type | Default | Description | Expert usage recommendations
------------ | ------------- | ------------- | ------------- | -------------
backbone_mover | String | backrub | Which backbone mover to use. Current options are backrub (default) or kic. Backrub does not require additional flags, and uses ShortBackrubMover which is hardcoded for 3-residue segments (or 4-residue if it hits a Proline). Kic optionally takes extra flag -kic_perturber.' legal = [ 'backrub', 'kic' ]
kic_perturber | String | walking | Which perturber to use during kinematic closure (KIC). Current options are walking (default) or fragment. Walking perturber adjusts torsions by degrees, the magnitude of which can be set by -walking_perturber_magnitude. If you specify walking you MAY also specify -walking_perturber_magnitude. If you specify fragment you MUST also specify -loops::frag_files and -loops::frag_sizes. legal = [ 'walking', 'fragment' ]
walking_perturber_magnitude | Real | 2.0 | Degree parameter for coupled moves kic walking perturber | Use to control magnitude of Walking KIC backbone moves
kic_loop_size | Real | 4 | Can be constant or random. CONSTANT - If you set loop_size to a positive whole number, the loop moved by coupled_moves::backbone_mover will be 1+2*loop_size. In other words, the loop is defined by first selecting resnum, then defining loopstart=resnum-loop_size and loopend=resnum+loop_size. RANDOM - If you set loop_size to 0, in each trial, loop_size will be random_range( 3, 7 ). [ NOTE: This option is for coupled_moves::backbone_mover=kic only. Backrub segment length is hardcoded in ShortBackrubMover as 3-residue (or 4-residue if it hits a Proline)

-------------------------------------

----------------

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
* Place each ligand in its own chain (we recommend naming it chain X for the first ligand). 

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



### [7.3] Command-line examples: Advanced ligand usage

```
coupled_moves.default.linuxgccrelease
-s my.pdb # protein and ligand(s). 
   # NOTE: Ligand(s) must be last residues listed in pdb.
-resfile my.resfile
-ex1 -ex2 -extrachi_cutoff 0
-coupled_moves::ligand_mode true
-coupled_moves::number_ligands
-extra_res_fa my_ligand.params # params file for ligand on chain X in my.pdb
-extra_res_fa my_ligand.params # params file for ligand on chain Y in my.pdb
-coupled_moves::ligand_weight 2.0 # increased weight for ligand-protein interactions
```

### [7.4] Explicit Waters

**Preparing explicit waters**
* Place water molecules in a separate chain, chain W. Use TP3/WAT residue types and crystallographic positions of oxygens. 
* Add the hydrogens by scoring: `~/Rosetta/main/source/bin/score.linuxgccrelease -database ~/Rosetta/main/database/ -s pdb_file -ignore_unrecognized_res -out:output`
* Waters do not need a params file because WAT/TP3 are already in the Rosetta database.

----------------

# [8] Analysis

----------------

# [9] Command-line Options

**Command-line options you might want to change, and why**

Option | Type | Default | Description | Expert usage recommendations
------------ | ------------- | ------------- | ------------- | -------------
ntrials | Integer | 1000 | number of Monte Carlo trials to run | Extensive benchmarking shows that more trials is not better. **Check results, try less than 1000**. 

initial_repack | Boolean | true | start simulation with repack and design step | Initial repack may result in lower diversity
min_pack | Boolean | false | use min_pack for initial repack and design step |

output_prefix | String | default | prefix for output files | 

number_ligands | Integer | 1 | number of ligands in the pose | See [7-1-ligand-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-ligand-usage_7-1-ligand-command-line-options)
ligand_mode | Boolean | false | See [7-1-ligand-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-ligand-usage_7-1-ligand-command-line-options)
ligand_weight | Real | 1.0 | See [7-1-ligand-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#7-advanced-ligand-usage_7-1-ligand-command-line-options)

backbone_mover | String | backrub | See [6-3-backbone-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#6-advanced-backbone-usage_6-3-backbone-command-line-options)
kic_perturber | String | walking | See [6-3-backbone-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#6-advanced-backbone-usage_6-3-backbone-command-line-options)
kic_loop_size | Real | 4 | See [6-3-backbone-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#6-advanced-backbone-usage_6-3-backbone-command-line-options)
walking_perturber_magnitude | Real | 2.0 | See [6-3-backbone-command-line-options](https://www.rosettacommons.org/docs/wiki/coupled-moves#6-advanced-backbone-usage_6-3-backbone-command-line-options)




-------------------------------------

**Command-line options you probably don't want to touch, and why**

Option | Type | Default | Description | Expert usage recommendations
------------ | ------------- | ------------- | ------------- | -------------
mc_kt | Real | 0.6 | value of kT for Monte Carlo when accepting/rejecting coupled side-chain and backbone moves |
boltzmann_kt | Real | 0.6 | value of kT for Boltzmann weighted moves during side-chain design step |
mm_bend_weight | Real | 1.0 | weight of mm_bend bond angle energy term |
trajectory | Boolean | false | record a trajectory | Prints pdbs during design trajectory. Useful for viewing trajectory but takes a lot of space, use wisely.
trajectory_gz | Boolean | false | gzip the trajectory |
trajectory_stride | Integer | 100 | write out a trajectory frame every N trials |
trajectory_file | String | 'traj.pdb' | name of trajectory file |
output_fasta | String | sequences.fasta | name of FASTA output file |
output_stats | String | sequences.stats | name of stats output file |
save_sequences | Boolean | true | save all unique sequences  |  Sequences for analysis
save_structures | Boolean | false | save structures for all unique sequences | 
ligand_prob | Real | 0.1 | probability of making a ligand move | 
fix_backbone | Boolean | false | do not make any backbone moves | 
uniform_backrub | Boolean | false | select backrub rotation angle from uniform distribution | 
bias_sampling | Boolean | true | if true, bias rotamer selection based on energy
bump_check | Boolean | true | if true, use bump check in generating rotamers | 
repack_neighborhood | Boolean | false | After the backbone move and rotamer move, repack sidechains within 5A of the design residue. Default false for legacy behavior. | Does not seem to make an impact on benchmark results, but adds significant time.
legacy_task | Boolean | true | Default true for legacy behavior (Ollikainen 2015). True = use Clash Based Shell Selector to define repack residues around design residues from resfile, and perform Coupled Moves on these repack/design residues. False = Perform Coupled Moves on design/repack residues as defined in resfile.
-------------------------------------





**Example 4**
**Coupled Moves with Fragment KIC**
```
-coupled_moves::backbone_mover kic
-coupled_moves::kic_perturber fragment
-coupled_moves::kic_loop_size 0

```



**Example 2**

-ignore_unrecognized_res # If pdb contains ligands not defined by params that should be ignored \

Here, we want to do a denovo-run, starting with random CDRs grafted in instead of whatever we have in antibody to start with (only for the CDRs that are actually undergoing graft-design).  This is useful, as we start the design with very high energy and work our way down.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -random_start
```

----------------

#### Optimizing Interface Energy (opt-dG)

**Example 1**

Here, we want to set the protocol to optimize the interface energy during Monte Carlo instead of total energy.  The interface energy is calculated by the [[InterfaceAnalyzerMover]] through a specialized MonteCarlo called **MonteCarloInterface**.   **This is useful to improve binding energy and will result in better interface energies**.  Resulting models should still be pruned for high total energy.  This was benchmarked in the paper, and has been used for real-life designs after - so please see it for more information.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -mc_optimize_dG
```

----------------


**Example 2 - Optimizing Interface Energy and Total Score (opt-dG and opt-E)**

Here, we want to set the protocol to optimize the interface energy during Monte Carlo, but we want to add some total energy to the weight.  Because the overall numbers of total energy will dominate the overall numbers, we only add a small weight for total energy.  This has not been fully benchmarked, but if your models have very bad total energy when using opt-dG - consider using it.  

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -mc_optimize_dG \
-mc_total_weight .001 -mc_interface_weight .999

```

----------------


### Docked Design

**Example 1**

In this example, we use integrated RosettaDock (with sequence design during the high-res step) to sample the antibody-antigen orientation, but we don't care where the antibody binds to the antigen.  Just that it binds. IE - No Constraints. The RAbD protocol always has at least Paratope SiteConstraints enabled to make sure any docking is contained to the paratope (like most good docking programs).

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -do_dock
```

------------------------

**Example 2**

Allow Dock-Design, incorporating auto-generated SiteConstraints to keep the antibody around the starting interface residues.  These residues are determined by being within 6A to the CDR residues.  

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -do_dock -use_epitope_constraints
```

----------------

**Example 3**

Allow Dock-Design, as above, but specify the Epitope Residues and Paratope CDRs to guide design to have these interact.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -do_dock -use_epitope_constraints \
-paratope_cdrs H3 -epitope 63A 63A:A 64
```

-----------------------

**Example 4**

Here, we want to do a denovo-run, creating an interface at the light-chain, starting with random CDRs grafted in instead of whatever we have in the antibody to start with (for the designing CDRs).  

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs L1 L2 L3 \
-graft_design_cdrs L1 L2 L3 -seq_design_cdrs L1 L2 L3 -light_chain lambda -do_dock \
-use_epitope_constraints -paratope_cdrs L1 L2 L3 -epitope 63A 63A:A 64 -random_start
```

### Instruction File Customization
More complicated design runs can be created by using the Antibody Design Instruction file.  This file allows complete customization of the design run. See below for a review of the syntax of the file and possible customization.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-cdr_instructions my_instruction_file.txt
```

## Advanced Settings

**Example 1**

Here, we will disallow ANY sequence design into Proline residues and Cysteine residues, while giving a resfile to further LIMIT design and packing as specific positions. These can be given as 3 or 1 letter codes and mixed codes such as PRO and C are accepted. Note that the resfile does NOT turn any residues ON, it is simply used to optionally LIMIT design residue types and design and packing positions.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-resfile my_resfile.resfile -dissallow_aa PRO CYS
```

------------------------

**Example 2**

Here, we will change the mintype to relax.  This mintype enables Flexible-Backbone design.  Our default is to use min/pack cycles, but relax typically works better.  However, it also takes considerably more time!

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-resfile my_resfile.resfile -dissallow_aa PRO CYS -mintype relax
```

-------------------------

**Example 3**

Finally, we want to allow the framework residues AROUND the CDRs we will be designing and any interacting antigen residues to design as well here.  We will disable conservative framework design as we want something funky (this is not typically recommended and is used here to indicate what you CAN do.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-resfile my_resfile.resfile -dissallow_aa PRO CYS -mintype relax \
-design_antigen -design_framework -conservative_framework_design false
```

## Expert Settings

**Example 1**

Now, we will spice things up even further.  We are feeling daring today.  A new Rosetta energy function with fully polarizable forcefields has just been published, we have our first quantum computer, Andrew just got done the Quantum JD through JD4, and we have LOTS of money for designs (I can dream, right! ;).  We are ready to put Rosetta to the test.

We will enable H3 Stem design here, which can cause a flipping of the H3 stem type from bulged to non-bulged and vice-versa.  Typically, if you do this, you may want to run loop modeling on the top designs to confirm the H3 structure remains in-tact.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -design_H3_stem
```

Cool.  That should make some interesting antibodies for our experiment.  

------------------
**Example 3**

Now, we will change around the KT to get more interesting samplings (from our 1.0 default).

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-design_H3_stem -inner_KT 2.0 -outer_KT 2.0
```

----------------

**Example 4**

Finally, we want increased variability for our sequence designs.  So, we will increase number of sampling rounds for our lovely cluster profiles using the `-seq_design_profile_samples` option.  

Description of the option (default 1): "If designing using profiles, this is the number of times the profile is sampled each time packing done.  Increase this number to increase variability of designs - especially if not using relax as the mintype."

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-design_H3_stem -inner_KT 2.0 -outer_KT 2.0 -seq_design_profile_samples 5
```

# Antibody Design CDR Instruction File
The Antibody Design Instruction File handles CDR-level control of the algorithm and design.  It is used to create the CDRSet for sampling whole CDRs from the PDB, as well as fine-tuning the minimization steps and sequence design strategies.  

For example, in a redesign project, we may only want to design a particular CDR and explore the local conformations within its starting CDR cluster, or we may simply want to optimize the sequence of a CDR or set of CDRs using our cluster profiles. These examples can be accomplished using the CDR Instruction File. This file uses a simple syntax where each CDR is controlled individually in the first column, and then a rudimentary language controls each part of the antibody design machinery. The file controls which CDRs are sampled, what the final CDRSet will be, whether sequence design is performed and how, and which minimization type will be used to optimize the structure and sequence for each CDR. Some of these commands can also be controlled via command-line options for simple-to-setup runs.  Any option set via command-line (such as `-graft_design_cdrs` and `-seq_design_cdrs` will override anything set in the instruction file)

## Syntax

The CDR Instruction file is composed of tab or white-space delimited columns. The first column on each line specifies which CDR the option is for. For each option, 'ALL' can be given to control all of the CDRs at once. ALL can also be used in succession to first set all CDRs to something and then one or more CDRs can be set to something else in succeeding lines. Commands are not lower- or upper-case-sensitive. A ‘#’ character at the beginning of a line is a file comment and is skipped.

**First column** - _CDR_, 

**Second Column** -  _TYPE_

Other columns can be used to specify lists, etc. 

**Instruction Types**

Type | Description
------------ | -------------
GraftDesign | Instructions for the Graft-based Design stage
SeqDesign | Instructions for Sequence Design
CDRSet | Instructions for which structures end up in the set of structures from which to sample during GraftDesign. option follows the syntax: `CDR CDRSet option`
MinProtocol | Instructions for Minimization

**Example**
```
#H3 no design; just flexible motion of the loop

#SET All to design first
ALL GraftDesign ALLOW
ALL SeqDesign ALLOW

#Fix H3 and disallow GraftDesign for H1 and L2
L2 GraftDesign FIX
H1 GraftDesign FIX

#Disallow GraftDesign and SeqDesign for H3
H3 FIX

ALL MinProtocol MINTYPE relax

ALL CDRSet EXCLUDE PDBIDs 1N8Z 3BEI

#ALL CDRSet EXCLUDE Clusters L1-11-1 L3-9-cis7-1 H2-10-1
```

-------------------------

**General Design Syntax**

Instruction  | Description
------------ | -------------
`L1 Allow` | Allow L1 to Design in both modes
`L1 GraftDesign Allow` | Allow L1 to GraftDesign
`L1 SeqDesign Allow` |Allow L1 to SequenceDesign
`L1 Fix` | Disable L1 to Design in both modes
`L1 GraftDesign Fix` | Disable L1 to GraftDesign
`L1 SeqDesign Fix` | Disable L1 to SequenceDesign
`L1 Weights Z` |Weight a particular CDR when choosing which CDR to design. By default, all CDRs have an equal weight. 

--------------------------------

**CDRSet Syntax (General)**

Instruction  | Description
------------ | -------------
`L1 CDRSet Length Max X` | Maximum length of CDR
`L1 CDRSet Length Min Y` | Minimum length of CDR
`L1 CDRSet Cluster_Cutoffs Z` | Limits the CDRSet to include only CDRs of clusters that have Z or more members. Used in conjunction with Sequence Design cutoffs to sample clusters where profile data is sufficient or simply common clusters of a particular species.
`L1 CDRSet ONLY_CURRENT_CLUSTER` | Limits the CDRSet to include only CDRs belonging to the identified cluster of the starting CDR. Overrides other options. Used for sequence and structure sampling within CDR clusters. Useful for redesign applications.
`L1 CDRSet Center_Clusters_Only` | Limits the CDRSet to include only CDRs that are cluster centers. Overrides other options. Used for broadly sampling CDR structure space. Useful to get an idea of what CDRs can fit well or for a first-pass run for de novo design.

**CDRSet Syntax (Include and Excludes)**

This set of options either includes only the items specified or it excludes specific items. The syntax is thus:

`L1 CDRSet INCLUDE_ONLY option list of items`

OR

`L1 CDRSet EXCLUDE option list of items`

The options for this type of CDRSet syntax are listed below

Option  | Description
------------ | -------------
`PDBIDs` | Include only or leave out a specific set of PDBIds. This is very useful for benchmarking purposes.
`Clusters` | Include only or leave out a specific set of Clusters. Useful if the user already knows which clusters are able to interact with antigen, whether this is from previous runs of the program or via homologues. This is also useful for benchmarking. 
`Germline` | Include only or leave out specific human/mouse germlines. 
`Species` | Include only or leave out specific species. Very useful limiting possible immune reactions in the final designs. 2 Letter designation as used by IMGT.  Hu and Mo for Human and Mouse.

------------------------

**Sequence Design Instructions**

The Sequence Design Instructions, used with the keyword SeqDesign after the CDR specifier, is used to control the sequence design aspect of the algorithm. In addition to controlling which CDRs undergo sequence design, the Sequence Design options control which strategy to use when doing sequence design (primary strategy), and which strategy to use if the primary strategy cannot be used for that CDR (fallback strategy). 

Currently, the fallback strategy is used if the primary strategy does not meet statistical requirements. For example, using cluster-based profiles for sequence design (which is the default), it is imperative that the particular cluster has at least some number of sequences in the database for the strategy to be successful. By default, this cutoff is set at 10 and uses the command-line option, `‑seq_design_stats_cutoff Z`. This means that if a cluster has less than 10 members and the primary strategy is to use cluster-based profiles, then the fallback strategy will be used. The default fallback strategy for all of the CDRs is the use of a set of conservative mutations with data coming from the BLOSUM62 matrix by default, with the set of mutations allowed consisting of those substitutions with positive or zero scores in the matrix. For example, if we have a D at some position for which we are using this fallback strategy, the set of allowed mutants would be N, Q, E, and S. Further, the set of conservative mutations can be controlled using the command-line option, `‑cons_design_data_source` source, where other BLOSUM matrices can be specified. All BLOSUM matrices can be used for conservative design, where the numbers (40 vs. 62 vs. 80 etc.) indicate the sequence similarity cutoffs used to derive the BLOSUM matrices - with higher numbers being a more conservative set of mutations. 

**General Syntax**

Option  | Description
------------ |  -------------
`L1 SeqDesign Strategy Z` | Set Primary Sequence Design Strategy
`L1 SeqDesign Fallback_Strategy Z` | Set Fallback Sequence Design Strategy


**Strategy Types**

Z  | Strategy Use | Description
------------ | ------------- | -------------
`Profiles` | Primary | Use cluster-based profiles based on sequence probabilities as described above
`Profile_Sets` | Primary | Randomly sample a full CDR sequence from the CDR cluster each time packing is done
`Profiles_Combined` | Primary | Randomly sample a full CDR sequence from the CDR cluster and sample from the cluster-based profiles each time packing is done. Used to increase variability. Helpful in conjunction with center cluster member CDRSet sampling
`Conservative` | Both | Conservative design operation as described above
`Basic` | Both | Basic design – no profiles, just enabling all amino acids at those positions
`Disable` | Fallback | Turn off design for that CDR if primary strategy does not meet cutoffs. 

**Etc**

Option  | Description
------------ |  -------------
`L1 SeqDesign DISALLOWED` | Disable specific amino acid sampling for this CDR (One or Three letter codes. Can be mixed) Ex. ARG C S ASN PRO

-----------------------

**Minimization**

Many minimization types are implemented; however, they each require a different amount of time to run. See the MinType descriptions below for a list of acceptable options and their use.

Option  | Description
------------ |  -------------
`L1 MinProtocol MinType Z` |  Set the minimization type for this CDR
`L1 MinProtocol MinOther CDRX, CDRY, CDRZ` | Set other CDRs to minimize during the optimization/design of this particular CDR. A packing shell around the CDRs to be minimized within a set distance (default 6 Å) is created. Any CDRs or regions (framework/antigen) set to design within this shell will be designed. These regions will use all set sequence design options (profiles, conservative, etc.). This option is useful for creating CDR-CDR interactions for loop and antibody structural stability.  By default, we reasonably minimize other CDRs during the optimization step.  (More CDRs = Lower Speed)

## Default Settings

These settings are overridden by your set instruction file/command-line options

```

#General
ALL FIX
DE FIX

ALL WEIGHTS 1.0

#Minimization - Options: min, relax, ds_relax cartesian, backrub, repack, none
ALL MinProtocol MINTYPE min

#Neighbors.  These are conservative values used in benchmarking.  Limit these to speed up runs.
L1 MinProtocol Min_Neighbors L2 L3
L2 MinProtocol Min_Neighbors L1
L3 MinProtocol Min_Neighbors L1 H3
H1 MinProtocol Min_Neighbors H2 H3
H2 MinProtocol Min_Neighbors H1
H3 MinProtocol Min_Neighbors L1 L3

#Length
ALL CDRSet LENGTH MAX 25
ALL CDRSet LENGTH MIN 1


#Profile Design
ALL SeqDesign STRATEGY PROFILES
ALL SeqDesign FALLBACK_STRATEGY CONSERVATIVE

##DE Loops can be designed.  They use conservative design by default since we have no profile data!
DE SeqDesign STRATEGY CONSERVATIVE
```

# GraftDesign Sampling Algorithms
These change the way CDRs are sampled from the antibody design database.   They can be specified using the <code>-design_protocol</code> flag.

`-design_protocol` | Description
------------ | -------------
`even_cluster_mc` | Evenly sample clusters during the GraftDesign stage by first choosing a cluster from all the clusters set to design for the chosen Primary CDR and then choosing a structure within that cluster. (**DEFAULT**)
`even_length_cluster_mc` | Evenly sample lengths and clusters during the GraftDesign stage by first choosing a length from the set of lengths for the chosen Primary CDR and the a cluster from the set of clusters, and then finally a structure within that cluster.  Useful to broaden set of lengths sampled during the protocol.
`gen_mc`| Sample CDRs to GraftDesign according to their distribution in the database.  This results in common clusters and lengths being sampled more frequently.  However, these lengths/clusters may not be those regularly seen in nature vs regularly crystalized.  AKA - they are biased towards crystals, however, they have more profile data associated with them.
`deterministic_graft`| Deterministic Graft is meant to try every CDR combination from the CDRSet (the set of clusters and structures).  The outer loop is done deterministically for each CDR in a set.  It is very useful for trying small numbers of combinations - such as all loop lengths >=12 for H2 or all CDRs of a particular cluster.  Note that there is no outer monte carlo, so the final designs are the best found by the protocol, and each sampling is independent from the others. If you have too many structures in your CDRSet (such as all L1) and you try combos that are beyond a certain limit (AKA - they will never finish), you will error out.  Once a Multi-Threaded Rosetta is working (should be early 2018), trying all possibilities is certainly something that is more plausible.  If you are interested in using something like this, please email the author.

# Structure Optimization Types 
These 'Mintypes' can be independently set for each CDR through the instruction file or generally set using the command line option `-mintype`.  The default is `min`, as this has some optimization and does not take a very long time (and has been shown to be comparable to relax).  Although we refer to 'design' we mean side-chain packing, with any residues/CDRs set to design as designing. For further information on the algorithm and strategies used for sequence design, please see the instruction file overview and the methods section of the paper. 

Circular Harmonic Dihedral Constraints are added to each CDR according the cluster of the CDR or the starting dihedrals if this is a rare cluster that has no data.  These ensure that minimization and design does not destroy the loop.

`-mintype`| Description
------------ | -------------
`min`| **Cycle of design->min->design->min**. Results in good structures, however not as good as relax in recovering native physical characteristics.  Significantly faster. (**DEFAULT**)
`cartmin`| **Cycle of design->min->design->min** Cartesian Space Minimization. Automatically adds cart_bonded term if not present and turns off pro_close
`relax` | Flexible Backbone design using `RelaxedDesign`, which is neighbor-aware design during FastRelax where the packing shell to the designing CDRs is updated at every packing iteration. Results in lower energies and closer physical characteristics to native, but takes significantly longer.  It is recommended to first run min and then relax mintype on the top resulting models. [(Relax Protocol Paper)](https://www.ncbi.nlm.nih.gov/pubmed/21073878)
`dualspace_relax` | Flexible Backbone design using 'RelaxedDesign' while optimizing both Dihedral and Cartesian space [Dualspace Relax Protocol Paper](https://www.ncbi.nlm.nih.gov/pubmed/24265211)
`backrub` | **Cycle of backrub->design**. Uses backrub to optimize the Backbone of the CDRs set to minimize.   Use the `-add_backrub_pivots 11A 12A 12A:B ` option to add additional sets of back rub pivots, such as to add flexibility to the antigen interface. Flexibility is extremely minimal, but in some cases may be useful. [(Original Backrub Protocol Paper)](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000393)


#RosettaScripts and PyRosetta

The Full protocol that is the application is available to RosettaScripts as the [[AntibodyDesignProtocol]].  This just has a few extra options before and after design such as running fast relax and or snug dock. 

The Configurable main Mover is available as the [[AntibodyDesignMover]].

[[Individual components | Movers-RosettaScripts#antibody-modeling-and-design-movers]] of RAbD can be used to create your own custom antibody modeling and design protocols in RosettaScripts (or PyRosetta). 

# Command-line Options

**General Options**

Option | Description
------------ | -------------
`-view`| _Enable viewing of the antibody design run. Must have built using extras=graphics and run with antibody_designer.graphics executable_ (**Default=False**)	
`-cdr_instructions` | _Path to CDR Instruction File_
`-antibody_database` | _Path to the current Antibody Database, updated weekly.  Download from http://dunbrack2.fccc.edu/PyIgClassify/ _ (**Default=/sampling/antibodies/antibody_database_rosetta_design.db**)			
`-paper_ab_db` | _Force the use the Antibody Database with data from the North clustering paper.  This is included in Rosetta. If a newer antibody database is not found, we will use this. The full ab db is available at [Through PyIgClassify](http://dunbrack2.fccc.edu/PyIgClassify/)_ (**Default = false**)

---------------------------------------------


**Basic settings for an easy-to-setup run**

Option | Description
------------ | -------------
`-seq_design_cdrs`| _Enable these CDRs for Sequence-Design.  (Can be set here or in the instructions file. Overrides any set in instructions file if given ) Ex -seq_design_cdrs L1 L2 L3 h1_
`-graft_design_cdrs` | _Enable these CDRs for Graft-Design.  (Can be set here or in the instructions file. Overrides any set in instructions file if given) Ex -graft_design_cdrs L1 L2 L3 h1_		
`-primary_cdrs` | _Manually set the CDRs which can be chosen in the outer cycle. Normally, we pick any that are sequence-designing._		
`-mintype`| _The default mintype for all CDRs.  Individual CDRs may be set via the instructions file_ (_Options = min, cartmin, relax, backrub, pack, dualspace_relax, cen_relax, none_) (**Default=min**)
`-disallow_aa` | _Disallow certain amino acids while sequence-designing (could still be in the graft-designed sequence, however).  Useful for optimizing without, for example, cysteines and prolines. Applies to all sequence design profiles and residues from any region (cdrs, framework, antigen).  You can control this per-cdr (or only for the CDRs) through the CDR-instruction file. A resfile is also accepted if you wish to limit specific positions directly._ (Three or One letter codes)
`-top_designs`| _Number of top designs to keep (ensemble).  These will be written to a PDB and each move onto the next step in the protocol_. (**Default=1**)
`-do_dock` | Run a short lowres + highres docking step in the inner cycles.  (dock/min).  Recommended 2 inner cycles for better coverage. (dock/min/dock/min). Inner/Outer loops for highres are hard coded, while low-res can be changed through regular low_res options.  If sequence design is enabled, will design regions/CDRs set during the high-res dock (**Default=false**)


-------------------------------------

**Energy Optimization settings (opt-dG)**

Option | Description
------------ | -------------
`-mc_optimize_dG` | Optimize the dG during MonteCarlo.  It is not possible to do this within overall scoring, but where possible, do this during MC calls.  This option does not globally-use the MonteCarloInterface object, but is protocol-specific. This is due to needing to know the interface it will be used on. dG is measured by the InterfaceAnalyzerMover. (**Default=false**)
`-mc_interface_weight` | Weight of interface score if using MonteCarloInterface with a particular protocol. (**Default=1.0**)
`-mc_total_weight` | Weight of total score if using MonteCarloInterface with a particular protocol. (**Default=0.0**)


-------------------------------------
**Protocol Rounds**

Option | Description
------------ | -------------
`-outer_cycle_rounds` | Rounds for outer loop of the protocol (not for deterministic_graft ).  Each round chooses a CDR and designs. One run of 100 cycles with relax takes about 12 hours. If you decrease this number, you will decrease your run time significantly, but your final decoys will be higher energy.  Make sure to increase the total number of output structures (nstruct) if you use lower than this number.  Typically about 500 - 1000 nstruct is more than sufficient.  Full DeNovo design will require significantly more rounds and nstruct.  If you are docking, runs take about 30 percent longer. (**Default=25**)
`-inner_cycle_rounds` | Number of times to run the inner minimization protocol after each graft.  Higher (2-3) rounds recommended for pack/min/backrub mintypes or if including dock in the protocol. (**Default = 1**)
`-dock_cycle_rounds` | Number of rounds for any docking.  If you are seeing badly docked structures, increase this value. (**Default=1**)

----------------------------

**Distance Detection**

Option | Description
------------ | -------------
`-interface_dis` | Interface distance cutoff.  Used for repacking of interface, epitope detection, etc. (**Default=8.0**)
`-neighbor_dis` | Neighbor distance cutoff.  Used for repacking after graft, minimization, etc. (**Default=6.0**)


---------------------------


**Paratope + Epitope**


Option | Description
------------ | -------------
`-paratope` | Use these CDRs as the paratope. Default is all of them.  Currently only used for SiteConstraints. Note that these site constraints are only scored docking unless _-enable_full_protocol_atom_pair_cst_ is set (Ex -paratope L1 h1)
`-epitope` | Use these residues as the antigen epitope.  Default is to auto-identify them within the set interface distance at protocol start if epitope constraints are enabled. Currently only used for constraints.  PDB Numbering. Optional insertion code. Example: 1A 1B 1B:A. Note that these site constraints are only used during docking unless -enable_full_protocol_atom_pair_cst is set.
`-use_epitope_constraints` | Enable use of epitope constraints to add SiteConstraints between the epitope and paratope.  Note that paratope constraints are always used.  Note that these site constraints are only used during docking unless -global_atom_pair_cst_scoring is set.(**Default = false**)

------------------------------


**Regional Sequence Design**

Option | Description
------------ | -------------
`-design_antigen` | Design antigen residues during sequence design.  Intelligently.  Typically, only the neighbor antigen residues of designing cdrs or interfaces will be co-designed.  Useful for specific applications.(**Default = false**)
`-design_framework` | Design framework residues during sequence design.  Typically done with only neighbor residues of designing CDRs or during interface minimization. (**Default = false**)
`-conservative_framework_design` | 'If designing Framework positions, use conservative mutations instead of all of them.'(**Default=true**)


---------------------------


**Seq Design Control**

Option | Description
------------ | -------------
`-resfile` | Use a resfile to further limit which residues are packed/designed, and can further limit residue types for design.
`-design_H3_stem` | Enable design of the first 2 and last 3 residues of the H3 loop if sequence designing H3.  These residues play a role in the extended vs kinked H3 conformation.  Designing these residues may negatively effect the overall H3 structure by potentially switching a kinked loop to an extended and vice versa.  Rosetta may get it right.  But it is off by default to err on the cautious side of design. Sequence designing H3 may be already risky. (**Default=false**)
`-design_proline` | Enable proline design.  Profiles for proline are very good, but designing them is a bit risky.  Enable this if you are feeling daring. (**Default=false**)
`-sample_zero_probs_at` | Value for probabilstic design.  Probability that a normally zero prob will be chosen as a potential residue each time packer task is called.  Increase to increase variablility of positions. (**Default=0**)

------------------------------

**Profile Stats**

Option | Description
------------ | -------------
`-seq_design_stats_cutoff` | Value for probabilistic -> conservative sequence design switch.  If number of total sequences used for probabilistic design for a particular cdr cluster being designed is less than this value, conservative design will occur. More data = better predictability. (**Default=10**)
`-seq_design_profile_samples` | If designing using profiles, this is the number of times the profile is sampled each time packing done.  Increase this number to increase variability of designs - especially if not using relax as the mintype. (**Default=1**)


---------------------------


**Constraint Control**

Option | Description
------------ | -------------
`-dihedral_cst_weight` | Weight to use for CDR CircularHarmonic cluster-based or general constraints that are automatically added to each structure and updated after each graft. Set to zero if you dont want to use these constraints. Note that they are not used for the backrub mintype. Overrides weight/patch settings.(**Default = .3**)
`-atom_pair_cst_weight` | Weight to use for Epitope/Paratope SiteConstraints.  Paratope Side contraints are always used.  Set to zero to completely abbrogate these constraints. Overrides weight/patch settings.'Real' (**Default = 0.01**)
`-global_dihedral_cst_scoring` | Use the dihedral cst score throughout the protocol, including final scoring of the poses instead of just during minimization step (**Default = false**)
`-global_atom_pair_cst_scoring` | Use the atom pair cst score throughout the protocol, including final scoring of the poses instead of just during docking. Typically, the scoreterm is set to zero for scorefxns other than docking to decrease bias via loop lengths, relax, etc.  It may indeed help to target a particular epitope quicker during monte carlo design if epitope constraints are in use, as well for filtering final models on score towards a particular epitope if docking. (**Default = true**)

------------------------------------


**Fine Control**

Option | Description
------------ | -------------  			
`-idealize_graft_cdrs` | Idealize the CDR before grafting.  May help or hinder. (**Default = false**)
`-add_backrub_pivots` | 'Additional backrub pivot residues if running backrub as the MinType. PDB Numbering. Optional insertion code. Example: 1A 1B 1B:A.  Can also specify ranges: 1A-10:A.  Note no spaces in the range.
`-inner_kt` | KT used in the inner min monte carlo after each graft. (**default = 1.0)**,
`-outer_kt` | KT used for the outer graft Monte Carlo.  Each graft step will use this value (**Default = 1.0**),

------------------------------


**Outlier Control**

Option | Description
------------ | -------------
`-use_outliers` | Include outlier data for GraftDesign, profile-based sequence design stats, and cluster-based dihedral constraints.  Outliers are defined as having a dihedral distance of > 40 degrees and an RMSD of >1.5 A to the cluster center.  Use to increase sampling of small or rare clusters. (**Default=false**)
`-use_H3_graft_outliers` | Include outliers when grafting H3.  H3 does not cluster well, so most structures have high dihedral distance and RMSD to the cluster center.  Due to this, cluster-based dihedral constraints for H3 are not used.  Sequence profiles can be used for clusters, but not usually. (**Default = true**)
`-use_only_H3_kinked` | Remove any non-kinked CDRs from the CDRSet if grafting H3.  For now, the match is based on the ramachandran area of the last two residues of the H3. Kinked in this case is defined as having AB or DB regions at the end.  Will be improved for detection (**Default = false**)

-----------------------------------

**Protocol Steps**

Option | Description
------------ | -------------
`-design_protocol` | Set the main protocol to use.  Note that deterministic is currently only available for the grafting of one CDR. (_Options = gen_mc, even_cluster_mc, even_length_cluster_mc, deterministic_graft_)(**Default=even_cluster_mc**)
`-run_snugdock` | Run snugdock on each ensemble after designing. (**Default=false**)
`-run_relax` | Run Dualspace Relax on each ensemble after designing (after snugdock if run). Also output pre-relaxed structures (**Default = false**)
`-run_interface_analyzer`| Run the Interface Analyzer and add the information to the resulting score function for each top design output. (**Default = true**)

--------------------------------------

**Memory management / CDRSet caching**

Option | Description
------------ | -------------
`-high_mem_mode` | If false, we load the CDRSet (CDRs loaded from the database that could be grafted) on-the-fly for a CDR if it has more than 50 graft-design members.  If true, then we cache the CDRSet before the start of the protocol.  Typically, this will really only to come into play when designing all CDRs.  For de-novo design of 5/6 CDRs, without limiting the CDRSet in the instructions file, you will need 3-4 gb per process for this option. (**default = false**)
`-cdr_set_cache_limit` | If high_mem_mode is false, this is the limit of CDRSet cacheing we do before we begin load them on-the-fly instead.  If high_mem_mode is true, then we ignore this setting.  If you have extremely low memory per-process, lower this number (**default = 300**)


---------------------------------


**Benchmarking**

Option | Description
------------ | -------------
`-random_start` | Start graft design (currently) with a new set of CDRs from the CDRSets as to not bias the run with native CDRs. (**Default=false**)
`-remove_antigen` | Remove the antigen from the pose before doing any design on it (**Default = false**)
`add_graft_log_to_pdb` | Add the full graft log to the output pose.  Must also pass -pdb_comments option. (**Default = 'true'**)




#See Also

* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]
* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[AntibodyDesignProtocol]]
* [[AntibodyDesignMover]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[I want to do x]]: Guide to choosing a mover