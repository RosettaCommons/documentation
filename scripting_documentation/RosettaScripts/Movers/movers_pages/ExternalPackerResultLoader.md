# ExternalPackerResultLoader
*Back to [[RosettaScripts Movers|Movers-RosettaScripts]] page.*
## ExternalPackerResultLoader

Author: Vikram K. Mulligan (vmulligan@flatironinstitute.org)
Page created 22 December 2018.

[[_TOC_]]

## Description

The ExternalPackerResultLoader takes as input a packer problem file containing information about an input pose, a set of rotamers for that pose, the one-body energy for each rotamer, and the two-body energies for each interacting rotamer pair, an a second file defining a packer solution, and uses these to reconstruct a pose with the solution threaded onto it.  Note that this mover discards the input pose.  This mover is intended to be used in conjunction with the [[InteractionGraphSummaryMetric]], which generates descriptions of packing problems, and with external annealers or optimizers.  It permits Rosetta to set up a packing problem using the Rosetta energy function, an external annealer or optimizer to find the ideal solution, and Rosetta to rebuild the pose with the externally-found solution so that additional refinement operations may be carried out.

## Options

[[include:mover_ExternalPackerResultLoader_type]]

## Input formats

### Packer problem input format

The packer problem input format must match the output format for the [[InteractionGraphSummaryMetric]].  Please see [[the documentation for the InteractionGraphSummaryMetric|InteractionGraphSummaryMetric]] for details.  Note that the _full_ output (including pose and rotamer geometry information) is needed.

### Packer solution input format

The packer solution file must be formatted as a series of lines, one for each designable position in the packer problem, each with two whitespace-separated columns.  The first must specify the sequence position in the pose, and the second must specify the rotamer index selected for that sequence position as a solution to the packer problem.  No designable residue's sequence position may be repeated.  So, for example, if positions 3, 5, and 6 in a pose are designable, and rotamer indices 7, 14, and 3 at these positions, respectively, were chosen as the optimal solutions to a packing problem, the file would look like this:

```
3     7
5     14
6     3
```

This file format is intended to be easy for external annealers to be programmed to write.

## See also

* [[SimpleMetrics]] -- Rosetta modules that allow properties of a pose to be computed and written to the logfile, or cached in the pose for output with structure files.
* [[Task operations|TaskOperations-RosettaScripts]] -- Rosetta modules that restrict the rotamers considered at each position when packing.
* [[PackRotamersMover]] -- A mover that calls the Rosetta packer to optimize side-chain rotamers.
* [[InteractionGraphSummaryMetric]] -- A simple metric that writes out a description of a packing problem for use in external optimizers or annealers, in a format compatible with this mover.