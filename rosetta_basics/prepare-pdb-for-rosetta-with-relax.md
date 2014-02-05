#Prepare PDB For Rosetta With Relax (Relax with all-atom constraints.)

Author: Rocco Moretti and Lucas Nivon

Metadata
========

Updated 20120315 by Lucas Nivon. (nivon@u.washington.edu) . Baker lab. (dabaker@u.washington.edu)

Code and Demo
=============

Scripts are in `       rosetta/rosetta_source/src/apps/public/relax_w_allatom_cst      ` . Demo is in `       rosetta/rosetta_demos/public/prepare_pdb_for_rosetta_with_relax      ` .

Application purpose
===========================================

These scripts relax a pdb (minimize rosetta score) while keeping atoms as close as possible to the original positions in the crystal. It is designed to be used to prepare a structure for subsequent design in rosetta. We looked for a way to simultaneously minimize rosetta energy and keep all heavy atoms in a crystal structure as close as possible to their starting positions. As many posts below – or hard-won experience – will show, running relax on a structure will often move the backbone a few Angstroms. The best way we have found to perform the simultaneous optimization is to run relax with constraints always turned on (typically constraints ramp down in the late cycles of a relax run) and to constrain not just backbone but also sidechain atoms. This protocol has been tested on a benchmark set of 51 proteins and found to increase sequence recovery in enzyme design by 5% as compared with design in raw pdb structures. It accomplishes this with only .077 Angstrom RMSD over the set of proteins (C-alpha RMSD) from raw pdb to relaxed-with-csts pdb. A more complete description of the data leading to this protocol is below.

Algorithm
=========

The scipt sidechain\_cst\_3.py prepares a set of coordinate constraints for use with rosetta given an input pdb. The subsequent algorithm is identical to relax, except the sidechain heavy atom coordinate constraints from the script are added, and the constraints are not turned off during the relax run (this is the always\_constrained\_relax\_script). Briefly, in the relax protocol cycles of repack/minimize are run while ramping up and down the repulsive weight in the rosetta score function. Relax without any constraints can move the structure 2-3 angstroms from the starting position, hence the need for this constrained version.

Limitations
===========

This is not "normal" relax, that is to say, it will not find the global energy minimum for your structure, it will only find a good energy that is consistent with the input atom positions.

Modes
=====

This protocol is a specialized mode of relax.

Input Files
===========

The raw input is just a pdb. The sidechain constraints are prepared with the script: `       python rosetta/rosetta_source/src/apps/public/relax_w_allatom_cst/sidechain_cst_3.py 1A99_1A99.pdb 0.1 0.5      ` . This will produce the file yourpdb\_sc.cst, which is an input to relax.

Options
=======

The constraint script takes a pdb input and the parameters for the constraint. The potential for the constraint is flat bottom with linear sides. The first value after the pdb(0.1 above) is the width of the flat-bottom portion of the potential. The second value (0.5 above) is the stdev or "tightness" of the linear portion of the potential. The following flags are required for this protocol in relax: `-constrain_relax_to_start_coords` `-relax:script ../../../rosetta_source/src/apps/public/relax_w_allatom_cst/always_constrained_relax_script` `-constraints:cst_fa_file yourpdb_sc.cst`

Tips
====

We recommend starting with the flags given in the demo to get an initial relaxed structure. If you find the structure has drifted too far (high all-atom rmsd) from the native consider using a width of 0.0 for the sidechain\_cst\_3.py script, or consider decreasing the stdev in the script below 0.5.

Expected Outputs
================

The protocol produces an output pdb that has been relaxed with all-atom constraints.

Post Processing
===============

What post processing steps are typical? Are score vs RMSD plots useful? Are structures clustered (if so, give a command line)? Is it obvious when either the application has succeeded or if it has failed (e.g. if the protocol makes predictions like "This is the docked conformation of proteins A and B"). In the case of designs, how should designs be selected?
