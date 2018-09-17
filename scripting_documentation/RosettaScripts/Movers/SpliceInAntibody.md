[[_TOC_]]

###Author
Gideon Lapidoth; glapidoth@gmail.com; PI: Sarel J. Fleishman; sarel@weizmann.ac.il

###References


1. Baran, Dror, M. Gabriele Pszolla, Gideon D. Lapidoth, Christoffer Norn, Orly Dym, Tamar Unger, Shira Albeck, Michael D. Tyka, and Sarel J. Fleishman. 2017. “Principles for Computational Design of Binding Antibodies.” Proceedings of the National Academy of Sciences of the United States of America 114 (41): 10900–905.
2. Lapidoth, Gideon D., Dror Baran, Gabriele M. Pszolla, Christoffer Norn, Assaf Alon, Michael D. Tyka, and Sarel J. Fleishman. 2015. “AbDesign: An Algorithm for Combinatorial Backbone Design Guided by Natural Conformations and Sequences.” Proteins 83 (8): 1385–1406.
3. Norn, Christoffer H., Gideon Lapidoth, and Sarel J. Fleishman. 2017. “High-Accuracy Modeling of Antibody Structures by a Search for Minimum-Energy Recombination of Backbone Fragments.” Proteins 85 (1): 30–38.


##Overview
###Brief 

This mover is the core mover of the "AbDesign"[1-2] and "AbPredict"[3] algorithms for designing and modeling antibodies' variable domain (Fv), comprised of a the variable light and heavy chains. Both methods use a combinatorial backbone optimization algorithm, which leverages the large number of sequences and experimentally determined molecular structures of antibodies to construct new antibody models, rather than attempting to construct backbone conformations from scratch. Briefly, all the experimentally determined antibody structures are downloaded from the Protein Data Bank (PDB) and segmented along structurally conserved positions: the disulfide cysteines at the core of the variable domain's light and heavy chains, creating 4 segments comprising of CDR's 1&2 and the intervening scaffold (VH and VL)  and CDR 3 (H3 and L3). These four segments are then recombined combinatorially to produce a highly conformationally diverse set of novel antibody models. The models are then energetically optimized using Monte-Carlo sampling. At each step a random segment conformation is sampled from a pre-computed database using the **SpliceInAntibody** mover. 
The database is generated using the [SpliceOutAntibody](https://www.rosettacommons.org/docs/wiki/scripting_documentation/RosettaScripts/Movers/movers_pages/SpliceOutAntibody) mover - for each segment (VL, L3, VH, and H3) of each of the natural antibodies we extract the backbone dihedral angles (phi, psi and omega) from the source antibody and apply them to the corresponding segment on the template antibody. The new segment's dihedral angles are recorded and stored in conformation database. 

```xml
<SpliceInAntibody name="(&string;)" tolerance="(0.23 &real;)"
        ignore_chain_break="(false &bool;)" debug="(false &bool;)"
        min_seg="(false &bool;)" CG_const="(false &bool;)"
        rb_sensitive="(false &bool;)" chain_num="(1 &non_negative_integer;)"
        segment="(&string;)" superimposed="(true &bool;)"
        delta_lengths="(&int_cslist;)" dbase_iterate="(false &bool;)"
        database_entry="(&non_negative_integer;)"
        database_pdb_entry="(&string;)" scorefxn="(&string;)"
        template_file="(&string;)" 
        task_operations="(&task_operation_comma_separated_list;)"
        torsion_database="(&string;)" design_shell="(6.0 &real;)"
        repack_shell="(8.0 &real;)" 
        rtmin="(true &bool;)" splice_filter="(&string;)" 
        restrict_to_repacking_chain2="(true &bool;)"
        use_sequence_profile="(true &bool;)" >
</SpliceInAntibody>
```

-   **tolerance**: XRW TO DO
-   **ignore_chain_break**: XRW TO DO
-   **debug**: XRW TO DO
-   **min_seg**: XRW TO DO
-   **CG_const**: XRW TO DO
-   **segment**: XRW TO DO
-   **delta_lengths**: XRW TO DO
-   **dbase_iterate**: XRW TO DO
-   **database_entry**: XRW TO DO
-   **database_pdb_entry**: XRW TO DO
-   **scorefxn**: Name of score function to use
-   **template_file**: XRW TO DO
-   **task_operations**: A comma separated list of TaskOperations to use.
-   **torsion_database**: XRW TO DO
-   **design_shell**: XRW TO DO
-   **repack_shell**: XRW TO DO
-   **rtmin**: XRW TO DO
-   **splice_filter**: XRW TO DO
-   **restrict_to_repacking_chain2**: XRW TO DO
-   **use_sequence_profile**: XRW TO DO

---

##Example
Currently, this mover is only accessible via RosettaScripts. The SpliceOutAntibody definition below will generate a new **L1_L2 conformation** and apply it to the pose antibody. The new segment's conformation will be stored in the <name>_L1_L2.db file. The CCD and tail movers need to be defined in the XML as well.


An example RosettaScripts tag is below:

```xml
	<SpliceOutAntibody name="spliceout" source_pdb="%%source%%" torsion_database="db/%%name%%_L1_L2.db" scorefxn="talaris_cal" rms_cutoff="0.3" rms_cutoff_loop="0.3" splice_filter="chainbreak_val" template_file="%%start_pdb%%" task_operations="init,seqprofcons" debug="0" mover="ccd" tail_mover="tail" segment="L1_L2" use_sequence_profile="1" superimposed="1" > 
		</SpliceOutAntibody>

```