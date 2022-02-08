# CentralTendency Ensemble Metric
*Back to [[SimpleMetrics]] page.*
## CentralTendency Ensemble Metric

[[_TOC_]]

### Description

The Central Tendency metric accepts as input a real-valued [[SimpleMetric|SimpleMetrics]].  It then applies it to each pose in an ensemble, collecting a series of values.  At reporting time, the metric computes measures of central tendency (mean, median, and mode), plus other descriptive statistics about the distribution of the measured value over the ensemble (standard deviation, standard error, min, max, range).

### Author and history

Created Tuesday, 8 February 2022 by Vikram K. Mulligan, Center for Computational Biology, Flatiron Institute (vmulligan@flatironinstitute.org).  This was the first [[EnsembleMetric|EnsembleMetrics]] implemented

### Interface

[[include:ensemble_metric_CentralTendencyEnsembleMetric_type]]

### Named values produced

Measure | Name (used for the [[EnsembleFilter]]) | Description
--------|----------------------------------------|------------
Mean    | mean | The average of the values measured for the poses in the ensemble.
Median  | median | When values measured from all of hte poses in the ensemble are listed in increasing order, this is the middle value.  If the number of poses in the ensemble is even, the middle two values are averaged.
Mode    | mode | The most frequently seen value in the values measured from the poses in the environment.  If more than one value appears with equal frequency and this frequency is highest, the values are averaged.
Standard Deviation    | stddev | Estimate of the standard deviation of the mean, defined as the sqrt( sum_i( S_i - mean )^2 / N ), where S_i is the ith sample, mean is the average of all the samples, and N is the number of samples.
Standard Error    | stderr | Estimate of the standard error of the mean, defined by stddev / sqrt(N), where N is the number of samples.
Min | min | The minimum value seen.
Max | max | The maximum value seen.
Range | range | the largest value seen minus the smallest.

#### Note about mode

The mode of a set of floating-point numbers can be thrown off by floating-point error.  For instance, two poses may have energies of -3.7641 kJ/mol, but the process of computing that energy may result in slightly different values at the 15th decimal point.  This would prevent the filter from recognizing this is at the most frequent value.

##See Also

* [[SimpleMetrics]]: Available SimpleMetrics.
* [[EnsembleMetrics]]: Available EnsembleMetrics.
* [[I want to do x]]: Guide to choosing a tool in Rosetta.