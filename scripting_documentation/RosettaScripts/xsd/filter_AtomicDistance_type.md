<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Filters on the distance between two specific atoms or the minimal distance between atoms of two specific types, on one or two residues.

```xml
<AtomicDistance name="(&string;)" distance="(4.0 &real;)" atomtype1="(&string;)"
        atomtype2="(&string;)" atomname1="(CB &string;)"
        atomname2="(CB &string;)" residue1="(&refpose_enabled_residue_number;)"
        residue2="(&refpose_enabled_residue_number;)" res1_selector="(&string;)"
        res2_selector="(&string;)" confidence="(1.0 &real;)" />
```

-   **distance**: Distance threshold between atoms in question
-   **atomtype1**: Type desired for first atom
-   **atomtype2**: Type of second atom
-   **atomname1**: Name desired for first atom
-   **atomname2**: Name of second atom
-   **residue1**: First residue
-   **residue2**: Second residue
-   **res1_selector**: Alternative to using the residue1 option. This residue selector must select exactly one residue!. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **res2_selector**: Alternative to using the residue2 option. This residue selector must select exactly one residue!. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
