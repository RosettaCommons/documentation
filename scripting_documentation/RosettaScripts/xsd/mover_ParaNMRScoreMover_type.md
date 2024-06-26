<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
This Mover scores the input pose with PCS, RDC or PRE data, writes the scores and Q-factors to the scorefile, and optionally creates a file of experimental vs. calculated NMR values and a file with tensor infos.

```xml
<ParaNMRScoreMover name="(&string;)" scorefxn="(&string;)"
        verbose="(false &bool;)" output_exp_calc="(false &bool;)"
        write_tensor_info_="(false &bool;)" />
```

-   **scorefxn**: Scorefunction used by this Mover for scoring with paramagnetic NMR data.
-   **verbose**: Write separate score and Q-factor values for each spin-label site, alignment medium or metal ion to scorefile.
-   **output_exp_calc**: Write a table of experimental vs. calculated NMR values for each NMR dataset to prediction file.
-   **write_tensor_info_**: Write tensor and/or spinlabel info for each NMR dataset to info file.

---
