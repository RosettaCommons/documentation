#RBInMover

[[_TOC_]]

###Author
Gideon Lapidoth; glapidoth@gmail.com; Christopher Norn; ch.norn@gmail.com ;PI: Sarel J. Fleishman; sarel@weizmann.ac.il

##Overview
###Brief 

This mover is used to sample different variable light and variable heavy chains orientations for antibody modeling [ABpredict](https://www.ncbi.nlm.nih.gov/pubmed/27717001)) and antibody design ([ABdesign](https://onlinelibrary.wiley.com/doi/full/10.1002/prot.24779)). The database is created using the [[RBOutMover]].

```xml
<RBIn name="(&string;)" rigid_body_dbase="(&string;)"
        from_entry="(1 &non_negative_integer;)"
        to_entry="(1 &non_negative_integer;)" randomize="(true &bool;)"
        db_entry="(&string;)"
        modify_foldtree="(true &bool;)" />
```

-   **rigid_body_dbase**: path to database file with Vl/Vh orientations.
-   **from_entry**: limit range to sample database from 
-   **to_entry**: limit range to sample database from 
-   **randomize**: Randomly sample from database.
-   **db_entry**: Select specific entry to sample from
-   **modify_foldtree**: If true, set a new fold tree with jump between Vl/Vh

---


##Example
Currently, this mover is only accessible via RosettaScripts. 
An example RosettaScripts tag is below:

```xml
<RBIn name="rb" rigid_body_dbase="rb.db" db_entry="1AHW"/>
```