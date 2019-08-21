# ProhibitSpecifiedBaseResidueTypes
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

 `TaskOperation` to prohibit `ResidueType`s with the given properties from the [[palette|PackerPalette]].
 
 ## Usage
 ### XML
 ```xml
<ProhibitSpecifiedBaseResidueTypes name="(string)" base_types="(string)" selector="(string)" />
```

**base_types** &mdash; A comma-separated list of `ResidueType`s (by full base name).
**selector** &mdash; If provided, the `TaskOperation` will apply to the subset of residues specified. If not provided, the `TaskOperation` will apply to all residues in the `Pose`.

### C++
The following code is used to create a [[PackerTask]] in which residue 2 is prohibited from designing to a histidine residue.
```C++
ResidueIndexSelectorOP selector( make_shared< ResidueIndexSelector >() );
selector->set_index( "2" );

operation::ProhibitSpecifiedBaseResidueTypesOP task_op(
    make_shared< operation::ProhibitSpecifiedBaseResidueTypes >(
		utility::vector1< std::string >( { "HIS", "HIS_D" } ), selector ) );

TaskFactory tf;
tf.push_back( task_op );

PackerTaskOP task( tf.create_task_and_apply_taskoperations( pose ) );
```

`ProhibitSpecifiedBaseResidueTypes::set_base_types()` &mdash; Pass a vector of strings to set the list of base `ResidueType`s forbidden (by full base name).
`ProhibitSpecifiedBaseResidueTypes::set_selector()` &mdash; Pass a `ResidueSelector` to specificy to which residue(s) the list of prohibited `ResidueType`s applies. If no `ResidueSelector` is specified, Rosetta assumes that this `TaskOperation` applies to all residues in the `Pose`.

##See Also
* [[RestrictToSpecifiedBaseResidueTypes]]
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
