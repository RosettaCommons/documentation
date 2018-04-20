#Documentation for `rna_score`

Metadata
========

Author: Andrew Watkins

Added to documentation: Feb 2018

Code and Demo
=============

The central code for the `rna_score` application is in `       apps/public/rna/util/rna_score.cc      `

Application purpose
===========================================

This code is intended to score RNA-containing silent files in a way that provides extra functionality in ways that RNA workflows may expect.

Input Files
===========

Required files
-------------

-   A silent file (and tags) or PDB file(s) containing RNA (or, properly, anything) to score

Tips
----
+ This program can be made aware of what PDBs may once have contributed to the full modeling problem that resulted in the silent file to be scored; use the option `-original_input` to pass some PDBs
+ RNA chemical mapping data options are also respected (by passing `-rna:data_file`)
+ Will convert protein part to centroid if requested
* Can be used to recompute RMSDs for entire poses or subsets of the pose
* Can be used with superimposition over all residues, or over a particular fixed domain (especially useful if you are rescoring a silent file from a run that had used a superimposition-standard you are now regretting)

Options
=======

```
-in:file:s                     Name of single PDB file with template coordinates
-in:file:native                A native PDB (for RMS calculation)
-stepwise:virtualize_free_moieties_in_native    Will virtualize groups in the native PDB that 
                               aren't making any contacts (thus omitted from RMSD computation)
-in:file:fasta                 The fasta will allow a FullModelInfo setup based on each input 
                               pose, even if some or all of the input poses are incomplete 
                               (necessary for some RNA score terms like `loop_close`)
-rmsd_nosuper                  Calculate RMSD without superimposing to the native (good for 
                               density cases, where there IS a privileged reference frame
-rmsd_residues                 Specification of a subset of residues over which to calculate RMSD
-just_calc_rmsd                Do nothing but calculate RMSD
-color_by_score                Set the temperature of each atom in the `PDBInfo` to the score
                               so that you can color by score in PyMOL
-stepwise:superimpose_over_all    Will superimpose over every residue if true. If false, will try
                               to figure out a reasonable fixed domain to use instead.
-stepwise:alignment_anchor_res    Help out the superimposition by giving a residue from the fixed
                               domain over which superposition should take place
```


##See Also

* [[RNA applications]]: List of RNA applications
* [[Utilities Applications]]: List of utilities applications
* [[Application Documentation]]: Home page for application documentation
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Fixbb]]: App commonly used for design and/or threading with proteins
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
