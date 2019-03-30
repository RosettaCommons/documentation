# Movers for sampling membrane position: OptimizeMembranePositionMover

## Description

This Mover optimizes the membrane position and orientation around the protein (protein is fixed, membrane is movable) using the high-resolution membrane scorefunction (mpframework_smooth_fa_2012). It samples membrane depths from +/- 10A around the starting depth (as computed from trans-membrane spans and coordinates) in 0.1A steps. It also samples angles in 0.5 degree steps around the starting orientation within a range of +/- 45 degrees along the following axes in an independent manner: x, y, xy, -xy. The sampling is brute-force and therefore the outcome is deterministic.

## RosettaScripts interface

The following options are available within the RosettaScript interface:

`sfxn` - String - Provide the score function weights file.
`score_best` - Real - Provide the best score.
`starting_z` - Real - Provide the starting z value for center search.
`stepsize_z` - Real - Provide the stepsize z value for center search.
`stepsize_angle` - Real - Provide stepsize angle for normal search.

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::spanfiles <spanfile>` | Add spanfiles when registering options from the Command Line |

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press

