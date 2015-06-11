#OperateOnResidueSubset
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
##OperateOnResidueSubset

    <OperateOnResidueSubset name=(%string) selector=(%string) >
       <(ResLvlTaskOperation)/>
    </OperateOnResidueSubset/>

or

    <OperateOnResidueSubset name=(%string)>
       <(Selector)/>
       <(ResLvlTaskOperation)/>
    </OperateOnResidueSubset/>

-   OperateOnResidueSubset is a TaskOperation that applies a ResLevelTaskOperation to the residues indicated by a [[ResidueSelector|ResidueSelectors]].
-   The ResidueSelector may be provided either through the "selector" option (in which case, the string provided to the option should refer to a previously declared ResidueSelector which can be found in the DataMap), or though an anonymously declared ResidueSelector whose definition is given as a sub-tag. Anonymously declared ResidueSelectors are not added to the DataMap.
-   Existing ResLvlTaskOperations are defined at [[Residue-Level-TaskOperations]] .

## ResidueSelectors

[[ResidueSelectors]] are a flexible way of specifying subsets of residues in poses.

## Residue Level TaskOperations

[[Residue Level TaskOperations]] specify how the selected residues subsets should behave.

