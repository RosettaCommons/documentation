## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 4/26/15

## Description

This Mover can be used to visualize the embedding centers and normals in the PDB file and therefore in Pymol or visualization programs. It adds HETATMs to the PDB output file representing centers and normals of each trans-membrane span and of the overall embedding. This Mover MUST be called at the end of the protocol to output the correct embedding (since the embedding might be changed by movers that are called afterwards and since the embedding is not tracked by MembraneInfo as the membrane residue is).

## Code and Demo

The Mover lives in `main/source/src/protocols/membrane/visualize`.

## RosettaScripts interface

This Mover is currently not RosettaScripts compatible. 

## Reference
This Mover is currently unpublished. RosettaMP and previous protocols were published in:

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
