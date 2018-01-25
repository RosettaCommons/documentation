# Movers for Sampling Protein Embedding: Transform Into Membrane Mover

## Description

This Mover transforms the protein into membrane coordinates. By default, the embedding is computed from the trans-membrans spans and the Cα coordinates but a user-defined embedding can also be used. By default, the membrane coordinates are taken from MembraneInfo, but default membrane coordinates (center at [0, 0, 0] and normal at [0, 0, 1]) or user-defined coordinates can be used. This Mover  transforms the protein membrane coordinates such that the centers and normals of the overall EmbeddingDef and the membrane coincide. Works both for fixed membrane / movable protein and vice versa. 

## RosettaScripts interface

The following options are available via RosettaScripts:
`center` - 3 Floats - Desired center of the membrane bilayer.
`normal` - 3 Floats - Desired normal of the membrane bilayer.

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::center <XYZ-Vector of Real Numbers>` | Optional; user can provide desired membrane center coordinate. |
|`-mp::setup::normal <XYZ-Vector of Real Numbers>` | Optional; user can provide desired membrane normal vector. |

## Run the application

```
Rosetta/main/source/bin/mp_transform.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_tr.pdb \
-mp:setup:center 0 0 0 \	#optional: xyz coordinates of membrane center (3 floats)
-mp:setup:normal 0 0 1 \ 	#optional: normal vector of membrane bilayer (3 floats)
-mp:transform:optimize_embedding true \ #optional: optimize the protein embedding in the membrane after transformation (in the code this happens before)
```
## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press


