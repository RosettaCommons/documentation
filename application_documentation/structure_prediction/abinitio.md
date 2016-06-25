# Abinitio

An introductory tutorial on _ab initio_ can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/denovo_structure_prediction/Denovo_structure_prediction). A tutorial on protein folding using the broker can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/advanced_denovo_structure_prediction/folding_tutorial)

## Basic Algorithm, FragmentSampler

The fragment assembly proceeds in 4 stages that differ mainly by the ScoreFunction and the fragment size applied during the trial moves. The third stage is split into two sub-stages stage IIIa and IIIb. The weight-sets to create the ScoreFunctions are stored in the Rosetta database under the names `score0`, `score1`, `score2`, `score5` and `score3`, for stage 1, 2, 3a, 3b and 4, respectively. To manipulate the scoring during assembly stages one has to provide a score patch using the flags `-abinitio:stageX_patch file.wts_patch`, where X = 1, 2, 3a, 3b or 4, respectively and file.wts_patch is a file containing the patch. There is no single flag to patch the ScoreFunctions of all stages at once.

The fragment assembly protocol generally runs a block of fragment trial moves (standard block size is 2000 cycles) and then returns the conformation that during the cycles gave the lowest energy. Stage I and II run 1 cycle block each of 2000 cycles. In stage III 10 cycle-blocks of 2000 cycles are run interleaving in IIIa and IIIb modus. In stage IV 3 blocks of 4000 cycles are run. The number of cycles can be scaled up globally using flag `-increase_cycles X` such that the new cycle numbers are 2000\*X and 4000\*X, respectively.

The trial moves will be large fragments in Stages I, II, III and small fragments in stage IV and are handled by the ClassicFragmentMover. In blocks 2 and 3 of stage IV a SmoothFragmentMover is used that prefers fragment moves with little downstream perturbation. The amount of downstream perturbation is quantified using the GunnCost metric.

The flag `-abinitio:skip_stages [1,2,3,4]` allows to specify a list of stages that are skipped during the fragment assembly process. The standard behavior is to recover the lowest scoring pose after each cycle block. This can be behavior can be changed by explicitly enumerating the stages where a recovery should happen with flag `-abinitio:recover_low_instages [1,2,3,4]`.

## Fold Constraints Algorithm, ConstraintFragmentSampler

Some changes and additions to the basic algorithm are made to improve the performance in the presence of constraints.

Distance restraints and chainbreak penalties (jumping) are switched on according to their sequence separation, i.e., the minimum number of residues one has to traverse in the [[FoldTree|FoldTree overview]] to get from one residue to the other. The first cycling block in Stage I is started with a maximum sequence separation of 3 residues. Subsequently, this threshold is increased in steps of two residues until a maximum sequence separation of 15% (`-fold_cst::seq_sep_stages`) of the total length of the protein is reached. After each increment a StageI cycle block is sampled. This is a reason why the constraint algorithm is slower for large proteins (many increments until 15% is reached... ).
In subsequent stages, the sequence separation threshold is slowly ramped up to 100% (`-fold_cst::seq_sep_stages`) but no additional sampling cycles are used.

If beta-strand jumping is used the chainbreak penalties are treated similar to distance restraints such that they turned on/off according to the sequence separation threshold, additionally the chainbreak-weights in the `ScoreFunction` can be ramped up (`-jumping:ramp_chainbreaks`).

##  Flags (Abinitio)

An application that uses the abinitio protocol and is, for example, started in the directory `rosetta_demos/abinitio/` would read-out the following flags:

### Input Options
```
-in:file:native ./input_files/1elw.pdb 	                Native structure (optional)
-in:file:fasta ./input_files/1elwA.fasta 	        Protein sequence in fasta format (required)
-in:file:frag3 ./input_files/aa1elwA03_05.200_v1_3 	Fragment library: 3-residue fragments (required)
-in:file:frag9 ./input_files/aa1elwA09_05.200_v1_3 	Fragment library: 9-residue fragments (required)
-database path/to/rosetta/main/database 	        Path to rosetta database (required if not ROSETTA3_DB environment variable is set)
```

### Output options
```
-nstruct 1 	                        Number of output structures (default=1).
-out:file:silent 1elwA_silent.out 	Use silent file output, use filename after this flag (default=default.out).
(or -out:pdb) 	                        Use PDB file output (default=false).
-out:path /my/path 	                Path where PDB output files will be written to (default='.').
```

### Algorithmic options

These flags are implemented in `FragmentSampler.cc`

There are several optional settings. Those which have been benchmarked and tested thoroughly for optimal performance carry the comment "recommended":
```
-abinitio::increase_cycles 10 	Increase the number of cycles at each stage in ab initio by this factor (recommended).
-abinitio:rg_reweight 0.5 	Reweight contribution of radius of gyration to total score by this scale factor (recommended).
-abinitio:rsd_wt_helix 0.5 	Reweight env,pair,cb for helix residues by this factor (recommended).
-abinitio:rsd_wt_loop 0.5 	Reweight env,pair,cb for loop residues by this factor (recommended).
-abinitio:stage1_patch 	        Supply patch file for the score0 ScoreFunction used in Stage1
-abinitio:stage2_patch 	        Supply patch file for the score1 ScoreFunction used in Stage2
-abinitio:stage3a_patch 	Supply patch file for the score2 ScoreFunction used in Stage3
-abinitio:stage3b_patch 	Supply patch file for the score5 ScoreFunction used in Stage3
-abinitio:stage4_patch 	        Supply patch file for the score3 ScoreFunction used in Stage4
-abinitio:skip_stages 1 2 3 4 	list all stages (1-4) that should be skipped (default=None)
-abinitio:recover_low_in_stages 1 2 3 4     after the sampling cycles of a given block are finished the 
                                            lowest scoring pose recorded during the sampling is recovered,
                                            use this flag to switch this off for individual stages
```

### Constraint and Jumping options

These flags are implemented in `ConstraintFragmentSampler.cc`
```
-constraints:cst_weight 1.0 	                Patches the weight for the ScoreType atom_pair_constraint in
                                                all scores (score0, score1, score2, score5 and score3) used
                                                for abinitio. This change is applied after patching via
                                                -stageX_patch.
-fold_cst:seq_sep_stages f1 f2 f3 	        Restraints and chainbreak-penalties are considered based on
                                                their sequence separation. The maximum sequence separation an
                                                active restraint can have is slowly ramped up. The target values
                                                for the ramping can be controlled for the end-points of stage
                                                2, 3 and 4, and are given as fraction of total length of
                                                protein (default=0.15, 1.0, 1.2).
-fold_cst:skip_on_noviolation_in_stage1         In Stage1 the maximum restraint sequence separation is incremented 
                                                in steps of 2 residues. After each increment a block of sampling 
                                                cycles is performed. This option allows to terminate (or skip) 
                                                sampling no restraint is violated at a given time.
-constraint:threshold 	                        control the threshold above which a constraint is violated (default=1).
-fold_cst:no_recover_low_at_constraint_switch 	When new constraints are turned (seq_sep_stages) the MonteCarlo object
                                                has to be reset and the previously found lowest energy pose will be lost.
                                                To avoid loosing this information, we usually carry out a recover_low
                                                before switching on new constraints. Use this flag to avoid this extra
                                                recover_low.
-jumps:ramp_chainbreaks 	                smoothly ramp up the weights for ScoreTypes linear_chainbreak and
                                                overlap_chainbreak (recommended, default=true).
-jumps:increase_chainbreak 	                factor for the ramping of chainbreaks (default=1.0).
-jumps:overlap_chainbreak 	                use the overlap chainbreak in stage4 (recommended, default=false).
-jumps:chainbreak_weight_stage1 	        Set the weight for ScoreType linear_chainbreak for Stage1. 
                                                Irrelevant if ramping of chainbreaks is active.
-jumps:chainbreak_weight_stage2 	        Set the weight for ScoreType linear_chainbreak for Stage2. 
                                                Irrelevant if ramping of chainbreaks is active.
-jumps:chainbreak_weight_stage3 	        Set the weight for ScoreType linear_chainbreak for Stage3. 
                                                Irrelevant if ramping of chainbreaks is active.
-jumps:chainbreak_weight_stage4 	        Set the weight for ScoreType linear_chainbreak for Stage4. 
                                                Irrelevant if ramping of chainbreaks is active.
```

### Processing options

For running multiple jobs on a cluster the following options are useful:

```
-constant_seed 	        Use a constant seed (1111111 unless specified with -jran)
-jran 1234567 	        Specify seed. Should be unique among jobs (requires -constant_seed)
-seed_offset 10 	This value will be added to the random number seed. Useful when using 
                        time as seed and submitting many jobs to a cluster. If jobs are started 
                        in the same second they will still have different initial seeds when using 
                        a unique offset. If using Condor (http://www.cs.wisc.edu/condor), the Condor 
                        process id, $(Process), can be used for this. 
                        For example "-seed_offset $(Process)" can be used in the condor submit file.
-run:dry_run 	        no sampling cycles, just initialize all objects (for testing, default=False)
-run:test_cycles 	only a single sampling cycle per stage (for testing, default=False)
```

## Source Code 

The top-level mover that encodes the abrelax protocol is called AbrelaxMover and resides in `main/source/src/protocols/abinitio`.

This top-level mover calls the Movers for the fragment assembly protocol (abinitio), and relax protocol. If beta-strand jumping is used non-natural chainbreaks have to be closed, and the AbrelaxMover will the protocols for loop-closing and idealize before the relax stage.

The fragment assembly protocol is encoded in the Movers FragmentSampler and its derived class ConstraintFragmentSampler which reside in `main/source/src/protocols/abinitio`.

The AbrelaxMover works closely together with the [[TopologyBroker|BrokeredEnvironment]] module that resides in `main/source/src/protocols/topology_broker`. The TopologyBroker module handles the introduction of restraints, and then determines the kinematics of beta-strands through its ConstraintClaimer and TemplateJumpClaimer classes, respectively.


#See Also

* [Ab initio Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/denovo_structure_prediction/Denovo_structure_prediction)
* [Protein Folding using the Broker Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_denovo_structure_prediction/folding_tutorial)
* [[Abinitio relax]]: Main page for this application
* [[Fasta file]]: Fasta file format
* [[Fragment file]]: Fragment file format (required for abinitio structure prediction)
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
  * [[NonlocalAbinitio]]: Application for predicting protein structure given some prior structural information
  * [[Membrane abinitio]]: Ab initio for membrane proteins.  
  - [[Comparative modeling|minirosetta-comparative-modeling]]: Build structural models of proteins using one or more known structures as templates for modeling (uses the minirosetta application).
    * [[Minirosetta]]: More information on the minirosetta application.
  * [[Metalloprotein ab initio|metalloprotein-abrelax]]: Ab inito modeling of metalloproteins.  
  - [[Backrub]]: Create backbone ensembles using small, local backbone changes.  
  - [[Floppy tail]]: Predict structures of long, flexible N-terminal or C-terminal regions.
  - [[Fold-and-dock]]: Predict 3-dimensional structures of symmetric homooligomers.  
  - [[Molecular replacement protocols|mr-protocols]]: Use Rosetta to build models for use in X-ray crystallography molecular replacement.  
    * [[Prepare template for MR]]: Setup script for molecular replacement protocols.  
  - [[Relax]]: "Locally" optimize structures, including assigning sidechain positions.
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files