<!-- --- title: Residue Level TaskOperations -->

Residue Level TaskOperations
----------------------------
Use these as a subtag for [[OperateOnResidueSubset|OperateOnResidueSubsetOperation]] (or the deprecated [[OperateOnCertainResidues|OperateOnCertainResiduesOperation]]). Only one may be used per OperateOnResidueSubset/OperateOnCertainResidues tag.

Residue Level TaskOperations can also be declared as stand alone in their own tag `<RESIDUE_LEVEL_TASK_OPERATIONS>` and passed to [[DesignRestrictions|DesignRestrictionsOperation]].


### RestrictToRepackingRLT

Turn off design on the positions selected by the accompanying ResFilter.

    <RestrictToRepackingRLT/>

### PreventRepackingRLT

Turn off design and repacking on the positions selected by the accompanying ResFilter.

    <PreventRepackingRLT/>

### RestrictAbsentCanonicalAASRLT

Do not allow design to amino acid identities that are not listed (i.e. permit only those listed) at the positions selected by the accompanying ResFilter.

    <RestrictAbsentCanonicalAASRLT aas="(&string)"/>

-   aas - list of one letter codes of permitted amino acids, with no separator. (e.g. aas=HYFW for only aromatic amino acids.)

### AddBehaviorRLT

Add the given "behavior" to the positions selected by the accompanying ResFilter.

    <AddBehaviorRLT behavior="(&string)"/>

-   behavior - Behavior string. These are protocol-specific. Consult the protocol documentation for if it responds to behavior strings.


### DisallowIfNonnativeRLT 

[[include:rlto_DisallowIfNonnativeRLT_type]]

### ExtraChiCutoffRLT

[[include:rlto_ExtraChiCutoffRLT_type]]

### [[ExtraRotamersGenericRLT|rlto_ExtraRotamersGenericRLT_type]]

During packing, extra rotamers can be used to increase sampling. Use this TaskOperation to specify for all residues at once what extra rotamers should be used. 

### IncludeCurrentRLT

[[include:rlto_IncludeCurrentRLT_type]]



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