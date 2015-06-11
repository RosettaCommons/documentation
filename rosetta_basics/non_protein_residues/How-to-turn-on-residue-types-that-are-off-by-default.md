# How to turn on residue types that are off by default
Documentation by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).  Created 14 March 2014.

## Short summary
Not all of the residue types in the Rosetta database are turned on by default.  Many specialized types are only loaded if the user explicitly requests them, or if the list of residue types automatically loaded is edited.

## Usage cases
Typically, a user would have three usage cases:
* The user wishes to work with canonical amino acid residues, common inorganic ions, or conventional nucleic acids.  In this case, Rosetta should work "out of the box" -- _i.e._ the user should be able to load a PDB containing these things and have Rosetta interpret it properly.
* The user wishes to work with one or two noncanonical residues or ligands in addition to the usual set.  In this case, it is simplest to specify a path to a params file using the **-extra_res <path/filename>** or **-extra_res_fa <path/filename>** flags.  (The latter is for full-atom params files.)
* The user wishes to work with a set of noncanonical residues, and wants these to be loaded by default.  In this case, he or she should edit the file **database/chemical/residue_type_sets/fa_standard/residue_types.txt**, and uncomment lines for params files defining the residue types that he or she wants to use.

## Note for developers
Adding new residue types to the Rosetta database is fine, but most types should probably be turned off (commented out) by default in **residue_types.txt**.  Rosetta's database includes a very large set of noncanonicals, which are not used (and need not be loaded into memory) by most users.

## See also

* Notes on [[params files|Residue Params file]], for adding new residue types that are not already in the Rosetta database.
* [[Guides for non-protein inputs|non-protein-residues]]: Notes on working with [[noncanonical amino acids|Noncanonical Amino Acids]], [[metals|Metals]], [[carbohydrates|Carbohydrates]], _etc_.
