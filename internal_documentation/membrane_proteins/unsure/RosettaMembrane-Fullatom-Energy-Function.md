## About

### Developers
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com)) (Wrote this documentation + Rosetta3 terms)
- Patrick Barth (Original terms)

### MetaData
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Modified: 5/22/2014

## Overview
The Rosetta high resolution (fullatom) energy function for membrane proteins was developed in 2007 along with an updated Membrane Ab Initio folding method (Barth et al. 2007). It was derived from 18 alpha helical membrane proteins and extends the score12' Rosetta energy function for soluble proteins. The energy function includes the LJ attractive and repulsive terms, pair term and solvation term identical to those in score12'. In addition, the membrane energy function includes a membrane solvation energy, membrane environment energy and hydrogen bonding correction. 

### Energy Terms
Fullatom energy methods supported by the RosettaMembrane framework were added in April 2014. Terms, corresponding energy methods, and usage are described below. The score name is the name of the term you would use when setting up a weights file. 

#### Fullatom Membrane Residue-Environment Term
Score Name: FaMPEnv. Score the change in solvation free-energy of isolated atoms when transferred from water to membrane bilayer. Scores are determined as a function of z position along the membrane normal. Energy method type: One Body context dependent. For Developers - code in `core/scoring/membrane/FaMPEnvEnergy.hh`

#### Fullatom Membrane Solvation Energy term
Score Name: FaMPSolv. Score change in solvation energy of an atom upon burial in the protein. Computed using the IMM1 potential (extends the EFF1 potential for membrane proteins, Lazaridus et al. 2003). Energy method type: Two body context dependent. For Developers - code in `core/scoring/membrane/FaMPSolvEnergy.hh`

### Energy Term Corrections
To adapt terms in score12' for compatibility with membrane terms, specific corrections are added: 

#### Hydrogen Bonding Weight
The lipids in the membrane have no polar groups and the effect of solvent on hydrogen bonding at the membrane core is therefore negligible. A weight to correct for this effect based on z position along the membrane normal is incorporated to adapt the Hydrogen bonding energy term for membranes. This correction can be turned on using the -membrane_new:scoring:mphbond option described below

## Scoring Options
|**Option Name**|**Description**|**Type**|
|---|---|---|
|membrane_new:scoring:mphbond|turn on fullatom membrane hydrogen bonding correction|boolean|

## For Developers
The set of terms described above are only for use with the new membrane framework protocols. The old set of energy terms can be found in `core/scoring/methods.`

## References
Barth P, Wallner B, Baker D. (2009 Feb 3) Prediciton of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.

Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
