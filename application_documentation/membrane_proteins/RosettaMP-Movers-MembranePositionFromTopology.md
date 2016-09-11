# Movers for Sampling the Membrane Position: MembranePositionFromTopology

## Description

This mover calculates the position and orientation of the membrane using knowledge of the trans-membrane spans (in the SpanningTopologyobject) and Cα coordinates to compute the centers and normals of each transmembrane span (i.e. EmbeddingDef objects), computes an average, and sets the membrane center and normal to these values. 

This Mover only applies to a fixed protein and movable membrane (i.e. one of the protein residues is at the root of the FoldTree). It should be noted that this mover does not continuously optimize the membrane center and normal using a minimization scheme, but rather provides a first estimation that can be subsequently refined (for instance using membrane relax / MembraneRelaxMover or the OptimizeMembranePositionMover).

## RosettaScripts interface

Options in RosettaScripts are:
`structure_based` - Boolean - Use the structure to set the membrane position. This requires the input PDB to already be transformed into membrane coordinates (for instance using the PPM or TMDET servers). 

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press


