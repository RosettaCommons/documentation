<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
ConsensusLoopDesign restricts amino acid identities in loops based on the ABEGO torsion bins of the loop residues and the common sequence profiles from natives for loops with the same ABEGO bins.

```xml
<ConsensusLoopDesign name="(&string;)" use_dssp="(&string;)"
        secstruct="(&string;)" blueprint="(&string;)"
        residue_selector="(&string;)" include_adjacent_residues="(&bool;)"
        enrichment_threshold="(&string;)" />
```

-   **use_dssp**: If true, DSSP will be used to determine which residues are loops. If false, the secondary structure stored in the pose will be used to determine loops. Has no effect if the "secstruct" option is set.
-   **secstruct**: Allows the user to force a particular secondary structure onto the pose. If  set, use_dssp will be ignored. The length of the secondary structure must match the length of the pose.
-   **blueprint**: If a blueprint filename is given, the blueprint will be read and its secondary structure will be used to set the "secstruct" option.
-   **residue_selector**: By default, ConsensusLoopDesign works on all residues deemed "loops" by DSSP in the pose. If set, a residue selector is used to select regions of the protein in which to disallow residues. The selector can be used to choose one or two loops in the pose rather than all of them. Note that the residues flanking loop regions are also restricted according to the sequence profiles. By default, this task operation works on all loops in the pose.
-   **include_adjacent_residues**: If true, amino acids allowed at the non-loop positions joined by each loop will also be restricted via their frequencies in native structures. For example, some loops which follow helices strongly prefer proline as the last position in the helix.
-   **enrichment_threshold**: If the enrichment value of an amino acid at a particular position is below this number, it will be disallowed. 0.5 is more stringent than 0.0.

---
