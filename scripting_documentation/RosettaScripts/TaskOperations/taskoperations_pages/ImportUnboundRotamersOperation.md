# ImportUnboundRotamers
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## ImportUnboundRotamers

Import unbound rotamers from a given PDB file. Specify the unbound/native PDB file using the flag: -packing::unboundrot

Note: This task operation was developed to favor unbound rotamers (in particular, native rotamers) from an imported PDB file. If this is what you want, make sure that you use the load\_unbound\_rot mover (no parameters, and currently undocumented), which changes the rotamer Dunbrack scoring term (fa\_dun), such that the scores for your imported unbound rotamers are equal to the best scoring rotamers in your currently used library. This will favor the imported unbound rotamers at the time you design/repack sidechains. This task operation should be used with your favorite sidechain designing/packing mover (for example: GreedyOptMutationMover, RepackMinimize, or PackRotamersMover).

    <ImportUnboundRotamers name="(&string)"/>

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