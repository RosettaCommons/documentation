<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Implements a simple IF (filter(pose)) THEN true_mover(pose) ELSE false_mover(pose). If not using the logic option, true_mover is required, false_mover is not. Both movers default to null.

```xml
<If name="(&string;)" logic="(&string;)" value="(&xs:boolean;)"
        filter_name="(&string;)" true_mover_name="(null &string;)"
        false_mover_name="(null &string;)" />
```

-   **logic**: Parse logic as `if x : y else z` This corresponds to filter_name,true_mover_name,false_mover_name. Use null for do nothing. not is also accepted so - if not x : y else z
-   **value**: Alternative to filter_name/logic.  Allows control-flow through RS.  Set as 1 or 0
-   **filter_name**: Filter used for the if else statement
-   **true_mover_name**: Mover to be execuated when filter returns true
-   **false_mover_name**: Mover to be executed when filter returns false

---
