<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Simple mover that uses loophash to replace randomly chosen fragments in a given pose.

```xml
<LoopHashDiversifier name="(&string;)"
        num_iterations="(100 &non_negative_integer;)"
        num_try_div="(100 &non_negative_integer;)"
        diversify_loop_only="(false &bool;)" min_inter_ss_bbrms="(0 &real;)"
        max_inter_ss_bbrms="(100000 &real;)" min_intra_ss_bbrms="(0 &real;)"
        max_intra_ss_bbrms="(100000 &real;)" min_rms="(0.0 &real;)"
        max_rms="(100.0 &real;)" max_radius="(4 &non_negative_integer;)"
        max_struct="(10 &non_negative_integer;)" ideal="(false &bool;)"
        filter_by_phipsi="(false &bool;)" start_pdb_num="(&residue_number;)"
        start_res_num="(&non_negative_integer;)"
        stop_pdb_num="(&residue_number;)"
        stop_res_num="(&non_negative_integer;)"
        window_size="(4 &non_negative_integer;)" scorefxn_cen_cst="(&string;)"
        scorefxn_rama_cst="(&string;)" db_path="(&string;)"
        centroid_filter="(true_filter &string;)" ranking_cenfilter="(&string;)" />
```

-   **num_iterations**: Number of loophash runs to execute
-   **num_try_div**: Number of loophash runs to try in each execution
-   **diversify_loop_only**: XRW TO DO
-   **min_inter_ss_bbrms**: Min torsion-angle rmsd for residue windows that span two pieces of secondary structure
-   **max_inter_ss_bbrms**: Max torsion-angle rmsd for residue windows that span two pieces of secondary structure
-   **min_intra_ss_bbrms**: Min torsion-angle rmsd for residue windows that are a single pieces of secondary structure
-   **max_intra_ss_bbrms**: Max torsion-angle rmsd for residue windows that are a single pieces of secondary structure
-   **min_rms**: Min Anstrom Rmsd cuttofs for loophash generated structures
-   **max_rms**: Max Anstrom Rmsd cuttofs for loophash generated structures
-   **max_radius**: max loophash radius
-   **max_struct**: Max models to create in loophash (number of fragment tried is 200x this)
-   **ideal**: Save space and assume structure is ideal?
-   **filter_by_phipsi**: Filter-out non-ideal phipsi.
-   **start_pdb_num**: Residue number in PDB numbering (residue number + chain ID)
-   **start_res_num**: Residue number in Rosetta numbering (sequentially with the first residue in the pose being 1
-   **stop_pdb_num**: Residue number in PDB numbering (residue number + chain ID)
-   **stop_res_num**: Residue number in Rosetta numbering (sequentially with the first residue in the pose being 1
-   **window_size**: loophash window size and loophash fragment size
-   **scorefxn_cen_cst**: Score function for constraint centroid mode sampling
-   **scorefxn_rama_cst**: XRW TO DO
-   **db_path**: path to DB -- if not specified then command-line flag is used
-   **centroid_filter**: Filter after centroid stage using this filter.
-   **ranking_cenfilter**: Prune decoys based on the filter's apply function.

---
