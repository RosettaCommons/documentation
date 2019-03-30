[[_TOC_]]

###Author
Gideon Lapidoth; glapidoth@gmail.com; PI: Sarel J. Fleishman; sarel@weizmann.ac.il

##Overview
###Brief 

This mover is similar to the SpliceIn mover, it is used to apply new torsion angles (phi, psi, and omega) from a precomputed database (see [SpliceOutTail](https://www.rosettacommons.org/docs/wiki/create/scripting_documentation/RosettaScripts/Movers/SpliceOutTail)) and apply them to a corresponding segment on the pose. While SpliceIn is used to extract the torsion angles of a segment placed between two residues, SpliceInTail is designed for segments that are at the N or C termini of the protein chain. The template PDB used to build the torsion database should be the same used with this mover. Additionally the template PDB and pose should structurally aligned. The template pdb is used for "bookkeeping": The number of "from res" (the residue at the beginning of the modified segment) is according to the template PDB. 

```xml
<SpliceInTail name="(&string;)" debug="(false &bool;)" min_seg="(false &bool;)"
        CG_const="(false &bool;)" chain_num="(1 &non_negative_integer;)" 
        superimposed="(true &bool;)" use_sequence_profile="(&bool;)"
        scorefxn="(&string;)" template_file="(&string;)" task_operations="(&task_operation_comma_separated_list;)"
        torsion_database="(&string;)" database_entry="(&non_negative_integer;)" database_pdb_entry="(&string;)"
        design_shell="(6.0 &real;)" repack_shell="(8.0 &real;)" 
        delta_lengths="(&int_cslist;)" thread_original_sequence="(false &bool;)"
        rtmin="(true &bool;)" dbase_iterate="(false &bool;)">
  
  <Segments name="(&string;)" profile_weight_away_from_interface="(1.0 &real;)"
            current_segment="(&string;)" >
        <segment name="(&string;)" pdb_profile_match="(&string;)" profiles="(&string;)" />
    </Segments>
</SpliceInTail>
```

-    **debug**: If true output is more verbose and PDB structures are dumped.
-   **min_seg**: Apply minimizer to the new segment. This is recommended to improve energy. Apply with coordinate constraints.
-    **CG_const**: If true apply coordinate constraint on C-gammas of the segment during CCD/minimization
-   **chain_num**: The pose's chain onto which the new segment is added.
-   **superimposed**: If fasle, superimpose source pdb onto current pose.
-   **use_sequence_profile**: If true build PSSM and apply sequence profile on pose
-   **scorefxn**: Name of score function to use
-   **template_file**: The PDB file of the reference PDB (the one used to build to conformation database)
-   **task_operations**: A comma separated list of TaskOperations to use.
-   **torsion_database**: Name of conformation file to saveto
-   **database_entry**: Which entry to use from database (by number, e.g. first entry = 1, second entry = 2, etc)
-   **database_pdb_entry**: Which entry to use from database by PDB code
-   **design_shell**: how many residues around the built segment can be designed
-   **repack_shell**: how many residues around the built segment can be repacked
-   **delta_lengths**: sample lengths of new segment conformation with length deltas relative to stratign pose segment (e.g, if delta length is set -2 then only segments that 2 AA shorter than the pose segment will be sampled from the database)
-   **thread_original_sequence**: Use sequence from torsion database. 
-   **rtmin**: apply rtmin after minmover/tailsegmentmover
-   **dbase_iterate**: if true, go through the torsion database iteratively (so in the same trajectory won't sample same conformation twice from the database). 


Subtag **Segments**:   Wrapper for multiple segments tags

-   **profile_weight_away_from_interface**: multiply applied sequence constraint by a factor for residues outside predefined interface
-   **current_segment**: Which segment is currently being modified 

##Example
Currently, this mover is only accessible via RosettaScripts. The new segment's conformation will be sampled from the test.db file. 

An example RosettaScripts tag is below:

```xml
			<SpliceInTail name="splice" torsion_database="test.db"  scorefxn="talaris_cal" repack_shell="1" design_shell="1" template_file="template.pdb" task_operations="init,thread" debug="1"  min_seg="1" delta_lengths="-2,-1,0,1,2" dbase_iterate="1" > rtmin=1 CG_const="1"
          <Segments current_segment="blade6"/>
	</SpliceInTail>


```