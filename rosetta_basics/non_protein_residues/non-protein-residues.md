#Using Non-Protein Residues and Ligands in Rosetta
* **[[D-amino acids|D-Amino-Acids]]**
* **[[Noncanonical amino acids|Noncanonical-Amino-Acids]]**
* **[[Noncanonical Backbones]]**
* **[[RNA|RNA]]**
* **[[Metals|Metals]]**

Many other residues and ligands (other than (L)-canonical amino acids) are included in the Rosetta database but are disabled by default. Instructions for enabling them can be found  [[here|How-to-turn-on-residue-types-that-are-off-by-default]]. You can also find an introductory tutorial on how to prepare ligands [here](https://www.rosettacommons.org/demos/latest/tutorials/prepare_ligand/prepare_ligand_tutorial).

Molecules with params files that are not currently included in the Rosetta database require the input of a [[residue params file|Residue-Params-file]] using the `-in:file:extra_res_fa`, `-in:file:extra_res_path`, or `-in:file:extra_res_cen` command-line options documented [[here|input-options]].

If you instead want Rosetta to automatically remove residues or ligands that it does not recognize (e.g. if those residues or ligands do not affect your protocol), you may want to [[ignore unrecognized residues|Ignore-Unrecognized]].

##See Also

* [Tutorial on Ligand Preparation](https://www.rosettacommons.org/demos/latest/tutorials/prepare_ligand/prepare_ligand_tutorial)
* [[NC scorefunction info]]: Information on scorefunctions that work well with non-protein residues and molecules.
* [[Options in Rosetta|options-overview]]
* [[How to turn on residue types that are off by default]]
* [[Params files|Residue Params file]]: Notes for adding new residue types that are not already in the Rosetta database.
* [[Preparing structures for Rosetta|preparing-structures]]
* [[Making your code robust against malformed PDBs|robust]]
