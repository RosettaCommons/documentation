<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
XRW TO DO

```xml
<AtomCoordinateCstMover name="(&string;)" coord_dev="(0.5 &real;)"
        bounded="(false &bool;)" bound_width="(0 &real;)"
        sidechain="(false &bool;)" flip_hnq="(false &bool;)"
        native="(false &bool;)" func_groups="(&bool;)"
        task_operations="(&task_operation_comma_separated_list;)"
        packer_palette="(&named_packer_palette;)" />
```

-   **coord_dev**: the strength/deviation of the constraints to use
-   **bounded**: whether to use harmonic (false) or bounded (true) constraints
-   **bound_width**: the width of the bounded constraint (e.g. -relax::coord_cst_width)
-   **sidechain**: whether to constrain just the backbone heavy atoms (false) or all heavy atoms (true)
-   **flip_hnq**: XRW TO DO
-   **native**: if true, use the pose from -in:file:native as the reference instead of the pose at apply time
-   **func_groups**: f true, will apply coordinate constraints on the functional atoms of the constraints residues.
-   **task_operations**: A comma-separated list of TaskOperations to use.
-   **packer_palette**: A previously-defined PackerPalette to use, which specifies the set of residue types with which to design (to be pruned with TaskOperations).

---
