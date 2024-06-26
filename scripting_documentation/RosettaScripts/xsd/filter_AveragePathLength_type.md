<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Computes the average shortest path length on the 'network' of the single-chain protein topology, considering residues as nodes and peptide and disulfide bonds as edges.

```xml
<AveragePathLength name="(&string;)" path_tightness="(1 &real;)"
        max_path_length="(99999 &real;)" confidence="(1.0 &real;)" />
```

-   **path_tightness**: Tightness of path length threshold; lower values are more stringent
-   **max_path_length**: The absolute maximum, protein-size-independent, to pass the filter for path length.
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
