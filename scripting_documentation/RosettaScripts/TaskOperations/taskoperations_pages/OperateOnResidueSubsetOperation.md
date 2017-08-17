#OperateOnResidueSubset
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
##OperateOnResidueSubset

    <OperateOnResidueSubset name="(%string)" selector="(%string)" >
       <(ResLvlTaskOperation)/>
    </OperateOnResidueSubset>

or

    <OperateOnResidueSubset name="(%string)">
       <(Selector)/>
       <(ResLvlTaskOperation)/>
    </OperateOnResidueSubset>

-   OperateOnResidueSubset is a TaskOperation that applies a ResLevelTaskOperation to the residues indicated by a [[ResidueSelector|ResidueSelectors]]. (selector="my_prev_defined_res_selector")
-   The ResidueSelector may be provided either through the "selector" option (in which case, the string provided to the option should refer to a previously declared ResidueSelector which can be found in the DataMap), or though an anonymously declared ResidueSelector whose definition is given as a sub-tag. Anonymously declared ResidueSelectors are not added to the DataMap.
-   Existing ResLvlTaskOperations are defined at [[Residue-Level-TaskOperations]] .

## ResidueSelectors

[[ResidueSelectors]] are a flexible way of specifying subsets of residues in poses.

## Residue Level TaskOperations

[[Residue Level TaskOperations]] specify how the selected residues subsets should behave.

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