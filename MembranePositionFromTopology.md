## TODO

- expand

## Metadata

The Rosetta Membrane Framework was developed by Julia Koehler Leman and Rebecca Alford at the Gray Lab at JHU. 
Last updated: 12/12/14. 

For questions please contact: 
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Description

The *MembranePositionFromTopologyMover* uses the protein topology (SpanningTopology from the spanfile) and the structure to calculate an optimal position and orientation (center and normal) of the membrane, as represented by the MembraneResidue. This mover should only be used for a **fixed protein and a flexible membrane** (i.e. a protein residue is at the root of the FoldTree).

## Code and documentation

`protocols/membrane/MembranePositionFromTopology.<>`

## Flags

`-membrane_new::setup::spanfiles <spanfile 1>` required flag to read in spanfile

## Example

`-membrane_new::setup::spanfiles 1afo.span`

## References

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley D, Elazar A, Gray JJ. (2015) An integrated framework enabling computational modeling and design of Membrane Proteins. PlosOne - in preparation 
