<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Selects residues that are involved in strand-strand pairings.

```xml
<PairedSheetResidueSelector name="(&string;)" secstruct="(&string;)"
        sheet_topology="(&string;)" use_dssp="(true &bool;)" />
```

-   **secstruct**: Secondary structure, e.g. "EEEELLEEEE". If undefined, sec struct will be chosen based on the value of the 'use_dssp' option
-   **sheet_topology**: String describing sheet topology, of the format A-B.P.R, where A is the strand number of the first strand in primary space, B is the strand number of the second strand in primary space, P	 is 'P' for parallel and 'A' for antiparallel, and R is the register shift. E.g. "1-2.A.-1".
-   **use_dssp**: Use dssp to aito-detect secondary structure.

---
