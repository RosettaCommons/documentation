#theta_lig Commands

Metadata
========

Author: Ragul Gowthaman (g.ragul at gmail.com)

This document was last updated May 28, 2015, by Ragul Gowthaman.

The corresponding principal investigator is John Karanicolas (johnk@ku.edu).

Purpose and Algorithm
=====================

This application takes in a protein and ligand PDB files and outputs the "theta-lig" value, which is the fraction of ligand that is exposed to the solvent in the complex. See the referred paper for more details.

References
==========

Gowthaman R, Deeds EJ, and Karanicolas J. (2013) The structural properties of non-traditional drug targets present new challenges for virtual screening. J. Chem. Inf. Model, 53(8), p. 2073-81.

Command Line Options
====================

**Sample command**

```
~/Rosetta/main/source/bin/theta_lig.macosgccrelease -input_bound_pdb protein_bound.pdb -input_unbound_pdb protein_unbund.pdb -input_ligand_pdb LIGAND_0001.pdb -extra_res_fa LIGAND.params

```


```
General Rosetta Options
   -database                   Path to rosetta databases

```

Tips
====
To generate parameter file for the ligand one can use the 'molfile_to_params.py' script.

Rosetta/main/source/src/python/apps/public/molfile_to_params.py -p LIGAND LIGAND.mol2