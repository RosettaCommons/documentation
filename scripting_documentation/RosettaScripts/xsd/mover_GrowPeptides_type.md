<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Extend a structure by adding new reidues to N or C terminual.

```xml
<GrowPeptides name="(&string;)" SeedFoldTree="(0 &bool;)" ddg_based="(0 &bool;)"
        extend_nterm="(0 &non_negative_integer;)"
        extend_cterm="(0 &non_negative_integer;)" all_ala_N="(0 &bool;)"
        all_ala_C="(0 &bool;)" nseq="(&string;)" cseq="(&string;)"
        output_centroid="(0 &bool;)" template_pdb="(&string;)"
        sequence="(&string;)" >
    <Steal_seq_span begin="(&string;)" end="(&string;)" />
    <Seeds begin="(&string;)" end="(&string;)" anchor="(0 &non_negative_integer;)" />
</GrowPeptides>
```

-   **SeedFoldTree**: Use SeedFoldTree to setup fold tree.If "false", the fold tree will be extracted from the input pose.
-   **ddg_based**: Comput jump atoms based on ddG
-   **extend_nterm**: Extend peptide N-terminally by n residues
-   **extend_cterm**: Extend peptide C-terminally by n residues
-   **all_ala_N**: N-terminally added amino acids are all ALA
-   **all_ala_C**: C-terminally added amino acids are all ALA
-   **nseq**: Not used.
-   **cseq**: Not used.
-   **output_centroid**: Ouput the structure in centroid representation.
-   **template_pdb**: Template pdb to take the sequence from. Required if sequence is nor specified.
-   **sequence**: Sequence for growing peptide. Required if template_pdb is not specified.


Subtag **Steal_seq_span**:   

-   **begin**: (REQUIRED) First residue of a fragment.
-   **end**: (REQUIRED) Last residue of a fragment.

Subtag **Seeds**:   

-   **begin**: (REQUIRED) First residue of a fragment.
-   **end**: (REQUIRED) Last residue of a fragment.
-   **anchor**: Use anchor residue for Seed.Specifies residue nr of anchor residue.

---
