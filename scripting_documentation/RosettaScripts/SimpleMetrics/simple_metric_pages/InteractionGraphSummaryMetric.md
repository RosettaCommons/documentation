# InteractionGraphSummaryMetric
*Back to [[SimpleMetrics]] page.*
## InteractionGraphSummaryMetric

Author: Vikram K. Mulligan (vmulligan@flatironinstitute.org)
Page created 22 December 2018.

[[_TOC_]]

## Description

The InteractionGraphSummaryMetric takes a pose and a number of [[task operations|TaskOperations-RosettaScripts]], carries out the steps of [[packer|PackRotamersMover]] setup (generating rotamers for the pose and pre-computing the pairwise interaction energies to populate the interaction graph), and then constructs and stores a human- and machine-readable summary of the interaction graph.  This is useful for experimenting with optimization or annealing approaches external to Rosetta.  By default, the information includes everything necessary to reconstruct the initial pose.  When used in conjunction with the [[ExternalPackerResultLoader mover|ExternalPackerResultLoader]], this allows a packing problem to be exported from Rosetta, run in an external optimizer or annealer, and the solutione re-imported into Rosetta to rebuild the packed pose.

## Options

```xml
<InteractionGraphSummaryMetric name="(string)" task_operations="(string)" skip_pose_reconstruction_info="(bool, false)" scorefxn="(string)" />
```

* **task_operations**: A comma-separated list of previously defined task operations that collectively define the packing problem to solve by limiting the rotamers allowed at each position.
* **skip_pose_reconstruction_info**:  If true, additional information used to rebuild the original pose is omitted from the output.  False by default, meaning that the extra information _is_ included.
* **scorefxn**: A named, previously-defined scoring function to use when calculating pairwise interaction energies to populate the interaction graph.

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
# is true.
[END ROTAMER NAME/SEQPOS/ROTINDEX/CHIVALS]

```

## See also

* [[SimpleMetrics]] -- Rosetta modules that allow properties of a pose to be computed and written to the logfile, or cached in the pose for output with structure files.
* [[Task operations|TaskOperations-RosettaScripts]] -- Rosetta modules that restrict the rotamers considered at each position when packing.
* [[PackRotamersMover]] -- A mover that calls the Rosetta packer to optimize side-chain rotamers.
* [[ExternalPackerResultLoader mover|ExternalPackerResultLoader]] -- A mover to import a packer problem description and a solution file, which then rebuilds the pose and threads the packer solution onto it.