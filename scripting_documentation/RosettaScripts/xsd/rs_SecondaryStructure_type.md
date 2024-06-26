<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
SecondaryStructureSelector selects all residues with given secondary structure. For example, you might use it to select all loop residues in a pose. SecondaryStructureSelector uses the following rules to determine the pose secondary structure: 1. If pose_secstruct is specified, it is used. 2. If use_dssp is true, DSSP is used on the input pose to determine its secondary structure. 3. If use_dssp is false, the secondary structure stored in the pose is used.

```xml
<SecondaryStructure name="(&string;)" overlap="(0 &non_negative_integer;)"
        minH="(1 &non_negative_integer;)" minE="(1 &non_negative_integer;)"
        include_terminal_loops="(false &bool;)" use_dssp="(true &bool;)"
        pose_secstruct="(&string;)" ss="(&string;)" />
```

-   **overlap**: If specified, the ranges of residues with matching secondary structure are expanded by this many residues. Each selected range of residues will not be expanded past chain endings. For example, a pose with secondary structure LHHHHHHHLLLEEEEELLEEEEEL, ss='E', and overlap 0 would select the two strand residue ranges EEEEE and EEEEE. With overlap 2, the selected residues would also include up to two residues before and after the strands (LLEEEEELLEEEEEL).
-   **minH**: Defines the minimal number of consecutive residues with helix assignation to be considered an helix. Smaller assignation patches are understood as loops.
-   **minE**: Defines the minimal number of consecutive residues with beta assignation to be considered a beta. Smaller assignation patches are understood as loops.
-   **include_terminal_loops**: If false, one-residue "loop" regions at the termini of chains will be ignored. If true, all residues will be considered for selection.
-   **use_dssp**: f true, dssp will be used to determine the pose secondary structure every time the SecondaryStructure residue selector is applied. If false, and a secondary structure is set in the pose, the secondary structure in the pose will be used without re-computing DSSP. This option has no effect if pose_secstruct is set.
-   **pose_secstruct**: If set, the given secondary structure string will be used instead of the pose secondary structure or DSSP. The given secondary structure must match the length of the pose.
-   **ss**: (REQUIRED) The secondary structure types to be selected. This parameter is required. Valid secondary structure characters are 'E', 'H' and 'L'. To select loops, for example, use ss="L", and to select both helices and sheets, use ss="HE"

---
