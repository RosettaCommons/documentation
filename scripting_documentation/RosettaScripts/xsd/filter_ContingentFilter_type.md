<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
A special filter that allows movers to set its value (pass/fail). This value can then be used in the protocol together with IfMover to control the flow of execution depending on the success of the mover.

```xml
<ContingentFilter name="(&string;)" confidence="(1.0 &real;)" />
```

-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
