# FastDesign
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FastDesign

Performs a FastRelax with design enabled. By default, each repeat of FastDesign involves four repack/minimize cycles in which the repulsive energy term is initially very low and is increased during each cycle. Optionally, constraint weights can also be decreased during each cycle. This enables improved packing and scoring. This mover can use all FastRelax options, and in addition contains design-centric features.

    <FastDesign name="&string" scorefxn="(ref2015 &string)" clear_designable_residues="(false &bool)" ramp_down_constraints="(false &bool)" />

In addition to all options supported by FastRelax, FastDesign supports:

-   clear\_designable\_residues (default false): If set, all residues set to designable by the task operations will be mutated to alanine prior to design.
-   ramp\_down\_constraints (default false): If set, constraints will be ramped during the FastDesign process according to the relax script. By default, each repeat of FastDesign will use constraint weight multipliers of [ 1.0, 0.5, 0.0, 0.0 ] for the four design/minimize cycles. The constraints ramped are coordinate\_constraint, atom\_pair\_constraint, angle\_constraint and dihedral\_constraint.

##See Also
* [[FastRelaxMover]]
* [[Relax]]: The relax application
* [[RelaxScripts]]
* [[I want to do x]]: Guide to chosing a mover