<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Add/Remove labels to/from residues defined by ResidueSelector.

```xml
<LabelPoseFromResidueSelectorMover name="(&string;)" property="(&string;)"
        remove_property="(&string;)" from_remark="(0 &bool;)"
        residue_selector="(&string;)" />
```

-   **property**: New label to add to the residues.
-   **remove_property**: Label to remove from the selected residues (if present).
-   **from_remark**: Read the LABELS from REMARKs in the input structure or silent file (when called, ignores all other attributes, so actively setting it to false makes the mover do nothing).
-   **residue_selector**: Selector specifying residues to be labeled. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.

---
