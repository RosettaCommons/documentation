# ProhibitResidueProperties
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

 `TaskOperation` to prohibit the [[palette|PackerPalette]] of `ResidueType`s from using those with any of the given properties.
 
 ## Usage
 ### XML
 ```xml
<ProhibitResidueProperties name="(string)" properties="(string)" selector="(string)" />
```

**properties** &mdash; A comma-separated list of `ResidueProperty`s, none of which may be present in a `ResidueType` to design with it.
**selector** &mdash; If provided, the `TaskOperation` will apply to the subset of residues specified. If not provided, the `TaskOperation` will apply to all residues in the `Pose`.

### C++
The following code is used to create a [[PackerTask]] in which residue 2 is prohibited from using residues with a side-chain thiol functionality.
```C++
ResidueIndexSelectorOP selector( make_shared< ResidueIndexSelector >() );
selector->set_index( "2" );

operation::ProhibitResiduePropertiesOP task_op(
    make_shared< operation::ProhibitResidueProperties >(
		vector1< ResidueProperty >( { SIDECHAIN_THIOL } ), selector ) );

TaskFactory tf;
tf.push_back( task_op );

PackerTaskOP task( tf.create_task_and_apply_taskoperations( pose ) );
```

`ProhibitResidueProperties::set_properties()` &mdash; Pass a vector of `ResidueProperty`s with which to restrict design.
`ProhibitResidueProperties::set_selector()` &mdash; Pass a `ResidueSelector` to specificy to which residue(s) the list of prohibited `ResidueProperty`s applies. If no `ResidueSelector` is specified, Rosetta assumes that this `TaskOperation` applies to all residues in the `Pose`.

##See Also
* [[RestrictToResidueProperties]]
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
