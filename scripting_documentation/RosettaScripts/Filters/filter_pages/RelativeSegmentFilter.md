# RelativeSegmentFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## RelativeSegmentFilter

Reports the numbers of residues that align with a segment on source pose.

```xml
<RelativeSegment name="(&string)" source_pose="(&string)" start_res="(&string)" stop_res="(&string)"/>
```

-   source\_pose: The pose to which to align. The two poses should be superimposed prior to running. This filter will not superimpose.
-   start\_res: start res for alignment. Refers to residues on the source pose. Rosetta numbering only.
-   stop\_res: stop res for alignment. ditto.

Taskoperation RestrictToAlignedSegments supersedes this filter as it allows more than one segment to be defined. Use that taskoperation and feed it to DesignableResidues filter to find aligned residues in the input pose.

## See also:

* [[Design in Rosetta|application_documentation/design/design-applications]]

