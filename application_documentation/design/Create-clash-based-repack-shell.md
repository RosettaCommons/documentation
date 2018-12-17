#Create clash based repack shell application

Metadata
========

Application created by Roland Pache. The corresponding principal investigator is Tanja Kortemme (kortemme@cgl.ucsf.edu).

Purpose
===========================================

When creating a resfile for design positions, it's often useful to allow residues around the design positions to repack to accommodate the new amino acid identities. Manually identifying and specifying these residues can be tedious. The create_clash-based_repack_shell application aims to simplify this.

This application takes an input structure and a resfile with designable positions, and then automatically locates those positions with sidechains which may clash with any of the designable residues. It then alters the resfile to add repacking to those positions.


Input Files
===========

* -in:file:s -- The input protein to be designed. Note that currently the application will only use a single PDB-formatted file passed to -in:file:s -- other input approaches/formats do not work.
* -packing:resfile -- The initial resfile to use. This resfile should specify one or more positions to design. (The application may not work correctly with a repack-only resfile.) Other positions may be either NATAA or NATRO.

Output
=====

The file specified with -packing:resfile **will be modified** by adding NATAA lines for each (non-design) residue in the protein which has a sidechain which may clash with any of the designable rotamers at any of the designable positions.

A list of these residues will be printed to the tracer output, along with a PyMol-formatted selection string which can be used to visualize the locations of the selected residues.


##See Also

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
the first 

