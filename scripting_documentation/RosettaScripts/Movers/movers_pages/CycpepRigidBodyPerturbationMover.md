# CycpepRigidBodyPerturbationMover 
*Back to [[Mover|Movers-RosettaScripts]] page.*
## CycpepRigidBodyPerturbationMover

[[_TOC_]]

### Description

The CycpepRigidBodyPerturbationMover is used to consider alternative docked conformations of a cyclic peptide bound to a protein.  Given a residue selector that selects the cyclic peptide portion, the mover superimposes the cyclic peptide on a cyclic permutation or inverse cyclic permutation of itself, adds a small random offset and orientation permutation, and updates the coordinates of only the cyclic peptide atoms.  The mover can act in one of two modes.  In "randomized_perturbation" mode, the cyclic permutation is random, and will vary from run to run (nstruct to nstruct).  In "set_permutation" mode, the user specifies the permutation offset, and whether or not a reverse permutation should be used.  Note that this mover only does rigid body perturbations.  It is highly recommended to follow this with side-chain repacking and energy minimization (for example, with the [[FastRelax mover|FastRelaxMover]].

### Author and Development History

The mover was written by Vikram K. Mulligan, Center for Computational Biology, Flatiron Institute (vmulligan@flatironinstitute.org) on 9 Dec. 2021.  It was tested by Stephan Kudlacek, Menten AI (stephan.kudlacek@menten.ai).

### Code Organization

The mover and its creator are found in the `protocols::cyclic_peptide` namespace, and in the `Rosetta/main/source/src/protocols/cyclic_peptide` directory.

### Usage

[[include:mover_CycpepRigidBodyPerturbationMover_type]]

##See Also

* [[PeptideStubMover]] -- Build a peptide one amino acid at a time.
* [[PeptideCyclizeMover]] -- Connect the termini of a peptide to cyclize it.
* [[ModifyVariantTypeMover]] -- Alter the variant types on an amino acid (for example, to remove terminal types).
* [[DeclareBond mover|DeclareBond]] -- Create a chemical bond between two open connection points.
* [[simple_cycpep_predict application|simple_cycpep_predict]] -- Predict structures of cyclic peptides from amino acid sequence, and validate peptide designs.
* [[I want to do x]]: Guide to choosing a mover
