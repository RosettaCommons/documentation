<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Prohibit the base ResidueTypes provided by name from the palette of ResidueTypes.

```xml
<ProhibitSpecifiedBaseResidueTypes name="(&string;)"
        base_types="(&string_cslist;)" selector="(&string;)" />
```

-   **base_types**: A comma-separated list of ResidueTypes (by full base name).
-   **selector**: If provided, the TaskOperation will apply to the subset of residues specified. If not provided, the TaskOperation will apply to all residues in the Pose.

---
