## AddMHCEpitopeConstraintMover

Documentation created by Brahm Yachnin (brahm.yachnin@rutgers.edu), Khare laboratory and Chris Bailey-Kellogg (cbk@cs.dartmouth.edu).  Parts of this documentation are copied/adapted from Vikram K. Mulligan's (vmullig@uw.edu) design-centric guidance documentation.
Last edited May 8, 2019.

[[_TOC_]]

##Overview

A detailed explanation of packer-compatible de-immunization in Rosetta is described in the [[MHCEpitopeEnergy]] documentation.  If your goal is to apply de-immunization globally to an entire protein/pose, it is simple enough to configure the de-immunization protocol at the scorefunction level and use that scorefunction for all relevant design movers.

An alternative approach, which attempts to preserve the protein sequence by targeting only the "hottest" immunogenic regions, can be implemented using the `AddMHCEpitopeConstraintMover`.  This also makes using more sophisticated epitope prediction methods, like the NetMHCII predictor, that require a pre-computed external database to be feasible.  We have provided the [[mhc-energy-tools]] to help you identify hotspots in your protein, and generate an external database if desired.

Generally speaking, the `AddMHCEpitopeConstraintMover` will de-immunize a pose only over the residues specified by the `selector`.  The configuration of the epitope predictor can be the same as the scorefunction configuration, or it can be different by passing a unique `.mhc` file.  (Note that you can even turn on the scoreterm without any configuration, and apply a configuration using constraints only.  In this case, de-immunization will only be performed at the constraint-specified positions and configuration.)

You can also use `AddMHCEpitopeConstraintMover` to add a second epitope prediction method to the entire pose by applying it without a selector.

Note that for the constraint to be function, YOU MUST USE A SCOREFUNCTION WITH `mhc_epitope` WEIGHTED TO SOMETHING OTHER THAN 0.  The `weight` parameter passed to the constraint mover will be multiplied by scorefunction weight to give you the "net weight."  If you scorefunction has `mhc_epitope` weighted to 0, it will therefore have a net weight of 0.

##Citation Information

Please see the main [[MHCEpitopeEnergy|MHCEpitopeEnergy#citation-information]] page for citation information if you use the `AddMHCEpitopeConstraintMover`.

##Usage

[[include:mover_AddMHCEpitopeConstraintMover_type]]

##Removing Constraints

The [[ClearCompositionConstraintsMover]] mover will remove all MHCEpitopeConstraints, along with any other composition constraints.  Of course, this will not remove predictors configured at the scorefunction level, only those configured at the constraint level.

##See Also

* [[MHCEpitopeEnergy]]
* [[mhc-energy-tools]]
* [[ClearCompositionConstraintsMover]]
* [[Design-centric guidance terms|design-guidance-terms]]