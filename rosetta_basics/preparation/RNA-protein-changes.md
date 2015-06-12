#Changes Need to Achieve Protein and RNA compatibility in Rosetta

Metadata
========

Author: Caleb Cassidy (cacassidy@gmail.com)

Last edited 8-16-10.

Application purpose
===========================================

Currently, Rosetta can easily handle poses that have both protein and DNA. However, poses with RNA and protein will cause Rosetta to crash. By making a few simple database changes, it is possible to get compatability between RNA and protein in Rosetta.

How to achieve compatibility?
=============================

All the files necessary for RNA/protein compatability already exist in the rosetta database. All that we'll be doing is copying the RNA parameter files and patch files from the rna residue type set to the full atom standard residue type set.

1. Copy the RNA parameter files (RAD.params, RCY.params, etc) from /path/to/rosetta/main/database/chemical/residue\_type\_sets/rna/residue\_types/ to /path/to/rosetta/main/database/chemical/residue\_type\_sets/fa\_standard/residue\_types/nucleic/
2. Copy the RNA patch files (LowerRNA.txt and UpperRNA.txt) from /path/to/rosetta/main/database/chemical/residue\_type\_sets/rna/patches/ to /path/to/rosetta/main/database/chemical/residue\_type\_sets/fa\_standard/patches/
3. Open /path/to/rosetta/main/database/chemical/residue\_type\_sets/fa\_standard/residue\_types.txt and add the RNA parameter files' names under the Nucleic Acid Types heading
4. Open /path/to/rosetta/main/database/chemical/residue\_type\_sets/fa\_standard/patches.txt and add the RNA patch files' names

With these 4 simple changes, we have achieved compatablity between RNA and protein in full atom mode

Useful Tips
===========

If you plan on using Rosetta to build RNA, be aware that the one letter codes for nucleic acids A, G, and C are shared between RNA and DNA. The RNA parameter files show that the names necessary for the pdb reader to recognize RNA residues are rA, rG, rC, rU respectively so it may be necessary to edit your pdb file. Additionally, the full atom patch 12 score function is initialized with an option to exclude DNA-DNA interactions, which applies to all nucleic acid - nucleic acid interactions, so if RNA-RNA interactions are important to you it will be necessary to set this option to false in the code.

##See Also

* [[RNA]]: Main guide to using RNA with rosetta
* [[Non-protein residues]]: Guide to using non-protein molecules with Rosetta
* [[Making Rosetta robust against malformed PDBs|robust]]
* [[RNA applications]]: Applications intended for use with RNA
* [[Residue Params file]]: File to specify chemical and geometric information for ligands and residues.
* [[Preparing structures]]: Preparing typical protein structures for use in Rosetta
* [[Preparing PDB files for non-peptide polymers]]
* [[Preparing PDB files containing protein and RNA|RNA-protein-changes]]
* [[Running Rosetta with options]]: Instructions for running Rosetta applications on the command line
* [[File types list]]: File types used in Rosetta
