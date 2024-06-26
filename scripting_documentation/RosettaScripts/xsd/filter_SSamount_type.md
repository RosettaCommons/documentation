<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Filter on the proportion of residues with a secondary structure assignment (i.e., not loop)

```xml
<SSamount name="(&string;)" reference_name="(&string;)" chain="(&char;)"
        upper_threshold="(1.0 &real;)" lower_threshold="(0.5 &real;)"
        discard_lonely_SS="(&non_negative_integer;)" confidence="(1.0 &real;)" />
```

-   **reference_name**: Name of reference pose to use (Use the SavePoseMover to create a reference pose)
-   **chain**: Chain over which to calculate the filter
-   **upper_threshold**: Upper threshold above which the filter would return false
-   **lower_threshold**: Lower threshold above which the filter would return false
-   **discard_lonely_SS**: Score poses with only one SS element as -1.0
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
