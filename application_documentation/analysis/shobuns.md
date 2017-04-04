#shobuns: Buried UNSatisfied polar groups for the SHO solvation model
Metadata
========

Author: Andrea Bazzoli

Apr 2017 by Andrea Bazzoli (ndrbzz [at] gmail.com).

Code
====

The application's code lives in `src/apps/public/analysis/shobuns.cc`.

Application's purpose
===================

Given a target set of polar groups, identifies those that are buried unsatisfied for the SHO model of polar solvation.

A polar group is defined to be "buried unsatisfied" if it has a SHO energy higher than a given cutoff and if it is not hydrogen bonded to any atom of the solute. 
