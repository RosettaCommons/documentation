#ConfChangeMover (docs in progress)
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ConfChangeMover

Samples new protein conformations as described in:                     
[Modeling of protein conformational changes with Rosetta guided by limited experimental data](https://www.biorxiv.org/content/10.1101/2022.02.14.480383v1)                                             
Davide Sala, Diego del Alamo, Hassane S. Mchaourab, Jens Meiler
doi: https://doi.org/10.1101/2022.02.14.480383

## Overview

Given a starting structure, ConfChangeMover perturbs the protein pose in two steps:                                       
1. Secondary Structure Elements (SSEs) are roto-translated. Optionally, new dihedral angles are sampled through fragments insertion.
2. Loops are closed with fragments insertion. In this step, the intensity of sampling new loops conformations can be tuned through the frequency of inserting fragments taken from the starting structure rather than from the PDB. Higher frequency means more starting conformation fragments and a more conservative sampling.

[[include:mover_ConfChangeMover_type]]