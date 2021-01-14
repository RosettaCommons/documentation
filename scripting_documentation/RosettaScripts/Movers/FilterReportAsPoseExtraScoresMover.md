# FilterReportAsPoseExtraScoresMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FilterReportAsPoseExtraScoresMover

For some reason, the value reported by [[Filter|Filters-RosettaScripts]]s to the [[scorefile|Glossary#scorefile]] is their value at the end of the run, not their value at the time they perform the filtering operation.  This Mover stores a Filter's report value at the time it is called into the PoseExtraScores for later output to the scorefile.
This value can be extracted using [[ReadPoseExtraScoreFilter|ReadPoseExtraScoreFilter]].

```xml
<FilterReportAsPoseExtraScoresMover name="&string" report_as="(&string)" filter_name="(&string)"/>
```

- report_as: the string label for the report to the scorefile.  It shouldn't be the same as the filter's report label; otherwise I'm not sure which overwrites the other.  This is necessary because because the filter is still going to report its usual end-of-the-run value. 
- filter_name: The Filter object to run.  It expects to go dig this out of the DataMap, so it should have been declared in the FILTERS block of your xml.

##Note 
The add option in the protocols sections accepts `report_at_end` value, which will prevent filters returning the value at the end of the run. For example
```XML
<Add filter="vbuns" report_at_end="false"  />
```

Coupled with the `-mute protocols.rosetta_scripts.ParsedProtocol.REPORT` flag, filters will only get called once and return the expected value.

##See Also

* [[WriteFiltersToPose]]: Use this if you want to write the values of all filters (useful for parsing data). 
* [[I want to do x]]: Guide to choosing a mover
