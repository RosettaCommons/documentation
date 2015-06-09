## TODO

- add Movers for applications

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

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley DC, Elazar A, Gray JJ. (2015) An integrated framework enabling computational modeling and design of Membrane Proteins. PlosOne - in preparation 

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

### FlipMover

This Mover flips a pose or part of the pose in the membrane and is tested only for a fixed membrane and a movable protein. Possible arguments are the jump number along which jump to flip the downstream partner, the flip axis, and the rotation angle. For the default constructor these values are the membrane jump, 180 degree angle, and the x-axis as rotation axis.  

### MembranePositionFromTopologyMover

This Mover only applies to a fixed protein and movable membrane (i.e. one of the protein residues is at the root of the FoldTree). It uses knowledge of the trans-membrane spans (stored in the SpanningTopology object) and Cα coordinates to compute the centers and normals of each transmembrane span (i.e. EmbeddingDef objects), computes an average, and sets the membrane center and normal to these values. It should be noted that this mover does not continuously optimize the membrane center and normal using a minimization scheme, but rather provides a first estimation that can be subsequently refined (for instance using membrane relax or the MembraneRelaxMover).

### RandomMembranePositionMover

Makes random perturbations to the center and normal of the MembraneResidue. Only works for a fixed protein and a movable membrane!

### SetMembranePositionMover

This Mover only applies to a fixed protein and movable membrane (i.e. one of the protein residues is at the root of the FoldTree). It uses knowledge of the trans-membrane spans (stored in the SpanningTopology object) and Cα coordinates to compute the centers and normals of each transmembrane span (i.e. EmbeddingDef objects), computes an average, and sets the membrane center and normal to these values. It should be noted that this mover does not continuously optimize the membrane center and normal using a minimization scheme, but rather provides a first estimation that can be subsequently refined (for instance using membrane relax or the MembraneRelaxMover).

### TransformIntoMembraneMover

This Mover only applies to a fixed membrane and a movable protein. Similar to the MembranePositionFromTopologyMover it uses the trans-membrane spans and the Cα coordinates to compute the embedding of the complete protein based on the coordinates of trans-membrane spans. This Mover then transforms the protein into default (center at [0, 0, 0] and normal at [0, 0, 15]) or user-provided membrane coordinates such that the centers and normals of the overall EmbeddingDef and the membrane coincide. 

### TranslationRotationMover

This class contains three movers: TranslationMover, RotationMover, and TranslationRotationMover, all of which were only tested for a fixed membrane and a movable protein. 

The TranslationMover translates a pose element based on the translation vector and an optional jump number. The default jump is the membrane jump.

The RotationMover rotates a pose element based on the old normal vector, the new (i.e. desired) normal vector, the rotation center, and optional jump number. The default jump is also the membrane jump.

The TranslationRotationMover rotates / translates a pose element based on the old center and normal, the new (i.e. desired) center and normal, and optional jump number. This is useful for moving a pose element based on the comparison between the membrane center and normal and its computed embedding from the pose element. 

## Applications as Movers

### MPrelaxMover

To implement

### MP_ddGMover

To implement

### MPDockingSetupMover


### MPDockingMover


### MPSymDockMover
