#Sewing Hasher Application
##Purpose
This application is used to generate model files and edge files to be used in the [[SEWING]] protocol. It is also used to convert SEWING edge files to a more memory-efficient binary format.
##References
Science. 2016;352(6286):687-90
Design of structurally distinct proteins using strategies inspired by evolution.
Jacobs TM, Williams B, Williams T, Xu X, Eletsky A, Federizon JF, Szyperski T, Kuhlman B.
##Input
The input files required by the sewing_hasher application depend on the mode being used to run the application (see the Command line options section below for details). Possible required inputs include a database (created using the [[FeaturesReporters]] framework) to be used when generating SEWING models; a list of PDBs to be used when generating SEWING models; a SEWING model file; a SEWING edge file; and/or a PDB file.
##Output
The sewing_hasher's output again varies depending on the mode being used. Possible outputs include a SEWING model file, a SEWING edge file (text), a SEWING alignment file, or a binary SEWING edge file.
##Command Line Options
```
-sewing:mode   Mode used to run the application. Options are:
               generate: Used to generate a model file
               hash:     Used to generate an edge file
               pregenerate_alignments: Used to generate an alignment file
               convert:  Convert an edge file from text to binary format
-sewing:model_file_name Name of output model file (for generate mode) or input model file (for all other modes)
-in:file:l     In generate mode, can be used to provide a list of PDBs containing SEWING models
-inout:dbms:
-sewing:score_file_name
-sewing:min_hash_score
-sewing:max_clash_score



```






