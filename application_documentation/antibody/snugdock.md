# SnugDock

## Authors
Aroop Sircar and Jeffery J. Gray

## Publication
[[SnugDock: Paratope Structural Optimization during Antibody-Antigen Docking Compensates for Errors in Antibody Homology Models|http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000644]]

## Overview

The above paper describes the SnugDock method, but flags have evolved with time. To run SnugDock, it is necessary to input a PDB-formatted file with an antibody (light chain labelled as L and heavy chain labelled as H) and an antigen (labelled as anything you want, I use A). The input should be prepacked using the docking_prepack_protocol.

The current, recommended way to run SnugDock is:

```bash
/path/to/Rosetta/bin/snugdock.linuxgccrelease @flags
```

with minimal flags being:
```
### JOB IO
-s input.pdb
-native native_input.pdb # if available
-out:file:scorefile score_out_snugdock.sc
-out:path:pdb models_path_out/
-out:pdb_gz # gzip models for space
-nstruct 1000 # adequate sampling

# low-res constraints (constrain alpha/tau if available)
-constraints:cst_file kink.cst
-constraints:cst_weight 1.0

# high-res constraints (constrain alpha/tau if available)
-constraints:cst_fa_file kink.cst
-constraints:cst_fa_weight 1.0

### Docking
-partners LH_G
-spin
-dock_pert 3 8

### do not filter for h3, constraint takes care of this geom
-h3_filter false

### loop modeling settings
#
# KIC

-kic_rama2b
-loops:ramp_fa_rep
-loops:ramp_rama

-kic_omega_sampling
-allow_omega_move true

-loops:refine_outer_cycles 3
-loops:max_inner_cycles 80

# CCD (exit with ptr error)
#-antibody:centroid_refine refine_ccd
#-antibody:refine refine_ccd
#-loops:outer_cycles 5

#more standard settings, for packages used by antibody_H3
-ex1
-ex2aro
-talaris2014 true
```

One key flag **which everyone should include** is the `-h3_filter false` flag. When set to true, this flag repeats CDR H3 modeling up to 20 times if the loop is not in a kinked conformation (see [[Weitzner et al. for more|http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4318709/]]). Do not turn this on as it wastes too many cycles attempting to kink the CDR H3 loop. Instead, apply two flat harmonic constraints, scaled to be 1 REU at 3 standard deviations from the mean of the alpha and tau angles as defined in the above paper.

The two loops flags are very important as SnugDock was initially written with CCD as the default loop modeling approach. Now we use next-generation kinematic loop closure (KIC) which is much, much slower but also much, much better at exploring conformational space. Runtimes with default next-generation KIC (NGK) flags are approximately 10 hours per model -- 60x slower than standard rigid-body docking protocol and a 17x slower that CCD-based SnugDock. **Use (`-loops:refine_outer_cycles 3` and `-loops:max_inner_cycles 80`) or (`-loops:refine_outer_cycles 2` and `-loops:max_inner_cycles 20`) unless you have loads of free time resources at hand**. _These flags have been benchmarked and preform slightly better than CCD-based SnugDock_.

Partners must be ordered in the PDB and partners flag as light chain, heavy chain, and then antigen. This is due to the way the fold tree is initialized. We hope to do away with this rigid requirement soon.

### Other Useful Flags

These flags have not all been tested with SnugDock (nor are they comprehensive) so buyer be ware. In general, it is useful to know that SnugDock expands on DockingProtocol machinery, which means that most flag docking flags still apply (the biggest exception identified so far is the `-no_filters` which doesn't get passed on the SnugDock via DockingHighRes).

**Docking Flags**

                        Option |                  Setting  |Type|  Description
-------------------------------|---------------------------|----|---------------------
                     multibody |                           | (I)| List of jumps allowed to move during docking.
         low_res_protocol_only |                     false |   B| Run only low resolution docking, skip high resolution docking.
          docking_local_refine |                     false |   B| Do a local refinement of the docking position (high resolution).
                      dock_min |                     false |   B| Minimize the final fullatom structure.
                    dock_rtmin |                     false |   B| does rotamer trials with minimization, RTMIN
                        sc_min |                     false |   B| does sidechain minimization of interface residues
                      partners |                         _ |   S| defines docking partners by ChainID, example: docking chains L+H with A is -partners LH_A
                    no_filters |                     false |   B| Toggle the use of docking filters only.
           use_legacy_protocol |                     false |   B| Use the legacy high resolution docking algorithm for output compatibility.
   ignore_default_docking_task |                     false |   B| Allows the user to define another task to give to Docking and will ignore the default DockingTask. Task will default to designing everything if no other TaskFactory is given to docking.
            recover_sidechains |                           |   F| usually side-chains are taken from the input structure if it is fullatom - this overrides this behavior and takes sidechains from the pdb-file
 docking_centroid_inner_cycles |                        50 |   I| Inner cycles during docking rigid body adaptive moves.
 docking_centroid_outer_cycles |                        10 |   I| Outer cycles during docking rigid body adaptive moves.
                     ensemble1 |                           |   S| turns on ensemble mode for partner 1.  String is multi-model pdb file (must be prepacked)
                     ensemble2 |                           |   S| turns on ensemble mode for partner 2.  String is multi-model pdb file (must be prepacked)

**Constraints Flags**

                        Option |                  Setting  |Type|  Description
-------------------------------|---------------------------|----|---------------------
                      cst_file |                           | (S)| constraints filename(s) for centoroid. When multiple files are given a *random* one will be picked.
                   cst_fa_file |                           | (S)| constraints filename(s) for fullatom. When multiple files are given a *random* one will be picked.

**I/O Flags**

                        Option |                  Setting  |Type|  Description
-------------------------------|---------------------------|----|---------------------
                out:score_only |                     false |   B| calculate the score only and exit
                in:file:native |                           |   F| Native PDB filename
                in:file:silent |                           |   F| silent input filename(s)
                     in:file:s |                           |   F| Name(s) of single PDB file(s) to process
                     in:file:l |                           |   F| File(s) containing list(s) of PDB files to process
               out:file:silent |               default.out |   S| Use silent file output, use filename after this flag     
            out:file:scorefile |                default.sc |   S| Write a scorefile to the provided filename

**Evaluation Flags**

                        Option |                  Setting  |Type|  Description
-------------------------------|---------------------------|----|---------------------
                          rmsd |                           | (F)| [vector/pairs] tripletts: rmsd_target (or NATIVE/IRMS) col_name selection_file (or FULL)
                         gdtmm |                     false |   B| for each rmsd evaluator also a gdtmm evaluator is created
                           rdc |                           | (S)| [vector] rdc-files and column names for RDC calculation
                          pool |                           |   F| find closest matching structure in this pool and report tag and rmsd
               chemical_shifts |                           | (S)| compute chemical shift score with SPARTA+ use tuples: talos_file [cs]_column_name (ATTENTION uses  filesystem)