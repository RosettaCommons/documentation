## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 8/12/15

## Algorithm Description

This application reads in a sequence from a fasta file, creates a pose with ideal helix angles and outputs it into a PDB file ("helix_from_sequence.pdb"). If the protein is a membrane protein, it can also transform the helix into the membrane. For this, two variables are defined from the Calpha coordinates of the first and last residue of the helix: (1) the center is the center point between the two Calpha coordinates and (2) the normal is the vector between the two Calpha coordinates. The default membrane coordinate system is defined as a center of (0, 0, 0) and a normal of (0, 0, 1). The helix is transformed into the membrane coordinate frame such that the helix center coincides with the membrane center and the helix normal coincides with the membrane normal.

## Code and Demo
The application can be found at `apps/pilot/jkleman/helix_from_sequence.cc`. It uses Movers from the RosettaMP framework. An integration test is available in `Rosetta/main/tests/integration/tests/helix_from_sequence`. 

## Run the application
The input file is a single PDB file and a single spanfile, which can be generated with the mp_docking_setup application. Example flags for finding the interface:

```
Rosetta/main/source/bin/helix_from_sequence.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_tr.pdb \
-mp:setup:transform_into_membrane 1 \      # optional boolean: transforms helix into membrane
```

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::transform::optimize_embedding <bool>` | Use the scorefunction to optimize the embedding after an initial coarse grained setting. |
|`-mp::setup::transform_into_membrane <bool>` | Add this option to transform helix into fixed membrane.|


## Reference
This protocol is currently not published yet. The framework and previous protocol was published in:

Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (under revision)