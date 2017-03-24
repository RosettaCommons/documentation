| asd | asd |   | ad   |
|-----|-----|---|------|
| ad  | ad  |   |      |
|     |     |   | dddd |

### Overview

This page is to collect benchmark results of various Rosetta protocols by running with beta_nov15 energy function. The main aim is to check improvements or degradation in scientific performance before we switch our default energy function from talaris2014 to beta_nov15. Please make sure the items below are properly described when you contribute here:

* Title
* Who ran it (Person/Lab)
* Brief explanation/aim of the protocol or reference
* Metrics for both beta_nov15 & talaris2014
* Description of the metric(s) you are using (at least whether higher/lower is the better)
* Rosetta cmdline or mover in RosettaScripts

I'm keep failing on making tables here... Also, if anyone has better idea on the format, please give a suggestion to Hahnbeom Park (hahnbeom@uw.edu).

== Structure Prediction ==

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
| **Monomeric decoy discrimination 1**
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
| **Monomeric decoy discrimination 2**
| Hahnbeom Park
| https://wiki.rosettacommons.org/index.php/Benchmark_datasheets_-_Decoy_discrimination
| H Park et al, JCTC 2016
| Boltzmann-weighted probability
| Y
| 0.606
| 0.669
| relax, dualmode
| 
|-
| **Protein-protein docking**
| Hahnbeom Park
| https://wiki.rosettacommons.org/index.php/Benchmark_datasheets_-_Docking
| H Park et al, JCTC 2016
| Boltzmann-weighted probability
| Y
| 0.712
| 0.779
| relax, torsion only
| 
|-
| **Homology modeling**
| Hahnbeom Park
| 67 recent CAMEO targets with medium-difficulty 
| H Park et al, JCTC 2016
| Model 1 average GDT-HA
| Y
| 63.9
| 65.1
| Hybridize
| 
|-
|}

== Design ==
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
| **Packer design**
| Hahnbeom Park
| Sequence design on whole monomeric structure using packer
| H Park et al, JCTC 2016
| Sequence recovery
| Y
| 38.9
| 40.6
| fixbb
| 
|-
|}

== Etc ==
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
|-
|}

##See Also

* [[Updates-beta-nov15]]