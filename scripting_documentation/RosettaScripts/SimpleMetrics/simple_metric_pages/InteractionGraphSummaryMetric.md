# InteractionGraphSummaryMetric
*Back to [[SimpleMetrics]] page.*
## InteractionGraphSummaryMetric

Author: Vikram K. Mulligan (vmulligan@flatironinstitute.org)
Page created 22 December 2018.

[[_TOC_]]

## Description

The InteractionGraphSummaryMetric takes a pose and a number of [[task operations|TaskOperations-RosettaScripts]], carries out the steps of [[packer|PackRotamersMover]] setup (generating rotamers for the pose and pre-computing the pairwise interaction energies to populate the interaction graph), and then constructs and stores a human- and machine-readable summary of the interaction graph.  This is useful for experimenting with optimization or annealing approaches external to Rosetta.  By default, the information includes everything necessary to reconstruct the initial pose.  When used in conjunction with the [[ExternalPackerResultLoader mover|ExternalPackerResultLoader]], this allows a packing problem to be exported from Rosetta, run in an external optimizer or annealer, and the solutione re-imported into Rosetta to rebuild the packed pose.

## Options

## See also

* [[Task operations|TaskOperations-RosettaScripts]] -- Rosetta modules that restrict the rotamers considered at each position when packing.
* [[PackRotamersMover]] -- A mover that calls the Rosetta packer to optimize side-chain rotamers.
* [[ExternalPackerResultLoader mover|ExternalPackerResultLoader]]


##