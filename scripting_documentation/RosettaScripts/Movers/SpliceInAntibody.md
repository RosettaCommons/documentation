[[_TOC_]]

###Author
Gideon Lapidoth; glapidoth@gmail.com; PI: Sarel J. Fleishman; sarel@weizmann.ac.il

###References


1. Lapidoth, Gideon D., Dror Baran, Gabriele M. Pszolla, Christoffer Norn, Assaf Alon, Michael D. Tyka, and Sarel J. Fleishman. 2015. “AbDesign: An Algorithm for Combinatorial Backbone Design Guided by Natural Conformations and Sequences.” Proteins 83 (8): 1385–1406.
2. Baran, Dror, M. Gabriele Pszolla, Gideon D. Lapidoth, Christoffer Norn, Orly Dym, Tamar Unger, Shira Albeck, Michael D. Tyka, and Sarel J. Fleishman. 2017. “Principles for Computational Design of Binding Antibodies.” Proceedings of the National Academy of Sciences of the United States of America 114 (41): 10900–905.
3. Norn, Christoffer H., Gideon Lapidoth, and Sarel J. Fleishman. 2017. “High-Accuracy Modeling of Antibody Structures by a Search for Minimum-Energy Recombination of Backbone Fragments.” Proteins 85 (1): 30–38.


##Overview
###Brief 

This mover is the core mover of the "AbDesign"[1-2] and "AbPredict"[3] algorithms for designing and modeling antibodies' variable domain (Fv), comprised of the variable light and heavy chains. Both algorithms use a combinatorial backbone optimization, which leverages the large number of sequences and experimentally determined molecular structures of antibodies to construct new antibody models, rather than attempting to construct backbone conformations from scratch. Briefly, all the experimentally determined antibody structures are downloaded from the Protein Data Bank (PDB) and segmented along structurally conserved positions: the disulfide cysteines at the core of the variable domain's light and heavy chains, creating 4 segments comprising of CDR's 1&2 and the intervening scaffold (VH and VL)  and CDR 3 (H3 and L3). These four segments are then recombined combinatorially to produce a highly conformationally diverse set of novel antibody models. The models are then energetically optimized using Monte-Carlo sampling. At each step a random segment conformation is sampled from a pre-computed torsion database using the **SpliceInAntibody** mover. The mover applies the torsion angles from the database to the corresponding segment (e.g. VH,VL,L3 or H3). If the segment being replaced is shorter than the one being sampledת idealized residues are added to the pose's segment. 
The torsion database is generated using the [SpliceOutAntibody](https://www.rosettacommons.org/docs/wiki/scripting_documentation/RosettaScripts/Movers/movers_pages/SpliceOutAntibody) mover. 
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

-   **tolerance**: How many standard deviations is the bond length of the chain-break from the norm.
-   **ignore_chain_break**: If true, if chain-break is found do not fail trajectory. Used for debugging. 
-   **debug**: If true, make output more verbose and dump pdbs.
-   **min_seg**: Apply minimization on backbone and side-chains of the new segment conformation.
-   **segment**: Which segment type are we changing (L1_L2,H1_H2,L3, or H3)
-   **delta_lengths**: A list of integers separated by commas, specifying the length deltas between the current segment's lengths and those sampled from the database. E.g. if delta_length=-1,1 then only conformations that are longer or shorter by one residue compared to the original segment will be sampled.
-   **dbase_iterate**: Iterate through the conformation database. Used for antibody modeling. 
-   **database_entry**: Specify entry number of conformation to sample from conformation database.
-   **database_pdb_entry**:  Specify entry PDB code of conformation to sample from conformation database.
-   **scorefxn**: Name of score function to use
-   **template_file**: The pdb file used to construct the conformation database.
-   **task_operations**: A comma separated list of TaskOperations to use.
-   **torsion_database**: path to conformation database file. 
-   **design_shell**: design shell around sampled conformation.
-   **repack_shell**: repack shell around sampled conformation.
-   **rtmin**: bool. Perform rtmin on new segment?
-   **restrict_to_repacking_chain2**: bool. Apply design to non antibody chain?
-   **use_sequence_profile**: use sequence constraints from conformation specific pssms.

---

##Example
Currently, this mover is only accessible via RosettaScripts. The SpliceInAntibody definition below will apply a new **L1_L2 conformation** to the pose antibody. 


An example RosettaScripts tag is below:

```xml
	<SpliceInAntibody name="splice" torsion_database="L1_L2.db"  scorefxn="ref_15" repack_shell="8" design_shell="6" template_file="template.pdb" task_operations="init" debug="0"  min_seg="1" database_entry="5" segment="L1_L2"> 
		</SpliceInAntibody>



```