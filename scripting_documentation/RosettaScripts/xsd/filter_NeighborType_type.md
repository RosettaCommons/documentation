<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Filter for poses that place a neighbour of the types specified around a target residue in the partner protein.

```xml
<NeighborType pdb_num="(&residue_number;)" res_num="(&non_negative_integer;)"
        distance="(8.0 &real;)" confidence="(1.0 &real;)" >
    <Neighbors type="(&string;)" />
</NeighborType>
```

-   **pdb_num**: Residue number in PDB numbering (residue number + chain ID)
-   **res_num**: Residue number in Rosetta numbering (sequentially with the first residue in the pose being 1
-   **distance**: XRW TO DO
-   **confidence**: Probability that this pose will be filtered out if the filter fails


Subtag **Neighbors**:   XRW TO DO

-   **type**: XRW TO DO

---
