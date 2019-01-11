# Utilities with Options from RosettaMP

## Metrics.cc

**Description**

This file contains protocols that are specific to low resolution docking.

metrics.cc lives in `main/source/src/protocols/docking/metrics.cc`

**Flags / Options**

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::spanfiles <spanfile>` | Add this option before calculating interaction energy to calculate energy for membrane proteins. |

## Util.cc (Temporary) 

**Description**

This file contains utility functions for RosettaMP.

This util.cc lives in `main/source/src/core/conformation/membrane/util.cc`

**Flags / Options**

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::spanfiles <spanfile>` | Add this option to read in user-specified spanfile. |

## Util.cc

**Description**

This file contains several groups of utilities for working with RosettaMP:

- Calculate RMSD between the transmembrane domains of two poses (with or without superimposition)
- Calculate the tilt of the protien relative to the membrane normal
- Safety checks and convenience methods for working with membrane foldtrees
- Utility for accessing DSSP secstruc and z coordinates
- Calculate protein embedding based on the structure
- Split topology by jump, and other multi-chain (or partner) functions

This util.cc lives in `main/source/src/protocols/membrane/util.cc`

**Flags / Options**

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::center <three real numbers defining the center point>` | Set center vector safely when reading from command line. |
|`-mp::setup::normal <three real numbers defining the normal vector>` | Set normal vector safely when reading from command line. |

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press

