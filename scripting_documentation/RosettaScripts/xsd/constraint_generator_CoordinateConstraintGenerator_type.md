<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Adds coordinate constraints to the specified residues

References and author information for the CoordinateConstraintGenerator constraint generator:

CoordinateConstraintGenerator ConstraintGenerator's author(s):
Thomas W. Linsky, Neoleukin Therapeutics [tlinsky@gmail.com]  (Created the ConstraintGenerator framework and the CoordinateConstraintGenerator.)

```xml
<CoordinateConstraintGenerator name="(&string;)" native="(false &bool;)"
        ca_only="(&bool;)" sidechain="(&bool;)" sd="(&real;)"
        ambiguous_hnq="(&bool;)" bounded="(&bool;)" bounded_width="(&real;)"
        align_reference="(&bool;)" residue_selector="(&string;)" />
```

-   **native**: Constrain to native coordinates
-   **ca_only**: Only apply constraints to alpha carbons
-   **sidechain**: Apply constraints to side chain atoms
-   **sd**: Standard deviation for constraints
-   **ambiguous_hnq**: If true, these residues could be flipped without affecting the score
-   **bounded**: Should we use a bounded function for this constraint?
-   **bounded_width**: Width of bounded function if using
-   **align_reference**: Align reference pose to constraint target pose?
-   **residue_selector**: Selector specifying residues to constrain. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.

---
