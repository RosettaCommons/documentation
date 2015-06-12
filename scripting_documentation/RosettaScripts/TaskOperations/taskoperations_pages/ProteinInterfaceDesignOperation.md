# ProteinInterfaceDesign
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## ProteinInterfaceDesign

Restricts to the task that is the basis for protein-interface design. Default behavior:

    - prevent mutation of native pro/gly/cys
    - prevent design of nonnative pro/gly/cys
    - allow design of chain2 non-pro/gly/cys positions with Cbeta within 8.0Å of chain1
    - allow repack of chain1 non-pro/gly/cys positions with Cbeta within 8.0Å of chain2

Note: When using this taskop on a pose with more than 2 chains, everything before the indicated jump is treated as "chain1", everything after as "chain2".

-   repack\_chain1=(1, &bool)
-   repack\_chain2=(1, &bool)
-   design\_chain1=(0, &bool)
-   design\_chain2=(1, &bool)
-   allow\_all\_aas=(0 &bool)
-   design\_all\_aas=(0 &bool)
-   interface\_distance\_cutoff=(8.0, &Real)
-   jump=(1&integer) chains below, and above the jump are called chain1 and chain2 above.
-   modify\_before\_jump=(1 &bool)
-   modify\_after\_jump=(1 &bool)

modify before/after jump determine whether the taskoperation will change residues before/after the jump. For instance, if you want set repack on chain2 interfacial residues to true, and the rest of chain2 to false, and yet not change the task for chain1, then use this taskoperation with modify\_before\_jump=0

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