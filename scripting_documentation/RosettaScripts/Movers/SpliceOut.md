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
        mover="(&string;)" restrict_to_repacking_chain2="(true &bool;)" >
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
-   **superimposed**: If false, superimpose source pdb onto current pose.
-   **source_pdb_to_res**: If structures are not aligned use the template from_res and source pdb from_res to align
-   **use_sequence_profile**: If true build PSSM and apply sequence profile on pose
-   **scorefxn**: Name of score function to use
-   **template_file**:  The PDB file of the reference PDB (the one used to build to conformation database)
-   **source_pdb**: The PDB file from which the segment conformation is extracted
-   **task_operations**: A comma separated list of TaskOperations to use.
-   **from_res**: The N-ter residue of the sampled segment
-   **to_res**: The C-ter residue of the sampled segment
-   **torsion_database**: Name of conformation file to save to
-   **design_shell**: Design shell radius around new segment conformation.
-   **repack_shell**: Repack shell radius around new segment conformation.
-   **rms_cutoff**: At the end of the run the RMSD value between the new segment conformation and source segment conformation. If RMSD value is above set cutoff value the run fails. This value only relates to secondary structure elements in the new segment. 
-   **rms_cutoff_loop**: The same as rms_cutoff, but only relates to loop secondary structure elements. 
-   **randomize_cut**:  if true cut will be placed randomly in the segment
-   **cut_secondarystruc**: if true cut can be placed in secondary structure element.
-   **thread_original_sequence**: If true,use sequence from source PDB 
-   **rtmin**:  apply rtmin after CCD/minmover
-   **splice_filter**: name of filter used to test of mover finished successfully.
-   **mover**: Which mover to use to close the segment
-   **restrict_to_repacking_chain2**: If true do not design chain2
-   **use_sequence_profiles**: XRW TO DO


Subtag **Segments**:   Wrapper for multiple segments tags

-   **current_segment**: Which segment are we currently changing


Subtag **Segment**:   individual segment tag

-   **pdb_profile_match**: map from pdb source segment to  PSSM file
-   **profiles**: path to PSSM files

---
##Example
Currently, this mover is only accessible via RosettaScripts. The new segment's conformation will be stored in  test.db file. The mover "min" is used to optimize the new backbone conformation in the context of the pose.

An example RosettaScripts tag is below:

```xml
			<SpliceOut name="spliceout" source_pdb="source.pdb" torsion_database="test.db" scorefxn="talaris14" randomize_cut="1" cut_secondarystruc="0" from_res="127" to_res="199" rms_cutoff="0.25" design_shell="0.01" repack_shell="0.01" splice_filter="chainbreak_val" template_file="template.pdb" task_operations="init,rtr" debug="0" mover="min" superimposed="1"> 
 <Segments current_segment="blade4"/>
</SpliceOut>


```