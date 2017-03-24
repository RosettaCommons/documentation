### Overview

This page is to collect benchmark results of various Rosetta protocols by running with beta_nov15 energy function. The main aim is to check improvements or degradation in scientific performance before we switch our default energy function from talaris2014 to beta_nov15. Please make sure the items below are properly described when you contribute here:

* Title
* Who ran it (Person/Lab)
* Brief explanation/aim of the protocol or reference
* Metrics for both beta_nov15 & talaris2014
* Description of the metric(s) you are using (at least whether higher/lower is the better)
* Rosetta cmdline or mover in RosettaScripts

Please refer to http://www.tablesgenerator.com/markdown_tables to make/edit tables. Also, if anyone has better idea on the format, please give a suggestion to Hahnbeom Park (hahnbeom@uw.edu).

== Structure Prediction ==
| Title              | Who           | Description      | Reference | NameOfMetric   | HigherBetter? | Talaris2014 | BetaNov15 | App/Mover      | Rosetta Version |
|--------------------|---------------|------------------|-----------|----------------|---------------|-------------|-----------|----------------|-----------------|
| Rotamer, core      | Hahnbeom Park | CADRES           |           | Success rate   | yes           |             |           | RTmin          |                 |
| Rotamer, interface | Hahnbeom Park | CADRES           |           | Success rate   | yes           |             |           | RTmin          |                 |
| Decoy, Mike        | Hahnbeom Park | CADRES           | Ref. 1    | Boltzmann Prob | yes           | 0.538       | 0.600     | Relax, dual    |                 |
| Decoy, Patrick     | Hahnbeom Park | CADRES           | Ref .1    | Boltzmann Prob | yes           | 0.606       | 0.699     | Relax, dual    |                 |
| PPdock, ZDOCK      | Hahnbeom Park | CADRES           | Ref .1    | Boltzmann Prob | yes           | 0.712       | 0.779     | Relax, torsion |                 |
| HomologyModeling   | Hahnbeom Park | 67 CAMEO targets | Ref .1    | Model1 GDT-HA  | yes           | 63.9        | 65.1      | Hybridize      |                 |


== Design ==
| Title              | Who           | Description      | Reference | NameOfMetric   | HigherBetter? | Talaris2014 | BetaNov15 | App/Mover      | Rosetta Version |
|--------------------|---------------|------------------|-----------|----------------|---------------|-------------|-----------|----------------|-----------------|

== Etc. ==
| Title              | Who           | Description      | Reference | NameOfMetric   | HigherBetter? | Talaris2014 | BetaNov15 | App/Mover      | Rosetta Version |
|--------------------|---------------|------------------|-----------|----------------|---------------|-------------|-----------|----------------|-----------------|

##See Also

* [[Updates-beta-nov15]]