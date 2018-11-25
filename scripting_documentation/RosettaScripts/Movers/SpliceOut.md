[[_TOC_]]

###Author
Gideon Lapidoth; glapidoth@gmail.com; PI: Sarel J. Fleishman; sarel@weizmann.ac.il

##Overview
###Brief 

This mover is used to extract the phi, psi, and omega torsion angles from a source PDB structure and store them in a torsion database. The torsion database is later used in design to modify the backbone conformation of a pose (see [SpliceIn](https://www.rosettacommons.org/docs/wiki/create/scripting_documentation/RosettaScripts/Movers/SpliceIn)). 
The segment to be changed is defined by two residues: "From_res" and "To_res". The numbering of those residues corresponds to the "Template PDB". The same template PDB should be used for the SpliceIn mover. 
 The source PDB, pose structure and template need to be aligned.

```xml
<SpliceOut name="(&string;)" tolerance="(0.23 &real;)"
        ignore_chain_break="(false &bool;)" debug="(false &bool;)"
        CG_const="(false &bool;)" chain_num="(1 &non_negative_integer;)"
        cut_site="(1 &non_negative_integer;)" superimposed="(true &bool;)" 
        source_pdb_to_res="(&refpose_enabled_residue_number;)"
        use_sequence_profile="(&bool;)" scorefxn="(&string;)"
        add_sequence_constraints_only="(false &bool;)"
        template_file="(&string;)" source_pdb="(&string;)"
        task_operations="(&task_operation_comma_separated_list;)"
        from_res="(0 &refpose_enabled_residue_number;)"
        to_res="(0 &refpose_enabled_residue_number;)"
        design_task_operations="(&string;)" 
        torsion_database="(&string;)" design_shell="(6.0 &real;)"
        repack_shell="(8.0 &real;)" rms_cutoff="(999999 &real;)"
        rms_cutoff_loop="(999999 &real;)"
        randomize_cut="(false &bool;)"
        cut_secondarystruc="(false &bool;)" thread_ala="(true &bool;)"
        design="(false &bool;)" thread_original_sequence="(false &bool;)"
        rtmin="(true &bool;)" checkpointing_file="(&string;)" splice_filter="(&string;)"
        mover="(&string;)" restrict_to_repacking_chain2="(true &bool;)"
        use_sequence_profiles="(true &bool;)" >
    <Segments name="(&string;)" current_segment="(&string;)" >
        <Segment name="(&string;)" pdb_profile_match="(&string;)" profiles="(&string;)" />
    </Segments>
</SpliceOut>
```

-   **tolerance**: Splice mover performs an internal check of peptide bond length in the new segment. If the bond length is more than the set tolerance the mover reports failure.
-   **ignore_chain_break**: If true, will ignore deviation in bond length. This is not recommended and usually used for debugging.
-   **debug**: If true output is more verbose and PDB structures are dumped
-   **CG_const**: If true apply coordinate constraint on C-gammas of the segment during CCD/minimization
-   **chain_num**: The pose's chain onto which the new segment is added.
-   **cut_site**: residue number of where to place cut
-   **Segment**: XRW TO DO
-   **superimposed**: XRW TO DO
-   **delete_hairpin**: XRW TO DO
-   **delete_hairpin_n**: XRW TO DO
-   **delete_hairpin_c**: XRW TO DO
-   **source_pdb_to_res**: XRW TO DO
-   **use_sequence_profile**: XRW TO DO
-   **scorefxn**: Name of score function to use
-   **add_sequence_constraints_only**: XRW TO DO
-   **template_file**: XRW TO DO
-   **set_fold_tree_only**: XRW TO DO
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
-   **locked_residue**: XRW TO DO
-   **checkpointing_file**: XRW TO DO
-   **splice_filter**: XRW TO DO
-   **mover**: Which mover to use to close the segment
-   **restrict_to_repacking_chain2**: XRW TO DO
-   **use_sequence_profiles**: XRW TO DO


Subtag **Segments**:   Wrapper for multiple segments tags

-   **current_segment**: XRW TO DO


Subtag **Segment**:   individual segment tag

-   **pdb_profile_match**: XRW TO DO
-   **profiles**: XRW TO DO

---
##Example
Currently, this mover is only accessible via RosettaScripts. The new segment's conformation will be stored in  test.db file. The mover "min" is used to optimize the new backbone conformation in the context of the pose.

An example RosettaScripts tag is below:

```xml
		<SpliceOutTail name="spliceout" source_pdb="1.pdb" torsion_database="test.db" scorefxn="talaris2014" tail_segment="c" from_res="100" rms_cutoff="100" design_shell="0.01" repack_shell="0.01" template_file="template.pdb" task_operations="init,rtr" debug="1" mover="min" superimposed="1"> 
      			<Segments current_segment="test"/>
		</SpliceOutTail>


```