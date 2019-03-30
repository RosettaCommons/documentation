## Overview

This page is where developers can collect benchmark results for various Rosetta protocols with beta_nov15 energy function. The main aim is to check any improvements or degradations in scientific performances before we switch our default energy function from talaris2014 to beta_nov15. Please make sure the items below are properly described when you contribute here.

Please refer to http://www.tablesgenerator.com/markdown_tables to make/edit tables. Also, if anyone has better idea on the format, please give a suggestion to Hahnbeom Park (hahnbeom@uw.edu).

### Structure Prediction

| Title  | Who    | Description| Metric | Talaris2014 | BetaNov15 | Sign? |App/Mover| Ref. |Rosetta V. |
|--------|--------|------------|--------|-------------|-----------|-------|---------|------|-----------|
| Rotamer, core      | H Park | CADRES     | Success rate |              |           |+|RTmin          | |      |
| Rotamer, interface | H Park | CADRES     | Success rate |              |           |+|RTmin          | |      |
| Decoy, Mike        | H Park | CADRES     | Boltzmann P  |  0.538       | 0.600     |+|Relax, dual    |1|      |
| Decoy, Patrick     | H Park | CADRES     | Boltzmann P  |  0.606       | 0.699     |+|Relax, dual    |1|      |
| PPdock, ZDOCK      | H Park | CADRES     | Boltzmann P  |  0.712       | 0.779     |+|Relax, torsion |1|      |
| HomologyModeling   | H Park | 67 CAMEO targets | GDT-HA |  63.9        | 65.1      |+|Hybridize      |1|      |
| LoopModeling       | H Park |  | Boltzmann P | |   |+| NGK |2|            |

### Design

| Title  | Who    | Description| Metric | Talaris2014 | BetaNov15 | Sign? |App/Mover| Ref. |Rosetta V. |
|--------|--------|------------|--------|-------------|-----------|-------|---------|------|-----------|
|FullDesign| H Park | StdScientific | SuccessRate | 38.9 | 40.6   |+| fixbb |3| |
|ProteinMono| H Park| One-res-at-a-time | SuccessRate | 45.1 | 47.0 |+| pilot app | 1 | |
|ProteinProtein| H Park| One-res-at-a-time | SuccessRate | 45.1 | 47.0 |+| pilot app | 1 | |
|ProteinLigand| H Park| One-res-at-a-time | SuccessRate | 45.1 | 47.0 |+| pilot app | 1 | |
  

### Etc

| Title  | Who    | Description| Metric | Talaris2014 | BetaNov15 | Sign? |App/Mover| Ref. |Rosetta V. |
|--------|--------|------------|--------|-------------|-----------|-------|---------|------|-----------|

### References
1. H Park et al, Simultaneous optimization of biomolecular energy function on features from small molecules and macromolecules, JCTC 2016.
2. Stein et al,

## See Also

* [[Updates-beta-nov15]]