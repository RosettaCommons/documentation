# ReadPoseExtraScoreFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ReadPoseExtraScoreFilter

This filter reads an extra score stored in the pose.
This can be useful to retrieve values stored by [[FilterReportAsPoseExtraScoresMover|FilterReportAsPoseExtraScoresMover]]
(the `term_name` option here should be the same as the `report_as` option in FilterReportAsPoseExtraScoresMover).

```xml
<ReadPoseExtraScoreFilter name="read_sew_total" term_name="sew_total" threshold="-1"/>
```

-   term\_name: Name of the score term stored in the pose.
-   threshold: Filters the pose if the stored value is greater than the threshold.



