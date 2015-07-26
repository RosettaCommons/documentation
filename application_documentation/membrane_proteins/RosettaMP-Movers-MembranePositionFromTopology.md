## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 7/27/15

## Description

This Mover only applies to a fixed protein and movable membrane (i.e. one of the protein residues is at the root of the FoldTree). It uses knowledge of the trans-membrane spans (stored in the SpanningTopology object) and Cα coordinates to compute the centers and normals of each transmembrane span (i.e. EmbeddingDef objects), computes an average, and sets the membrane center and normal to these values. It should be noted that this mover does not continuously optimize the membrane center and normal using a minimization scheme, but rather provides a first estimation that can be subsequently refined (for instance using membrane relax / MembraneRelaxMover or the OptimizeMembranePositionMover).

## Code and Demo

The Mover lives in `main/source/src/protocols/membrane`.

## RosettaScripts interface

Options in RosettaScripts are:
`structure_based` - Boolean - Use the structure to set the membrane position. This requires the input PDB to already be transformed into membrane coordinates (for instance using the PPM or TMDET servers). 

## Reference

Currently unpublished. RosettaMP is described in 

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
