# ProhibitResidueProperties
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

 `TaskOperation` to prohibit the [[palette|PackerPalette]] of `ResidueType`s from using those with any of the given properties.
 
## Usage
### RosettaScripts

[[include:to_ProhibitResidueProperties_type]]

### C++

The following code is used to create a [[PackerTask]] in which residue 2 is prohibited from using residues with a side-chain thiol functionality.

```c++
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
