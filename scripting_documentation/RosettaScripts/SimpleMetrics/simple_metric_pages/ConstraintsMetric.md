# ConstraintsMetric
*Back to [[SimpleMetrics]] page.*
Page created 19 May 2021 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

## ConstraintsMetric

The ConstraintsMetric provides a summary of all of the constraints in a pose or pose region selected by a residue
selector.  The summary is formatted as (non-enzdes) [[constraints file|constraint-file]] constraints, and can be copied
into a .cst file directly for use with the [[ConstraintSetMover]], for example.

[[include:simple_metric_ConstraintsMetric_type]]

##See Also

* [[ConstraintSetMover]]: A mover that adds constraints from a .cst file.
* [[ClearConstraintsMover]]: A mover that removes constraints from a pose.
* [[AddConstraintsToCurrentConformationMover]]: A mover that adds constraints to help to hold a pose in its current confomation.
* [[Constraints file format|constraint-file]]: The .cst file format, for defining myriad different types of constraints.