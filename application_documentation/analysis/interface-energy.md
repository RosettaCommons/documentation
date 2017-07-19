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

Command line
=====
````
interface_energy -s <POSE> -face1 <FACE1> -face2 <FACE2> -score:hbond_bb_per_residue_energy
````
* \<FACE1\> and \<FACE2\> are paths to two files specifying face #1 and face #2, respectively. Each file specifies one residue per line by indicating—in that order—the residue's chain ID, sequence number, and insertion code in the input PDB file.

Input example
=====
The following \<FACE1\> specifies a face consisting of residues 58, 59, and 60 from chain H:
````
H 58 _
H 59 _
H 60 _
````

The following \<FACE2\> specifies a face consisting of residues 94 and 95 from chain A:
````
A 94 _
A 95 _

````