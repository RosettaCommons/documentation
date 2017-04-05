#shobuns: Buried UNSatisfied polar atoms for the SHO solvation model (WORK IN PROGRESS)
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

### Accepted option combinations
Application-specific options are accepted only in the following combinations:

* **Option combination #1** selects all polar atoms in the pose:  
````
[NO OPTIONS]
````

* **Option combination #2** selects all polar atoms named \<ATOM\> in all residues of type \<AMINO\>:
````
-pose_metrics:shobuns:tgt_atom <ATOM>
<ATOM> is the atom name.

-pose_metrics:shobuns:tgt_amino <AMINO>
<AMINO> is the residue type's one-letter code. If <AMINO> is the string "any" (without quotes), then the application selects all polar atoms named <ATOM> from all residues that have one.
````



* **Option combination #3** selects all polar atoms from the residues specified in target file \<TGTFIL\>:
````
-pose_metrics:shobuns:tgtres <TGTFIL>
<TGTFIL> is a pathname.
````
File \<TGTFIL\> specifies one target residue per line by indicating—in that order—the residue's chain ID, sequence number, and insertion code in the input PDB file. For example, to select residues 50, 52, 54, and 55 from chain A, all having a blank insertion code, one would specify the following \<TGTFIL\> file:
````
A 50 _
A 52 _
A 54 _
A 55 _
````
Note that a blank insertion code is specified by underscore (_).

### Further options
The above option combinations can be supplemented with the following options:
````
pose_metrics:shobuns:sho_cutoff <CUTOFF>
<CUTOFF> is the maximum SHO-energy value (kcal/mol) for an atom to be classified as solvent exposed (i.e., not buried). Defaults to 4.9 kcal/mol.
```` 

--- to be continued ---