### Overview

This page is to collect benchmark results of various Rosetta protocols by running with beta_nov15 energy function. The main aim is to check improvements or degradation in scientific performance before we switch our default energy function from talaris2014 to beta_nov15. Please make sure the items below are properly described when you contribute here:

* Title
* Who ran it (Person/Lab)
* Brief explanation/aim of the protocol or reference
* Metrics for both beta_nov15 & talaris2014
* Description of the metric(s) you are using (at least whether higher/lower is the better)
* Rosetta cmdline or mover in RosettaScripts

If anyone has better idea on the format, please give a suggestion to Hahnbeom Park (hahnbeom@uw.edu).

{| 
class="wikitable"
|-
! Header 1
! Header 2
! Header 3
|-
| row 1, cell 1
| row 1, cell 2
| row 1, cell 3
|-
| row 2, cell 1
| row 2, cell 2
| row 2, cell 3
|}

{| border="1" cellspacing="0" cellpadding="5"
! align="left" width="250px" | Name
! Title
! Who
! Description
! Reference
! Name of Metric
! Higher the Better? 
! talaris2014
! beta_nov15
! App or Mover
! Rosetta version (opt.)
|-
| Monomeric decoy discrimination 1
| Hahnbeom Park
| https://wiki.rosettacommons.org/index.php/Benchmark_datasheets_-_Decoy_discrimination
| H Park et al, JCTC 2016
| Boltzmann-weighted probability
| Y
| 0.538
| 0.600
| relax, dualmode
| 
|-
|}

##See Also

* [[Updates-beta-nov15]]