## Metadata

The Rosetta Membrane Framework was developed by Julia Koehler Leman and Rebecca Alford at the Gray Lab at JHU. 
Last updated: 12/12/14. 

For questions please contact: 
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Description

This Mover only applies to a fixed protein and movable membrane (i.e. one of the protein residues is at the root of the FoldTree). It uses knowledge of the trans-membrane spans (stored in the SpanningTopology object) and Cα coordinates to compute the centers and normals of each transmembrane span (i.e. EmbeddingDef objects), computes an average, and sets the membrane center and normal to these values. It should be noted that this mover does not continuously optimize the membrane center and normal using a minimization scheme, but rather provides a first estimation that can be subsequently refined (for instance using membrane relax or the MembraneRelaxMover).

## Code and documentation

`protocols/membrane/MembranePositionFromTopology.<>`

## Flags

`-membrane_new::setup::spanfiles <spanfile 1>` required flag to read in spanfile

## Example

`-membrane_new::setup::spanfiles 1afo.span`

## References

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley D, Elazar A, Gray JJ. (2015) An integrated framework enabling computational modeling and design of Membrane Proteins. PlosOne - in preparation 
