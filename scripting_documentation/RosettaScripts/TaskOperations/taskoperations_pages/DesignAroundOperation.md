# DesignAround
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DesignAround

Designs in shells around a user-defined list of residues. Restricts all other residues to repacking.

    <DesignAround name="(&string)" design_shell="(8.0 &real)" resnums="(comma-delimited list)" repack_shell="(8.0&Real)" allow_design="(1 &bool)" resnums_allow_design="(1 &bool)"/> 

-   resnums can be a list of pdb numbers, such as 291B,101A.
-   repack\_shell: what sphere to pack around the target residues. Must be at least as large as design\_shell.
-   allow\_design: allow design in the sphere, else restrict to repacking.
-   resnums\_allow\_design: allow design in the resnums list, else restrict to repacking.


##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Design application|design-applications]]: applications with which you can do design
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
