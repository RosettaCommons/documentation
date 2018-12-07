[[_TOC_]]

###Author
Gideon Lapidoth; glapidoth@gmail.com; PI: Sarel J. Fleishman; sarel@weizmann.ac.il

##Overview
###Brief 

This mover is used to create a rotamer database based on structural alignment between the input pose and a list reference pdbs. The purpose for this is to constrain rotamer choices during design/modeling to those seen in natural proteins. Best use case scenario: designing a new protein within a defined protein fold family. 
The mover works by going through to the pose residues and finding a residue on the reference pdb that is closer than "min_dist". If the mover finds a residue on the reference pdb that is below the distance threshold the mover will continue to the next residue on the pose and reference pdb. If the next pair is also below the min_dist then the mover continues to the next pair and so on. In the there are N>="min_frag_len" consecutive pairs the segment on the reference pair is stored in the sequence alignment and the rotamers are saved in the rotamer database.



```xml
<RotLibOut name="(&string;)" min_frag_len="(&string;)"
min_dist="(3 &non_negative_integer;)" dump_pdb="(false &bool;)"
rotamer_db_filename="(&string;)"
sequence_alignment_filename="(&string;)" />
```

-   **min_frag_len**: Set minimum fragment length to use in alignmnet
-   **min_dist**: Minimum distance between aligned residues
-   **dump_pdb**: for debuging, whether to dump pdbs during run
-   **rotamer_db_filename**: Path to save rotamer db file
-   **sequence_alignment_filename**: file name to save sequence alignment between pose and input pdbs.

**To input list of reference pdbs files use this flags:**
`-unboundrot PDB.pdb, PDB1.pdb..`

---
##Example
Currently, this mover is only accessible via RosettaScripts. 
An example RosettaScripts tag is below:

```xml

<RotLibOut name="RLO" min_frag_len="3" min_dist="3" dump_pdb="0" rotamer_db_filename="rot.db"        sequence_alignment_filename="seq.f" />
```
