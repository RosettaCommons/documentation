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

**SEA#5** extracts all 2-residue constellations that match a target type of 2-residue large-to-small mutation: 
````
-constel:pair_target_mutations <A><B>_<C><D>
````
* \<A\>, \<B\>, \<C\>, and \<D\> are 1-letter amino acid type codes. \<A\>\<B\>\_\<C\>\<D\> represents the target 2-residue mutation type, where \<A\>\<B\> denotes mutation from amino acid type \<A\> (larger) to amino acid type \<B\> (smaller), and \<C\>\<D\> denotes mutation from amino acid type \<C\> (larger) to amino acid type \<D\>
(smaller).

**SEA#6** extracts a single, target constellation: 
````
-constel:target_cnl <CNL_FILE>
````
* \<CNL_FILE\> is the path to an input file specifying the constellation. The file has the following format:
````
<CID_1> <RNU_1> <ICO_1> <AASTA_1> <AAEND_1>
...
<CID_N> <RNU_N> <ICO_N> <AASTA_N> <AAEND_N>
````
* \<CID_i\>, \<RNU_i\>, \<ICO_i\>, \<AASTA_i\>, and \<AAEND_i\> are the chain ID, residue number, insertion code, start amino acid type (larger), and end amino acid type (smaller), respectively, of the ith residue contributing to the constellation (i=1,...,N; N=2 or N=3).
* \<AASTA_i\> and \<AAEND_i\> are one-letter amino acid type codes. 
* \<CID_i\>, \<RNU_i\>, and \<ICO_i\> are as given in the pose's input PDB file.
* A blank chain identifier in the input PDB file is specified by ',' (comma).
* A blank insertion code in the input PDB file is specified by '_' (underscore).

### Filtering options:
The application accepts one or more of the following 10 filtering option combinations (FIL#1 through FIL#10). Every filter is inactive by dafault.

**FIL#1** deprives constellations of the atoms that are closest to what remains of their residue after the mutation. This avoids clash between the mutated residues and the rescuing compound:
````
-constel:cnl_stripped
````

**FIL#2** filters by solvent accessible surface area (SASA):
````
-constel:max_atom_sasa <X>
````
* \<X\> is the maximum allowed SASA for an atom in a constellation (squared angstroms). Defaults to 999999.9.

**FIL#3** extracts only constellations that are shared by two or more chains: 
````
-constel:interface
````

**FIL#4** extracts only constellations that contain at least one aromatic ring:
````
-constel:aromatic
````

**FIL#5** extracts only constellations that do not contain any of a list of forbidden residues: 
````
-constel:cnl_exclude <FORBIDDEN>
````
* \<FORBIDDEN\> is the path to a file that lists the forbidden residues. The file has the following format:
````
<RNU_1> <CID_1> 
...
<RNU_N> <CID_N> 
````
* \<RNU_i\> and \<CID_i\> are the ith forbidden residue's number and chain ID, respectively, in the pose's input PDB file (i=1,...,N).

**FIL#6** extracts only constellations near the N- or C-terminui of a protein chain:
````
-constel:prox_ct_max <DCT>
-constel:prox_tt_max <DTT>
-constel:prox_nres <TNUM>
````
* \<DCT\> is the maximum allowed distance (angstroms) between a constellation and the N- or C-termini of any chain that the constellation belongs to. The position of the constellation is that of its center of mass; the position of each terminal residue is that of its CA atom. Defaults to 0, meaning that this option combination is inactive.
* \<DTT\> is the maximum allowed distance (angstroms) between the N- and C-termini of any chain that a constellation belongs to. Defaults to 10.
* \<TNUM\> is the number of residues forming the N- and C-termini. Defaults to 10.

**FIL#7** extracts only constellations that are in principle compatible with rescue by a compound that contains an indole moiety and a carboxylic group.
````
-constel:indole_coo
````

**FIL#8** extracts only constellations that are in principle compatible with rescue by tryptamine.
````
-constel:tryptamine
````

**FIL#9** extracts only constellations that are in principle compatible with rescue by amphetamine.
````
-constel:amphetamine
````

**FIL#10** extracts only constellations that are in principle compatible with rescue by histamine.
````
-constel:histamine
````

Output 
======
to be written
References
==========
Khowsathit J, Bazzoli A, Cheng H, and Karanicolas J. Allosteric control of antibody activity by
deletion and rescue of a complex structural constellation. 2019. Submitted.
