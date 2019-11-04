#constel: "Constellations" of atoms
Metadata
========

Author: Andrea Bazzoli (ndrbzz [at] gmail.com)

Last updated: October 2019

Code
====

The application's code lives in `src/apps/public/constel.cc`.

Application's purpose
===================
Extracts "constellations" of atoms from a protein structure. A constellation is defined as the arrangement of atoms that are lost by a group of spatially contiguous residues upon mutation to a smaller residue.

Once extracted, constellations may serve as templates for compounds that rescue the structure and activity of the mutated protein or protein complex.

Usage
=====
Application-specific options are divided into "search" options and "filtering" options.

### Search options: accepted combinations


**Search option combination #1** extracts all 2-residue constellations formed by a target residue:
````
-constel:pair_target_resnum <PDB_NUM>
-constel:target_chain <PDB_CHAIN>
````
* \<PDB_NUM\> is the target residue's number in the PDB file.
* \<PDB_CHAIN\> is the target residue's chain ID in the PDB file.

**Search option combination #2** extracts all 2-residue constellations formed by all residues:
````
-constel:pair_all_res
````

**Search option combination #3** extracts all 3-residue constellations formed by a target residue:
````
-constel:triple_target_resnum <PDB_NUM>
-constel:target_chain <PDB_CHAIN>
````
* \<PDB_NUM\> is the target residue's number in the PDB file.
* \<PDB_CHAIN\> is the target residue's chain ID in the PDB file.

**Search option combination #4** extracts all 3-residue constellations formed by all residues:
````
-constel:triple_all_res
````

**Search option combination #5** extracts all 2-residue constellations that can be obtained from a target type of 2-residue large-to-small mutation: 
````
-constel:pair_target_mutations <A><B>_<C><D>
````
* <A>, <B>, <C>, and <D> are 1-letter amino acid type codes. <A><B>_<C><D> represents the target 2-residue mutation type, where <A><B> denotes mutation from amino acid type <A> (larger) to amino acid type <B> (smaller), and <C><D> denotes mutation from amino acid type <C> (larger) to amino acid type <D>
(smaller)


Output 
======
to be written
References
==========
to be written