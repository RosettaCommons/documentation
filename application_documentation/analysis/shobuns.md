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

* Option combination #1: evaluates all polar atoms in the pose
````
[NO OPTIONS]
````

* Option combination #2: evaluates all polar atoms named \<ATOM\> in all residues of type \<AMINO\>
````
-pose:metrics:shobuns:tgt_amino <AMINO>
-pose:metrics:shobuns:tgt_atom <ATOM>
````
\<AMINO\> is a three-letter amino acid code