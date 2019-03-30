# InteractionGraphSummaryMetric
*Back to [[SimpleMetrics]] page.*
## InteractionGraphSummaryMetric

Author: Vikram K. Mulligan (vmulligan@flatironinstitute.org)
Page created 22 December 2018.

[[_TOC_]]

## Description

The InteractionGraphSummaryMetric takes a pose and a number of [[task operations|TaskOperations-RosettaScripts]], carries out the steps of [[packer|PackRotamersMover]] setup (generating rotamers for the pose and pre-computing the pairwise interaction energies to populate the interaction graph), and then constructs and stores a human- and machine-readable summary of the interaction graph.  This is useful for experimenting with optimization or annealing approaches external to Rosetta.  By default, the information includes everything necessary to reconstruct the initial pose.  When used in conjunction with the [[ExternalPackerResultLoader mover|ExternalPackerResultLoader]], this allows a packing problem to be exported from Rosetta, run in an external optimizer or annealer, and the solutione re-imported into Rosetta to rebuild the packed pose.

## Options

[[include:simple_metric_InteractionGraphSummaryMetric_type]]

## Output format

The output resembles the following:

```
[BEGIN POSE BINARY]
# Binary-format information is included here which can be used
# to rebuild the input pose.  Note that this pose may or may not
# contain rotamers used in the packing problem.  This section is
# omitted if skip_pose_reconstruction_info is true.
[END POSE BINARY]

[BEGIN ROTAMER NAME/SEQPOS/ROTINDEX/CHIVALS]
# Information is included here about the geometry of each rotamer.
# This can be used to rebuild individual solutions to the packing
# problem.  This section is omitted if skip_pose_reconstruction_info
# is true.  This section is divided into information for individual
# rotamers with [BEGIN_ROT] ... [END_ROT] blocks.  Each block starts
# with a line in which the tab-separated columns are:
# 1. Residue name (e.g. "DSER:NtermProteinFull", "CYS:disulfide",
# "THR", etc.)
# 2. Sequence position in the pose.
# 3. Rotamer index for this sequence position.
# 4. Side-chain chi angle values for each rotatable dihedral in the
# side-chain for this rotamer at this position.
# This is followed by a block of binary information for the detailed
# three-dimensional geometry of this rotamer.
[END ROTAMER NAME/SEQPOS/ROTINDEX/CHIVALS]

[BEGIN ONEBODY SEQPOS/ROTINDEX/ENERGY]
# Entries in this section contain the information for individual
# nodes in the interaction graph (i.e. the one-body energies).  Each
# row in this section contains tab-separated columns consisting of:
# 1. Sequence position in the pose.
# 2. Rotamer index for this sequence position.
# 3. One-body energy for this rotamer at this sequence position.
# This section is intended to be easy to import into an external
# annealer.
[END ONEBODY SEQPOS/ROTINDEX/ENERGY]

[BEGIN TWOBODY SEQPOS1/ROTINDEX1/SEQPOS2/ROTINDEX2/ENERGY]
# Entries in this section contain the information for individual
# edges in the interaction graph (i.e. the two-body energies).  Each
# row in this section contains tab-separated columns consisting of:
# 1. The sequence position of the first interacting residue in the pose.
# 2. The rotamer index at the first sequence position.
# 3. The sequence position of the second interacting residue in the pose.
# 4. The rotamer index at the second sequence position
# 5. The interaction energy between the two rotamers.
# This section is also intended to be easy to import into an external
# annealer.
```

## See also

* [[SimpleMetrics]] -- Rosetta modules that allow properties of a pose to be computed and written to the logfile, or cached in the pose for output with structure files.
* [[Task operations|TaskOperations-RosettaScripts]] -- Rosetta modules that restrict the rotamers considered at each position when packing.
* [[PackRotamersMover]] -- A mover that calls the Rosetta packer to optimize side-chain rotamers.
* [[ExternalPackerResultLoader mover|ExternalPackerResultLoader]] -- A mover to import a packer problem description and a solution file, which then rebuilds the pose and threads the packer solution onto it.