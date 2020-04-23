# PeptideInternalHbondsMetric
*Back to [[SimpleMetrics]] page.*
Page created 23 April 2020 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

## PeptideInternalHbondsMetric

The PeptideInternalHbondsMetric counts hydrogen bonds between residues that are within a residue selection, or, if no residue selection is provided, wihin a pose.  Unlike the [[HbondMetric]], the PeptideInternalHbondsMetric omits from the count any hydrogen bonds that are between residues that are within a user-specified distance in terms of covalent connectivity.  This is particularly useful for finding long-range backbone hydrogen bonds in peptide macrocycles, for example.

[[include:simple_metric_PeptideInternalHbondsMetric_type]]

##See Also

* [[PeptideInternalHbondsFilter]]: A simple wrapper filter for the PeptideInternalHbondMetric, to filter based on count.
* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover