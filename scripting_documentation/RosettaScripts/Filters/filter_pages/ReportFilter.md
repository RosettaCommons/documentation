# Report
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Report

This filter reports the value of another filter with the current job name. Useful when running long trajectories where one wants to see intermediate values of successful trajectories.  The value of the filter at the time the filter is run will be stored in the score file alongside the value of the filter for the final pose.

```xml
<Report name="(&string)" filter="('' &string)" report_string="(''&string)" checkpointing_file="(''&string)"/>
```

-   filter: name of a filter on the datamap that report will invoke.
-   report\_string: name of an object on the datamap that stores a value for reporting. This requires another mover/filter to be aware of this object and modify it. Currently no movers/filters use this functionality, but it could come in useful in future.
-   checkpointing\_file: If the protocol is checkpointed (e.g., through GenericMonteCarlo) this will make ReportFilter checkpoint its data. If the checkpointing file exists the value from the checkpointing file will be read into ReportFilter's internal value and will be reported at the end of the run. On apply, the filter's value will be written to the checkpointing file.

23Sep13 report\_string is not really necessary. Report filter simply caches the value of the filter when you call ReportFilter and then returns this saved value at the end of the run. Simple and useful


