<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
XRW TO DO

```xml
<LRmsd name="(&string;)" reference_name="(&string;)"
        threshold="(200 &non_negative_integer;)"
        jump="(1 &non_negative_integer;)" confidence="(1.0 &real;)" />
```

-   **reference_name**: Name of reference pose to use (Use the SavePoseMover to create a reference pose)
-   **threshold**: Holes score threshold above which we fail the filter
-   **jump**: Jump across which to evaluate the holes score, numbered sequentially from 1
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
