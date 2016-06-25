#Next-generation kinematic loop modeling and torsion-restricted sampling

Metadata
========

Author: Amelie Stein

Documentation and code by Amelie Stein. The corresponding PI for this application is Tanja Kortemme (kortemme@cgl.ucsf.edu). This document was last updated December, 2015 by Jared Adolf-Bryfogle. 

An introductory tutorial to loop modeling can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/loop_modeling/loop_modeling).

Code and Demo
=============

The current application for this method (in Rosetta 3.5) is `       bin/loopmodel.<my_os>gccrelease      ` . Implementation of the analytic closure is described in the kinematic loop closure documentation. The major additions for next-generation KIC (NGK) are the addition of new perturbers in `       src/protocols/loops/loop_closure/kinematic_closure/KinematicPerturber      ` and the TabooMap in `       src/protocols/loops/loop_closure/kinematic_closure/KinematicMover      ` , which keeps track of the torsion bin vectors that have been sampled in the current trajectory. General and torsion-bin-specific tables for phi/psi sampling of non-pivot residues are implemented in `       src/core/scoring/Ramachandran</core> for residue-specific distributions and               src/core/scoring/Ramachandran2B</core> for residue- and neighbor-specific distributions. A basic usage example that briefly remodels an 8-residue loop is the                 next_generation_KIC        ` integration test, which resides at `         main/tests/integration/tests/next_generation_KIC        ` .


References
==========

Next-generation KIC is described and compared to standard KIC loop modeling in 

-   Stein A, Kortemme T. (2013). [Improvements to robotics-inspired conformational sampling in rosetta.](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0063090) PLoS One. 2013 May 21;8(5)

Torsion bin definitions used by TabooSampling and TorsionRestrictedSampling are based on

-   Kim DE, Blum B, Bradley P, Baker D. (2009). Sampling bottlenecks in de novo protein structure prediction. *J Mol Biol* . 393(1):249-260.

Neighbor-dependent Ramachandran distributions used for non-pivot sampling are described in

-   Ting D, Wang G, Shapovalov M, Mitra R, Jordan MI, Dunbrack RL Jr. (2010). Neighbor-dependent Ramachandran probability distributions of amino acids developed from a hierarchical Dirichlet process model. *PLoS Comput Biol* . 6(4):e1000763.

Best current flags and protocol captures can be found [here](https://guybrush.ucsf.edu/benchmarks/benchmarks/loop_modeling)

Limitations
===========

By definition, KIC moves are local perturbations, so the C-alpha atoms of start and end residues in loop definitions stay fixed. Loop definitions may include the N- and/or C-termini of monomeric proteins, and the C-alpha atoms of the termini will remain fixed (i.e., NGK loop modeling cannot be used to sample conformations of terminal residues themselves without adding 'virtual' residues to the termini).

Input Files
===========

The following files are required for kinematic loop modeling:

-   Starting PDB file, specified by `    -in:file:s       ` . The starting structure must have real coordinates for all residues outside the loop definition, plus the first and last residue of each loop region.

-   Loop definition file, specified by ` -loops:loop_file` and shared across all loop modeling protocols. For each loop to be modeled, include the following on one line:

    ```
    column1  "LOOP":     The loop file identify tag
    column2  "integer":  Loop start residue number
    column3  "integer":  Loop end residue number
    column4  "integer":  Cut point residue number, >=startRes, <=endRes. default - let the loop modeling code choose cutpoint. 
                         Note: Setting the cut point outside the loop can lead to a segmentation fault. 
    column5  "float":    Skip rate. default - never skip
    column6  "boolean":  Extend loop. Default false. Setting this flag to 1 leads to randomization of the loop conformation before NGK sampling, 
                         using idealized bond lengths and angles. This is important for loop reconstruction benchmarks to ensure a starting loop 
                         conformation that is different from the original one, as well as for de novo loop construction/insertion with KIC, 
                         to create a connected starting loop conformation from single unconnected loop residues 
                         (see tutorial at rosetta/demos/public/model_missing_loop). 
    ```

    An example loop definition file can be found at `    rosetta/main/tests/integration/tests/next_generation_KIC/input/4fxn.loop`, which looks like this:

    ```
    LOOP 88 95 92 0 1
    ```

**NOTE:** Residue indices in loop definition files refer to *Rosetta numbering* (numbered continuously from '1', including across multi-chain proteins). It may be useful to renumber starting structures with Rosetta numbering so loop defintions and PDB residue indices agree.

Options
=======

Please see [Rosetta Benchmark](https://guybrush.ucsf.edu/benchmarks/benchmarks/loop_modeling) for current best-practices for running NGK.

-   The following options are used to activate NGK and must be present in the command line. One or both of `    -loops:remodel   ` (centroid stage, required for *de novo* loop reconstruction) or `    -loops:refine   ` (full-atom stage) are required:

    ```
    -database                       Path to the Rosetta database. [Path]
    -loops:remodel                  Selects a protocol for the centroid remodeling stage.
                                    Legal values: 'perturb_kic','perturb_ccd','quick_ccd','quick_ccd_moves','old_loop_relax','no'.
                                    default = 'quick_ccd'. For KIC and NGK, use 'perturb_kic'. [String]
    -loops:refine                   Selects the all-atom refinement stage protocol.
                                    Legal values: 'refine_kic','refine_ccd','no'. default = 'no'. For KIC and NGK, use 'refine_kic'. [String]
    -loops:taboo_sampling           Taboo Sampling: keep track of sampled torsion bins for each loop position and promote diversity among models by sampling non-torsion pivots from currently underrepresented bins. Perturb/remodel stage only.
    -loops:kic_rama2b               Use neighbor-dependent Ramachandran distributions for phi/psi sampling of non-pivot torsions instead of the standard Ramachandran distributions. Perturb and refine stages. Note that this increases the memory footprint to about 6G.
    -loops:ramp_fa_rep              Ramp the weight of fa_rep over outer loops in refinement. It is recommended to use 5 or more outer loops for smoother ramp effects. 
    -loops:ramp_rama                Ramp the weight of rama (or rama2b, if using -loops:kic_rama2b) over outer loops in refinement. It is recommended to use 5 or more outer loops for smoother ramp effects. 
    -loops:loop_file                Path/name of loop definition file. default = 'loop_file'. [File]
    ```

-   The following general Rosetta options are commonly used with NGK:

    ```
    -in:file:s                      Path/name of input pdb file. [File]
    -in:file:native                 Path/name of native pdb file. Backbone rmsd to this structure will be reported in each output decoy.
                                    If no native structure is provided, the protocol will return an rmsd of 0. [File]
    -in:file:fullatom               Read the input structure in full-atom mode. Set this flag to avoid discarding the native side chains and repacking the input structure
                                    before modeling (KIC refine alway begins by repacking the loop side-chains,
                                    including the neighboring side-chains if -loops:fix_natsc is 'false'). default = 'false'. [Boolean]
    -loops:fix_natsc                Don't repack, rotamer trial, or minimize loop residue neighbors. default = 'false'. [Bolean]
    -ex1 (-ex2, -ex3, -ex4)         Include extra chi1 rotamers (or also chi2, chi3, chi4).
    -extrachi_cutoff 0              Set to 0 to include extra rotamers regardless of number of neighbors
    -extra_res_cen                  Path to centroid parameters file for non-protein atoms or ligands. Note that this is required for structures with ligands even if only full-atom remodeling is performed.
    -extra_res_fa                   Path to all-atom parameters file for non-protein atoms or ligands
    -overwrite                      Overwrite existing models (Rosetta will not output without this flag if same-named model exists)
    -out:pdb_gz                     Create compressed output PDB files (using gzip), which saves a lot of space. These files can still be 
                                    visualized normally with software such as Pymol. 
    ```

-   See also "expert options" in the KIC documentation.

Torsion-restricted sampling
===========================

For intensive sampling in specific parts of conformational space, e.g. when information about the secondary structure is available, use the options below. The torsion bin string must have the same length as the remodeled loop. Currently this is only implemented for remodeling a single loop at a time. Use `X` (uppercase) for arbitrary torsion bins (i.e., the full Ramachandran distribution).  Valid choices are `ABEGUX`, but the class that implements this doesn't explain what they actually are.  

```
-loops:restrict_kic_sampling_to_torsion_string    Only sample phi/psi for non-pivot torsions from the provided torsion bin string. [String]
-loops:derive_torsion_string_from_native_pose     Only sample phi/psi for non-pivot torsions within the torsion bins in the native (or, if -in:file:native isn't provided, input) structure.
```

New things since last release
=============================

Rosetta 3.5 is the first release featuring next-generation KIC.

##See Also

* [Loop Modeling Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/loop_modeling/loop_modeling)
* [[Loopmodel]]: The main loopmodel application page
* [Rosetta Benchmarks](https://guybrush.ucsf.edu/benchmarks/benchmarks/loop_modeling): Current benchmarks for NGK
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