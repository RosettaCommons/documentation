# FastDesign
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FastDesign

[[_TOC_]]

**Temporary Note:** The increased repulsive feature presented at Rosettacon2018 can be [[found here|RelaxScript]].

Performs a FastRelax with design enabled. By default, each repeat of FastDesign involves four repack/minimize cycles in which the repulsive energy term is initially very low and is increased during each cycle. Optionally, constraint weights can also be decreased during each cycle. This enables improved packing and scoring. This mover can use all FastRelax options, and in addition contains design-centric features.

### Usage

[[include:mover_FastDesign_type]]

### Relax Scripts

For a list of relax scripts in the database, [[click here|RelaxScript]].

### Symmetry

FastDesign is fully symmetry compatible and no special considerations are needed. 

### Deprecated behaviours

Until 8 February 2020, the default behaviour of FastDesign was to disable packing at all positions for which side-chain minimization was disabled by the MoveMap.  This is counter-intuitive, since in all other cases, MoveMaps control only minimization, and not packing.  (Packing is normally controlled by TaskOperations).   This behaviour has therefore been deprecated.  It can still be re-enabled using the `movemap_disables_packing_of_fixed_chi_positions="true"` option in RosettaScripts.

##See Also
* [[FastRelaxMover]]
* [[Relax]]: The relax application
* [[Relax Scripts|RelaxScript]]
* [[I want to do x]]: Guide to chosing a mover