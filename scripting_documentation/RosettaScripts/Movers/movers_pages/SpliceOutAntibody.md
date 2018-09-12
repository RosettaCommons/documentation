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