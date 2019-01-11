# RotamerExplosion
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## RotamerExplosion

Sample residue chi angles much more finely during packing. Currently hardcoded to use three 1/3 step standard deviation.

*Note: This might actually need to be called as RotamerExplosionCreator in the xml*

     <RotamerExplosionCreator name="(&string)" resnum="(&Integer)" chi="(&Integer)" />

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