# Movers for Initialization: SymmetricAddMembraneMover

## Description
This mover initializes a membrane representation (membrane residue, spanning topology etc) for a symmetric pose. The pose must already be symmetric (SetupForSymmetry has been run) for this setup to work. The membrane residue is added as the root of the symmetric system. This setup currently only works for C-Symmetric poses. 

## RosettaScripts interface

All [[AddMembraneMover | RosettaMP-Movers-AddMembrane]] options are available for this mover in the RosettaScripts interface.

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::spanfiles <spanfile>` | Read in the first spanfile only when initializing from Command Line. |
|`-mp::setup::spans_from_structure <bool>` | If no spanfile is given, the user has the option of creating a SpanningTopology object from the given structure. Structure must be transformed into membrane coordinates. Spanfile is written with this option: out.span |
|`-mp::setup::lipsfile <lipsfile>` | Read in user-provided lipsfile if initializing from Command Line. Defaults to "mypdb.lips4" |
|`-mp::setup::membrane_rsd <residue number for MEM residue>` | Read in user-provided membrane residue position. |

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Reference

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press

