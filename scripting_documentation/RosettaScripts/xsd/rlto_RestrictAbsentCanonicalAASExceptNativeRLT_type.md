<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Except for the native amino acid, do not allow design to amino acid identities that are not listed (i.e. permit only those listed + native) at specific positions (selected by a ResidueSelector or a ResFilter).

```xml
<RestrictAbsentCanonicalAASExceptNativeRLT name="(&string;)" aas="(&string;)" />
```

-   **aas**: (REQUIRED) list of one letter codes of permitted amino acids, with no separator. (e.g. aas=HYFW for only aromatic amino acids.)

---
