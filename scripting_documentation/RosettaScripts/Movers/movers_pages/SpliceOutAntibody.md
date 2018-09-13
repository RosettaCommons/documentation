[[_TOC_]]

###Author
Gideon Lapidoth; glapidoth@gmail.com; PI: Sarel J. Fleishman; sarel@weizmann.ac.il

###References


1. Baran, Dror, M. Gabriele Pszolla, Gideon D. Lapidoth, Christoffer Norn, Orly Dym, Tamar Unger, Shira Albeck, Michael D. Tyka, and Sarel J. Fleishman. 2017. “Principles for Computational Design of Binding Antibodies.” Proceedings of the National Academy of Sciences of the United States of America 114 (41): 10900–905.
2. Lapidoth, Gideon D., Dror Baran, Gabriele M. Pszolla, Christoffer Norn, Assaf Alon, Michael D. Tyka, and Sarel J. Fleishman. 2015. “AbDesign: An Algorithm for Combinatorial Backbone Design Guided by Natural Conformations and Sequences.” Proteins 83 (8): 1385–1406.
3. Norn, Christoffer H., Gideon Lapidoth, and Sarel J. Fleishman. 2017. “High-Accuracy Modeling of Antibody Structures by a Search for Minimum-Energy Recombination of Backbone Fragments.” Proteins 85 (1): 30–38.


##Overview
###Brief 

This mover is the core mover of the "AbDesign"[1-2] and "AbPredict"[3] algorithms for designing and modeling antibodies' variable domain (Fv), comprised of a the variable light and heavy chains. Both methods use a combinatorial backbone optimization algorithm, which leverages the large number of sequences and experimentally determined molecular structures of antibodies to construct new antibody models, rather than attempting to construct backbone conformations from scratch. Briefly, all the experimentally determined antibody structures are downloaded from the Protein Data Bank (PDB) and segmented along structurally conserved positions: the disulfide cysteines at the core of the variable domain's light and heavy chains, creating 4 segments comprising of CDR's 1&2 and the intervening scaffold (VH and VL)  and CDR 3 (H3 and L3). These four segments are then recombined combinatorially to produce a highly conformationally diverse set of novel antibody models. The models are then energetically optimized using Monte-Carlo sampling. At each step a random segment conformation is sampled from a pre-computed database. 
The **SpliceOutAntibody** mover is used to create the conformation database. The conformation database is specific to a template antibody. Any PDB structure can be used as the template antibody, which serves as starting point or frame of reference onto which the different antibody backbones conformation are sampled onto. 
For each segment (VL, L3, VH, and H3) of each of the natural antibodies we extract the backbone dihedral angles (phi, psi and omega) from the source antibody and replace the segment in the template with the source segment’s dihedral angles, introducing a main-chain cut site in a randomly chosen position in the inserted segment. Where the inserted segment is longer than the template antibody segment, residues are added to the model using idealized bond lengths and angles. We then refine the main chain using either cyclic-coordinate descent (CCD) mover on minmover.

```xml
<SpliceOutAntibody name="(&string;)" tolerance="(0.23 &real;)"
        ignore_chain_break="(false &bool;)" debug="(false &bool;)"
        CG_const="(false &bool;)" rb_sensitive="(false &bool;)"
        chain_num="(1 &non_negative_integer;)"
        cut_site="(1 &non_negative_integer;)" segment="(&string;)"
        superimposed="(true &bool;)" delete_hairpin="(false &bool;)"
        delete_hairpin_n="(4 &non_negative_integer;)"
        delete_hairpin_c="(13 &non_negative_integer;)" scorefxn="(&string;)"
        add_sequence_constraints_only="(false &bool;)"
        template_file="(&string;)" source_pdb="(&string;)"
        task_operations="(&task_operation_comma_separated_list;)"
        from_res="(0 &refpose_enabled_residue_number;)"
        to_res="(0 &refpose_enabled_residue_number;)"
        design_task_operations="(&string;)" residue_numbers_setter="(&string;)"
        torsion_database="(&string;)" design_shell="(6.0 &real;)"
        repack_shell="(8.0 &real;)" rms_cutoff="(999999 &real;)"
        rms_cutoff_loop="(999999 &real;)"
        res_move="(1000 &non_negative_integer;)" randomize_cut="(false &bool;)"
        cut_secondarystruc="(false &bool;)" thread_ala="(true &bool;)"
        design="(false &bool;)" thread_original_sequence="(false &bool;)"
        rtmin="(true &bool;)" allow_all_aa="(false &bool;)"
        locked_residue="(&string;)" checkpointing_file="(&string;)"
        splice_filter="(&string;)" mover="(&string;)" tail_mover="(&string;)"
        restrict_to_repacking_chain2="(true &bool;)"
        use_sequence_profile="(true &bool;)" >
    <Segments name="(&string;)" current_segment="(&string;)" >
        <segment name="(&string;)" pdb_profile_match="(&string;)" profiles="(&string;)" />
    </Segments>
</SpliceOutAntibody>
```

-    **tolerance**: Splice mover preforms an internal check of peptide bond length in the new segment. If the bond length is more than the set tolerance the mover reports failure 
-    **ignore_chain_break**: If true, will ignore deviation in bond length. This is not recommended and usually used for debugging. 
-    **debug**: If true output is more verbose and PDB structures are dumped 
-    **CG_const**: If true apply coordinate constraint on C-gammas of the segment during CCD/minimization
-    **rb_sensitive**: if true, align the current pose to the template pdb
-   **chain_num**: The pose's chain onto which the new segment is added.
-   **cut_site**: residue number of where to place cut, used mainly for debugging.
-   **segment**: which segment are are changing (VL, VH, L3, H3)
-   **superimposed**: superimpose source pdb onto current pose.
-   **delete_hairpin**: 
-   **delete_hairpin_n**: XRW TO DO
-   **delete_hairpin_c**: XRW TO DO
-   **scorefxn**: Name of score function to use
-   **add_sequence_constraints_only**: XRW TO DO
-   **template_file**: XRW TO DO
-   **source_pdb**: XRW TO DO
-   **task_operations**: A comma separated list of TaskOperations to use.
-   **from_res**: XRW TO DO
-   **to_res**: XRW TO DO
-   **design_task_operations**: XRW TO DO
-   **residue_numbers_setter**: XRW TO DO
-   **torsion_database**: XRW TO DO
-   **design_shell**: XRW TO DO
-   **repack_shell**: XRW TO DO
-   **rms_cutoff**: XRW TO DO
-   **rms_cutoff_loop**: XRW TO DO
-   **res_move**: XRW TO DO
-   **randomize_cut**: XRW TO DO
-   **cut_secondarystruc**: XRW TO DO
-   **thread_ala**: XRW TO DO
-   **design**: XRW TO DO
-   **thread_original_sequence**: XRW TO DO
-   **rtmin**: XRW TO DO
-   **allow_all_aa**: XRW TO DO
-   **locked_residue**: XRW TO DO
-   **checkpointing_file**: XRW TO DO
-   **splice_filter**: XRW TO DO
-   **mover**: Which mover to use to close the segment
-   **tail_mover**: Which mover to use to close the segment
-   **restrict_to_repacking_chain2**: XRW TO DO
-   **use_sequence_profile**: XRW TO DO