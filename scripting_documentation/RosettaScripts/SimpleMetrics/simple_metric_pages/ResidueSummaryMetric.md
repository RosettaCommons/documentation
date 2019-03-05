# ResidueSummaryMetric
*Back to [[SimpleMetrics]] page.*
## ResidueSummaryMetric

Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)

The **ResidueSummaryMetric** takes a [[PerResidueRealMetric | SimpleMetrics#PerResidueRealMetric]] and summarizes the data in various ways, such as the mean, sum, or the number of residues above, below, or equal to a certain value. This Metric is itself a [[RealMetric | SimpleMetrics#RealMetric]] and can be used as such in filters, features reporters, etc.

[[include:simple_metric_ResidueSummaryMetric_type]]

##See Also

* [[PerResidueRealMetrics | SimpleMetrics#PerResidueRealMetric]]: List of PerResidueRealMetrics which this metric can use.
* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[CompositeEnergyMetric]]: Calcualte individual scoreterms of a scorefuntion
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover