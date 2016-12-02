# AddLigandMotifRotamers
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## AddLigandMotifRotamers

Using a library of protein-ligand interactions, identify possible native-like interactions to the ligand and add those rotamers to the packer, possibly with a bonus.

    <AddLigandMotifRotamers name="(&string)"/>

Since it only makes sense to run AddLigandMotifRotamers once (it takes a very long time), I have not made the options parseable. You can however read in multiple weight files in order to do motif weight ramping.

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [Preparing ligands|preparing-ligands]: making ligands ready for use with Rosetta
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta