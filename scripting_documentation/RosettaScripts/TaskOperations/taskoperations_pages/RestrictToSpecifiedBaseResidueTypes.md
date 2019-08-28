# RestrictToSpecifiedBaseResidueTypes
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

 `TaskOperation` to restrict the [[palette|PackerPalette]] of `ResidueType`s to the base `ResidueType`s given.
 
 ## Usage
 ### XML
 ```xml
<RestrictToSpecifiedBaseResidueTypes name="(string)" base_types="(string)" selector="(string)" />
```

**base_types** &mdash; A comma-separated list of `ResidueType`s (by full base name).
**selector** &mdash; If provided, the `TaskOperation` will apply to the subset of residues specified. If not provided, the `TaskOperation` will apply to all residues in the `Pose`.

### C++
The following code is used to create a [[PackerTask]] in which residue 2 is limited to only an alanine or glycine.
```C++
ResidueIndexSelectorOP selector( make_shared< ResidueIndexSelector >() );
selector->set_index( "2" );

operation::RestrictToSpecifiedBaseResidueTypesOP task_op(
    make_shared< operation::RestrictToSpecifiedBaseResidueTypes >(
    utility::vector1< std::string >( { "ALA", "GLY" } ), selector ) );

TaskFactory tf;
tf.push_back( task_op );

PackerTaskOP task( tf.create_task_and_apply_taskoperations( pose ) );
```

`RestrictToSpecifiedBaseResidueTypes::set_base_types()` &mdash; Pass a vector of strings to set the list of base `ResidueType`s allowed (by full base name).
`RestrictToSpecifiedBaseResidueTypes::set_selector()` &mdash; Pass a `ResidueSelector` to specificy to which residue(s) the list of allowed `ResidueType`s applies. If no `ResidueSelector` is specified, Rosetta assumes that this `TaskOperation` applies to all residues in the `Pose`.

##See Also
* [[ProhibitSpecifiedBaseResidueTypes]]
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
