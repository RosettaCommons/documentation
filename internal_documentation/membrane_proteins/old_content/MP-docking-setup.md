## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 4/26/15

## Algorithm Description
This application reads in two membrane protein PDBs and their corresponding spanfiles. Each structure is then separately transformed into membrane coordinates and concatenated into a single PDB output file and a single spanfile. Renumbered spanfiles for each chain are also given. The membrane is fixed with a center of [0, 0, 0] and a normal of [0, 0, 15].

## Code and Demo
The application can be found at `apps/pilot/jkleman/mpdocking_setup.cc`. The underlying mover is located in `protocols/docking/membrane/MPDockingSetupMover`. An integration test can be found at `Rosetta/main/tests/integration/tests/mp_docking_setup/`.

## Run the application

Example flags: 

```
Rosetta/main/source/bin/mp_mutate_relax.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_A.pdb 1AFO_B.pdb \
-mp:setup:spanfiles 1AFO_A.span 1AFO_B.span \ # MAKE SURE THAT THE ORDER OF THE SPANFILES CORRESPONDS TO THE ORDER 
                                              # OF THE PDB FILES!
```

## Reference

Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design,
PLoS Computational Biology (under revision) 
