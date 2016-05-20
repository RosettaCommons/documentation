#Surface Docking Application 

Purpose
=======

Surface docking is a protocol for simultaneous optimization of protein rigid-body orientation, backbone and side chain conformations on a solid mineral surface. Fragment insertion, small, and shear moves are used to optimize the protein fold while the standard RosettaDock algorithm is applied to optimize rigid body orientation. Standard docking is supplemented by a SurfaceOrientMover that enforces the periodic boundary conditions of a crystalline mineral surface. All degrees of freedom pertaining to the mineral surface remain fixed. 

References
==========

Pacella MS, Koo da CE, Thottungal RA, Gray JJ (2013) Using the RosettaSurface algorithm to predict protein structure at mineral surfaces. Methods Enzymol 532: 343-366. [Paper](http://www.sciencedirect.com/science/article/pii/B9780124166172000163) 


Input
=====

Surface docking takes as input a single PDB formatted structure with the protein positioned directly above the mineral surface face it is desired to dock to. The protein coordinates must be listed after the surface coordinates in the PDB file and they must be separate chains. All residues belonging to the surface should be listed as the same chain. 

A surface vectors file must also be provided. This file specifies three points that define the plane of the surface and the periodicity of the surface. The first point should lie near the center of the surface. The second and third points define vectors originating from the first point and correspond to the lattice vectors of the surface unit cell. 


Output
===============

Surface docking outputs three pdbs, a solution state structure, a surface state bound structure, and a final scored pdb. 


Command Line Options
====================

**Sample command**

```
surface_docking.linuxgccrelease -database /path/to/rosetta/main/database -in:file:s input.pdb -in:file:surface_vectors surface_vectors.surf -include_surfaces
```

surface docking can take all general file IO options common to all Rosetta applications written with JD2: (see JD2 documentation for details)

```
   -database                 Path to rosetta databases
   -in:file:s                Input pdb file(s)
   -score:weights            Supply a different weights file from the Rosetta default
   -score:patch              Supply a different patch file from the Rosetta default
   -nstruct                  Make how many decoys per input structure ?
```

Options specific to surface_docking

```
   Simple Options:
   -include_surfaces         Allows recognition of mineral surface residue types by rosetta 
   -in:file:surface_vectors  Specify the name of the surface vectors file that will define the surface
```

Example
=======

A protocol capture of surface docking may be found in Rosetta/demos/protocol_capture/2013/surface_docking

Results
=======

Surface docking returns three full-atom pdb structures: one solution state structure, one surface state structure, and one final scored pdb.  Depending on the size of the protein and the degree of convergence of the results either the lowest energy structure or statistics on the top 1% low energy structures may be desired. 

Description of algorithm
========================

The algorithm employs a multiscale MCM protocol based on Rosetta docking (Gray et al., 2003) and folding (Simons et al., 1999) strategies. A key feature in our algorithm is variation in the number of cycles before transitioning from the “solution” to the “adsorbed” stages. In the solution stage, the protein is able to sample both extended and compact structures. Once adsorbed onto the surface, large conformational changes often produce steric clashes between protein and surface atoms, preventing acceptance in a traditional MC algorithm (a computational limitation). In the algorithm, the protein begins the solution stage as a fully extended peptide chain and undergoes several optimization cycles, each resulting in a more compact and “protein-like” structure, containing features that occur frequently in known crystal structures. Varying the number of optimization cycles in solution before transitioning to the adsorbed state ensures that both extended (few optimization cycles in solution) and compact (many optimization cycles in solution) structures are sampled in the adsorbed state. Physically, this feature allows the calculation to capture protein conformational changes upon adsorption (such as unfolding or structural transitions).



##See Also

* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
* [[Design applications]]: A list of other applications that can be used for design.
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
