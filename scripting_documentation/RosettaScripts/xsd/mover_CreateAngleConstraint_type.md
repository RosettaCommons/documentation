<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Adds angle constraints to a pose

```xml
<CreateAngleConstraint name="(&string;)" >
    <Add res_center="(&non_negative_integer;)" atom_center="(&string;)"
            res1="(&non_negative_integer;)" atom1="(&string;)"
            res2="(&non_negative_integer;)" atom2="(&string;)" cst_func="(&string;)" />
</CreateAngleConstraint>
```



Subtag **Add**:   

-   **res_center**: (REQUIRED) Residue at center of angle
-   **atom_center**: (REQUIRED) Atom at center of angle
-   **res1**: (REQUIRED) Residue on one side of angle
-   **atom1**: (REQUIRED) Atom on one side of angle
-   **res2**: (REQUIRED) Residue on other side of the angle
-   **atom2**: (REQUIRED) Atom on other side of the angle
-   **cst_func**: (REQUIRED) Function to use for this constraint

---
