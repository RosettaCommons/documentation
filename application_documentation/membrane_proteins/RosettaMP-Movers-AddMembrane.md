# Movers for Initialization: AddMembraneMover

## Description

The AddMembraneMover initializes RosettaMP by configuring data needed for membrane representation. This mover is **required** for membrane protein modeling in Rosetta and must be called first. The AddMembraneMover adds the membrane residue to the Pose, sets up a default FoldTree, and initializes the MembraneInfo object. The correct setup of the root in the FoldTree for either a fixed membrane and movable protein or movable membrane and fixed protein is the responsibility of the protocol developer.

## RosettaScripts interface

The following options are available within the RosettaScript interface:

`spanfile` - String - Provide the spanfile name.
`anchor_rsd` - Integer - The residue number in the pose to which the membrane residue should be anchored at. 
`membrane_rsd` - Integer - The residue number that the membrane residue should have in the pose. 
`thickness` - Float - Half of the desired membrane thickness. 
`steepness` - Float - The steepness of the function describing the interface, the higher the steeper the transition. Ideally between 2 and 10.
`center` - Float - Desired center of the membrane bilayer. 
`normal` - Float - Desired normal of the membrane bilayer. 
`include_lips` - Boolean - To include a lips file for lipophilicity.
`lipsfile` - String - Provide the lipsfile name.

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::spanfiles <spanfile>` | AddMembraneMover only uses the first spanfile. Not a requirement if a structure is given that is transformed into membrane coordinates: use spans_from_structure flag in this case.|
|`-mp::setup::spans_from_structure <bool>` | If no spanfile is given, the user has the option of creating a SpanningTopology object from the given structure. Structure must be transformed into membrane coordinates. Spanfile is written with this option: out.span |
|`-mp::setup::lipsfile <lipsfile>` | optional; functionality currently not tested within RosettaMP.|
|`-mp::setup::membrane_rsd <residue number for MEM residue>` | optional; reads in the MEM residue from previously generated framework PDB. If not given, Rosetta still searches for it and uses it if found.|
|`-mp::setup::center <three real numbers defining the center point>` | optional; user can provide desired membrane center coordinate.|
|`-mp::setup::normal <three real numbers defining the normal vector>` | optional; user can provide desired membrane normal vector.|

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press

