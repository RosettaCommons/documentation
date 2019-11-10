#constel: "Constellations" of atoms -- UNDER CONSTRUCTION
Metadata
========

Author: Andrea Bazzoli (ndrbzz [at] gmail.com)

Last updated: November 2019

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
The app accepts one—and only one—of the following six search option combinations (SEA#1 through SEA#6): 

**SEA#1** extracts all 2-residue constellations formed by a target residue:
````
-constel:pair_target_resnum <PDB_NUM>
-constel:target_chain <PDB_CHAIN>
````
* \<PDB_NUM\> is the target residue's number in the PDB file.
* \<PDB_CHAIN\> is the target residue's chain ID in the PDB file.

**SEA#2** extracts all 2-residue constellations formed by all residues:
````
-constel:pair_all_res
````

**SEA#3** extracts all 3-residue constellations formed by a target residue:
````
-constel:triple_target_resnum <PDB_NUM>
-constel:target_chain <PDB_CHAIN>
````
* \<PDB_NUM\> is the target residue's number in the PDB file.
* \<PDB_CHAIN\> is the target residue's chain ID in the PDB file.

**SEA#4** extracts all 3-residue constellations formed by all residues:
````
-constel:triple_all_res
````

**SEA#5** extracts all 2-residue constellations that can be obtained from a target type of 2-residue large-to-small mutation: 
````
-constel:pair_target_mutations <A><B>_<C><D>
````
* \<A\>, \<B\>, \<C\>, and \<D\> are 1-letter amino acid type codes. \<A\>\<B\>\_\<C\>\<D\> represents the target 2-residue mutation type, where \<A\>\<B\> denotes mutation from amino acid type \<A\> (larger) to amino acid type \<B\> (smaller), and \<C\>\<D\> denotes mutation from amino acid type \<C\> (larger) to amino acid type \<D\>
(smaller)

**SEA#6** extracts a single, target constellation 
````
-constel:target_cnl <CNL_FILE>
````
* \<CNL_FILE\> is the path to an input file specifying the constellation. The file has the following format:
````
<CID_1> <RNU_1> <ICO_1> <AASTA_1> <AAEND_1>
...
<CID_N> <RNU_N> <ICO_N> <AASTA_N> <AAEND_N>
````
* \<CID_i\>, \<RNU_i\>, \<ICO_i\>, \<AASTA_i\>, and \<AAEND_i\> are the chain ID, residue number, insertion code, start amino acid type (larger), and end amino acid type (smaller) of the ith residue contributing to the constellation (i=1,...N; N=2 or N=3)
\<AASTA_i\> and \<AAEND_i\> are one-letter amino acid type codes. 
* \<CID_i\>, \<RNU_i\>, and \<ICO_i\> are as given in the pose's input PDB file.
* A blank chain identifier in the input PDB file is specified by ',' (comma)
* A blank insertion code in the input PDB file is specified by '_' (underscore)

### Filtering options:
The application accepts any combination of the following filtering options (FIL#1 through FIL#12):

**FIL#1** deprives constellations of the atoms that are closest to the mutated residues after the mutation. This avoids clash between those residues and the rescuing compound:
````
-constel:cnl_stripped
````

**FIL#2** filters by solvent accessible surface area (SASA):
````
-constel:max_atom_sasa <X>
````
* \<X\> is the maximum allowed SASA for an atom in a constellation (squared angstrom). Defaults to 999999.9.



Output 
======
to be written
References
==========
to be written