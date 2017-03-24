## Overview

This page is where developers can collect benchmark results for various Rosetta protocols with beta_nov15 energy function. The main aim is to check any improvements or degradations in scientific performances before we switch our default energy function from talaris2014 to beta_nov15. Please make sure the items below are properly described when you contribute here.

Please refer to http://www.tablesgenerator.com/markdown_tables to make/edit tables. Also, if anyone has better idea on the format, please give a suggestion to Hahnbeom Park (hahnbeom@uw.edu).

### Structure Prediction

| Title  | Who    | Description| Ref. | Metric | Higher? | Talaris2014 | BetaNov15 | App/Mover      | Rosetta V. |
|--------|--------|------------|------|--------|---------|-------------|-----------|----------------|------------|
| Rotamer, core      | H Park | CADRES     |      | Success rate | yes           |             |           | RTmin          |            |
| Rotamer, interface | H Park | CADRES     |      | Success rate | yes           |             |           | RTmin          |            |
| Decoy, Mike        | H Park | CADRES     | 1    | Boltzmann P  | yes           | 0.538       | 0.600     | Relax, dual    |            |
| Decoy, Patrick     | H Park | CADRES     | 1    | Boltzmann P  | yes           | 0.606       | 0.699     | Relax, dual    |            |
| PPdock, ZDOCK      | H Park | CADRES     | 1    | Boltzmann P  | yes           | 0.712       | 0.779     | Relax, torsion |            |
| HomologyModeling   | H Park | 67 CAMEO targets | 1    | GDT-HA       | yes           | 63.9        | 65.1      | Hybridize      |            |
| LoopModeling   | H Park |  | 2    | Boltzmann P | yes |   |   | NGK |            |

### Design

| Title              | Who    | Description      | Ref. | Metric       | HigherBetter? | Talaris2014 | BetaNov15 | App/Mover      | Rosetta V. |
|--------------------|--------|------------------|------|--------------|---------------|-------------|-----------|----------------|------------|

### Etc

| Title              | Who    | Description      | Ref. | Metric       | HigherBetter? | Talaris2014 | BetaNov15 | App/Mover      | Rosetta V. |
|--------------------|--------|------------------|------|--------------|---------------|-------------|-----------|----------------|------------|


### References
1. H Park et al, Simultaneous optimization of biomolecular energy function on features from small molecules and macromolecules, JCTC 2016.
2. Stein et al,

## See Also

* [[Updates-beta-nov15]]