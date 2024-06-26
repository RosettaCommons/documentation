<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
This Metric reports options that have been set in the command line and splits script_vars.  Each option name is the type and the setting is the value in the map.  This is primarily aimed at benchmarking and record-keeping for large-scale rosetta runs or experiments.
  It works with both the global and local OptionsCollection to enable its use in JD3.  
It is analogous to the ProtocolFeatures reporter, with more options for xml-based variables.

```xml
<ProtocolSettingsMetric name="(&string;)" custom_type="(&string;)"
        base_name_only="(true &bool;)" get_user_options="(true &bool;)"
        get_script_vars="(true &bool;)" limit_to_options="(&string_cslist;)"
        skip_corrections="(true &bool;)" job_tag="(&string;)" />
```

-   **custom_type**: Allows multiple configured SimpleMetrics of a single type to be called in a single RunSimpleMetrics and SimpleMetricFeatures. 
 The custom_type name will be added to the data tag in the scorefile or features database.
-   **base_name_only**: Use only the base option name instead of the whole path
-   **get_user_options**: Report all set cmd-line options
-   **get_script_vars**: Split script_vars and report
-   **limit_to_options**: Limit reporting to these options (comma-separated list).  Can be user-set or script_vars, but works with the get_user_options and get_script_vars options.
-   **skip_corrections**: Skip ScoreFunction Corrections, which are set in-code at the beginning of a run.
-   **job_tag**: Add a tag for this particular job.  Will be output as opt_job_tag. Used for benchmarking.

---
