#Changes Need to Achieve Protein and RNA compatibility in Rosetta

**This section used to have tips for reading protein/RNA poses into Rosetta, but is now deprecated**
+ The standard ResidueTypeSet of Rosetta can handle RNA, DNA, and proteins.
+ RNA is read in from PDB lines with 'A','C','G','U' residue names. DNA is read in from PDB lines with 'DA','DC','DG','DT'
+ There is a very active effort to now unify the scorefunctions for modeling RNA and proteins to enable structure prediction and design of RNP complexes and machines.

-- Updated R. Das, 2015.

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
