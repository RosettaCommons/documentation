<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Sets B factors in the PDB based on per-residue PSSM score

```xml
<PSSM2Bfactor name="(&string;)" Value_for_blue="(5.0 &real;)"
        chain_num="(1 &non_negative_integer;)" Value_for_red="(-1.0 &real;)" />
```

-   **Value_for_blue**: PSSM score cutoff below which b factors will
-   **chain_num**: Chain number for which to calculate PSSM and store as B factors
-   **Value_for_red**: Above this PSSM score, B factors will be set to 50

---
