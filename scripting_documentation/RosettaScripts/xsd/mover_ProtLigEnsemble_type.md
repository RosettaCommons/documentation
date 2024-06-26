<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
High resolution docking of a cross ensemble of protein and ligands

References and author information for the ProtLigEnsemble mover:

ProtLigEnsemble Mover's citation(s):
Fu DY, and Meiler J.  (2018).  RosettaLigandEnsemble: A Small-Molecule Ensemble-Driven Docking Approach.  ACS Omega 3(4):3655-64.  doi: 10.1021/acsomega.7b02059.

```xml
<ProtLigEnsemble name="(&string;)" scorefxn="(&string;)" qsar_file="(&string;)"
        final_score="(&string;)" distance="(&real;)"
        ignore_correlation="(&non_negative_integer;)"
        ignore_correlation_fter="(&non_negative_integer;)"
        cycles="(&non_negative_integer;)"
        repack_every_Nth="(&non_negative_integer;)" />
```

-   **scorefxn**: (REQUIRED) Score function to be used during docking
-   **qsar_file**: (REQUIRED) File containing protein mutations and ligand piars
-   **final_score**: (REQUIRED) Score function to be used during minimizing
-   **distance**: Distance around ligand to repack
-   **ignore_correlation**: Ignore correlation weight for first few ligands
-   **ignore_correlation_fter**: Ignore correlation weight for at the end
-   **cycles**: Number of cycles to run.
-   **repack_every_Nth**: Perform side chain repacking every Nth cycle.

---
