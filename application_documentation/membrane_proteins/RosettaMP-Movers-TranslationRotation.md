# Movers for Sampling the Protein Embedding: Translation Rotation Mover

## Description

This class contains three movers: TranslationMover, RotationMover, and TranslationRotationMover, all of which were only tested for a fixed membrane and a movable protein. 

The TranslationMover translates a pose element based on the translation vector and an optional jump number. The default jump is the membrane jump.

The RotationMover rotates a pose element based on the old normal vector, the new (i.e. desired) normal vector, the rotation center, and optional jump number. The default jump is also the membrane jump.

The TranslationRotationMover rotates / translates a pose element based on the old center and normal, the new (i.e. desired) center and normal, and optional jump number. This is useful for moving a pose element based on the comparison between the membrane center and normal and its computed embedding from the pose element. 

## RosettaScripts interface

`center` - 3 Floats - Desired center of the membrane bilayer.
`normal` - 3 Floats - Desired normal vector of the membrane bilayer. 

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press


