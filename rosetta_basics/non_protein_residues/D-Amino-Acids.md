# Working with D-Amino Acids in Rosetta
Documentation by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).  Created 19 March 2014.  Last modified 21 Sept. 2016.

## Short summary
Rosetta has full support for the 19 D-amino acids that are mirror images of the 19 canonical L-amino acids, and these are fully functional with the **talaris2013**, **talaris2014**, and **beta_nov15** scoring functions.  This page has information on how to activate these residue types, as well as on working with other D-amino acids with noncanonical side chains.

## What are D-amino acids?
D-alpha-amino acids are amino acids with inverted chirality at the alpha carbon relative to the conventional L-alpha-amino acids.  Conventionally, the mirror-image versions of the 19 canonical chiral amino acids are called by the same names (D-tyrosine is the mirror image of L-tyrosine, for example).  For the most part, D-amino acids are not incorporated into natural proteins, since the ribosome translates D-residues very inefficiently.  (There are some special cases in which posttranslational enzymatic modification of certain bacterial cell wall proteins produces a few D-residues.)

There are two special cases in which we have to be careful about definitions: the two canonical amino acids that also have a chiral center in the side-chain (L-threonine and L-isoleucine) have this chiral center reversed in their D-forms, as well, making D-threonine the true mirror image of L-threonine and D-isoleucine the true mirror image of L-isoleucine.  (Inversion of the side-chain alone produces L-_allo_-threonine and L-_allo-isoleucine, while inversion of the backbone chiral center alone produces D-_allo_-threonine and D-_allo_-isoleucine.)

The simple way to determine whether an alpha-amino acid is a D-amino acid or an L-amino acid is to imagine holding the backbone amide in your left hand and the backbone carbonyl in your right hand, with the alpha carbon pointing out in front of you (as though you were holding a dowsing rod).  If the side chain points _up_, you have an L-amino acid.  If the side-chain points _down_, you have a D-amino acid.

## How can I enable D-amino acids in Rosetta?
D-amino acid residues are considered "non-canonical" by Rosetta.  Internally, D-amino acid ResidueType objects are automatically generated by mirroring their L-amino acid counterparts; no separate input on the part of the user is required.  By default, Rosetta's _packer_, which is used for side-chain rotamer optimization and for sequence design, does not design with D-amino acids, but they can be turned on using the "NC" (for "non-canonical") command in a resfile.

## How does Rosetta handle D-amino acid scoring?
In the case of the 19 "canonical" D-amino acids (that is, the D-amino acids that are mirror images of the 19 canonical L-amino acids), all terms in the **talaris2013**, **talaris2014**, and **beta_nov15** scoring functions, as well as the **cart_bonded** term, use the statistical and scoring information for the corresponding L-amino acids, mirroring appropriate terms to ensure that mirror-image structures score and minimize identically.  To save memory, the database information loaded for the **fa_dun**, **p_aa_pp**, **cart_bonded**, and **rama** terms for the L-amino acids is reused (with appropriate mirroring) for the corresponding D-amino acids, so this is not duplicated unnecessarily.

In the case of "noncanonical" D-amino acids, some terms currently may not handle these properly.  These include:
* **pro_close** (Doesn't know how to recognize "proline-like" noncanonical D-amino acids, like D-hydroxyproline.)
* **cart_bonded** (Doesn't know what the ideal geometry for noncanonicals is, as far as I know.)
* **rama** and **rama_prepro** (Completely ignores noncanonicals, unless the **BACKBONE_AA** line is included in the params file, and this line currently only allows canonical L-amino acids to be specified.)
* **p_aa_pp** (Completely ignores noncanonicals, unless the **BACKBONE_AA** line is included in the params file, and this line currently only allows canonical L-amino acids to be specified.)
* **fa_dun** (This _can_ score D-noncanonicals properly, if provided with a rotamer library that is pre-mirrored for the D-version of the noncanonical)

_PAGE STILL UNDER CONSTRUCTION_