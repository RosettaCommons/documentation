## Metadata

The Rosetta Membrane Framework was developed by Julia Koehler Leman and Rebecca Alford at the Gray Lab at JHU. 
Last updated: 01/22/15. 

For questions please contact: 
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Description

Several Movers are available in the Membrane Framework. Be aware that:
- The **AddMembraneMover** NEEDS to be run to create a membrane pose from a regular pose. It instantiates the MembraneInfo object and the MembraneResidue.
- **All other Movers are (unless otherwise stated) sensitive to which parts are moving during a protocol**, either the membrane or the protein! Using the wrong Mover will result in incorrect output. 

## Code and documentation

`protocols/membrane` contains most of the simple movers, except maybe some specific ones that rely on other protocols (like the MPDocking mover for instance).

## References

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley D, Elazar A, Gray JJ. (2015) An integrated framework enabling computational modeling and design of Membrane Proteins. PlosOne - in preparation 

***

## Membrane-specific movers

### AddMembraneMover
The Mover that invokes the MP_Framework and instantiates a membrane Pose is the AddMembraneMover. This mover is required for membrane protein modeling in Rosetta and must be called first. The AddMembraneMover adds the membrane residue to the Pose, sets up a default FoldTree, and initializes the MembraneInfo object. The correct setup of the root in the FoldTree for either a fixed membrane and movable protein or movable membrane and fixed protein is the responsibility of the protocol developer.

|**Flag**|**Description**|
|:-------|:--------------|
|`-membrane_new::setup::spanfiles <spanfile>` | AddMembraneMover only uses the first spanfile. Not a requirement if a structure is given that is transformed into membrane coordinates: use spans_from_structure flag in this case.|
|`-membrane_new::setup::spans_from_structure <bool>` | If no spanfile is given, the user has the option of creating a SpanningTopology object from the given structure. Structure must be transformed into membrane coordinates. Spanfile is written with this option: out.span |
|`-membrane_new::setup::lipsfile <lipsfile>` | optional; functionality currently not tested for the new framework.|
|`-membrane_new::setup::membrane_rsd <residue number for MEM residue>` | optional; reads in the MEM residue from previously generated framework PDB. If not given, Rosetta still searches for it and uses it if found.|
|`-membrane_new::setup::center <three real numbers defining the center point>` | optional; user can provide desired membrane center coordinate.|
|`-membrane_new::setup::normal <three real numbers defining the normal vector>` | optional; user can provide desired membrane normal vector.|
