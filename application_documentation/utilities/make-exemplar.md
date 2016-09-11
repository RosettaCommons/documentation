#make_exemplar Commands

Metadata
========

This application in Rosetta3 was created and documented by David Johnson, et al.

Purpose and Algorithm
=====================

This application takes in a PDB file and specified target residue/residue pair and, generates a (localized) PocketGrid, identifies the exemplar, and outputs it to a file. See the 2013 paper for PocketGrid algorithm details and the 2015 for exemplar creation algorithm details.

References
==========

Johnson DK and Karanicolas J. Druggable protein interaction sites are more predisposed to surface pocket formation than the rest of the protein surface. PLoS Comput Biol. 2013;9(3):e1002951
Johnson DK and Karanicolas J. Selectivity by small-molecule inhibitors of protein interactions can be driven by protein surface fluctuations. PLoS Comput Biol. 2015;11(2):e1004081

Command Line Options
====================

**Sample command**

```
make_exemplar.linuxgccrelease -database ~/Rosetta/main/database -in:file:s input.pdb -central_relax_pdb_num 97:A,143:A -pocket_grid_size 12 -pocket_static_grid -pocket_filter_by_exemplar
```

***make_exemplar options***

```
General Rosetta Options
   -database                      Path to rosetta databases
   -in:file:s                     Input pdb file(s)

Pocket Identification Options
   -pocket_num_angles             Number of different pose angles to measure pocket score at, default is 1, but at least 100 is recommended to reduce grid and orientation artifacts
   -pocket_grid_size              Defines the dimensions of the PocketGrid centered on the target residue(s), or 10 Angstroms by default
   -pocket_psp                    Mark Pocket-Solvent-Pocket events as well, default=false
   -pocket_sps                    Unmark Solvent-Pocket-Solvent events, default=true
   -pocket_surface_dist           Distance to consider pocket point being "surface" and excluded from "deep volume"
   -pocket_max_spacing            Maximum residue-residue distance to be considered a pocket, default is 12 Angstroms
   -pocket_min_size               Minimum pocket size to score, in cubic Angstroms, default is 10 cubic Angstroms
   -pocket_max_size               Maximum pocket size to report, in cubic Angstroms, 0 for no limit (default)
   -pocket_probe_radius           Radius of surface probe molecule, default 1.0 Angstroms
   -pocket_side                   Include only side chain residues for target surface, default=false
   -pocket_filter_by_exemplar     Additional filter generates an exemplar and then restricts the pocket to that exemplars, defaul=false
   -pocket_limit_exemplar_color   During clustering of exemplar atoms into exemplars, do not allow exposed color elements that are farther than 3 Angstroms apart to cluster together, creating a more concise exemplar, default=true
   -pocket_limit_small_exemplars  Ignore exemplars with fewer than 5 hydrophobic atoms, default=true
   -pocket_ignore_buried          Ignore pockets that are not solvent exposed, default=true
   -pocket_only_buried            Identify only pockets buried in the protein core (automatically sets -pocket_ignored_buried false), default=false
   -pocket_static_grid            By default the PocketGrid expands if pocket points are identified near the edge, this flag disables the autoexpanding feature.
   -pocket_grid_spacing           Defines the spacing of the PocketGrid, 0.5 by default
```

Tips
====

* Large grids create large exemplars, which are useless for anything related to small molecule inhibition of protein-protein interactions, so -pocket_static_grid should be defined.
* Likewiae, -pocket_filter_by_exemplar should aways be used.
* Sometimes a pocket may be too shallow to get a good exemplar with the default values. In those cases reducing -pocket_surface_dist will identify more shallow pockets.
* Exemplar detection has changed since publishing the Johnson and Karanicolas 2015 and 2016 papers. To restore the functionality to that used in those papers, the following flags need to be used: -pocket_limit_exemplar_color false -pocket_limit_small_exemplars false

## See Also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.