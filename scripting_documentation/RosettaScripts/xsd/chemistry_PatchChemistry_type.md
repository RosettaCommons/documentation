<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
A patch chemistry applies a given patch to the residue type.

```xml
<PatchChemistry name="(&string;)" patch_name="(&string;)"
        patch_file="(&string;)" >
    <Op line="(&string;)" />
</PatchChemistry>
```

-   **patch_name**: The name of the patch from the ResidueTypeSet to apply.
-   **patch_file**: The name of a file from which to get the patches.


Subtag **Op**:   

-   **line**: (REQUIRED) The patch file line contents.

---
