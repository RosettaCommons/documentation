<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Sample mainchain torsions for peptides in a grid, saving good conformations

References and author information for the BackboneGridSampler mover:

BackboneGridSampler Mover's author(s):
Vikram K. Mulligan, Systems Biology, Center for Computational Biology, Flatiron Institute [vmulligan@flatironinstitute.org]

```xml
<BackboneGridSampler name="(&string;)" scorefxn="(&string;)"
        max_samples="(10000 &non_negative_integer;)"
        selection_type="(&BackboneGridSampler_lohigh;)"
        pre_scoring_mover="(&string;)" pre_scoring_filter="(&string;)"
        dump_pdbs="(false &bool;)" pdb_prefix="(&string;)"
        nstruct_mode="(false &bool;)"
        nstruct_repeats="(1 &non_negative_integer;)"
        residues_per_repeat="(1 &non_negative_integer;)"
        residue_count="(12 &non_negative_integer;)"
        repeat_count="(12 &non_negative_integer;)" residue_name="(ALA &string;)"
        residue_name_1="(ALA &string;)" residue_name_2="(ALA &string;)"
        residue_name_3="(ALA &string;)" residue_name_4="(ALA &string;)"
        cap_ends="(false &bool;)" >
    <MainchainTorsion index="(&non_negative_integer;)"
            res_index="(1 &non_negative_integer;)" value="(0 &real;)"
            start="(-180.0 &real;)" end="(-180.0 &real;)"
            samples="(2 &non_negative_integer;)" />
</BackboneGridSampler>
```

-   **scorefxn**: (REQUIRED) Scorefunction to employ
-   **max_samples**: Maximum number of total backbone combinations to be sampled.
-   **selection_type**: Score criterion for selection: "high" or "low".
-   **pre_scoring_mover**: A mover to apply after backbone torsions are set but before final scoring and evaluation (like a min mover or something similar).
-   **pre_scoring_filter**: A filter to apply before scoring, which could help avoid wasteful scoring of bad conformations (like a bump check filter).
-   **dump_pdbs**: Dump all PDBs, if true; otherwise, there will be no PDB output at all.
-   **pdb_prefix**: A prefix to apply to all output PDBs.
-   **nstruct_mode**: If true, sample a different set of mainchain torsions for each job; if false, each job consists of the whole mainchain sampling effort.
-   **nstruct_repeats**: Number of repeats to perform for each nstruct.
-   **residues_per_repeat**: Number of residues in the minimal repeating unit of this secondary structure.
-   **residue_count**: Number of residues in the secondary structure exemplar to be sampled.
-   **repeat_count**: Number of residue-repeats in the secondary structure exemplar to be sampled.
-   **residue_name**: Residue type of which to create the secondary structure, indicated by three-letter code.
-   **residue_name_1**: Residue type of which to create the secondary structure, indicated by three-letter code.
-   **residue_name_2**: Residue type of which to create the secondary structure, indicated by three-letter code.
-   **residue_name_3**: Residue type of which to create the secondary structure, indicated by three-letter code.
-   **residue_name_4**: Residue type of which to create the secondary structure, indicated by three-letter code.
-   **cap_ends**: If true, adds acetylated and amidated N- and C- termini.


Subtag **MainchainTorsion**:   Tags describing individual torsions in the helix

-   **index**: (REQUIRED) Mainchain torsion index indicated
-   **res_index**: Residue whose mainchain torsion is being specified (if there is more than one residue per repeat)
-   **value**: A single value in degrees, if this torsion ought to be fixed
-   **start**: Starting value of a torsion range in degrees
-   **end**: Ending value of a torsion range in degrees
-   **samples**: Number of samples to be taken of the dihedral range indicated

---
