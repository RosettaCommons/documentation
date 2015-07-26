## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 7/27/15

## Description

This Mover flips a pose or part of the pose in the membrane and is tested only for a fixed membrane and a movable protein. Possible arguments are the jump number along which jump to flip the downstream partner, the flip axis, and the rotation angle. For the default constructor these values are the membrane jump, 180 degree angle, and the x-axis as rotation axis. There is also the option to set a random flip angle in the membrane or set the range of the maximum angle deviation from the membrane normal. 

## Code and Demo

The Mover lives in `main/source/src/protocols/membrane`.

## RosettaScripts interface

TODO: Currently not compatible with RosettaScripts. 

## Reference

Currently unpublished. RosettaMP is described in 

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
