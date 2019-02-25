# SequenceMetric
*Back to [[SimpleMetrics]] page.*
## SequenceMetric

Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)

Modified 20 December 2018 by Vikram K. Mulligan (vmulligan@flatironinstitute.org) to add more output options.

[[include:simple_metric_SequenceMetric_type]]

Note that the `three_letter` option has been deprecated in favour of the `output_mode` option, which provides the options "oneletter", "threeletter", "basename", or "fullname".  Examples of each are given below.  Note that the distinctions are particularly important for noncanonicals: some noncanonicals, such as ornithine, don't have a separate three-letter code for the D-equivalent.

| Output type | Example |
| ----------- | ------- |
| oneletter   | RSTLNEXXYYS                                                                      |
| threeletter | ARG,SER,THR,LEU,ASN,GLU,ORN,ORN,DTY,TYR,DSE                                      |
| basename    | ARG,SER,THR,LEU,ASN,GLU,ORN,DORN,DTYR,TYR,DSER                                   |
| fullname    | ARG:NtermProteinFull,SER,THR,LEU,ASN,GLU,ORN,DORN,DTYR,TYR,DSER:CtermProteinFull |

##See Also

* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover