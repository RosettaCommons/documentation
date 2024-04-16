#RBOutMover

[[_TOC_]]

###Author
Gideon Lapidoth; glapidoth@gmail.com; Christopher Norn; ch.norn@gmail.com ;PI: Sarel J. Fleishman; sarel@weizmann.ac.il

##Overview
###Brief 

This mover is used to build a database of jump coordinates between the variable light and variable heavy chains of antibodies. The jump coordinate database is then later used during antibody modeling ([ABpredict](https://www.ncbi.nlm.nih.gov/pubmed/27717001)) and antibody design ([ABdesign](https://onlinelibrary.wiley.com/doi/full/10.1002/prot.24779)) to sample different Vl/Vh orientaions. The template PDB should be the same PDB used to build the [[SpliceOutAntibody]] coordinate database. The input PDB (-s) is the one used to copy the jump coordinates from.

```xml
<RBOut name="(&string;)" template_fname="(&string;)" jump_dbase_fname="(&string;)" jump_from_foldtree="(false &bool;)" />
```


-   **template_fname**: The reference PDB file used to build the database
-   **jump_dbase_fname**: jump coordinate database file
-   **jump_from_foldtree**: If true get jump from fold tree and not automatically from the pose chain break (dflt)

---

##Example
Currently, this mover is only accessible via RosettaScripts. 
An example RosettaScripts tag is below:

```xml
<RBOut name="rbo" template_fname="template.pdb" jump_dbase_fname="test.db" jump_from_foldtree="0" />
```