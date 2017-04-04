#shobuns: Buried UNSatisfied polar groups for the SHO solvation model
Metadata
========

Author: Andrea Bazzoli

Apr 2017 by Andrea Bazzoli (ndrbzz [at] gmail.com).

Code
====

The code for the application lives in `src/apps/public/analysis/shobuns.cc`.

Application purpose
===================

Identifies the buried unsatisfied polar groups in a pose or among a given set of polar groups. A polar group is defined to be "buried unsatisfied" if it is not hydrogen-bonded to any solute atom and if it has a SHO energy higher than a given cutoff.

