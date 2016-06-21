GlycanRelax
===========

[[_TOC_]]

MetaData
========

Application created by Jared Adolf-Bryfogle (jadolfbr@gmail.com) and Jason Labonte (JWLabonte@jhu.edu)

PIs: William Schief (schief@scripps.edu) and Jeffrey Gray (jgray@jhu.edu)


Description
===========

App: glycan_relax


Glycan Relax aims to sample potential conformational states of carbohydrates, either attached to a protein or free.  It is extremely fast.  Currently, it uses a few strategies to do so, using statistics from various papers, the CHI (CarboHydrate Intrinsic) energy term, and a new framework for backbone dihedral sampling. Conformer statistics adapted from Schief lab Glycan Relax app, originally used/written by Yih-En Andrew Ban.

Algorithm
=======

Each round optimizes either one residue for BB sampling, linkage, or multiple for minimization. The overall total number of rounds is scaled linearly with the number of residues to sample.

Currently uses a random sampler with a set of weights to each mover for sampling.  The packing of OH groups is currently disabled for speed and memory.

Weights are currently as follows:
 .20 Phi Sugar BB Sampling
 .20 Psi Sugar BB Sampling
 .20 Linkage Conformer Sampling
 .30 Small BB Sampling - equal weight to phi, psi, or omega
    -> .17 +/- 15 degrees
    -> .086 +/- 45 degrees
    -> .044 +/- 90 degrees
 .10 MinMover

Options
=======

Tips
====

Typical Use
===========

RosettaScript Tags
==================
This application is itself a mover and can be called directly within in RosettaScripts.  Options are similar to command-line options.  Here are the tags as in most RosettaScript Documentation:
