# RosettaMP Application: Membrane Protein-Protein Docking Setup (MPDockSetup)

## Code and Demo
The application can be found at `Rosetta/main/source/src/apps/public/membrane/mp_dock_setup.cc`.

A demo for the code can be found as part of the MPDock demo in `Rosetta/demos/protocol_captures/mp_dock`

## Algorithm Description
This application reads in two membrane protein PDBs and their corresponding spanfiles. Each structure is then separately transformed into membrane coordinates and concatenated into a single PDB output file and a single spanfile. Renumbered spanfiles for each chain are also given. The membrane is fixed with a center of [0, 0, 0] and a normal of [0, 0, 15].

## Run the application

Example flags: 

```
Rosetta/main/source/bin/mp_mutate_relax.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_A.pdb 1AFO_B.pdb \
-mp:setup:spanfiles 1AFO_A.span 1AFO_B.span \ # MAKE SURE THAT THE ORDER OF THE SPANFILES CORRESPONDS TO THE ORDER 
                                              # OF THE PDB FILES!
```

## Citation
Rosetta Revision #57518

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press

## Contact

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))


