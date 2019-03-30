# ProteinLigandInterfaceUpweighter
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## ProteinLigandInterfaceUpweighter

Specifically upweight the strength of the protein-ligand interaction energies by a given factor.

    <ProteinLigandInterfaceUpweighter name="(&string)" interface_weight="(1.0 &Real)" catres_interface_weight="(1.0 &Real)"/>

interface\_weight: upweight ligand interactions by this weight

catres\_interface\_weight: upweight catatlytic residue interactions by this weight

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