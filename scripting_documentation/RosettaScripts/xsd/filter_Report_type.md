<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
This filter reports the value of another filter with the current job name. Useful when running long trajectories where one wants to see intermediate values of successful trajectories

```xml
<Report name="(&string;)" report_string="(&string;)" filter="(&string;)"
        checkpointing_file="(&string;)" confidence="(1.0 &real;)" />
```

-   **report_string**: name of an object on the datamap that stores a value for reporting. This requires another mover/filter to be aware of this object and modify it. Currently no movers/filters use this functionality, but it could come in useful in future
-   **filter**: name of a filter on the datamap that report will invoke
-   **checkpointing_file**: If the protocol is checkpointed (e.g., through GenericMonteCarlo) this will make ReportFilter checkpoint its data. If the checkpointing file exists the value from the checkpointing file will be read into ReportFilter's internal value and will be reported at the end of the run. On apply, the filter's value will be written to the checkpointing file.
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
