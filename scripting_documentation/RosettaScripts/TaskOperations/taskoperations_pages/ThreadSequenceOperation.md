# ThreadSequence
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## ThreadSequence

[[include:to_ThreadSequence_type]]

To actually change the sequence of the pose, you have to call something like PackRotamersMover on the pose using this task operation. Notice that with default parameters, this packs the threaded sequence while leaving everything else open for design.

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta