# RetrieveStoredTask
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## RetrieveStoredTask

Retrieves a stored packer task from the pose's cacheable data; must be used in conjunction with the [[StoreTaskMover]]. Allows the caching and retrieval of tasks such that a packer task can be defined at an arbitrary point in a RosettaScripts protocol and used again later. This is useful when changes to the pose in the intervening time may result in a different packer task even though the same task operations are applied. Has the ancillary benefit of shortening the lists of task operations that frequently pepper RosettaScripts .xml files.

      <RetrieveStoredTask name="(&string)" task_name="(&string)" />

-   task\_name - The index where the stored task can be accessed in the pose's cacheable data. This must be identical to the task\_name used to store the task using the StoreTask mover.

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta