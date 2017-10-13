# SetCatalyticResPackBehavior
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## SetCatalyticResPackBehavior

Ensures that catalytic residues as specified in a match/constraint file do not get designed. If no option is specified the constrained residues will be set to repack only (not design).

If the option fix\_catalytic\_aa=1 is set in the tag (or on the commandline), catalytic residues will be set to non-repacking.

[[include:to_SetCatalyticResPackBehavior_type]]

If the option -enzdes::ex\_catalytic\_rot \<number\> is active, the extra\_sd sampling for every chi angle of the catalytic residues will be according to \<number\>, i.e. one can selectively oversample the catalytic residues

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