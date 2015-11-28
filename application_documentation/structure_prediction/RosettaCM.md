#RosettaCM - Comparative Modeling with Rosetta

Metadata
========

Documentation by Sebastian Raemisch (raemisch@scripps.edu) and Jared Adolf-Bryfogle (jadolfbr@gmail.com)

Purpose
=======

This protocol functions to create a homology model or combined model of several different PDBs and templates.  It is used for comparative modeling of proteins.  

References
==========

_High-resolution comparative modeling with RosettaCM_.  
Song Y, DiMaio F, Wang RY, Kim D, Miles C, Brunette T, Thompson J, Baker D.,
Structure. 2013 Oct 8;21(10):1735-42. doi: 10.1016/j.str.2013.08.005. Epub 2013 Sep 12.

Algorithm
=========
The first step of the protocol is to thread the same sequence onto one or multiple templates.  These templates can be homologous proteins or the same proteins from multiple crystal structures.  The second step is to use the [[HybridizeMover]] through RosettaScripts to create a single model from the template(s) using foldtree hybridization, sampling regions from each template, and loop closure through cartesian minimization. 

Step One - Threading
====================

Step Two - Hybridize
====================

Options
=======

Tips
====

Post Processing
===============


##See Also

* [[HybridizeMover]]: The Hybridize Mover used by RosettaCM
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files