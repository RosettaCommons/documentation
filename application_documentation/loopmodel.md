#Loop modeling application

Metadata
========

This document was edited Nov 1st 2008 by Yi Liu. This application in Rosetta3 was created by Michael Tyka, et al. Most of the contents are still based on the Rosetta++ loop tutorial written by Chu Wang 2007.

Example runs
============

This file only contents loop relax example at this moment. See `       rosetta/main/tests/integration/tests/loop_modeling      ` for an example loop relax run and input files.

References
==========

-   Qian, B., Raman, S., Das, R., Bradley, P., McCoy, A.J., Read, R.J. and Baker D. (2007). High resolution protein structure prediction and the crystallographic phase problem. Nature. manuscript accepted.
-   Wang, C., Bradley, P. and Baker, D. (2007) Protein-protein docking with backbone flexibility. Journal of Molecular Biology, in press, DOI, [http://dx.doi.org/10.1016/j.jmb.2007.07.050](http://dx.doi.org/10.1016/j.jmb.2007.07.050)

Purpose and Algorithm
=====================

This protocol was developed to be combined with Rosetta full atom structure refinement (relax mode) to streamline the task of comparative modeling. Briefly, it identifies structural variable regions from an ensemble of refined models by Rosetta fullatom refinement protocol and then models these loops using a protocol similar to the pose-based protocol.

Input Files
===========

-   Start pdbs: The template pdb file and must have real coordinates for all template residues plus the first and last residue of each loop region.
-   Loop file:

    ```
    column1  "LOOP":     The loop file identify tag
    column2  "integer":  Loop start residue number
    column3  "integer":  Loop end residue number
    column4  "integer":  Cut point residue number, >=startRes, <=endRes. default - let LoopRebuild choose cutpoint
    column5  "float":    Skip rate. default - never skip
    column6  "boolean":  Extend loop. Default false
    ```

-   Fragment files

Command Line Options
====================

You can run loop modeling with the following flags:

```
-in::file::fullatom
-in::file::s inputs/4fxn.start_0001.pdb
-loops::loop_file inputs/4fxn.loop_file
-loops::frag_sizes 9 3 1
-loops::frag_files  inputs/cc4fxn_09_05.200_v1_3.gz inputs/cc4fxn_03_05.200_v1_3.gz none
-loops::ccd_closure
-loops::random_loop
```

Other combinable flags:

```
-loops::remodel [perturb_ccd|perturb_alc|quick_ccd|old_looprelax]     Centroid remodelling
-loops::refine [refine_ccd|refine_alc]                                Fullatom refinement
-loops::relax [fullrelax|shortrelax|fastrelax]                        Fullatom relax
```

For more information about loop modeling flags, please check the [[full options list|full-options-list]]

loopmodel MPI
=============

The loopmodel executable has a separate MPI implementation from the JD2 implementation that serves most of Rosetta. As normal, just compile Rosetta in mpi (add extras=mpi to the scons command line when compiling) to activate MPI. When you run loopmodel.mpi.\*\*\*, it will expect that you have precreated output directories for it, named ./output\_\#, where \# is the zero-indexed processor rank (and you need one for each processor). So, for a 8-processor MPI job, created output\_0, output\_1, ..., output\_7.
