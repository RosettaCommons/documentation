<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
XRW TO DO

```xml
<IterativeLoophashLoopInserter name="(&string;)"
        loop_anchor="(&positive_integer;)" max_torsion_rms="(&real;)"
        min_torsion_rms="(&real;)" max_closure_deviation="(1 &real;)"
        loop_sizes="(&nnegative_int_cslist;)"
        max_lh_radius="(&non_negative_integer;)"
        modify_flanking_regions="(&bool;)"
        num_flanking_residues_to_match="(&non_negative_integer;)"
        max_insertions="(&real;)" />
```

-   **loop_anchor**: Loop anchor residue
-   **max_torsion_rms**: maximum rmsd of flanking regions
-   **min_torsion_rms**: min rmsd rmsd of flanking regions
-   **max_closure_deviation**: closure deviation
-   **loop_sizes**: Loop sizes, as a comma-separated list
-   **max_lh_radius**: Maximum loophash radius, an integer
-   **modify_flanking_regions**: Whether we are allowed to modify flanking regions
-   **num_flanking_residues_to_match**: If we are modifying flanking regions, then this many residues must match
-   **max_insertions**: Probably-integral description of how many insertions are appropriate over the course of simulation

---
