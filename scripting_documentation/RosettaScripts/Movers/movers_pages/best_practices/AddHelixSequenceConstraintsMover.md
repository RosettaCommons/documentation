# AddHelixSequenceConstraints Mover
Page created on 12 February 2017 by Vikram K. Mulligan (vmullig@uw.edu), Baker Laboratory.
*Back to [[Mover|Movers-RosettaScripts]] page.*

[[_TOC_]]

## Mover description

     The AddHelixSequenceConstraints mover sets up sequence constraints for each helix in a pose or in a selection.  It can require negative and positive charges at the N- and C-termini, respectively, can limit the number of helix-disfavouring residues in each helix, and can require that the helix be a user-specified fraction alanine.  Note that these constraints remain attached to the pose, and are intended to be used during design with the aa_composition score term.  Helices are detected using DSSP when this mover is applied, so if the secondary structure changes between application of this mover and design, the constraints will applied to out-of-date residue indices.  (In such a case, the sequence constraints can be re-applied with this mover after first clearing the old constraints with either the ClearCompositionConstraintsMover, or by setting "reset=true" in this mover's options.)

     Note that this mover's defaults have been set so that it can be applied without manually setting anything, and still produce reasonable behaviour.  For advanced users, all settings can be tweaked manually, but this shouldn't be necessary in many cases.



