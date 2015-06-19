# SnugDock

## Authors
Aroop Sircar and Jeffery J. Gray

## Publication
[[SnugDock: Paratope Structural Optimization during Antibody-Antigen Docking Compensates for Errors in Antibody Homology Models|http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000644]]

## Overview

The author has provided no documentation on this wiki, but the paper is quite good and freely available.

The tool describes its options as follows:
<pre>
Usage:

/usr/lib/rosetta/bin/snugdock.default.linuxgccrelease [options]

Options:   [Specify on command line or in @file]

Showing only relevant options...


                        Option |                  Setting  |Type|  Description
--------------------------------------------------------------------------------------
                               |                           |    |
                    docking:   |                           |    |
                     multibody |                           | (I)| List of jumps allowed to
                               |                           |    |  move during docking
         low_res_protocol_only |                     false |   B| Run only low resolution
                               |                           |    |  docking, skip high
                               |                           |    |  resolution docking
          docking_local_refine |                     false |   B| Do a local refinement of the
                               |                           |    |  docking position (high
                               |                           |    |  resolution)
                      dock_min |                     false |   B| Minimize the final fullatom
                               |                           |    |  structure.
                    dock_rtmin |                     false |   B| does rotamer trials with
                               |                           |    |  minimization, RTMIN
                        sc_min |                     false |   B| does sidechain minimization
                               |                           |    |  of interface residues
                      partners |                         _ |   S| defines docking partners by
                               |                           |    |  ChainID, example: docking
                               |                           |    |  chains L+H with A is
                               |                           |    |  -partners LH_A
                    no_filters |                     false |   B| Toggle the use of filters
                               |                           |    |
                constraints:   |                           |    |
                    cst_weight |                         1 |   R| No description
                 cst_fa_weight |                         1 |   R| No description
                               |                           |    |
                        run:   |                           |    |
                    score_only |                     false |   B| calculate the score only and
                               |                           |    |  exit
                               |                           |    |
                    in:file:   |                           |    |
                        native |                           |   F| Native PDB filename
                               |                           |    |
                    docking:   |                           |    |
           use_legacy_protocol |                     false |   B| Use the legacy high
                               |                           |    |  resolution docking
                               |                           |    |  algorithm for output
                               |                           |    |  compatibility.
   ignore_default_docking_task |                     false |   B| Allows the user to define
                               |                           |    |  another task to give to
                               |                           |    |  Docking and will ignore
                               |                           |    |  the default DockingTask.
                               |                           |    |  Task will default to
                               |                           |    |  designing everything if no
                               |                           |    |  other TaskFactory is given
                               |                           |    |  to docking.
            recover_sidechains |                           |   F| usually side-chains are
                               |                           |    |  taken from the input
                               |                           |    |  structure if it is
                               |                           |    |  fullatom - this overrides
                               |                           |    |  this behavior and takes
                               |                           |    |  sidechains from the
                               |                           |    |  pdb-file
 docking_centroid_inner_cycles |                        50 |   I| Inner cycles during docking
                               |                           |    |  rigid body adaptive moves.
 docking_centroid_outer_cycles |                        10 |   I| Outer cycles during cking
                               |                           |    |  rigid body adaptive moves.
                     ensemble1 |                           |   S| turns on ensemble mode for
                               |                           |    |  partner 1.  String is
                               |                           |    |  multi-model pdb file
                     ensemble2 |                           |   S| turns on ensemble mode for
                               |                           |    |  partner 2.  String is
                               |                           |    |  multi-model pdb file
                               |                           |    |
                constraints:   |                           |    |
                      cst_file |                           | (S)| constraints filename(s) for
                               |                           |    |  centoroid. When multiple
                               |                           |    |  files are given a *random*
                               |                           |    |  one will be picked.
                   cst_fa_file |                           | (S)| constraints filename(s) for
                               |                           |    |  fullatom. When multiple
                               |                           |    |  files are given a *random*
                               |                           |    |  one will be picked.
                               |                           |    |
                 evaluation:   |                           |    |
                          rmsd |                           | (F)| [vector/pairs] tripletts:
                               |                           |    |  rmsd_target (or NATIVE /
                               |                           |    |  IRMS) col_name
                               |                           |    |  selection_file (or FULL)
                         gdtmm |                     false |   B| for each rmsd evaluator also
                               |                           |    |  a gdtmm evaluator is
                               |                           |    |  created
                           rdc |                           | (S)| [vector] rdc-files and
                               |                           |    |  column names for RDC
                               |                           |    |  calculation
                          pool |                           |   F| find closest matching
                               |                           |    |  structure in this pool and
                               |                           |    |  report tag and rmsd
                   constraints |                           | (F)| [vector] evaluate against
                               |                           |    |  these constraint sets
                               |                           |    |
                    in:file:   |                           |    |
                        native |                           |   F| Native PDB filename
                               |                           |    |
                 evaluation:   |                           |    |
               chemical_shifts |                           | (S)| compute chemical shift score
                               |                           |    |  with SPARTA+ use tuples:
                               |                           |    |  talos_file
                               |                           |    |  [cs]_column_name
                               |                           |    |  (ATTENTION uses
                               |                           |    |  filesystem)
                               |                           |    |
                    in:file:   |                           |    |
                        silent |                           | (F)| silent input filename(s)
                             s |                           | (F)| Name(s) of single PDB
                               |                           |    |  file(s) to process
                             l |                           | (F)| File(s) containing list(s)
                               |                           |    |  of PDB files to process
                        native |                           |   F| Native PDB filename
    silent_read_through_errors |                     false |   B| will ignore decoys with
                               |                           |    |  errors and continue
                               |                           |    |  reading
                               |                           |    |
                   out:file:   |                           |    |
                        silent |               default.out |   S| Use silent file output, use
                               |                           |    |  filename after this flag
                     scorefile |                default.sc |   S| Write a scorefile to the
                               |                           |    |  provided filename
                               |                           |    |
                        run:   |                           |    |
                       batches |                           | (F)| batch_flag_files
                       archive |                     false |   B| run MPIArchiveJobDistributor
</pre>

Its invocation scheme followes the general principle to have single PDB files specified with the argument "-s filename.pdb". The PDB file is expected to contain both the antibody and the target. If not camlid, the antibody is of the two chains H (heavy) and L (light), as e.g. produced by Rosetta Antibody.py. The target may be of any other chain ID but, at least conceptionally, within the same PDB entry that is read into a single pose of Rosetta. Rosetta by default allows to have multiple PDB files read into the same internal pose representation when those are specified together, i.e. as "-s 'antibody.pdb target.pdb'. This eliminates the need to perform a respective merge manually. The above referenced publication has more insights into appropriate parameter settings.

