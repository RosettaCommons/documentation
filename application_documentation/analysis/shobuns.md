#shobuns: Buried UNSatisfied polar atoms for the SHO solvation model
Metadata
========

Author: Andrea Bazzoli

Apr 2017 by Andrea Bazzoli (ndrbzz [at] gmail.com).

Code
====

The application's code lives in `src/apps/public/analysis/shobuns.cc`.

Application's purpose
===================

Given a target set of polar atoms, identifies those that are buried unsatisfied for the SHO model of polar solvation.

A polar atom is defined to be "buried unsatisfied" if it has a SHO energy higher than a given cutoff and if it is not hydrogen bonded to any atom of the solute. 

Usage
=====

The application accepts only the following combinations of options:

* **Option combination #1** evaluates all polar atoms in the pose:  
````
[NO OPTIONS]
````

* **Option combination #2** evaluates all polar atoms named \<ATOM\> in all residues of type \<AMINO\>:
````
-pose_metrics:shobuns:tgt_amino <AMINO>
-pose_metrics:shobuns:tgt_atom <ATOM>
````

\<AMINO\> is a one-letter amino acid code. If \<AMINO\> is the string `any `, then the application will evaluate all polar atoms named \<ATOM\> from all residues that have one.

* **Option combination #3** evaluates all polar atoms from the residues specified in target file \<TGTFIL\>:
````
-pose_metrics:shobuns:tgtres <TGTFIL>
````
File \<TGTFIL\> specifies one target residue per line by indicating—in that order—the residue's chain ID, sequence number, and insertion code in the input PDB file. For example, to evaluate residues 50, 52, 54, and 55 from chain A, all having a blank insertion code, one would specify the following \<TGTFIL\> file:
````
A 50 _
A 52 _
A 54 _
A 55 _
```` 

