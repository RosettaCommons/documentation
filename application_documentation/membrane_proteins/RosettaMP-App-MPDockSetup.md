# RosettaMP Application: Membrane Protein-Protein Docking Setup (MPDockSetup)

## Code and Demo
The application can be found at `Rosetta/main/source/src/apps/public/membrane/mp_dock_setup.cc`.

A demo for the code can be found as part of the MPDock demo in `Rosetta/demos/protocol_captures/mp_dock`

Rosetta Revision #58096

## Algorithm Description
This application reads in two membrane protein PDBs and their corresponding spanfiles. Each structure is then separately transformed into membrane coordinates (the scorefunction can be used to optimize each partner) and concatenated into a single PDB output file and a single spanfile. Renumbered spanfiles for each chain are also given. The membrane is fixed with a center of [0, 0, 0] and a normal of [0, 0, 15].

## Run the application

Example flags: 

```
Rosetta/main/source/bin/mp_dock_setup.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_A.pdb 1AFO_B.pdb \
-mp:setup:spanfiles 1AFO_A.span 1AFO_B.span \ 
```

**Note: Please make sure that the order of the spanfiles given corresponds to the order of the PDB files!!!**

## References

1. Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press

## Contact

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))


