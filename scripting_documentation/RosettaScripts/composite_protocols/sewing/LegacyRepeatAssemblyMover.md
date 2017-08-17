#LegacyRepeatAssemblyMover
##Note: This page is for LegacySEWING.
**This is an outdated page. For information on the current version of sewing, please visit the [[AssemblyMover]] and [[AppendAssemblyMover]] pages.**

The RepeatAssemblyMover is intended for the design of repeat proteins using the SEWING framework. Due to the graph-traversal based generation of backbones used by SEWING, repeat protein generation is relatively easy; one needs only to find cycles in the graph. This mover is currently under active development, and as such many of the features expected in a SEWING mover may not be implemented (for instance, this mover currently does not respect the RequirementSet)

##Command line options
See [[Assembly of models]] for required and optional command-line options.

##RosettaScripts options

* num_repeating_segments: Used to determine the size of the final assembly (see below).

##Sample
**WARNING: Currently the num_repeating_segments options of this tag is misleading. The below tag will actually generate an assembly with 4 repeating segments (e.g. helix-loop-helix-loop). The final repeat in the created assembly will be missing the last segment (e.g. helix-loop-helix). This should be fixed soon and the documentation will be updated to reflect this change**

```xml
<RepeatAssemblyMover name="assemble" num_repeating_segments="2" />
```

##See Also
* [[RequirementSet]]
* [[LegacyMonteCarloAssemblyMover]]
* [[LegacyAppendAssemblyMover]]
* [[Assembly of models]]
* [[SEWING]]