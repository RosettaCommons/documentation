# Movers for Sampling the Membrane Position: SetMembranePositionMover

## Description

This Mover works both for a fixed membrane / movable pose and vice versa. It sets the membrane center and normal of the membrane residue without updating the coordinates of the rest of the pose. It should be noted that this mover does not continuously optimize the membrane center and normal using a minimization scheme!

## RosettaScripts interface

The following options are available via RosettaScripts:
`center` - Float - Desired center of the membrane bilayer.
`normal` - Float - Desired normal of the membrane bilayer.

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Reference

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press

