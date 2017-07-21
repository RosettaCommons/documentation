#interface_energy: energy at the interface between two sets of residues 
Metadata
========

Author: Andrea Bazzoli (ndrbzz [at] gmail.com)

Last updated: July 2017

Code
====

The application's code lives in `src/apps/public/analysis/interface_energy.cc`.

Application's purpose
===================

Given two residue sets, or "faces", computes their interface energy as the sum of pairwise residue energies over all residue pairs (R1, R2), R1 belonging to face #1 and R2 belonging to face #2.

Usage
=====

### Command line
````
interface_energy -s <POSE> -face1 <FACE1> -face2 <FACE2> -score:hbond_bb_per_residue_energy
````
\<FACE1\> and \<FACE2\> are paths to two files that define face #1 and face #2, respectively. Each file specifies one residue per line by indicating—in that order—the residue's chain ID, sequence number, and insertion code in the input PDB file.

### Input example
The following \<FACE1\> defines a face consisting of residues 58, 59, and 60 from chain H:
````
H 58 _
H 59 _
H 60 _
````

The following \<FACE2\> defines a face consisting of residues 94 and 95 from chain A:
````
A 94 _
A 95 _
````
Note that a blank insertion code is denoted by underscore (_).

Output (on screen)
==================
* Pairwise energies of all residue pairs (R1, R2) for each of several types of energy (short-ranged, context-dependent long-range, context-independent long-range).
* Total interface energy, computed as the sum of those pairwise contributions.

For example, the output for the above two faces (given a certain input pose) is the following:
````
##### PAIRWISE SHORT-RANGE ENERGIES #####
ILE58_H(51) --- HIS94_A(220): 0
ILE58_H(51) --- PRO95_A(221): 0
ASN59_H(52) --- HIS94_A(220): 0
ASN59_H(52) --- PRO95_A(221): 0
TRP60_H(53) --- HIS94_A(220): -0.92086
TRP60_H(53) --- PRO95_A(221): -0.962562

##### PAIRWISE ENERGIES FOR CI_LR_2B METHOD IN CHARGE OF dslf_ss_dst #####
ILE58_H(51) --- HIS94_A(220): 0
ILE58_H(51) --- PRO95_A(221): 0
ASN59_H(52) --- HIS94_A(220): 0
ASN59_H(52) --- PRO95_A(221): 0
TRP60_H(53) --- HIS94_A(220): 0
TRP60_H(53) --- PRO95_A(221): 0

##### PAIRWISE ENERGIES FOR CI_LR_2B METHOD IN CHARGE OF rama_prepro #####
ILE58_H(51) --- HIS94_A(220): 0
ILE58_H(51) --- PRO95_A(221): 0
ASN59_H(52) --- HIS94_A(220): 0
ASN59_H(52) --- PRO95_A(221): 0
TRP60_H(53) --- HIS94_A(220): 0
TRP60_H(53) --- PRO95_A(221): 0

##### TOTAL INTERFACE ENERGY: -1.88342
````
In the notation used to specify a residue, after the obvious descriptors, the number in parentheses denotes the residue's index in the pose.

Note that energy types which are inactive, and hence contribute no energy (like context-dependent long-range energies in the above example), are not included in the output.

References
==========
[1] Bazzoli A, Vance DJ, Rudolph MJ, Rong Y, Angalakurthi SK, Toth IV RT, Middaugh CR, Volkin DB, Weis DD, Karanicolas J, Mantis NJ. _Using homology modeling to interrogate binding affinity in neutralization of ricin toxin by a family of single domain antibodies_. Proteins: Structure, Function, and Bioinformatics, doi:
10.1002/prot.25353, 2017.

See also
========
[[Interface analyzer]]: Calculates binding energies, buried surface areas, and other metrics for interfaces between two or more chains in a PDB.

[[Residue Energy Breakdown]]: Decompose structure energies on a pairwise basis.