Batch Distances
===============

Purpose and Algorithm
=====================

This application simply iterates through all pairs of residues in the input protein, and prints information about the closest atom-atom approach between the two proteins.

Output
======

Example output, as printed to standard output is as follows:

```
  resi_idx  resj_idx  resi  resj   atomi   atomj  burial_i  burial_j      dist    seqsep      pose_tag
         2         3     P     K     N       NZ          7        11    9.0335         1     1f4pA.pdb
         2         3     P     K     CA      CA          7        11    3.8200         1     1f4pA.pdb
         2         3     P     K     C       C           7        11    3.4303         1     1f4pA.pdb
```

Command Line Options
====================

Example commandline:

```
~/rosetta/main/source/bin/batch_distances.default.linuxgccrelease -s input.pdb -mute all
```

| option            |  effect  | 
|-------------------|----------|
| -s / -l / -in:file:silent |  Standard Rosetta input flags for one or more input structure. |
| -dist_thresholds  | The maximum atom-atom through-space distance to be reported. (default: unbounded) | 
| -min_seqsep       | Ignore interactions with sequence separations less than the given value (default: 0) 

Tips & Caveats
==============

As the output will be printed to the standard output, it may be helpful to put `-mute all` on the command line, to suppress standard Rosetta output.

As currently written, hydrogens are ignored completely, and only distances between heavy atoms of similar Rosetta atom types will be printed. (This can be changed by using the "undocumented" option of `-james:debug`). Which atom types are printed can be changed with the option `-atom_names` 


