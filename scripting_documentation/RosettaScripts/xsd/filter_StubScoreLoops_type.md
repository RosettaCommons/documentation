<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
This filter checks whether in the current configuration the scaffold is 'feeling' any of the hotspot stub constraints. This is useful for quick triaging of hopeless configuration. If used in conjunction with the Mover PlaceSimultaneously, don't bother setting flags -- the Mover will take care of it.

```xml
<StubScoreLoops name="(&string;)" cb_force="(2 &non_negative_integer;)"
        start="(&positive_integer;)" stop="(&positive_integer;)"
        stubfile="(&string;)" resfile="(NONE &string;)"
        confidence="(1.0 &real;)" />
```

-   **cb_force**: Chain that ought to be designed, numbered sequentially from 1
-   **start**: (REQUIRED) Starting residue of loop
-   **stop**: (REQUIRED) Ending residue of loop
-   **stubfile**: (REQUIRED) Stub file filename
-   **resfile**: Resfile filename
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
