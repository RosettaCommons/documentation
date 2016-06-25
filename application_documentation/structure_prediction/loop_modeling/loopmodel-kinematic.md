#Kinematic loop modeling

#NOTE: KIC is deprecated. Use [[next generation KIC]] or [[KIC with fragments|KIC_with_fragments]] instead.

Metadata
========

Author: Daniel J. Mandell, Roland A. Pache, Amelie Stein

This document was last updated October 10, 2012 by Amelie Stein. The corresponding PIs for this application are Tanja Kortemme (kortemme@cgl.ucsf.edu) and Evangelos A. Coutsias (coutsias@unm.edu).

An introductory tutorial on loop modeling can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/loop_modeling/loop_modeling).

Code and Demo
=============

The current application for this method (in Rosetta 3.4) is `       bin/loopmodel.<my_os>gccrelease      ` . The major protocol movers are `       src/protocols/moves/KinematicMover      ` , which performs a localized kinematic perturbation to a peptide chain, `       src/protocols/loops/loop_mover/perturb/LoopMover_KIC      ` and `       src/protocols/loops/loop_mover/refine/LoopMover_KIC      ` , which wrap the KinematicMover into a Monte Carlo protocol for loop modeling, and `       src/protocols/comparative_modeling/LoopRelaxMover      ` , which allows the protocols in LoopMover\_KIC to be combined with other loop modeling protocols. A basic usage example that briefly remodels an 8-residue loop is the `       kinematic_looprelax      ` integration test, which resides at `       main/tests/integration/tests/kinematic_looprelax      ` .

For reproducing the benchmark results for dataset 1 and 2 of the Mandell *et al.* (2009) paper (see reference below), please checkout Rosetta revision 24219 from the subversion system. In this older version of Rosetta, the kinematic loop modeling application is `       bin/loop_test.<my_os>gccrelease      ` . Being a pilot app, for proper compilation, please ensure that in the file `       src/pilot_apps.src.settings.all      ` the application `       loop_test      ` is not commented out and then compile Rosetta, using the `       scons.py      ` script from the current Rosetta distribution (Rosetta 3.3) with the command line

```
scons.py bin mode=release pilot_apps_all
```

This version of the kinematic loop modeling application also uses different flags than the current version implemented in Rosetta 3.3 (see below for details).

References
==========

A description of the kinematic loop modeling protocol, the geometric steps taken by the protocol, and results showing 0.9 Å median accuracy in *de novo* reconstruction of 45 12-residue loops in protein monomers, and similar accuracy in modeling conformational changes of protein interface loops can be found here:

-   Mandell DJ, Coutsias EA, Kortemme T. (2009). Sub-angstrom accuracy in protein loop reconstruction by robotics-inspired conformational sampling. *Nature Methods* 6(8):551-2.

More detail on the underlying principles of the kinematic closure algorithm can be found here:

-   Coutsias EA, Seok C, Wester MJ, Dill KA. (2005). Resultants and loop closure. *International Journal of Quantum Chemistry* . 106(1), 176–189.

An application using KIC to predict the sequences tolerated in a high-affinity antibody-antigen interface is described here:

-   Babor M, Mandell DJ, Kortemme T. (2010). Assessment of flexible backbone protein design methods for sequence library prediction in the therapeutic antibody Herceptin-HER2 interface. *Protein Sci.* . 20(6):1082-1089.

Purpose
=======

Kinematic closure (KIC) is an analytic calculation inspired by robotics techniques for rapidly determining the possible conformations of linked objects subject to constraints. In the Rosetta KIC implementation, 2 *N* - 6 backbone torsions of an *N* -residue peptide segment (called non-pivot torsions) are set to values drawn randomly from the Ramachandran space of each residue type, and the remaining 6 phi/psi torsions (called pivot torsions) are solved analytically by KIC. This formulation allows for rapid sampling of large conformational spaces. If `       -loops:vicinity_sampling      ` is set, the non-pivot torsions are sampled around their starting values by `       -loops:vicinity_degree      ` degrees to focus sampling around the starting conformation, rather than drawing random Ramachandran values for larger perturbations.

The KIC loop modeling protocols are used to address either of two general problems:

-   **Loop reconstruction:** The *de novo* prediction of the conformation of a peptide segment given its sequence, where the initial backbone and side-chain conformations are discarded
-   **Loop refinement:** Finding low-energy conformations for a given peptide conformation and sequence

These protocols are useful for several tasks including predicting loop conformations in comparative modeling, predicting conformational changes upon binding in protein-protein interfaces, and pre-generating loop conformations for docking with receptor flexibility.

It is also possible to use the KIC protocols for a number of new applications (see [New things since last release](#New-things-since-last-release) below):

-   Simultaneous modeling of multiple loops
-   Iterative flexible backbone design, where sequence design and KIC backbone moves are interleaved
-   Generation of whole-protein conformational ensembles, where KIC moves are applied to an entire structure (not just loop segments)

Although this documentation refers to modeling loop regions, in practice KIC protocols can be applied to any protein segments at least 3 residues in length.

Quick Start Example
===================

The following command lines will perform a *de novo* reconstruction of a protein loop (the starting coordinates will be discarded and the loop will be modeled from scratch), followed by all-atom refinement with extra rotamers. In order to discard the starting coordinates of the loop, be sure the 'Extend loop' field in the loop definition file is set to '1' (see [Input Files](#Input-Files) ).

Using Rosetta 3.4:

```
rosetta/main/source/bin/loopmodel.<my_os>gccrelease -database <rosetta_database_path> -loops:remodel perturb_kic -loops:refine refine_kic -in:file:s <my_starting_structure>.pdb -in:file:fullatom -loops:loop_file <my_loopfile>.loop -nstruct <num_desired_models> -ex1 -ex2 -overwrite
```

Using the old version of Rosetta (Rosetta revision 24219) from the original publication by Mandell *et al.* (2009, see [References](#References) ):

```
rosetta/mini/bin/loop_test.<my_os>gccrelease -database <rosetta_database_path> -loops:kinematic -loops:nonpivot_torsion_sampling -loops:template_pdb <my_starting_structure>.pdb -in:file:fullatom -loops:loop_file <my_loopfile>.loop -nstruct <num_desired_models> -ex1 -ex2 -out:file:fullatom -overwrite
```

Protocol
========

There are two stages to the KIC loop modeling protocol: **remodel** , activated by `       -loops:remodel perturb_kic      ` and **refine** , activated by `       -loops:refine refine_kic      ` , which may be invoked seperately or sequentially by command line flags.

Remodel stage overview
----------------------

The remodel stage is used for fast, broad sampling of backbone conformations, usually for the purpose of remodeling or reconstructing peptide segments. This stage samples backbone conformations of each loop defined in the loop definition file independently using a reduced (centroid) representation of side-chains and the Rosetta low-resolution scoring function. This stage is activated by `       -loops:remodel perturb_kic      ` . If the 'extend loop' field of the loop definition is set to '1' (see [Input Files](#Input-Files) ), the loop will first be placed into a random closed conformation with idealized bond lengths, bond angles, and omega angles. Otherwise, the input conformation is used as the starting structure. Each loop is then subject to a single cycle of simulated annealing Monte Carlo.

Remodel stage details
---------------------

Each step in the remodel Monte Carlo cycle consists of a kinematic closure move applied to the loop, followed by a line minimization of the loop phi/psi torsions, and a test for acceptance by the Metropolis criterion using the Rosetta `       score4L      ` low-resolution scoring function. The number of Monte Carlo steps is determined by the `       outer_cycles      ` \* `       inner_cycles      ` . The number of `       outer_cycles      ` is set by `       -loops:refine_outer_cycles      ` . The number of inner cycles is `       min( 1000, number_of_loop_residues * 20 )      ` , or is set to `       -loops:max_inner_cycles      ` if provided. At the end of each outer cycle, the pose is set to the lowest energy conformation observed so far in the simulation, unless the flag `       -loops:kic_recover_last      ` is set, in which case the last accepted conformation passes on to the next outer cycle. From the first step to the last, the temperature decreases exponentially from `       -loops:remodel_init_temp      ` to `       -loops:remodel_final_temp      ` .

Refine stage overview
---------------------

The refine stage is used to find predicted low energy conformations of peptide segment, given a starting conformation. This stage can be used, for example, to refine homology models, or to allow backbones to adjust in response to sequence mutations. In this stage, side-chains are represented in all-atom detail, and together with backbone conformations are evaluated by Rosetta's high-resolution scoring function.

Refine stage details
--------------------

The refine stage uses Rosetta's all-atom respresentation and high-resolution scoring function ( `       score12      ` with an upweighted chain break term). This stage is invoked by `       -loops:refine refine_kic      ` . At the beginning of this stage, unless the flag `       -loops:fix_natsc      ` is provided, all residues within the neighbor distance of a loop (defined by `       -loops:neighbor_dist      ` ) are repacked and then subject to rotamer trials. The backbones of all loop residues, and the side-chains of all loop residues and neighbors are then subject to energy minimization (using the DFP algorithm). If `       -loops:fix_natsc      ` is set, only the loop residues (and not the neighbors) will be subject to repacking, rotamer trials, and minimization. Consequently, if this stage has been preceeded by the centroid stage, and the `       -loops:fix_natsc      ` flag is omitted, the side-chains surrounding the loop will be optimized for the perturbed loop conformation, rather than the starting loop conformation, which provides a more challenging task for benchmarking purposes, since the wild-type neighboring side-chains must be reconstructed in addition to the loop backbone and side-chain conformations. The simulation then proceeds through a single cycle of simulated annealing Monte Carlo, following the same scheduling as the centroid stage, except that two rounds of kinematic closure moves are attempted per inner cycle, and if `       -loops:max_inner_cycles      ` is not set, the number of inner cycles is `       min( 200, 10 * total_number_loop_residues )      ` . Here, the number of loop residues includes all the loop definitions (if multiple loops are defined), because refine-stage kinematic closure moves are applied randomly to any of the loops. After each kinematic move, the loop and neighbor residues are subject to rotamer trials, and DFPmin is applied to the loop backbone, and loop and neighbor side-chains. Every `       repack_cycle      ` , which is set by `       -loops:repack_period      ` , all of the loop and neighbor side-chains are repacked. For all of these optimizations, if the `       -loops:fix_natsc      ` flag is set, the neighbor residues will remain fixed, and only the loop residues will be subject to rotamer trials, minimization, and repacking. From the first step to the last, the temperature decreases exponentially from `       -loops:refine_init_temp      ` to `       -loops:refine_final_temp      ` .

Protocol usage
--------------

For ***de novo* reconstruction** of protein loops, use both `       -loops:remodel perturb_kic      ` and `       -loops:refine refine_kic      ` , with the 'extend loop' field in the loop definition file set to '1'.

For **loop refinement** , just use `       -loops:refine refine_kic      ` .

For details on the geometric steps taken by the underlying kinematic solver, please see the supplementary material of Mandell *et al.* referenced above.

In Rosetta revision 24219 used in the original publication by Mandell *et al.* (2009, see [References](#References) ), these flags did not exist yet. Instead, in that Rosetta version there is a flag `       -loops:kinematic      ` , which activates the KIC method in both the remodel and refine stages.

Limitations
===========

By definition, KIC moves are local perturbations, so the C-alpha atoms of start and end residues in loop definitions stay fixed. Loop definitions may include the N- and/or C-termini of monomeric proteins, and the C-alpha atoms of the termini will remain fixed (i.e., KIC loop modeling cannot be used to sample conformations of terminal residues themselves without adding 'virtual' residues to the termini). For terminal definitions in protein complexes, please see the note in *Whole protein ensemble generation* under [New things since last release](#New-things-since-last-release).

Input Files
===========

The following files are required for kinematic loop modeling:

-   Starting PDB file, specified by `-in:file:s`. The starting structure must have real coordinates for all residues outside the loop definition, plus the first and last residue of each loop region. In Rosetta revision 24219 used in the original publication by Mandell *et al.* (2009, see [References](#References) ), this flag is called `        -loops:template_pdb       ` instead.

-   Loop definition file, specificied by `        loops:loop_file       ` and shared across all loop modeling protocols. For each loop to be modeled, include the following on one line:

    ```
    column1  "LOOP":     The loop file identify tag
    column2  "integer":  Loop start residue number
    column3  "integer":  Loop end residue number
    column4  "integer":  Cut point residue number, >=startRes, <=endRes. default - let the loop modeling code choose cutpoint. 
                         Note: Setting the cut point outside the loop can lead to a segmentation fault. 
    column5  "float":    Skip rate. default - never skip
    column6  "boolean":  Extend loop. Default false. Setting this flag to 1 leads to randomization of the loop conformation before KIC sampling, 
                         using idealized bond lengths and angles. This is important for loop reconstruction benchmarks to ensure a starting loop 
                         conformation that is different from the original one, as well as for <em>de novo</em> loop construction/insertion with KIC, 
                         to create a connected starting loop conformation from single unconnected loop residues 
                         (see tutorial at rosetta/demos/public/model_missing_loop/). 
    ```

    An example loop definition file can be found at `        test/integration/tests/kinematic_looprelax/input/4fxn.loop       ` , which looks like this:

    ```
    LOOP 88 95 92 0 1
    ```

**NOTE:** Residue indices in loop definition files refer to *Rosetta numbering* (numbered continuously from '1', including across multi-chain proteins). It may be useful to renumber starting structures with Rosetta numbering so loop defintions and PDB residue indices agree.

Options
=======

-   The following options are used to activate KIC and must be present in the command line (one or both of `        -loops:remodel       ` or `        -loops:refine       ` are required):

    ```
    -database                       Path to the Rosetta database. [Path]
    -loops:remodel                  Selects a protocol for the centroid remodeling stage.
                                    Legal values: 'perturb_kic','perturb_ccd','quick_ccd','quick_ccd_moves','old_loop_relax','no'.
                                    default = 'quick_ccd'. For KIC, use 'perturb_kic'. [String]
    -loops:refine                   Selects the all-atom refinement stage protocol.
                                    Legal values: 'refine_kic','refine_ccd','no'. default = 'no'. For KIC, use 'refine_kic'. [String]
    -loops:loop_file                Path/name of loop definition file. default = 'loop_file'. [File]
    ```

-   The following general Rosetta options are commonly used with KIC:

    ```
    -in:file:s                      Path/name of input pdb file. [File]
    -in:file:native                 Path/name of native pdb file. Backbone rmsd to this structure will be reported in each output decoy.
                                    If no native structure is provided, the protocol will return an rmsd of 0. [File]
    -in:file:fullatom               Read the input structure in full-atom mode. Set this flag to avoid discarding the native side chains and repacking the input structure
                                    before modeling (KIC refine alway begins by repacking the loop side-chains,
                                    including the neighboring side-chains if -loops:fix_natsc is 'false'). default = 'false'. [Boolean]
    -loops:fix_natsc                Don't repack, rotamer trial, or minimize loop residue neighbors. default = 'false'. [Bolean]
    -ex1 (-ex2, -ex3, -ex4)         Include extra chi1 rotamers (or also chi2, chi3, chi4). Using -ex1 -ex2 improves benchmark performance.  
    -extrachi_cutoff 0              Set to 0 to include extra rotamers regardless of number of neighbors
    -extra_res_cen                  Path to centroid parameters file for non-protein atoms or ligands. Note that this is required for structures with ligands even if only full-atom remodeling is performed.
    -extra_res_fa                   Path to all-atom parameters file for non-protein atoms or ligands
    -overwrite                      Overwrite existing models (Rosetta will not output without this flag if same-named model exists)
    -out:pdb_gz                     Create compressed output PDB files (using gzip), which saves a lot of space. These files can still be 
                                    visualized normally with software such as Pymol. 
    ```

-   The following 'expert' options may be used to customize the behavior of KIC:

    ```
    -loops:cen_weights          Centroid weight set to be used; use of smooth weights is strongly recommended when bicubic interpolation is used, which is now active by default. [String]
    -loops:cen_patch            Optional patch for centroid weights. [String]
    -loops:neighbor_dist            Only optimize side-chains with C-beta atoms within this many angstroms of any loop C-beta atom.
                                    default = '10.0'. To speed up runs, try '6.0'. [Float]
    -loops:vicinity_sampling        Sample non-pivot torsions within a vicinity of their input values. default = 'false'.
                                    For a description of pivot and non-pivot torsions, please see Purpose, above. [Boolean]
    -loops:vicinity_degree          Number of degrees allowed to deviate from current non-pivot torsions when using vicinity sampling
                                    (smaller number makes tighter sampling). default = '1.0'. [Float]
    -loops:kic_max_seglen           Maximum number of residues in a KIC move segment. default = '12'. [Integer]
    -loops:remodel_init_temp        Initial temperature for simulated annealing in 'perturb_kic'. default = '2.0'. [Float]
    -loops:remodel_final_temp       Final temperature for simulated annealing in 'perturb_kic'. default = '1.0'. [Float]
    -loops:refine_init_temp         Initial temperature for simulated annealing in 'refine_kic'. default = '1.5'. [Float]
    -loops:refine_final_temp        Final temperature for simulated annealing in 'refine_kic'. default = '0.5'. [Float]
    -loops:max_kic_build_attempts   Number of times to attempt initial closure in 'perturb_kic' protocol.
                                    Try increasing to 1000000 if initial closure is failing. default = 10000. [Integer]
    -loops:refine_outer_cycles             Number of outer cycles for Monte Carlo (described above in Protocol). default = '3'. [Integer]
    -loops:max_inner_cycles         Maximum number of inner cycles for Monte Carlo (default described above in Protocol). [Integer]
    -loops:kic_recover_last         Keep the last sampled conformation at the end of each outer cycle instead of the lowest
                                    energy conformation sampled so far. default = 'false'. [Boolean]
    -loops:optimize_only_kic_
    region_sidechains_after_move    Should rotamer trials and minimization be performed after every KIC move but only within the
                                    loops:neighbor_dist of the residues in the moved KIC segment. Speeds up execution when using very
                                    large loop definitions (such as when whole chains are used for ensemble generation).
                                    default = 'false'. [Boolean]
    -loops:fast                     Signifcantly reduces the number of inner cycles. For quick testing, not production runs.
                                    default = 'false'. [Boolean]
    -run:test_cycles                Sets the number of outer cycles and inner cycles to 3. For extremely quick testing and
                                    sanity checks, not for production runs. default = 'false'. [Boolean]
    ```

-   Flags specific to Rosetta revision 24219 used in the original publication by Mandell *et al.* (2009, see [[References|next-generation-KIC#kic_refs]] ):

    ```
    -loops:template_pdb             Path/name of input pdb file.  [File]
    -loops:kinematic                Activates the KIC method for both remodel and refine stages. 
    -loops:output_pdb               Definition of the output path and PDB prefix. Note: In this old version of Rosetta, the 
                                    -out:pdb_gz and -out:path flags don't work. 
    ```

    **NOTE:** In this old version of the KIC protocol, an unlimited number of loop build attempts are performed.

Tips
====

For production runs, it is recommended to include `       -ex1      ` and `       -ex2      ` . To consistently reconstruct long loops (e.g., 12-residues or longer) to high accuracy, it is recommended to generate 1000 models by using `       -nstruct 1000      ` (or by running several smaller jobs over multiple processor cores). The KIC protocol was optimized for *de novo* reconstruction of 12-residue protein loops in different environments with different end-to-end distances. Shorter loops or largely buried peptide segments *may* require substantially fewer models. The KIC method was also shown to reconstruct 9 different 18-residue loops from SH3 domains to sub-angstrom accuracy, for which 5000 models were generated per case. On average, each model generated by the combined remodel and refine protocol shown in the [Quick Start Example](#Quick-Start-Example) section takes 15-20 minutes for a 12-residue loop on a single CPU-core, although the time required can vary depending on loop burial and amino acid composition.

If the starting structure includes non-protein ligands, it is required to convert these HETATMs into Rosetta atom types and include centroid (for remodel) and all-atom (for refine) parameter files via the `       -extra_res_cen      ` and `       -extra_res_fa      ` command lines. The script `       rosetta/main/source/scripts/python/public/molfile_to_params.py      ` may be used to create the all-atom parameter file (include the '-c' option to also generate the centroid parameter file). The mofile\_to\_params.py script requires an MDL Molfile of the ligand as input. OpenBabel may be used to convert PDB ligands to Molfiles.

KIC has also been used to generate backbone ensembles for flexible backbone design. A recent study found that designing on a backbone ensemble generated by KIC correctly predicted an average of 82% of amino acids across 17 positions observed in phage display experiments on the Herceptin-HER2 interface (for details see Babor *et al.* , referenced above). Loop definitions followed the description given in *Whole protein ensemble generation* under [New things since last release](#New-things-since-last-release) . The command line options were

```
loopmodel.linuxgccrelease -database <path/to/rosetta/main/database> -loops:refine refine_kic -loops:input_pdb structure.pdb -loops:loop_file modeling.loops -loops:outer_cycles 1 -loops:refine_init_temp 1.2 -loops:refine_final_temp 1.2 -loops:vicinity_sampling -loops:vicinity_degree 3 -loops:optimize_only_kic_region_sidechains_after_move -ex1 -ex2 -nstruct 100
```

**NOTE:** The input pdb is now specified through the job distributor, using `       -in:               file:s             ` instead of `       -loops:input_pdb      ` . The above commandline is kept as-is for historical interest.

Expected Outputs
================

Each output decoy contains information about the energy and rmsd of the model at the end of the file. If `       -in:::file:native      ` is provided, the reported rmsd is the backbone (N, Ca, C, O) rmsd to the native loop(s). If not, the reported rmsd is 0. Example output looks like this:

```
loop_cenrms: 3.49022 (rmsd to native/start after centroid stage)
loop_rms: 0.858667 (rmsd to native/start after all-atom stage)
total_energy: -389.076 (total score of the system)
chainbreak: 0.0254188 (score of the chainbreak term, smaller value means well-closed loops. should be < 1.0)
```

Pre-processing
==============

The KIC refine protocol will perform a repack of all residues within the neighbor distance of any loop before attempting any KIC moves. Note that off-rotamer side-chain conformations in the starting structure are included in the packer, but if they are ever replaced they are excluded from further consideration. See the [[fixbb documentation|fixbb]] to repack, redesign and/or minimize any or all side-chains in the starting structure if desired. For benchmarking purposes, the initial side-chains in Mandell *et al* . were discarded, repacked, and minimized before running the loopmodel application.

Post-processing
===============

For benchmarking purposes, creating a score *vs* rmsd plot across decoys and looking for near native 'energy funnels' is good way to test the performance of the protocols on a system, and can help to determine whether errors are due to scoring or sampling. For blind prediction and refinement, such plots can still be useful to look for convergence or multiple minima in the energy landscape. Decoys may also be pairwise-clustered to search for well-populated regions of conformational space that may represent alternative low-energy conformations. For more on analyzing loop modeling results, please see Mandell *et al.* and the accompanying supplemental referenced above.

Comparison to CCD Loop Modeling
===============================

The KIC loop modeling protocols were shown to improve median accuracy to the crystal structures of 45 12-residue loops to 0.9 Å backbone rmsd from 2.0 Å backbone rmsd using the CCD loop modeling protocols (please see Mandell *et al.* , referenced above). On average, the KIC protocols took 15% longer than the CCD protocols to produce 1000 decoys for each benchmark case.

New things since last release
=============================

The KIC protocols have been extended to perform additional tasks that have not yet been benchmarked.

-   *Modeling multiple loops* . To model multiple loops (or other regions in a protein) simply include multiple entries in the loop definition file. Each loop is modeled sequentially in the remodel stage, while in the refine stage loops are randomly selected from the loop definitions and iteratively refined.
-   *Iterative flexible backbone design* . If a `        -resfile       ` is added to the command line, the packer will include the specified residues for design every `        -loops:repack_period       ` cycles in the `        refine_kic       ` protocol. This feature can be used, for example, to redesign protein interfaces exhibiting conformational plasticity.
-   *Whole protein ensemble generation* . The loop definition file can specify regions of any size, including whole proteins. This procedure can also be applied to protein complexes, although it is necessary that the end of the first loop be set no further than the C-terminus of the first partner - 1 residue, and the start of the second loop be no earlier than the N-terminus of the second partner + 1 residue. Preliminary results on recapitulating the natural sequence variation of the ubquitin-like family by designing sequences on KIC ensembles suggest it may be useful to skip the centroid remodeling stage and include the flags `        -loops:outer_cycles 1 -loops:refine_init_temp 1.2 -loops:refine_final_temp 1.2 -loops:vicinity_sampling -loops:vicinity_degree 3` These parameters were also used to recover an average of 82% of residues observed in phage display experiments across 17 positions in the Herceptin-HER2 interface (see Babor *et al* ., above).

Calling the KIC protocols directly
==================================

Expert users may wish to call the KIC protocols from directly within their own protocols or applications. Code for setting up and using LoopMover\_KIC is in `       src/protocols/comparative_modeling/LoopRelaxMover.cc      ` . The key lines are reproduced here.

-   To read in the loop defintions:

    ```
    protocols::loops::Loops loops = protocols::loops::get_loops_from_file();
    ```

-   To setup the fold tree for loop modeling:

    ```
    core::kinematics::FoldTree f_new;
    protocols::loops::fold_tree_from_loops( pose, loops,  f_new, true );
    pose.fold_tree( f_new );
    ```

-   To run the remodel (centroid) stage:

    ```
    IndependentLoopMoverOP remodel_mover( static_cast< loops::IndependentLoopMover * >
       ( loops::get_loop_mover( "perturb_kic"), loops ).get() ) );
    remodel_mover->apply( pose );
    ```

-   To run the refine (all-atom) stage:

    ```
    protocols::loops::LoopMover_Refine_KIC refine_kic( loops );
    refine_kic.apply( pose );
    ```


##See Also

* [Loop Modeling Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/loop_modeling/loop_modeling)
* [[Loopmodel]]: The main loopmodel application page
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction, including loop modeling
* [[Fragment file]]: Fragment file format (required for abinitio structure prediction)
* [[Loops file]]: File format for specifying loops for loop modeling
* [[Loop modeling algorithms|loopmodel-algorithms]]
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
