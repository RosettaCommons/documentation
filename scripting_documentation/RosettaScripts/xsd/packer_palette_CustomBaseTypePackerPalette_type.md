<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Sets up a packer palette that expands the default (canonical) residue type set with user-defined base types or types selected by ResidueProperties.

References and author information for the CustomBaseTypePackerPalette packer palette:

CustomBaseTypePackerPalette PackerPalette's citation(s):
Mulligan VK, Kang CS, Sawaya MR, Rettie S, Li X, Antselovich I, Craven T, Watkins A, Labonte JW, DiMaio F, Yeates TO, and Baker D.  (2020).  Computational design of mixed chirality peptide macrocycles with internal symmetry.  Protein Sci 29(12):2433-45.  doi: 10.1002/pro.3974.

```xml
<CustomBaseTypePackerPalette name="(&string;)"
        additional_residue_types="(&string_cslist;)" />
```

-   **additional_residue_types**: A comma-separated list of additional residue types (by full base name) to add to the PackerPalette.

---
