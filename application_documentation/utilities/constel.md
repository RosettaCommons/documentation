#constel: "Constellations" of atoms for chemical rescue of structure
Metadata
========

Author: Andrea Bazzoli (ndrbzz [at] gmail.com)

Last updated: March 2020

Code
====

The application's code lives in `src/apps/public/constel.cc`.

Application's purpose
===================
Extracts "constellations" of atoms from a protein structure. A constellation is defined as the arrangement of atoms that are lost by a group of spatially contiguous residues upon mutation to a smaller residue. (Two residues are defined to be "spatially contiguous" if their side-chains interact with an unweighted attractive van der Waals energy [fa_atr] lower than –0.375.)

Once extracted, constellations may serve as templates for compounds to rescue the structure and activity of the mutated protein or protein complex.

Usage
=====
Application-specific options are divided into "search" options and "filtering" options.

### Search options: accepted combinations
The application requires one—and only one—of the following 6 search option combinations (SEA#1 through SEA#6): 

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
-constel:chain_interface
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

**FIL#6** extracts only constellations near the N- or C-termini of a protein chain:
````
-constel:prox_ct_max <DCT>
-constel:prox_tt_max <DTT>
-constel:prox_nres <TNUM>
````
* \<DCT\> is the maximum allowed distance (angstroms) between a constellation and the N- or C-termini of any chain that the constellation belongs to. The position of the constellation is that of its center of mass; the position of each terminal residue is that of its CA atom. Defaults to 0, meaning that this option combination is inactive.
* \<DTT\> is the maximum allowed distance (angstroms) between the N- and C-termini of any chain that a constellation belongs to. Defaults to 10.
* \<TNUM\> is the number of residues forming the N- and C-termini. Defaults to 10.

**FIL#7** extracts only constellations that are in principle compatible with rescue by a compound that contains an indole moiety and a carboxylic group:
````
-constel:indole_coo
````

**FIL#8** extracts only constellations that are in principle compatible with rescue by tryptamine:
````
-constel:tryptamine
````

**FIL#9** extracts only constellations that are in principle compatible with rescue by amphetamine:
````
-constel:amphetamine
````

**FIL#10** extracts only constellations that are in principle compatible with rescue by histamine:
````
-constel:histamine
````

Output 
======
A set of PDB files, each describing a different constellation. For example, the output of command line
````
constel.linuxclangrelease -s 2awl.pdb -constel:triple_target_resnum 69 -constel:target_chain A -constel:max_atom_sasa 15 -constel:aromatic
````
is a set of 160 constellation files:
````
...
constel_Q0069GA_F0084AA_V0150GA.pdb
constel_Q0069GA_F0084AA_Y0092AA.pdb
constel_Q0069GA_F0084AA_Y0092FA.pdb
constel_Q0069GA_F0084AA_Y0092GA.pdb
constel_Q0069GA_F0084AA_Y0092LA.pdb
constel_Q0069GA_F0084GA_I0152AA.pdb
constel_Q0069GA_F0084GA_I0152GA.pdb
constel_Q0069GA_F0084GA_I0152VA.pdb
constel_Q0069GA_F0084GA_I0161AA.pdb
constel_Q0069GA_F0084GA_I0161GA.pdb
constel_Q0069GA_F0084GA_I0161VA.pdb
constel_Q0069GA_F0084GA_L0201AA.pdb
constel_Q0069GA_F0084GA_L0201GA.pdb
constel_Q0069GA_F0084GA_N0185AA.pdb
...
````
Output file names have the "constel\_\<M1\>\_\<M2\>(\_\<M3\>).pdb" format. \<Mi\> denotes mutation of the ith residue of the constellation (i=1,2,3), and has the \<S\>\<IIII\>\<E\>\<C\> format, where \<S\> is the start amino acid type, \<IIII\> is a four-digit, zero padded number denoting the residue's number, \<E\> is the end amino acid type, and \<C\> is the residue's chain ID.

Each output file starts with one HEADER line that summarizes the constellation, and then lists the ATOM records of the constellation. In the example above, file constel_Q0069GA_F0084AA_Y0092LA.pdb has the following contents:
````
HEADER    1st MUTATION: A:Q69G 2nd MUTATION: A:F84A 3rd MUTATION: A:Y92L
ATOM      1  CB  GLN A  69      27.786  23.666   8.084  1.00  9.49           C  
ATOM      2  CG  GLN A  69      28.268  24.943   7.384  1.00 14.82           C  
ATOM      3  CD  GLN A  69      28.124  26.209   8.214  1.00 17.44           C  
ATOM      4  OE1 GLN A  69      27.286  26.296   9.111  1.00 19.60           O  
ATOM      5  NE2 GLN A  69      28.920  27.217   7.883  1.00 18.31           N  
ATOM      6  CG  PHE A  84      27.462  21.466  11.574  1.00  7.47           C  
ATOM      7  CD1 PHE A  84      26.557  22.537  11.710  1.00  6.59           C  
ATOM      8  CD2 PHE A  84      28.838  21.727  11.593  1.00  4.88           C  
ATOM      9  CE1 PHE A  84      27.024  23.868  11.862  1.00  6.87           C  
ATOM     10  CE2 PHE A  84      29.330  23.043  11.744  1.00  9.75           C  
ATOM     11  CZ  PHE A  84      28.423  24.118  11.878  1.00  9.03           C  
ATOM     12  CE1 TYR A  92      22.400  23.144  10.666  1.00  9.42           C  
ATOM     13  CE2 TYR A  92      23.040  20.837  11.071  1.00 12.92           C  
ATOM     14  CZ  TYR A  92      23.118  22.004  10.294  1.00 12.27           C  
ATOM     15  OH  TYR A  92      23.886  22.013   9.152  1.00 11.00           O  
````


References
==========
Khowsathit J, Bazzoli A, Cheng H, and Karanicolas J. _Computational design of an allosteric antibody switch by deletion and rescue of a complex structural constellation._ ACS Central Science (2020), https://doi.org/10.1021/acscentsci.9b01065 
