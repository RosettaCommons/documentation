<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
XRW TO DO

```xml
<Superimpose name="(&string;)" ref_start="(1 &non_negative_integer;)"
        ref_end="(0 &non_negative_integer;)"
        target_start="(1 &non_negative_integer;)"
        target_end="(0 &non_negative_integer;)" CA_only="(1 &bool;)"
        ref_pose="(&string;)" spm_reference_name="(&string;)" />
```

-   **ref_start**: Starting residue for superposition, in reference
-   **ref_end**: Ending residue for superposition, in reference
-   **target_start**: Starting residue for superposition
-   **target_end**: Ending residue for superposition
-   **CA_only**: Superimpose by CA coordinates only
-   **ref_pose**: Reference pose file name
-   **spm_reference_name**: Name of reference pose to use (Use the SavePoseMover to create a reference pose)

---
