# SequenceMetric
*Back to [[SimpleMetrics]] page.*
## SequenceMetric

## Reference
**Growing Glycans in Rosetta: Accurate de novo glycan modeling, density fitting, and rational sequon design**
Jared Adolf-Bryfogle, J. W Labonte, J. C Kraft, M. Shapavolov, S. Raemisch, T. Lutteke, F. Dimaio, C. D Bahl, J. Pallesen, N. P King, J. J Gray, D. W Kulp, W. R Schief
_bioRxiv_ 2021.09.27.462000; [[https://doi.org/10.1101/2021.09.27.462000]]

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