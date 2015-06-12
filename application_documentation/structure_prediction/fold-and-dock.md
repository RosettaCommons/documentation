#Fold And Dock

Metadata
========

Author: Ingemar Andre

This document was edited Aug 22th 2010 by Ingemar André. This application in rosetta was created by Ingemar André. The original fold-and-dock protocol in rosetta++ was written by Rhiju Das and Ingemar André.

Code and Demo
=============

The code for the fold-and-dock application is in `       rosetta/main/source/src/protocols/topology_broker/FoldAndDockClaimer.cc      ` . See `       rosetta/main/tests/integration/tests/fold_and_dock      ` for an example of fold-and/dock protocol and input files. Run without the -run:test\_cycles for a real case prediction example. Fold-and-dock uses the topology broker framework and the actual excecutable is the minirosetta application, `       rosetta/main/source/src/apps/public/boinc/minirosetta.cc      `

References
==========

Das R, André I, Shen Y, Wu Y, Lemak A, Bansal S, Arrowsmith CH, Szyperski T, Baker D. Simultaneous prediction of protein folding and docking at high resolution. Proc Natl Acad Sci U S A. 2009 Nov 10;106(45):18978-83. Epub 2009 Oct 28.

Application purpose
===========================================

The application predicts the structure of symmetric homooligomeric protein assemblies starting from the sequence of a subunit. It is a combination of the abinitio and [[symmetric assembly protocol|sym-dock]] .

Algorithm
=========

The protocol start by generating an initial symmetric assembly configuration described by the symmetrical definition file given as a input to rosetta using an extended conformation of the subunits. The rigid body position is then randomized to get an unbiased starting state. The protocol proceeds with a fragment assembly according to the standard abinitio protocol but combines this with additional moves used to optimize the binding orentation of subunits in the assembly. They involve moves to bring chains into contact (slide-into-contact), rigid-body randomizations and moves to change the anchor point by which the subunits are anchored to the coordinate system. The fraction of these moves relative to the fragment insertion moves can be controlled by options. The fragment assembly is performed through the topology broker framework and calls the same fragment assembly code that regular abinitio does. Look at the documentation for ab-initio for additional exlanation of how fragment assembly works in rosetta.

Depending on the user the protocol can then move into the all-atom refinement stage by calling the relax code. The relax code is sensitive to the presense of symmetry and relaxes the protein while maintaining the overall symmetry of the system.

Limitations: The protocol nly works on symmetric structures. It will most likely not work for protein in excess of 120 residues unless aditional experimental data is available.

Input Files
===========

-   fold-and-dock needs to be given protein sequence in fasta format. This is the sequence of a single subunit.

-   In addition, the location of fragment libraries must be specified.

-   A symmetry definition file must be give defining the symmetry of the simulated system. Typically you have no prior knowledge of the rigid body configuration, use the [[make_symmdef_file_denovo|make-symmdef-file-denovo]] script to generate the symmetry input file for the common symmetry types (cyclical or dihedral). If you want to simulate a symmetry not encoded in the make\_symmdef\_file\_denovo then the symmetry definition can be written by hand. This may be complicated and the alternative is to use to analyze a protein complex with the same symmetry in the PDB database and to generate a symmetry defintion file from this protein. Then make sure that the initial orientation is properly randomized by editing the definition file.

Observe that for more complex symmetries you may have to edit the definition file to select in which order translation (sliding-into-contact) movements are supposed to be done. Read the [[Symmetry User's Guide.|symmetry]] for reference.

-   The fold-and-dock protocol uses the topology broker framework. The borker is not part of the current rosetta release. However, all you need to do is to give rosetta a broker input file and give the option -broker:setup my\_setup\_file

```
CLAIMER FoldandDockClaimer
END_CLAIMER
```

The fasta file and fragments is most easily supplied through command line options but can also be specified through the broker input file (see broker documentation for example).

Options
=======

General/Packing Options
-----------------------

-   -database [file path] - the Rosetta3 database location

-   -in:file:fasta [file path] - The protein sequence of a single subunit

-   -file:frag3, -file:frag9 - The location of fragment libraries

-   -ex1, -ex2, -extrachi\_cutoff [num residues], etc. - increase the resolution of the rotamer library. Only used if the relax protocol is called at the end of fold-and-dock.

Abinitio options
-------

All the abinitio options are valid in fold-and-dock. See the documentation for abinitio for a full explanation.

Relax options
-------

All the Relax options are valid in fold-and-dock. See the documentation for <relax> for a full explanation.

Symmetry options
----------------

-   -symmetry:initialize\_rigid\_body\_dofs - Initialize the rigid body configuration according to the symmetry definition file.
-   -symmetry:perturb\_rigid\_body\_dofs ANGSTROMS DEGREES - If you want to apply a rigid body perturbation to the initial rigid body conformation. Rarely makes sense in the context of denovo structure prediction.

Required options
----------------

The following options should always be given to rosetta when running fold-and-dock.

```
-run:protocol broker    - Tells rosetta application to run the broker
-broker:setup               - The location of broker setup file
-database
-file:frag3
-file:frag9
-in:file:fasta
-symmetry:symmetry_definition
-symmetry:initialize_rigid_body_dofs    - Setup the rigid body system according to the symmetry definition file.
-run:reinitialize_mover_for_each_job    - Since an oligomer is made from a monomer we need to start fresh with a monomer for each simulation.
-out:file:silent_struct_type binary - Currently the only silent file type that is compatible with symmetry.
```

Fold-and-dock options
---------------------

```
-fold_and_dock:rigid_body_cycles - Number of rigid bosy cycles during fold and dock fragment insertion
-fold_and_dock:move_anchor_points  - Move the anchor points that define symmetric coordinate system during symmetry fragment insertion.
-fold_and_dock:set_anchor_at_closest_point - Set the anchor points that define symmetric coordinate system to the nearest point between two consecutive chains during fragment insertion.
-fold_and_dock:rotate_anchor_to_x - Rotate the anchor residue to the x-axis before applying rigid body transformations.
-fold_and_dock:trans_mag_smooth - Translation perturbation size for smooth refineme.
-fold_and_dock:rot_mag_smooth - Rotational perturbation size for smooth refinement.
-fold_and_dock:rb_rot_magnitude - Rotational perturbation size for rigid body perturbations.
-fold_and_dock:rb_trans_magnitude Translational perturbation size rigid body perturbations.
-fold_and_dock:rigid_body_cycles - Number of rigid bosy cycles during fold and dock fragment insertion.
-fold_and_dock:rigid_body_frequency - The fraction of times rigid body cycles are applied during fragment assembly moves.
-fold_and_dock:rigid_body_disable_mc - Dissallow moves to be accepted locally by Monte Carlo criteria within the rigid body mover.
-fold_and_dock:slide_contact_frequency - The fraction of times subunits are slided together during fragment assembly moves.
```

Additional useful flags
-----------------------

To add calculate a rmds to a reference structure use evaluators:

-evaluation:rmsd\_target - The reference pdb. It should be a oligomer with the same number of residues and sequence as the structure outputted by rosetta. -evaluation:rmsd\_column - Name of the output column in the scorefile and silent output file. evaluation:symmetric\_rmsd - Find the lowest rmds vs the native by considering all possible chain orderings. Necessary to get the right rms for systems with more than 2 subunits. May not be necessary if a local perturbation or dock\_pert is performed, if the input has the matching chain order. The number of rms calculations grows exponentially with number of subunits, so for large systems it will be very slow.

Tips
====

Because of the extra degrees of freedom needed to define the rigid body relation betweeen subunits in the assembly the conformation space is larger for fold-and-dock than regular abinitio with the same size of folded subunit. However, the symmetry constraint radically decreases the conformational space. Fold-and-dock requires about the same amount of sampling as regular abinitio, 5-100k models. Fold-and-dock without additional experiemental constraints (such as chemical shifts) is effective in the range below 100 residues.

Running fold-and-dock with chemical shift data follows the same procedure as regular abinitio. Just supply fold-and-dock with fragment libraries picked with chemical shift data.

For many systems it is not necessary to explicitly simulate all subunits in the symmetrical systems. for example in a dodecamer with cyclical symmetry a subunit only interacts with neighbor subunits to the left or right of it in the ring. With the [[make_symmdef_file_denovo|make-symmdef-file-denovo]] you can add the -subsystem option to generate a smaller symmetry definition for a smaller system. With the [[make_symmdef_file|make-symmdef-file]] script this can be controlled by finetuning the cutoff distance.

CPU Time: This is very dependent on the size of the protein. For most proteins it will be about 1-15 minutes per model. So the CPU time to generate a funneled energy landscape would vary between 150-10 000 CPU hours.

The following flags have been succesfull in repeating the result of the fold-and-dock benchmark in the original paper and is a good starting point.

```
-run:protocol broker
-broker:setup
-nstruct
-out:file:scorefile
-database
-file:frag3
-file:frag9
-in:file:fasta
-symmetry:symmetry_definition
-out:file:silent
-out:file:silent_struct_type binary
-relax:fast
-relax:jump_move
-symmetry:initialize_rigid_body_dofs
-fold_and_dock::rotate_anchor_to_x // May even be a required flag...
-evaluation:rmsd_target
-evaluation:rmsd_column
-evaluation:symmetric_rmsd
-rg_reweight 0.001 // Rewight the rg scoring term. For extended structures like coiled-coils this is crucial. For global structures perhaps not as beneficial.
-rigid_body_cycles 1 // Works in conjuction with rigid_body_disable_mc
-abinitio::recover_low_in_stages 0 // The lowest energy structure is not always selected after each stage.
                This prevents overoptimization of low-resolution energy but may not be optimal for all cases.
-rigid_body_frequency 5
-rigid_body_disable_mc  //  Makes sure that the rigid body moves are accepted by the same Monte Carlo process as the fragment sampling.
                This prevents overoptimization of low-resolution energy but may not be optimal for all cases.
-run:reinitialize_mover_for_each_job
```

Expected Outputs
================

The protocol produces a silent file together with a scorefile. The normal exit status of the protocol is coming from the jd2 job distributor, with message like "You'll see the jd2 x jobs completed in y seconds message if successfully completed". If you run with pdb output there will be additional pdb structures outputted: before\_repack.pdb, init\_dofs.pdb etc. They are generated by the general fragment sampling protocol in rosetta, which is called by fold-and-dock, as debug output. Do not use pdb output for production runs.

Post Processing
===============

The same procedures used for regular abinitio are used for fold-and-dock. If you have a native reference generate a score vs rmsd plot and lock for a funnel. Without reference structure cluster the 200-400 lowest energy models using the [[cluster app|cluster]] (for some cases you may want to calculate a symmetric rms during clutering. Add -symmetry:symmetric\_rmsd as an option to the cluster app).


##See Also

* [[Fasta file]]: Fasta file format
* [[Fragment file]]: Fragment file format (required for abinitio structure prediction)
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
  * [[Abinitio relax]]: Predict protein structure from its sequence
    * [[Abinitio]]: Details on this application
  * [[NonlocalAbinitio]]: Application for predicting protein structure given some prior structural information
  * [[Membrane abinitio]]: Ab initio for membrane proteins.  
  - [[Comparative modeling|minirosetta-comparative-modeling]]: Build structural models of proteins using one or more known structures as templates for modeling (uses the minirosetta application).
    * [[Minirosetta]]: More information on the minirosetta application.
  * [[Metalloprotein ab initio|metalloprotein-abrelax]]: Ab inito modeling of metalloproteins.  
  - [[Backrub]]: Create backbone ensembles using small, local backbone changes.  
  - [[Floppy tail]]: Predict structures of long, flexible N-terminal or C-terminal regions.
  - [[Fold-and-dock]]: Predict 3-dimensional structures of symmetric homooligomers.  
  - [[Molecular replacement protocols|mr-protocols]]: Use Rosetta to build models for use in X-ray crystallography molecular replacement.  
    * [[Prepare template for MR]]: Setup script for molecular replacement protocols.  
  - [[Relax]]: "Locally" optimize structures, including assigning sidechain positions.
* [[Docking applications]]
  - [[Camelid Antibody Modeling|antibody-mode-camelid]]: Docking antibody with their antigens
  - [[SnugDock | snugdock]]: Paratope structure optimization during antibody-antigen docking
  - [[Ligand docking|ligand-dock]] (RosettaLigand): Determine the structure of protein-small molecule complexes.  
    * [[Extract atomtree diffs]]: Extract structures from the AtomTreeDiff file format.
    - [[Docking Approach using Ray-Casting|DARC]] (DARC): Docking method to specifically target protein interaction sites.
    - [[Flexible peptide docking|flex-pep-dock]]: Dock a flexible peptide to a protein.
    - [[Protein-Protein docking|docking-protocol]] (RosettaDock): Determine the structures of protein-protein complexes by using rigid body perturbations.  
      * [[Docking prepack protocol]]: Prepare structures for protein-protein docking.  
    - [[Symmetric docking|sym-dock]]: Determine the structure of symmetric homooligomers.  
    - [[Chemically conjugated docking|ubq-conjugated]]: Determine the structures of ubiquitin conjugated proteins.  
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
