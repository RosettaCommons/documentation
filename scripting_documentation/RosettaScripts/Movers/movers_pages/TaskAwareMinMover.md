# TaskAwareMinMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## TaskAwareMinMover

Performs minimization. Accepts TaskOperations via the task\_operations option e.g.

    task_operations=(&string,&string,&string)

to configure which positions are minimized. Options

    chi=(&bool) and bb=(&bool) jump=(0 &bool) scorefxn=(score12 &string)

control jump, sidechain or backbone freedom. Defaults to sidechain minimization. Options type, and tolerance are passed to the underlying MinMover.

To allow backbone minimization, the residue has to be designable. If the residue is only packable only the side chain will be minimized.


##See Also

* [[TaskAwareSymMinMover]]: The symmetric version of this mover
* [[MinMover]]: The non-task aware version of this mover
* [[Task operations in RosettaScripts|TaskOperations-RosettaScripts]]
* [[TaskAwareCstsMover]]
* [[Minimization overview]]
* [[I want to do x]]: Guide to choosing a mover
