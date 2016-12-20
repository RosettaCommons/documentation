#KIC with fragments

Metadata
=======

Author: Roland A. Pache

This document was last updated July 27, 2014 by Roland A. Pache. The corresponding PI for this application is Tanja Kortemme (kortemme@cgl.ucsf.edu). 

An introductory tutorial on modeling loops can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/loop_modeling/loop_modeling).

Code and Demo
===========

The current application for this method is `       bin/loopmodel.<my_os>gccrelease      ` . The protocol is based on Kale Kundert's refactored KIC code. The main classes are `    src/protocols/kinematic_closure/KicMover      ` , which performs a localized kinematic perturbation to a peptide chain, `       src/protocols/loop_modeling/LoopBuilder.cc      `, which now allows the use of fragment data for the initial loop build (after discarding the native loop conformation), `       src/protocols/kinematic_closure/perturbers/FragmentPerturber      `, which samples loop conformations using coupled phi/psi/omega torsions from the given frament libraries, and `       src/protocols/comparative_modeling/LoopRelaxMover      `, which allows the combination with other loop modeling protocols. A basic usage example that briefly remodels an 8-residue loop is the `       KIC_with_fragments      ` integration test, which resides at `       main/tests/integration/tests/KIC_with_fragments      `.


References
========

The reference for the KIC with fragments paper will be added once available. 

A description of the original kinematic loop modeling protocol can be found here:

-   Mandell DJ, Coutsias EA, Kortemme T. (2009). Sub-angstrom accuracy in protein loop reconstruction by robotics-inspired conformational sampling. *Nat Methods*. 2009 Aug;6(8):551-2. doi: 10.1038/nmeth0809-551. PMID: 19644455

More detail on the underlying principles of the kinematic closure algorithm can be found here:

-   Coutsias EA, Seok C, Wester MJ, Dill KA. (2005). Resultants and loop closure. *International Journal of Quantum Chemistry* . 106(1), 176–189.


Purpose
======

Loop modeling using KIC with fragments has several important applications in structural biology, including predicting loop conformations in comparative modeling or the conformation of unresolved loops in crystal structures, predicting conformational changes upon binding in protein-protein interfaces, pre-generating loop conformations for docking with receptor flexibility and generating whole-protein conformational ensembles (the heterogeneity of the ensemble will depend on the heterogeneity of the given fragment libraries). Conceptually, the two major protocol variants to distinguish here are:

-   **Loop reconstruction:** The *de novo* prediction of the conformation of a peptide segment given its sequence, where the initial backbone and side-chain conformations are discarded
-   **Loop refinement:** Finding low-energy conformations for a given peptide conformation and sequence

Although this documentation refers to modeling loop regions, in practice the KIC with fragments protocol can be applied to any protein segments at least 3 residues in length, given the availability of fragment data (which can be generated for any amino acid sequence of interest, using either the free [Robetta web server](http://robetta.bakerlab.org/) or the [[fragment picker application|app-fragment-picker]]; see [[Using Fragment Files in Rosetta|fragment-file]] for details).


Quick Start Example
==============

The following command line will perform a *de novo* reconstruction of a protein loop (the starting coordinates will be discarded and the loop will be modeled from scratch), followed by all-atom refinement with extra rotamers. In order to discard the starting coordinates of the loop, be sure the 'Extend loop' field in the loop definition file is set to '1' (this ensures that an initial loop build is performed and idealizes loop bond lengths and angles; for details see [Input Files](#Input-Files) and [Options](#Options)).

```
rosetta/main/source/bin/loopmodel.<my_os>gccrelease -database </path/to/rosetta/main/database> -loops:remodel perturb_kic_with_fragments
-loops:refine refine_kic_with_fragments -in:file:s <my_starting_structure>.pdb -in:file:fullatom -loops:loop_file
<my_loopfile>.loop -nstruct <num_desired_models> -ex1 -ex2 -overwrite -loops:frag_sizes 9 3 1 -loops:frag_files 
<my_starting_structure>.200.9mers.gz <my_starting_structure>.200.3mers.gz none     
```


Algorithm
=======

Kinematic closure (KIC) is an analytic calculation inspired by robotics techniques for rapidly determining the possible conformations of linked objects subject to constraints. In the KIC with fragments protocol, coupled phi/psi/omega torsion angles from consecutive residues in protein fragments (by default 9mers, 3mers or 1mers) are used to sample all but 6 torsional degrees of freedom. Those remaining 6 torsions (the phi/psi dihedral angles of the 3 pivot residues), are solved analytically by KIC. This formulation allows for rapid sampling of large conformational spaces. (In contrast to [[KIC|loopmodel-kinematic]] and [[next generation KIC|next-generation-KIC]], the vicinity sampling flags do not apply, since non-pivot torsions are always picked from fragment data. )

For details on the geometric steps taken by the underlying kinematic solver, please see the supplementary material of Mandell *et al.* referenced above.

There are two stages to the KIC with fragments loop modeling protocol: **remodel** , activated by `       -loops:remodel perturb_kic_with_fragments      ` and **refine** , activated by `       -loops:refine refine_kic_with_fragments      ` , which may be invoked seperately or sequentially by command line flags.

Remodel stage 
------------

The remodel stage is used for fast, broad sampling of backbone conformations, usually for the purpose of remodeling or reconstructing peptide segments. This stage samples backbone conformations of each loop defined in the loop definition file independently using a reduced (centroid) representation of side-chains and the Rosetta low-resolution scoring function. This stage is activated by `       -loops:remodel perturb_kic_with_fragments      ` . If the 'extend loop' field of the loop definition file is set to '1' (see [Input Files](#Input-Files)), the loop will first be placed into a random closed conformation after idealizing bond lengths, bond angles, and omega torsions. Otherwise, the input conformation is used as the starting structure. Each loop is then subject to a single cycle of simulated annealing Monte Carlo.

During the initial loop build, first all loop bond lengths, angles and omega torsions are idealized. Then all loop phi/psi torsions are replaced with random values from Ramachandran space to ensure that all native loop information is discarded. Finally, phi/psi/omega torsions are sampled using fragment data, followed by kinematic closure of the loop. The flag `-loops:max_kic_build_attempts` determines the maximum number of attempts that are made to find a closed loop conformation. 
Each step in the subsequent remodel simulated annealing Monte Carlo cycle consists of fragment-based sampling on a random loop subsegment, followed by kinematic closure, minimization of the loop phi/psi torsions (using the BFGS algorithm (dfpmin)), and a test for acceptance by the Metropolis criterion using the Rosetta `       score4L      ` low-resolution scoring function. The number of Monte Carlo steps is determined by the number of `       outer_cycles      ` \* `       inner_cycles      ` . The number of `       outer_cycles      ` is set by `       -loops:refine_outer_cycles      ` (default=5). The number of inner cycles is `       min( 1000, number_of_loop_residues * 20 )      ` , or is set to `       -loops:max_inner_cycles      ` if provided. At the end of each outer cycle, the pose is set to the lowest energy conformation observed so far in the simulation. (The `       -loops:kic_recover_last      ` flag, which would pass the last accepted conformation to the next outer cycle, has not yet been implemented in the refactored KIC code on which KIC with fragments is based. ) From the first step to the last, the temperature decreases exponentially from 1.5 KT to 0.5 KT. (The flags `       -loops:remodel_init_temp      ` and `       -loops:remodel_final_temp      `, which would control the start and end temperature, have not yet been implemented in the refactored KIC code. )

The fragment-based sampling of phi/psi/omega torsions consists of a sequence of six different steps: (i) one of the given input fragment libraries is selected at random; (ii) that library is being searched for fragment alignment frames that overlap with the given loop subsegment; (iii) one of those alignment frames is randomly chosen; (iv) one of the fragments contained in that alignment frame is selected at random; (v) the phi/psi/omega torsions of that fragment are applied to the respective region of the loop subsegment; and (vi) kinematic closure (KIC) is used to close the loop. 

Refine stage 
-----------

The refine stage is used to find predicted low energy conformations of peptide segments, given a starting conformation. This stage can be used, for example, to refine homology models. In this stage, side-chains are represented in all-atom detail, and together with backbone conformations are evaluated by Rosetta's high-resolution scoring function (currently `Talaris2013` as of July 2014), with an upweighted chain break term.

This stage is invoked by `       -loops:refine refine_kic_with_fragments      ` . At the beginning of this stage, all residues within 10 Angstrom of the loop are repacked and subject to rotamer trials. The backbones and side-chains of all loop residues, as well as the side-chains of all neighbors are then subject to energy minimization (using the BFGS algorithm (dfpmin)). (The flags `       -loops:fix_natsc      `, which would preserve the native side chain conformations of all residues in the loop neighborhood, and `       -loops:neighbor_dist      `, which could be used to change the neighborhood distance cutoff, are not yet implemented in the refactored KIC code. ) Consequently, if this stage has been preceeded by the centroid stage, the side-chains surrounding the loop will be optimized for the perturbed loop conformation, rather than the starting loop conformation, which provides a more challenging task for benchmarking purposes, since the wild-type neighboring side-chains must be reconstructed in addition to the loop backbone and side-chain conformations. The simulation then proceeds through a single cycle of simulated annealing Monte Carlo, following the same scheduling as the centroid stage, except that two rounds of kinematic closure moves are attempted per inner cycle, and if `       -loops:max_inner_cycles      ` is not set, the number of inner cycles is `       min( 200, 10 * total_number_loop_residues )      ` . Here, the number of loop residues includes all the loop definitions (if multiple loops are defined), because refine-stage kinematic closure moves are applied randomly to any of the loops. After each kinematic move, the loop and neighbor residues are subject to rotamer trials, and the loop backbone, as well as the loop and neighbor residue side-chains are minimized. Every repack_cycle, which is set by `       -loops:repack_period      ` (default=20), all of the loop and neighbor residue side-chains are repacked. (For all of these optimizations, once the `       -loops:fix_natsc      ` flag is implemented in the refactored KIC code, the neighbor residues would remain fixed, and only the loop residues would be subject to rotamer trials, repacking and minimization. From the first step to the last, the temperature again decreases exponentially from 1.5 KT to 0.5 KT. (The flags `       -loops:refine_init_temp      ` and `       -loops:refine_final_temp      `, which would control the start and end temperature, have not yet been implemented in the refactored KIC code. )

The fragment-based sampling of phi/psi/omega torsions consists of the same sequence of six different steps described above for the remodel stage: (i) one of the given input fragment libraries is selected at random; (ii) that library is being searched for fragment alignment frames that overlap with the given loop subsegment; (iii) one of those alignment frames is randomly chosen; (iv) one of the fragments contained in that alignment frame is selected at random; (v) the phi/psi/omega torsions of that fragment are applied to the respective region of the loop subsegment; and (vi) kinematic closure (KIC) is used to close the loop.  

Protocol usage
-------------

For ***de novo* reconstruction** of protein loops, use both `       -loops:remodel perturb_kic_with_fragments      ` and `       -loops:refine refine_kic_with_fragments      ` , with the 'extend loop' field in the loop definition file set to '1'.

For **loop refinement** , just use `       -loops:refine refine_kic_with_fragments      ` .


Limitations
========

By definition, KIC moves are local perturbations, so the C-alpha atoms of start and end residues in loop definitions stay fixed. Loop definitions may include the N- and/or C-termini of monomeric proteins, and the C-alpha atoms of the termini will remain fixed (i.e., KIC loop modeling cannot be used to sample conformations of terminal residues themselves without adding 'virtual' residues to the termini). 


Input Files
========

The following files are required for KIC with fragments:

-   Starting PDB file, specified by `-in:file:s` or `-s`. The starting structure must have real coordinates for all residues outside the loop definition, plus the first and last residue of each loop region (side-chains can be reconstructed by Rosetta if there is missing electron density, but all backbone atoms must have well-defined coordinates).

-   Loop definition file, specified by `        -loops:loop_file       ` and shared across all loop modeling protocols. For each loop to be modeled, include the following on one line:

    ```
    column1  "LOOP":     The loop file identify tag
    column2  "integer":  Loop start residue number
    column3  "integer":  Loop end residue number
    column4  "integer":  Cut point residue number, >=startRes, <=endRes. Default: 0 (let the loop modeling code 
                         choose the cutpoint) 
                         Note: Setting the cut point outside the loop can lead to a segmentation fault. 
    column5  "float":    Skip rate. Default: 0 (never skip modeling this loop)
    column6  "boolean":  Extend loop (i.e. discard the native loop conformation and rebuild the loop from scratch,
                         idealizing all bond lengths and angles). Default: 0 (false). It is important for loop
                         reconstruction benchmarks to set this flag to 1 to ensure a starting loop conformation 
                         that is different from the original one, as well as for de novo loop construction/
                         insertion to create a connected starting loop conformation from single unconnected loop 
                         residues 
    ```

    An example loop definition file can be found at `        tests/integration/tests/KIC_with_fragments/inputs/4fxn.loop       ` , which looks like this:

    ```
    LOOP 88 95 92 0 1
    ```

    **NOTE:** Residue indices in loop definition files refer to *Rosetta numbering* (numbered continuously from '1', including across multi-chain proteins). It may be useful to renumber starting structures with Rosetta numbering so loop definitions and PDB residue indices agree.

-   Fragment libraries, specified by the flags `-loops:frag_sizes`, which defines the number of residues per fragment (commonly used are `9 3 1` to utilize 9mers, 3mers and 1mers during sampling), and `-loops:frag_files`, which defines the path to and name of the respective fragment libraries. Those files can be generated for any amino acid sequence of interest, using either the free [[Robetta web server|http://robetta.bakerlab.org/]] or the [[fragment picker application|app-fragment-picker]]; see [[Using Fragment Files in Rosetta|fragment-file]] for details). When `none` is specified as the name of the 1mers fragment library, 1mer fragments will be automatically generated from the given 3mers fragment data. 


Options
=======

-   The following options are used to activate KIC with fragments and must be present in the command line (one or both of `        -loops:remodel       ` or `        -loops:refine       ` are required):

    ```
    -database                                   Path to the Rosetta database. [Path]
    -loops:remodel perturb_kic_with_fragments   Selects the KIC with fragments protocol for the centroid remodeling stage.
    -loops:refine refine_kic_with_fragments     Selects the KIC with fragments protocol for the all-atom refinement stage. 
    -loops:loop_file                            Path/name of loop definition file. [File]
    -loops:frag_sizes                           Defines the number of residues per fragment for the following set
                                                of fragment libraries (e.g. 9 3 1). 
    -loops:frag_files                           Paths/names of the respective fragment libraries. [Files]
    ```

-   The following option is recommended to suppress output of fragment sampling details to stdout:
    ```
    -mute protocols.looprelax.FragmentPerturber Mutes FragmentPerturber output of sampling details. 
    ```

-   The following general Rosetta options are commonly used with KIC with fragments:

    ```
    -in:file:s           Path/name of input pdb file. [File]
    -in:file:native      Path/name of native pdb file. Backbone rmsd to this structure will be reported in 
                         each output decoy. [File]
    -in:file:fullatom    Read the input structure in full-atom mode. Set this flag to avoid discarding the 
                         native side chains and repacking the input structure before modeling (the refine stage 
                         always begins by repacking the loop and neighboring side-chains). Default = 'false'. [Boolean]
    -ex1 -ex2            Include extra chi1 and chi2 rotamers during packing and rotamer trials. 
                         This improves benchmark performance. 
    -extrachi_cutoff 0   Include extra rotamers regardless of number of neighbors. This can lead to more accurate 
                         side-chain conformations, but slightly decreases benchmark performance. 
    -extra_res_cen       Path to centroid parameters file for non-protein atoms or ligands. Note that this is 
                         required for structures with ligands even if only full-atom remodeling is performed.
    -extra_res_fa        Path to all-atom parameters file for non-protein atoms or ligands. 
    -overwrite           Overwrite existing models (Rosetta will not output without this flag if same-named model exists). 
    -out:pdb_gz          Create compressed output PDB files (using gzip), which saves a lot of space. 
                         These files can still be visualized normally with software such as Pymol. 
    ```

-   The following 'expert' options may be used to customize the behavior of KIC with fragments:

    ```
    -loops:max_kic_build_attempts   Number of times to attempt initial loop closure in the perturb stage.
                                    Try increasing to 1000000 if initial closure is failing. Default = 10000. [Integer]
    -loops:skip_initial_loop_build  This option allows to run KIC with fragments in both centroid and fullatom mode, but
                                    without building the loop from scratch first. This can be useful for broad sampling 
                                    of the given loop in the vicinity of its native conformation or for backbone ensemble
                                    generation, where using fullatom refinement only would lead to ensembles of too low
                                    conformational diversity. When modeling several loops simultaneously, if the initial
                                    loop build should be skipped for only a subset of loops, instead set the given loop 
                                    extend flag in the loop file to 0. 
    -loops:outer_cycles             Number of outer cycles for Monte Carlo (described above in Algorithm).
                                    Default = 5. [Integer]
    -loops:max_inner_cycles         Maximum number of inner cycles for Monte Carlo (described above in Algorithm). [Integer]
    -loops:fast                     Significantly reduces the number of inner cycles. For quick testing, 
                                    not production runs. Default = 'false'. [Boolean]
    -run:test_cycles                Sets the number of outer cycles and inner cycles to 3. For extremely quick testing 
                                    and sanity checks, not for production runs. Default = 'false'. [Boolean]
    ```


Tips
====

For production runs, it is recommended to include `       -ex1      ` and `       -ex2      ` and to generate 500 models per loop (either by using `       -nstruct 500      ` or by running several smaller jobs over multiple processor cores). The KIC with fragments protocol was originally benchmarked on reconstruction of 12-residue protein loops in different environments with different end-to-end distances. Shorter loops or largely buried peptide segments might require substantially fewer models. On average, each model generated by the combined remodel and refine protocol shown in the [Quick Start Example](#Quick-Start-Example) section takes 30-40 minutes for a 12-residue loop on a single CPU-core, although the time required can vary depending on loop burial and amino acid composition.

If the starting structure includes non-protein ligands, it is required to include centroid (for remodel) and fullatom (for refine) parameter files via the `       -extra_res_cen      ` and `       -extra_res_fa      ` options. The script `       rosetta/main/source/scripts/python/public/molfile_to_params.py      ` may be used for this purpose (use the '-c' option with that script to also generate the centroid parameter file). The script requires a mol or mol2 file describing the ligand as input, which can be generated using the software packages OpenBabel or Avogadro. 


Expected Outputs
================

Each output decoy contains information about the energy and rmsd of the model at the end of the file. If `       -in:::file:native      ` is provided, the reported rmsd is the backbone (N, Ca, C, O) rmsd to the native loop(s). If not, the reported rmsd is 0. Example output looks like this:

```
chainbreak: 0 (score of the chainbreak term, smaller value means well-closed loops. should be < 1.0)
loop_cenrms: 2.93581 (rmsd to native/start after centroid stage)
loop_rms: 0.857773 (rmsd to native/start after all-atom stage)
total_energy: -359.17 (total score of the system)
```


Pre-processing
==============

The refine stage will perform a repack of all residues within the neighbor distance of any loop before attempting any fragment insertion or KIC moves. Note that off-rotamer side-chain conformations in the starting structure are included in the packer, but if they are ever replaced they are excluded from further consideration. See the [[fixbb documentation|fixbb]] to repack, redesign and/or minimize any or all side-chains in the starting structure if desired. For benchmarking purposes, the initial side-chains were discarded, repacked and minimized before running the loop model application with the MinPack protocol, using the following command:

```
fixbb.<my_os>gccrelease -database <Rosetta_database> -s <input_PDB> -in:file:fullatom -overwrite -nstruct 1 
-out:pdb_gz -ignore_zero_occupancy false -constant_seed -ex1 -ex2 -extrachi_cutoff 0 -flip_HNQ -no_optH false 
-preserve_header -min_pack -packing:repack_only
```


Post-processing
===============

For benchmarking purposes, creating a score *vs* rmsd plot across decoys and looking for near-native 'energy funnels' is a good way to test the performance of the protocols on a system, and can help to determine whether errors are due to scoring or sampling. For blind prediction and refinement, such plots can still be useful to look for convergence or multiple minima in the energy landscape. Decoys may also be pairwise-clustered, using the [[cluster application|cluster]], to search for well-populated regions of conformational space that may represent alternative low-energy conformations. 


Comparison to other loop modeling protocols
===============================

Recent benchmarks using 45 12-residue loops have shown that KIC with fragments achieves sub-Angstrom loop-reconstruction accuracy (0.72 Å backbone rmsd), while considerably outperforming existing loop modeling protocols in the sampling of sub-Angstrom models (median fraction of sub-Angstrom models = 30% (without using homologs during fragment generation), compared to only 13% for next generation KIC, 6% for legacy KIC and 2% for CCD). 


New things since last release
=============================

This is the first public release. 

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
