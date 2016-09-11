# Movers for Initialization: AddMPLigandMover

## Description

This mover adds a single ligand to a membrane pose and reorganizes the FoldTree such that the ligand is anchored to a residue closest to the binding pocket. The membrane residue is anchored to the center-of-mass of the protein. 

## RosettaScripts interface

The following options are available via RosettaScripts:
`closest_rsd` - Integer - Specify the number of the residue closest to the binding pocket of where the ligand should be anchored to.
`ligand_seqpos` - Integer - Specify the residue number that the ligand should have. 

TODO: add flags for the commandline!

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press
