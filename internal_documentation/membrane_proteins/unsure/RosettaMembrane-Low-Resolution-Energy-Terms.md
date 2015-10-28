# About

### Developers
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com)) (Wrote this documentation + Rosetta3 terms)
- Vladmir Yarov-Yaravoy (Original terms)

### MetaData
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Modified: 5/22/2014

# About
The Rosetta low resolution (centroid-based) energy function for membrane proteins was developed in 2006 with the Membrane Ab Initio folding protocol (Yarov-Yaravoy et al. 2006). It was derived from 28 alpha helical membrane proteins and is knowledge-based. There are 6 low-resolution energy terms: a residue-environment energy, residue-residue energy, packing density, termini penalty, non helix penalty, and tm projection penalty. 

## Energy Terms
A new set of energy terms supported by the RosettaMembrane framework was added in 2014. Terms, corresponding energy methods, and usage are described below. The score name is the name of the term you would use when setting up a weights file. 

### Membrane Residue-Environment Term
Score Name: MPEnv. Score per-residue interactions with the membrane environment using a 5 layer membrane (Layers: inner hydrophobic, outer hydrophobic, interface, polar, water). Energy Method type: One body context-dependent.  For Developers - code in `core/scoring/membrane/MPEnvEnergy.hh`.

### Membrane Residue-Residue Pair Term 
Score Name: MPPair. Score residue-residue interactions in the membrane environment using a 2 layer membrane (Layers: hydrophobic, polar). Energy Method Type: Two-body context dependent. For Developers - code in `core/scoring/membrane/MPPairEnergy.hh`

### Membrane Packing Density Term
Score Name: MPCBeta. Score packing-density in the membrane based on the number of helices. Energy Method Type: One Body context dependent. For Developers - code in `core/scoring/membrane/MPCbetaEnergy.hh`

### Membrane Termini Penalty
Score Name: MPTermini. Penalty for termini residues (N- or C- termini) in the membrane. Energy Method Type: Whole structure energy. For Developers - code in `/core/scoring/membrane/MPTerminiPenalty.hh`

### Membrane TM Projection Penalty
Score Name: MPTMProj. Penalty for helices longer than thickness of the membrane. Energy Method type: Whole Structure Energy. For Developers - code in `core/scoring/membrane/MPTMProjPenalty.hh`

### Membrane Non Helix Penalty
Score Name: MPNonHelix. Penalty for non helix residues in the membrane. Uses Secondary structure in Rosetta (or provided). Energy Method Type: One body context independent energy. For Developers - code in `core/scoring/membrane/MPNonHelixPenalty.hh`

## Scoring Options
|**Option Name**|**Description**|**Type**|
|---|---|---|
|score:find_neighbors_3dgrid|Use a 3D lookup table for residue neighbors calculations|boolean|
|membrane:no_interpolate_Mpair|switch off interpolation between 2 layers when a pair of residues is on the boundary|boolean|

## For Developers
The set of terms described above are only for use with the new membrane framework protocols. The old set of energy terms can be found in `core/scoring/methods.`

## References
Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.
