<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
 Disable specific antibody regions in an antibody

```xml
<DisableAntibodyRegionOperation name="(&string;)" region="(&string;)"
        disable_packing_and_design="(true &bool;)" cdr_definition="(&string;)"
        input_ab_scheme="(&string;)" />
```

-   **region**: Region to apply this to: antibody_region, cdr_region, or framework_region
-   **disable_packing_and_design**: Disable packing AND design to this region
-   **cdr_definition**: The CDR Definition used for this operation
-   **input_ab_scheme**: The antibody scheme used for this operation

---
