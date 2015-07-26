## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 4/26/15

## Description

This Mover optimizes the membrane position and orientation around the protein (protein is fixed, membrane is movable) using the high-resolution membrane scorefunction (mpframework_smooth_fa_2012). It samples membrane depths from +/- 10A around the starting depth (as computed from trans-membrane spans and coordinates) in 0.1A steps. It also samples angles in 0.5 degree steps around the starting orientation within a range of +/- 45 degrees along the following axes in an independent manner: x, y, xy, -xy. The sampling is brute-force and therefore the outcome is deterministic.

## Code and Demo

The Mover lives in `main/source/src/protocols/membrane`.

## RosettaScripts interface

TODO: Currently not compatible with RosettaScripts. 

## Reference

This Mover is currently unpublished. RosettaMP and previous protocols were published in:

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
