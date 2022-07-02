# CustomStringValueMetric
*Back to [[SimpleMetrics]] page.*
## CustomStringValueMetric

Added by Vikram K. Mulligan (vmulligan@flatironinstitute.org) on 29 June 2022.

[[_TOC_]]

### Description

The CustomStringValueMetric allows a user to add an arbitrary string, indexed by a label, to a pose.  The value will be written out in the PDB file, or can be accessed by metrics that access strings.  This also provides a means for storing strings that are not produced by metrics in PyRosetta or from Rosetta C++, as well as for passing strings from the commandline to store in poses.

### Example with custom strings set from commandline

```xml
<ROSETTASCRIPTS>
	<SIMPLE_METRICS>
            <CustomStringValueMetric name="pose_annotation" value="%%external_val%%" />
	</SIMPLE_METRICS>
	<PROTOCOLS>
            <Add metrics="my_metric" />
	</PROTOCOLS>
</ROSETTASCRIPTS>
```

```sh
~/Rosetta/main/source/src/rosetta_scripts.default.linuxgccrelease -parser:protocol my_script.xml -script_vars external_val=high_quality_pose -in:file:s first_file.pdb
~/Rosetta/main/source/src/rosetta_scripts.default.linuxgccrelease -parser:protocol my_script.xml -script_vars external_val=poor_quality_pose -in:file:s second_file.pdb
```

The above would produce two outputs.  In the first case, the pose annotation "high_quality_pose" would be stored in the first pose, and in the second, the pose annotation "low_quality_pose" would be stored in the second.  This could be useful in cases in which external software (molecular dynamics programs, other molecular modelling packages, deep learning models, etc.) is used to perform some qualitative analysis on a pose, but one wishes Rosetta to be able to read the annotation produced.

### Full options (auto-generated documentation)

[[include:simple_metric_CustomStringValueMetric_type]]

## See also

* [[CustomRealValueMetric]]

