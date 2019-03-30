#pocket_relax Commands

Metadata
========

This application in Rosetta3 was created and documented by David Johnson, et al.

Purpose and Algorithm
=====================

This application is intended to automate the pocket optimization process, which previously had been done in two parts. [[Relax]] is performed and then the Pocket constraint is turned off an a full atom minimization is performed. If the pocket constraint is not used, it performs a simple relax and minimization, which is used to generate the unconstrained decoy comparison set.

References
==========

Johnson DK and Karanicolas J. Druggable protein interaction sites are more predisposed to surface pocket formation than the rest of the protein surface. PLoS Comput Biol. 2013;9(3):e1002951
Johnson DK and Karanicolas J. Selectivity by small-molecule inhibitors of protein interactions can be driven by protein surface fluctuations. PLoS Comput Biol. 2015;11(2):e1004081

Command Line Options
====================

**Sample command**

```
pocket_relax.linuxgccrelease -database ~/Rosetta/main/database -in:file:s input.pdb -pocket_max_size 300 -pocket_num_angles 2 -score:patch pocket.wts.patch -cst_fa_file constraints -nstruct 1000 -pocket_zero_derivatives
```

***make-exemplar options***

```
General Rosetta Options
   -database                   Path to rosetta databases
   -in:file:s                  Input pdb file(s)
   See [[Relax  | application_documentation/relax]] documentation for other options

Pocket Constraint Options
   -score:patch                The PocketConstraint needs to be turned on
   -cst_fa_file                The PocketConstraint target residue and weight is specified here
   -pocket_zero_derivatives    The PocketConstraint has no derivitive, and this flag specifies to return derivitives of 0 during minimization phases of Relax

Pocket Identification Options
   -pocket_num_angles          Number of different pose angles to measure pocket score at, default is 1, but 2 is recommended to reduce grid and orientation artifacts
   -pocket_grid_size           Defines the dimensions of the PocketGrid centered on the target residue(s), or 10 Angstroms by default
   -pocket_psp                 Mark Pocket-Solvent-Pocket events as well, default=false
   -pocket_sps                 Unmark Solvent-Pocket-Solvent events, default=true
   -pocket_surface_dist        Distance to consider pocket point being "surface" and excluded from "deep volume"
   -pocket_max_spacing         Maximum residue-residue distance to be considered a pocket, default is 12 Angstroms
   -pocket_min_size            Minimum pocket size to score, in cubic Angstroms, default is 10 cubic Angstroms
   -pocket_max_size            Maximum pocket size to report, in cubic Angstroms, 0 for no limit (default)
   -pocket_probe_radius        Radius of surface probe molecule, default 1.0 Angstroms
   -pocket_side                Include only side chain residues for target surface, default=false
   -pocket_filter_by_exemplar  Additional filter generates an exemplar and then restricts the pocket to that exemplars, defaul=false
   -pocket_ignore_buried       Ignore pockets that are not solvent exposed, default=true
   -pocket_only_buried         Identify only pockets buried in the protein core (automatically sets -pocket_ignored_buried false), default=false
   -pocket_static_grid         By default the PocketGrid expands if pocket points are identified near the edge, this flag disables the autoexpanding feature.
   -pocket_grid_spacing        Defines the spacing of the PocketGrid, 0.5 by default
```

***pocket.wts.patch file***

```
pocket_constraint = 1.0
```

***constraints file format***

```
Pocket 0.25 97:A,143:A
```

Tips
====

* Orientation artifiacts can have an artificial impact on pocket volume, therefore specifying -pocket_num_angles of 2 is suggested to reduce that effect
* -pocket_max_size is not necessary, however it can be useful when a given protein is able to open massive pockets that are not relevant for inhibition. -pocket_max_size essentially caps the volume returned by the PocketConstraint, at which point a pocket will grow ONLY when it is energetically favorable to do so.


## See Also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
