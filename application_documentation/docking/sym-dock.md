#Symmetric docking

Metadata
========

Author: Ingemar André

This document was edited Aug 20th 2010 by Ingemar Andre. This application in rosetta was created by Ingemar André.

Code and Demo
=============

The code for the symmetric docking application is in rosetta/main/source/src/apps/pilot/andre/SymDock.cc. See `       rosetta/tests/integration/tests/symmetric_docking      ` for an example of symmetric docking protocol and input files.

References
==========

Andre I, Bradley P, Wang C, Baker D. Prediction of the structure of symmetrical protein assemblies. Proc Natl Acad Sci U S A. 2007 Nov 6;104(45):17656-61.

Application purpose
===========================================

The application predicts the structure of symmetric homooligomeric protein assemblies starting from the structure of a single subunit. It is very similar in spirit to the [[standard protein-protein docking protocol|docking-protocol]] and contains the same basic components. The relative subunit orientation and conformations of side-chains are simultaneously optimized for a symmetric protein assembly.

Algorithm
=========

The protocol starts by generating an initial symmetric assembly configuration described by the symmetrical definition given as a input to rosetta. The rigid body position (the relative orientation between subunits) is then randomized to get a unbiased starting state. The protocol proceeds with a low resolution stage where the conformational universe is reduced to only configurations in which the subunits form significant amount contacts between them. First the subunits are translated along the allowed degrees of freedom into glancing contact. In a symmetric system there may be several translation degrees of freedom and a multidimensional slide might be required. In the simplest and most common type of symmetry, twofold symmetry (c2), translation can only occur along an axis that connects the the center of mass of the two subunits. This is typically set up to be the x-axis of the system and translation is only allowed along x. With more complicated symmetries there will often be several directions that translation can happen while maintaining the overall symmetry of the system. Generally, how slide moves are performed can be controlled by a parameter in the symmetry definition input. By default, a slide degree of freedom is randomly selected and subunits are translated along this direction until contact is found with other subunits. Then the next translational degree of freedom is selected and a slide into contact is performed. The next step is to optimize the rigid body orientation using Monte Carlo search using a low resolution energy function (same as docking, but symmetric).

The protocol proceeds with a high-resolution stage that simultaneously optimizes the side-chain and rigid body conformation using a Monte-Carlo Minimization (MCM) strategy. This mimics the standard heterodimeric docking protocol.

Symmetry
========

Protein assemblies can adopt multiple types of symmetrical assemblies. Rosetta can model any type of symmetry. You can find a short description of the more common symmetry types in the [[Symmetry User's Guide.|symmetry]] For a more thorough description of symmetry in biological macromolecules see "Structural symmetry and protein function" Goodsell DS and Olsson AJ, Annu Rev Biophys Biomol Struct. 2000;29:105-53.

Input Files
===========

-   The input to the symmetric docking protocol is a single monomeric structure. If you are running a refinement of an assembly or a dock\_pert the rigid body orientation of the input monomer must match with the input symmetry definition to correctly regenerate the full assembly. Use the make\_symmdef\_file script to get a matching input structure and symmetry defintion file.
-   A symmetry definition file must be given defining the symmetry of the simulated system. If your have no prior knowledge of the rigid body configuration you can use the [[make_symmdef_file_denovo|make-symmdef-file-denovo]] script to generate the symmetry input file for the common symmetry types (cyclical or dihedral). If you have a starting configuration to refine or perturb use the [[make_symmdef_file|make-symmdef-file]] script instead. If you want to simulate a symmetry not encoded in the make\_symmdef\_file\_denovo then the symmetry definition can be written by hand. This may be complicated and the alternative is to to analyze a protein complex with the same symmetry in the PDB database and to generate a symmetry definition file from this protein. Then make sure that the initial orientation is properly randomized by editing the definition file.

Observe that for more complex symmetries you may have to edit the definition file to select in which order translation (sliding-into-contact) movements are supposed to be done. Read the [[Symmetry User's Guide.|symmetry]] for reference.

Options
=======

General/Packing Options
-----------------------

-   -database [file path] - the Rosetta 3 database location

-   -in:file:s [file path] - the input subunit structure

-   -ex1, -ex2, -extrachi\_cutoff [num residues], etc. - increase the resolution of the rotamer library

Currently the best place to read about packing options in general is in the documentation for the [[fixed backbone design application|fixbb]] .

Standard Docking options
------------------------

-   -docking:docking\_local\_refine - Do a local refinement of the docking position (high resolution).
-   -docking:dock\_ppk - Do a prepacking of the monomer before docking run. This will produce a homomeric output pdb. Use only a single monomer as input to rosetta.
-   -docking:dock\_mcm\_trans\_magnitude ANGSTROM - Size of random adjustment of rigid body position during mcm procedure.
-   -docking:dock\_mcm\_rot\_magnitude DEGREES - Size of random rotational adjustment of position during mcm procedure.

Note, that some options does not make sense in the context of symmetry (such as randomize1 or randomize2, spin, and that dock\_pert is covered by the -symmetry:perturb\_rigid\_body\_dofs flag (below) instead etc).

Symmetry options
----------------

-   -symmetry:initialize\_rigid\_body\_dofs - Initialize the rigid body configuration according to the symmetry definition file.
-   -symmetry:perturb\_rigid\_body\_dofs ANGSTROMS DEGREES - If you want to apply a rigid body perturbation to the initial rigid body conformation. This randomly translates and rotates the original starting complex with magnitudes controlled by the parameters values (ANGSTROMS, DEGREES). The perturbations are Guassian distributed and centered around the parameter values.
-   -symmetry:symmetric\_rmsd - Find the lowest rmds vs the native by considering all possible chain orderings. Necessary to get the right rms for systems with more than 2 subunits. May not be necessary if a local perturbation or dock\_pert is performed, if the input has the matching chain order. The number of rms calculations grows exponentially with number of subunits, so for large systems it will be very slow.

Output Options
--------------

-   The symmetric docking protocol uses the [[jd2 job distributor|jd2]] .

Tips
====

Similar to regular docking it generally makes sense to start with a prepacked protein monomer.

Because of the fewer degrees of freedom in a symmetric system it is generally not required to run as many models as in regular docking. For a cyclical system 5000 models should be enough. For many systems it is not necessary to explicitly simulate all subunits in the symmetrical systems. for example in a dodecamer with cyclical symmetry a subunit only interacts with neighbor subunits to the left or right of it in the ring. With the [[make_symmdef_file_denovo|make-symmdef-file-denovo]] you can add the -subsystem option to generate a smaller symmetry definition for a smaller system. With the [[make_symmdef_file|make-symmdef-file]] script this can be controlled by finetuning the cutoff distance (option -r). Subunits within the cutoff distance will be explicitly simulated.

A standard run would involve the following flags

```
-in:file:s
-in:file:native
-database
-symmetry:symmetry_definition
-packing:ex1
-packing:ex2aro
-out:nstruct
-out:file:fullatom
-symmetry:initialize_rigid_body_dofs
-symmetry:symmetric_rmsd
```

If you want to cluster the result make sure to output silent files ( -out:file:silent and -out:file:silent_struct_type binary ) as the symmetry information is lost when outputting PDB files.

Expected Outputs
================

The protocol produces PDB files or a silent file depending on your options together with a scorefile. The normal exit status of the protocol is coming from the jd2 job distributor. It says something like "You'll see the jd2 x jobs completed in y seconds message if successfully completed".

Post Processing
===============

The same procedures used for regular docking are used for symmetric docking. If you have a native reference generate a score vs rmsd plot and look for a funnel. Without a reference structure cluster the 200-400 lowest energy models using the cluster app. For some cases you may want to calculate a symmetric rms during clutering. Add -symmetry:symmetric\_rmsd as an option to the cluster app.



##See Also

* [[Docking Applications]]: Home page for docking applications
* [[Symmetry]]: Information on using Rosetta with symmetry
* [[Preparing structures]]: Notes on preparing structures for use in Rosetta
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[RosettaScripts]]: Homepage for the RosettaScripts interface to Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
