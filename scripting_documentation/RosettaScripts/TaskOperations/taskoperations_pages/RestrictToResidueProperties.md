# RestrictToResidueProperties
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

 `TaskOperation` to restrict the [[palette|PackerPalette]] of `ResidueType`s to those with the given properties.
 
## Usage

### RosettaScripts

[[include:to_RestrictToResidueProperties_type]]

### C++
The following code is used to create a [[PackerTask]] in which residue 2 is limited to only hydrophobic residues.

```c++
ResidueIndexSelectorOP selector( make_shared< ResidueIndexSelector >() );
selector->set_index( "2" );

operation::RestrictToResiduePropertiesOP task_op(
    make_shared< operation::RestrictToResidueProperties >(
    vector1< ResidueProperty >( { HYDROPHOBIC } ), selector ) );

TaskFactory tf;
tf.push_back( task_op );

PackerTaskOP task( tf.create_task_and_apply_taskoperations( pose ) );
```

`RestrictToResidueProperties::set_properties()` &mdash; Pass a vector of `ResidueProperty`s with which to restrict design.
`RestrictToResidueProperties::set_selector()` &mdash; Pass a `ResidueSelector` to specificy to which residue(s) the list of allowed `ResidueProperty`s applies. If no `ResidueSelector` is specified, Rosetta assumes that this `TaskOperation` applies to all residues in the `Pose`.

##See Also
* [[ProhibitResidueProperties]]
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
