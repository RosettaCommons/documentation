# Visualization Movers: Visualize Embedding Mover

## Description

This Mover can be used to visualize the embedding centers and normals in the PDB file and therefore in Pymol or visualization programs. It adds HETATMs to the PDB output file representing centers and normals of each trans-membrane span and of the overall embedding. This Mover MUST be called at the end of the protocol to output the correct embedding (since the embedding might be changed by movers that are called afterwards and since the embedding is not tracked by MembraneInfo as the membrane residue is).

## RosettaScripts interface

This Mover is currently not RosettaScripts compatible. 

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::visualize::embedding <bool>` | Add this option to visualize embedding centers and normals. Required for VisualizeEmbeddingMover to work.|
|`-mp::visualize::spacing <Real>` | Set spacing of virtual membrane residues representing the membrane planes. Default = 5. Initialize from Command Line if using non-default value.|
|`-mp::visualize::width <Real>` | Width of membrane planes for n by n plane. Default = 100. Initialize from Command Line if using non-default value.|
|`-mp::visualize::thickness <Real>` | Thickness of membrane to visualize. Default = 12.5|

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press


