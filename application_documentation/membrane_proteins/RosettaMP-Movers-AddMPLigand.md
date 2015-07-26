## Metadata

Questions and comments to:

- Rebecca Alford (rfalford12@gmail.com)
- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 4/26/15

## Description

Mover that adds a single ligand to a membrane pose and reorganizes the FoldTree such that the ligand is anchored to a residue closest to the binding pocket. The membrane residue is anchored to the center-of-mass of the protein. 

## Code and Demo

The Mover lives in `main/source/src/protocols/membrane`.

## RosettaScripts interface

The following options are available via RosettaScripts:
`closest_rsd` - Integer - Specify the number of the residue closest to the binding pocket of where the ligand should be anchored to.
`ligand_seqpos` - Integer - Specify the residue number that the ligand should have. 

TODO: add flags for the commandline!

## Reference

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
