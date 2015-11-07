## Metadata

The Rosetta Membrane Framework was developed by Julia Koehler Leman and Rebecca Alford at the Gray Lab at JHU. 
Last updated: 12/12/14. 

For questions please contact: 
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Overview
The 2014 implementation of the Membrane Framework uses the same science (i.e. score terms) of the original RosettaMembrane implementation. While the original RosettaMembrane implementation was kept (`core/scoring/methods`), the score terms were re-implemented and cleaned up (`core/scoring/membrane`) while the interface to the ScoreFunctionFactory was established. 

The Rosetta low resolution (centroid-based) energy function for membrane proteins was developed in 2006 with the Membrane Ab Initio folding protocol (*Yarov-Yaravoy et al. 2006*). It was derived from 28 alpha helical membrane proteins and is knowledge-based. There are 6 low-resolution energy terms: a residue-environment energy, residue-residue energy, packing density, termini penalty, non-helix penalty, and TMprojection penalty. 

**For a detailed description of all score terms, their functional form and their weights for specific applications, please see Alford, Koehler Leman et al.**

### Energy Terms
Terms supported by the RosettaMembrane framework were added in April 2014. Terms, corresponding energy methods, and usage are described below. The score name is the name of the term you would use when setting up a weights file. 

#### Membrane Residue-Environment Term
Score Name: MPEnv. Score per-residue interactions with the membrane environment using a 5 layer membrane (Layers: inner hydrophobic, outer hydrophobic, interface, polar, water). Energy Method type: One body context-dependent.  For Developers - code in `core/scoring/membrane/MPEnvEnergy.hh`.

#### Membrane Residue-Residue Pair Term 
Score Name: MPPair. Score residue-residue interactions in the membrane environment using a 2 layer membrane (Layers: hydrophobic, polar). Energy Method Type: Two-body context dependent. For Developers - code in `core/scoring/membrane/MPPairEnergy.hh`

#### Membrane Packing Density Term
Score Name: MPCBeta. Score packing-density in the membrane based on the number of helices. Energy Method Type: One Body context dependent. For Developers - code in `core/scoring/membrane/MPCbetaEnergy.hh`

#### Membrane Termini Penalty
Score Name: MPTermini. Penalty for termini residues (N- or C- termini) in the membrane. Energy Method Type: Whole structure energy. For Developers - code in `/core/scoring/membrane/MPTerminiPenalty.hh`

#### Membrane TM Projection Penalty
Score Name: MPTMProj. Penalty for helices longer than thickness of the membrane. Energy Method type: Whole Structure Energy. For Developers - code in `core/scoring/membrane/MPTMProjPenalty.hh`

#### Membrane Non Helix Penalty
Score Name: MPNonHelix. Penalty for non helix residues in the membrane. Uses Secondary structure in Rosetta (or provided). Energy Method Type: One body context independent energy. For Developers - code in `core/scoring/membrane/MPNonHelixPenalty.hh`

## Scoring Options
|**Option Name**|**Description**|**Type**|
|---|---|---|
|score:find_neighbors_3dgrid|Use 3D lookup table in neighbor calculations|boolean|
|membrane:no_interpolate_Mpair|switch off interpolation between 2 layers when a pair of residues is on the boundary|boolean|

## For Developers
The set of terms described above are only for use with the new membrane framework protocols. The old set of energy terms can be found in `core/scoring/methods.`

## References

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley D, Elazar A, Gray JJ. (2015) An integrated framework enabling computational modeling and design of Membrane Proteins. PlosOne - in preparation 

## References for original RosettaMembrane

* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediction of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.
