# TaskAwareSymMinMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## TaskAwareSymMinMover

(This is a devel Mover and not available in released versions.)

<!--- BEGIN_INTERNAL -->

A task-aware version of the SymMinMover that allows minimization of only certain sets of residues specified by user-defined task operations.

    <TaskAwareSymMinMover name="(&string)" scorefxn="(&scorefxn)" bb="(0 &bool)" chi="(1 &bool)" rb="(0 &bool)" task_operations="(comma-delimited list of task operations)" />

-   bb - Whether to allow backbone minimization.
-   chi - Whether to allow side chain minimization.
-   rb - Whether to allow rigid body minimization.

<!--- END_INTERNAL --> 

##See Also

* [[TaskAwareMinMover]]: The non-symmetric version of this mover
* [[SymMinMover]]: The non-task aware version of this mover
* [[Task operations in RosettaScripts|TaskOperations-RosettaScripts]]
* [[TaskAwareCstsMover]]
* [[Minimization overview]]
* [[I want to do x]]: Guide to choosing a mover
