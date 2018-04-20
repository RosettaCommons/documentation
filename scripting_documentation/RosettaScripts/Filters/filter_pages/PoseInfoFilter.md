# PoseInfo
*Back to [[Filters|Filters-RosettaScripts]] page.*
## PoseInfo


Primarily intended for debugging purposes. When invoked, it will print basic information about the pose (e.g. PDB numbering and FoldTree layout) to the standard/tracer output.

This filter \*always\* returns true, therefore it's not recommended to use it with the standard "confidence" option, as that may result in the filter not being applied when you want it to be (and consequently not getting the tracer output).

```xml
<PoseInfo name="(&string)"/>
```

## See also:

* [[LoadPDBMover]]
* [[PoseCommentFilter]]
