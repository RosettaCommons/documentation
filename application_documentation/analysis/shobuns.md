#shobuns: Buried UNSatisfied polar atoms for the SHO solvation model
Metadata
========

Author: Andrea Bazzoli (ndrbzz [at] gmail.com)

Last updated: April 2017

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

* **Option combination #2** selects all polar atoms named \<ATOM\> from all residues of type \<AMINO\>:
````
-pose_metrics:shobuns:tgt_atom <ATOM>
<ATOM> is the atom name.

-pose_metrics:shobuns:tgt_amino <AMINO>
<AMINO> is the residue type's one-letter code. If <AMINO> is the string "any" (without quotes), then the application selects all polar atoms named <ATOM> from all residues that have one.
````

* **Option combination #3** selects all polar atoms from the residues specified in target file \<TGTFIL\>:
````
-pose_metrics:shobuns:tgt_res <TGTFIL>
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
<CUTOFF> is the maximum SHO-energy value (kcal/mol) that an atom can have in order to be classified as solvent exposed (i.e., not buried). Defaults to 4.9.
```` 

Output (on screen)
==================
Classification of the selected polar atoms into "buried unsatisfied" and "other" atoms. The output reports one line per atom, each of which has the following format:
````
ATOM_ID Esho #hb (wEhb wEsho+wEhb)

ATOM_ID: identifier.
Esho: SHO energy (kcal/mol).
#hb: number of H-bonds formed.
wEhb: weighted H-bond energy (secondary information).
wEsho+wEhb: weighted SHO plus H-bond energy (secondary information), not counting the SHO-to-EEF1 scaling (see Ref. 1).
````


Here is an output sample:
````
BURIED UNSATISFIED ATOMS:
A55(15)1HH1 Esho:5 #hb:0  (wEhb:0 wEsho+wEhb: 4.6875)
A52(12) H   Esho:5 #hb:0  (wEhb:0 wEsho+wEhb: 4.6875)
A54(14) H   Esho:5 #hb:0  (wEhb:0 wEsho+wEhb: 4.6875)
...

OTHER ATOMS:
A55(15) H   Esho:1.77322 #hb:0  (wEhb:0 wEsho+wEhb: 1.66239)
A55(15) HE  Esho:0.30118 #hb:0  (wEhb:0 wEsho+wEhb: 0.282356)
A55(15)2HH1 Esho:2.82807 #hb:1  (wEhb:-0.310352 wEsho+wEhb: 2.34097)
A55(15)1HH2 Esho:0.165621 #hb:0  (wEhb:0 wEsho+wEhb: 0.15527)
A55(15)2HH2 Esho:0.378151 #hb:0  (wEhb:0 wEsho+wEhb: 0.354516)
A55(15) O   Esho:2.06023 #hb:1  (wEhb:-0.0767224 wEsho+wEhb: 1.85474)
A52(12) O   Esho:0.571469 #hb:0  (wEhb:0 wEsho+wEhb: 0.535752)
...
````

References
==========
[1] Bazzoli A, Karanicolas J. _"Solvent hydrogen-bond occlusion": A new model of polar desolvation for biomolecular energetics_ . J Comput Chem. 2017 Mar 20. doi: 10.1002/jcc.24740. 
