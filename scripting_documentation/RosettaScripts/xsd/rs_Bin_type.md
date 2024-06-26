<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
The BinSelector selects residues that fall in a named mainchain torsion bin (e.g. the "A" bin, corresponding to alpha-helical residues by the "ABEGO" nomenclature). Non-polymeric residues are ignored. By default, only alpha-amino acids are selected, though this can be disabled.

```xml
<Bin name="(&string;)" bin_params_file="(ABEGO &string;)" bin="(&string;)"
        select_only_alpha_aas="(true &bool;)" />
```

-   **bin_params_file**: The filename of a bin_params file that defines a set of torsion bins. Current options include "ABEGO", "ABBA" (a symmetric version of the ABEGO nomenclature useful for mixed D/L design), and "PRO_DPRO" (which defines bins "LPRO" and "DPRO" corresponding to the regions of Ramachandran space accessible to L- and D-proline, respectively). Predefined bin_params files are in database/protocol_data/generalizedKIC/bin_params/. A custom-written bin_params file may also be provided with its relative path from the execution directory.
-   **bin**: The name of the mainchain torsion bin.
-   **select_only_alpha_aas**: If true, only alpha-amino acids are selected. If false, any polymeric type allowed by the bin definitions file is selected.

---
