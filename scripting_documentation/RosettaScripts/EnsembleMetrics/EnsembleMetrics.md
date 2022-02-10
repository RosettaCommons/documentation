# EnsembleMetrics
*Back to main [[RosettaScripts|RosettaScripts]] page.*

Page created Wed, 9 February 2022 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

## Description

Just as [[SimpleMetrics]] measure some property of a pose, EnsembleMetrics measure some property of a group (or _ensemble_) of poses.  They are designed to be used in two phases.  In the _accumulation_ phase, an EnsembleMetric is applied to each pose in an ensemble in sequence, allowing it to store any relevant measurements from that pose that will later be needed to calculate properties of the ensemble.  In the _reporting_ phase, the EnsembleMetric generates a report about the properties of the ensemble and writes this report to disk or to tracer.  Following reporting, an EnsembleMetric may be _interrogated_ by such modules as the [[EnsembleFilter]], allowing retrieval of any floating-point values computed by the EnsembleMetric for filtering.  Alternatively, the EnsembleMetric may be _reset_ for re-use (meaning that accumulated data, but not configuration settings, are wiped).

## Usage modes

EnsembleMetrics have three intended usage modes in [[RosettaScripts]]:

Mode | Setup | Accumulation Phase | Reporting Phase | Subsequent Interrogation | Subsequent Resetting
---- | ----- | ------------------ | --------------- | ------------------------ | --------------------
Basic accumulator mode | Added to a protocol at point of accumulation. | The EnsembleMetric is applied to each pose that the RosettaScripts script handles, in sequence. | The EnsembleMetric produces its report at termination of the RosettaScripts application.  This report covers all poses seen during this RosettaScripts run. | None. | None.
Internal generation mode | Provided with a ParsedProtocol for generating the ensemble of poses from the input pose, and a number to generate.  Added to protocol at point where ensemble should be generated from pose at that point. | Accumulates information about each pose in the ensemble it generates.  Poses are then discaded. | The report is provided immediately once the ensemble has been generated.  The script then continues with the input pose. | After reporting. | On next nstruct (repeat) or next job.
Multiple pose mover mode | Set to use input from a mover that produces many outputs (a [[MultiplePoseMover]]).  Placed in script after such a mover. | Collects data from each pose produced by previous mover. | Reports immediately after collecting data on all poses produced by previous mover.  The script then continues on. | After reporting. | On next nstruct (repeat) or next job.

CONTINUE HEREs

##Available EnsembleMetrics

EnsembleMetric  | Description
------------ | -------------
**[[CentralTendency]]** | Takes a [[real-valued SimpleMetric|SimpleMetrics]], applies it to each pose in an ensemble, and returns measures of central tendency (mean, median, mode) and other measures of the distribution (standard deviation, standard error, etc.).

##See Also

* [[SimpleMetrics]]: Measure a property of a single pose.
* [[Filters|Filters-RosettaScripts]]: Filter on a measured feature of a pose.
* [[EnsembleFilter]]: Filter on a property of an ensemble of poses.
* [[Movers|Movers-RosettaScripts]]: Modify a pose.
* [[I want to do x]]: Guide to choosing a Rosetta protocol.