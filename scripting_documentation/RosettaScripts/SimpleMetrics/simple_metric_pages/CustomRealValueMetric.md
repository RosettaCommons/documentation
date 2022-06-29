# CustomRealValueMetric
*Back to [[SimpleMetrics]] page.*
## CustomRealValueMetric

Added by Vikram K. Mulligan (vmulligan@flatironinstitute.org) on 29 June 2022.

[[_TOC_]]

### Description

The CustomRealValueMetric allows a user to add an arbitrary floating-point value, indexed by a label, to a pose.  The value will be written out in the PDB file, or can be accessed by metrics that perform arithmetic.  This also provides a means for storing values that are not computed by metrics in PyRosetta or from Rosetta C++, as well as for passing values from the commandline to store in poses.

### Example with custom values set from commandline

```xml
<ROSETTASCRIPTS>
	<SIMPLE_METRICS>
            <CustomRealValueMetric name="my_metric" value="%%extrernal_val%%" />
	</SIMPLE_METRICS>
	<PROTOCOLS>
            <Add metrics="my_metric" />
	</PROTOCOLS>
</ROSETTASCRIPTS>
```

```sh
~/Rosetta/main/source/src/rosetta_scripts.default.linuxgccrelease -parser:protocol my_script.xml -script_vars external_val=25.3 -in:file:s first_file.pdb
~/Rosetta/main/source/src/rosetta_scripts.default.linuxgccrelease -parser:protocol my_script.xml -script_vars external_val=-12.9 -in:file:s second_file.pdb
```

The above would produce two outputs.  In the first case, the value 25.3 would be stored in the first pose, and in the second, the value -12.9 would be stored in the second.  This could be useful in cases in which external software (molecular dynamics programs, other molecular modelling packages, deep learning models, etc.) is used to perform some analysis on a pose, but one wishes Rosetta to be able to read the value produced.

### Full options (auto-generated documentation)

[[include:simple_metric_CustomRealValueMetric_type]]

## See also

* [[CustomStringValueMetric]]

