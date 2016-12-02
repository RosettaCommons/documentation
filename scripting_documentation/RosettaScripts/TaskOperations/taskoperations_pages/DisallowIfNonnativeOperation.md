# DisallowIfNonnative
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DisallowIfNonnative

Restrict design to not include a residue as an possibility in the task at a position unless it is the starting residue. If resnum is left as 0, the restriction will apply throughout the pose.

     <DisallowIfNonnative name="(&string)" resnum="(0 &integer)" disallow_aas="(&string)" />

-   disallow\_aas takes a string of one letter amino acid codes, no separation needed. For example disallow\_aas=GCP would prevent Gly, Cys, and Pro from being designed unless they were the native amino acid at a position.

This task is useful when you are designing in a region that has Gly and Pro and you do not want to include them at other positions that aren't already Gly or Pro.

**Note:** "native" means the current residue, _not_ the starting "-s" residue or "-in:file:native".

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