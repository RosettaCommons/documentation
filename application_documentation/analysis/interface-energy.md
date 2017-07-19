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