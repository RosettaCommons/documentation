<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
Select residues of particular antibody regions.

```xml
<AntibodyRegion name="(&string;)" region="(&region_string;)"
        cdr_definition="(&string;)" input_ab_scheme="(&string;)" />
```

-   **region**: Select the region you wish to disable. Options: cdr_region, framework_region, antigen_region
-   **cdr_definition**: Set the cdr definition you want to use. Requires the input_ab_scheme option
-   **input_ab_scheme**: Set the antibody numbering scheme. Requires the cdr_definition XML option. Both options can also be set through the command line (recommended).

---
