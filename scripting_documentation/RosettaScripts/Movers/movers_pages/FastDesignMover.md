# FastDesign
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FastDesign

**Temporary Note:** The increased repulsive feature presented at Rosettacon2018 can be [[found here|RelaxScript]].

Performs a FastRelax with design enabled. By default, each repeat of FastDesign involves four repack/minimize cycles in which the repulsive energy term is initially very low and is increased during each cycle. Optionally, constraint weights can also be decreased during each cycle. This enables improved packing and scoring. This mover can use all FastRelax options, and in addition contains design-centric features.

### Usage

[[include:mover_FastDesign_type]]

### Relax Scripts

For a list of relax scripts in the database, [[click here|RelaxScript]].

##See Also
* [[FastRelaxMover]]
* [[Relax]]: The relax application
* [[Relax Scripts|RelaxScript]]
* [[I want to do x]]: Guide to chosing a mover