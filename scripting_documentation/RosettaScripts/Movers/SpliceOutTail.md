[[_TOC_]]

###Author
Gideon Lapidoth; glapidoth@gmail.com; PI: Sarel J. Fleishman; sarel@weizmann.ac.il

##Overview
###Brief 

This mover is similar to the SpliceOut mover, it is used to extract the phi, psi, and omega torsion angles from a reference PDB structure and store them in a torsion database. The torsion database is later used in design to modify the backbone conformation of a pose (see [SpliceInTail](https://www.rosettacommons.org/docs/wiki/create/scripting_documentation/RosettaScripts/Movers/SpliceInTail)). While SpliceOut is used to extract the torsion angles of a segment placed between two residues, SpliceOutTail is designed for segments that are at the N or C termini of the protein chain. The reference PDB, pose structure and template need to be aligned. The template pdb is used for "bookkeeping": The number of "from res" (the residue at the beginning of the modified segment) is according to the template PDB. The same template PDB should be used for the SpliceInTail mover. 

```xml
<SpliceOutTail name="(&string;)" debug="(false &bool;)"
        CG_const="(false &bool;)" 
        chain_num="(1 &non_negative_integer;)" 
        superimposed="(true &bool;)" tail_segment="(&n_or_c;)"
        use_sequence_profile="(&bool;)" scorefxn="(&string;)"
        template_file="(&string;)" 
        source_pdb="(&string;)"
        task_operations="(&task_operation_comma_separated_list;)"
        from_res="(0 &refpose_enabled_residue_number;)"
        torsion_database="(&string;)" design_shell="(6.0 &real;)"
        repack_shell="(8.0 &real;)" rms_cutoff="(999999 &real;)"
        thread_original_sequence="(false &bool;)"
        rtmin="(true &bool;)" splice_filter="(&string;)"
        mover="(&string;)" restrict_to_repacking_chain2="(true &bool;)"
        use_sequence_profiles="(true &bool;)" >
    <Segments name="(&string;)" current_segment="(&string;)" >
        <segment name="(&string;)" pdb_profile_match="(&string;)" profiles="(&string;)" />
    </Segments>
</SpliceOutTail>
```
-    **debug**: If true output is more verbose and PDB structures are dumped 
-    **CG_const**: If true apply coordinate constraint on C-gammas of the segment during CCD/minimization
-   **chain_num**: The pose's chain onto which the new segment is added.
-   **superimposed**: If fasle, superimpose source pdb onto current pose.
-   **tail_segment**: Is this a C-ter ("c") or and N-ter ("N") segment.
-   **scorefxn**: Name of score function to use
-   **template_file**: The PDB file of the reference PDB (the one used to build to conformation database)
-   **source_pdb**: The PDB file from which the segment conformation is extracted
-   **task_operations**: A comma separated list of TaskOperations to use.
-   **torsion_database**: Name of conformation file to saveto
-   **design_shell**: how many residues around the built segment can be designed
-   **repack_shell**: how many residues around the built segment can be repacked
-   **rms_cutoff**: The RMS cut-off between the new segment added to the pose and the segment in the source PDB. if the RMS is above a certain cut-off the mover reports failure. This parameter only refers to the secondary structure elements
-   **rtmin**: apply rtmin after minmover/tailsegmentmover
-   **splice_filter**: name of filter used to test of mover finished successfully. 
-   **mover**: Which mover to use to optimize segment's backbone (minmover/TailSegmentMover)
-   **restrict_to_repacking_chain2**: If true do not design chain2
-   **use_sequence_profile**: If true build PSSM and apply sequence profile on pose

Subtag **Segments**:   Wrapper for multiple segments tags

-   **profile_weight_away_from_interface**: multiply applied sequence constraint by a factor for residues outside predefined interface
-   **current_segment**: Which segment is currently being modified 

##Example
Currently, this mover is only accessible via RosettaScripts. The new segment's conformation will be stored in  test.db file. The mover "min" is used to optimize the new backbone conformation in the context of the pose.

An example RosettaScripts tag is below:

```xml
		<SpliceOutTail name="spliceout" source_pdb="1.pdb" torsion_database="test.db" scorefxn="talaris2014" tail_segment="c" from_res="100" rms_cutoff="100" design_shell="0.01" repack_shell="0.01" template_file="template.pdb" task_operations="init,rtr" debug="1" mover="min" superimposed="1"> 
      			<Segments current_segment="test"/>
		</SpliceOutTail>


```