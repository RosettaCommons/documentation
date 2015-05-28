#pocket_measure Commands

Metadata
========

Author: Ragul Gowthaman (ragul@ku.edu)

This document was last updated May 28, 2015, by Ragul Gowthaman.

The corresponding principal investigator is John Karanicolas (johnk@ku.edu).

Purpose and Algorithm
=====================

This application takes in a Protein and ligand PDB file and outputs the "theta lig" which is the fraction of ligand that is exposed to the solvent in the complex. See the referred paper for more details.

References
==========

Gowthaman R, Deeds EJ, and Karanicolas J. (2013) The structural properties of non-traditional drug targets present new challenges for virtual screening. J. Chem. Inf. Model, 53(8), p. 2073-81.

Command Line Options
====================

**Sample command**

```
~/Rosetta/main/source/bin/theta_ligand.macosgccrelease -input_bound_pdb protein_bound.pdb -input_unbound_pdb protein_unbund.pdb -input_ligand_pdb LIGAND_0001.pdb -extra_res_fa LIGAND.params

```


```
General Rosetta Options
   -database                   Path to rosetta databases

Tips
====

* Because orientation of the protein can affect the exact identification of the pocket, which can have profound effects on the measured pocket volume, it is recommended to use the -pocket_num_angles flag with at least 100 to generate PocketGrids at multiple rotations and return the average pocket volume.