About
=====
Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
PI: William Scheif (Schief@scripps.edu)



Description
===========

A pilot app specifically for glycan clashes which quantifies clashes between specified glycan branches and other chains and glycan branch - glycan branch clashes.  Does not count clashes for intra glycan branch.  Does not echo input files, adds info to output scorefile to allow for MPI runs.

Clash Definition
============

 Atom is clashing if it clashes with ANY other atom
 Count up clashes (hard and soft) per-residue

 - Hard:
  - distance <= LJ1 + LJ2
 - Soft:
  - distance <= (LJ1 + LJ2) * (1 - S).  S is between 0 and 1. Here, we use .33 as default.

-> Intuitive definition, easily conceptualized, still quantitative


Relevant Options:
======

-glycan_branches
 - Required. Vector of glycan branches.  Rosetta Residue numbering or PDB like RosettaScripts

-chech_chains
 - Required. A list of chains to compute chain-based clashes.  If not given, will only compute glycan-glycan clashes!


-ignore_hydrogens
 - Should we calculate only heavy-heavy atom clashes?

-soft_clash
  - When we calculate atom-atom distances using LJ distances, clash if distance < (atomI_LJ + atomJ_LJ)*(1 - soft_clash)
