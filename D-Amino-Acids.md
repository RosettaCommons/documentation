# Working with D-Amino Acids in Rosetta
Documentation by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).  Created 19 March 2014.

## What are D-amino acids?
D-alpha-amino acids are amino acids with inverted chirality at the alpha carbon relative to the conventional L-alpha-amino acids.  Conventionally, the mirror-image versions of the 19 canonical chiral amino acids are called by the same names (D-tyrosine is the mirror image of L-tyrosine, for example).  For the most part, D-amino acids are not incorporated into natural proteins, since the ribosome translates D-residues very inefficiently.  (There are some special cases in which posttranslational enzymatic modification of certain bacterial cell wall proteins produces a few D-residues.)

There are two special cases in which we have to be careful about definitions: the two canonical amino acids that also have a chiral center in the side-chain (L-threonine and L-isoleucine) have this chiral center reversed in their D-forms, as well, making D-threonine the true mirror image of L-threonine and D-isoleucine the true mirror image of L-isoleucine.  (Inversion of the side-chain alone produces L-_allo_-threonine and L-_allo-isoleucine, while inversion of the backbone chiral center alone produces D-_allo_-threonine and D-_allo_-isoleucine.)

The simple way to determine whether an alpha-amino acid is a D-amino acid or an L-amino acid is to imagine holding the backbone amide in your left hand and the backbone carbonyl in your right hand, with the alpha carbon pointing out in front of you (as though you were holding a dowsing rod).  If the side chain points _up_, you have an L-amino acid.  If the side-chain points _down_, you have a D-amino acid.

## How can I enable D-amino acids in Rosetta?
Since few D-amino acid residues are found in the PDB, D-amino acids in the Rosetta database are not loaded by default.  In order to work with them, you have two options:
* You can use the **-extra_res_fa <path/filename.params>** to specify a specific D-amino acid params file that you'd like Rosetta to load.  The params files for D-amino acids that are mirror images of the standard L-amino acids are located in **database/chemical/residue_type_sets/fa_standard/residue_types/d-caa/**, and a hodgepodge of D-amino acids with noncanonical side-chains are found in **database/chemical/residue_type_sets/fa_standard/residue_types/d-ncaa/**.
* You can edit **database/chemical/residue_type_sets/fa_standard/residue_types.txt**, and uncomment lines for params files for the D-amino acids that you'd like to use.  This will mean that by default, Rosetta now loads these params files for any app or protocol that it runs.

_PAGE STILL UNDER CONSTRUCTION_