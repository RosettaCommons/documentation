# SampleRotamersFromPDB
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## SampleRotamersFromPDB

Limit rotamer sampling to rotamers that are similar (+/- 5 deg. difference) to rotamers from input PDBs. The PDB files are given through the "-packing::unboundrot" flag. For each residue in the input pose a vector of rotamers is constructed from all residues that are structurally aligned between the pose residue and all the input PDBs. Note that the taskoperation **__does not align__** the input PDBs and the pose, it only determines which residues are structurally aligned. The alignment should be done before using the TaskOperation. 

    <SampleRotamersFromPDB name="(&string)"/>


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