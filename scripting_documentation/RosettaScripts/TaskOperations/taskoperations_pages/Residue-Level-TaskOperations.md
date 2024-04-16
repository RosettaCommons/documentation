<!-- --- title: Residue Level TaskOperations -->

Residue Level Task Operations
----------------------------
Residue Level TaskOperations control the packer at the residue level, in combination with [[ResidueSelectors|ResidueSelectors]].

Use these as a subtag (without the name) for [[OperateOnResidueSubset|OperateOnResidueSubsetOperation]] (or the deprecated [[OperateOnCertainResidues|OperateOnCertainResiduesOperation]]). Only one may be used per OperateOnResidueSubset/OperateOnCertainResidues tag.

Residue Level TaskOperations can also be declared as stand alone in their own tag `<RESIDUE_LEVEL_TASK_OPERATIONS>` and passed to [[DesignRestrictions|DesignRestrictionsOperation]].


### [[RestrictToRepackingRLT|rlto_RestrictToRepackingRLT_type]]

Turn off design on the positions selected.
```xml
<RestrictToRepackingRLT name="(&string;)" />
```

### [[PreventRepackingRLT|rlto_PreventRepackingRLT_type]]

Turn off design and repacking on the positions selected.

```xml
<PreventRepackingRLT name="(&string;)" />
```

### [[RestrictAbsentCanonicalAASRLT|rlto_RestrictAbsentCanonicalAASRLT_type]]

Do not allow design to amino acid identities that are not listed (i.e. permit only those listed) at the positions selected.
```xml
<RestrictAbsentCanonicalAASRLT name="(&string;)" aas="(&string)"/>
```
### [[RestrictAbsentCanonicalAASExceptNativeRLT|rlto_RestrictAbsentCanonicalAASExceptNativeRLT_type]]

Except for the native amino acid, do not allow design to amino acid identities that are not listed (i.e. permit only those listed + native).

```xml
<RestrictAbsentCanonicalAASExceptNativeRLT name="(&string;)" aas="(&string;)" />
```


### [[AddBehaviorRLT|rlto_AddBehaviorRLT_type]]
Add the given "behavior" to the positions selected by the accompanying ResFilter.
```xml
<AddBehaviorRLT name="(&string;)"  behavior="(&string)"/>
```

### [[DisallowIfNonnativeRLT|rlto_DisallowIfNonnativeRLT_type]]
Restrict design to not include a residue as an possibility in the task at a position unless it is the starting residue. 
```xml
<DisallowIfNonnativeRLT name="(&string;)" disallow_aas="(&string;)" />
```

### [[ExtraRotamersGenericRLT|rlto_ExtraRotamersGenericRLT_type]]

During packing, extra rotamers can be used to increase sampling. Use this TaskOperation to specify for all residues at once what extra rotamers should be used. 

### [[IncludeCurrentRLT|rlto_IncludeCurrentRLT_type]]
Includes current rotamers of the pose in the rotamer set.
```xml
<IncludeCurrentRLT name="(&string;)" />
```

### [[ExtraChiCutoffRLT|rlto_ExtraChiCutoffRLT_type]]
Move only toward a lower cutoff for #neighbors w/i 10A that qualify a residue to be considered buried.
```xml
<ExtraChiCutoffRLT name="(&string;)" extrachi_cutoff="(18 &non_negative_integer;)" />
```

### [[PreserveCBetaRLT|rlto_PreserveCBetaRLT_type]]
preserves c-beta during rotamer building for selected residues. Under development and untested. Use at your own risk.
```xml
<PreserveCBetaRLT name="(&string;)" />
```

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