# StoreTask
*Back to [[Mover|Movers-RosettaScripts]] page.*
## StoreTask

(This is a devel Mover and not available in released versions.)

<!--- BEGIN_INTERNAL -->
Creates a packer task by applying the user-specified task operations to the current pose and saves the packer task in the pose's cacheable data, allowing the task to be accessed, unchanged, at a later point in the RosettaScripts protocol. Must be used in conjunction with the RetrieveStoredTask task operation.

    <StoreTaskMover name="(&string)" task_name="(&string)" task_operations="(comma-delimited list of task operations)" overwrite="(0 &bool)" />

-   task\_name - The index where the task will be stored in the pose's cacheable data. Must be identical to the task\_name used to retrieve the task using the RetrieveStoredTask task operation.
-   task\_operations - A comma-delimited list of task operations used to create the packer task.
-   overwrite - If set to true, will overwrite an existing task with the same task\_name if one exists.

<!--- END_INTERNAL --> 

##See Also

* [[StoreCompoundTaskMover]]
* [[Task operations in RosettaScripts|TaskOperations-RosettaScripts]]
* [[TaskAwareCstsMover]]
* [[TaskAwareMinMOver]]
* [[TaskAwareSymMinMover]]
