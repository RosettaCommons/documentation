<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Apply the given chemistry to the given residues, replacing the residues in the pose with the new residue type.

```xml
<ApplyChemistryMover name="(&string;)" chemistry="(&string;)"
        residue="(&string;)" new_name="(&string;)" tag="(mod &string;)"
        residue_selector="(&string;)" >
    <PatchChemistry name="(&string;)" patch_name="(&string;)"
            patch_file="(&string;)" >
        <Op line="(&string;)" />
    </PatchChemistry>
</ApplyChemistryMover>
```

-   **chemistry**: The name of the chemistry to use
-   **residue**: Which residues (as a comma separated list) to apply the chemistry to. Ignored if residue selector is set.
-   **new_name**: What to call the new ResidueType. (Only if a single type, and the name isn't already chosen.)
-   **tag**: A suffix to use to distinguish residues which have the same name
-   **residue_selector**: Which residues (as a residue selector) to apply the chemistry to. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.


Subtag **PatchChemistry**:   A patch chemistry applies a given patch to the residue type.

-   **patch_name**: The name of the patch from the ResidueTypeSet to apply.
-   **patch_file**: The name of a file from which to get the patches.


Subtag **Op**:   

-   **line**: (REQUIRED) The patch file line contents.

---
