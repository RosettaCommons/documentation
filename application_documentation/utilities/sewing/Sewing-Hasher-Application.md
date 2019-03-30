#Sewing Hasher Application
##Note: This page is for LegacySEWING.
**This is an outdated page. For information on the current version of sewing, please visit the [[Segment File Generation]] page. If performing hashed SEWING, visit the [[Structural Comparison of Substructures]] page. If you don't know what that means, start at the [[SEWING]] home page.**
##Purpose
This application is used to generate model files and edge files to be used in the [[SEWING]] protocol. It is also used to convert SEWING edge files to a more memory-efficient binary format.
##References
Science. 2016;352(6286):687-90
Design of structurally distinct proteins using strategies inspired by evolution.
Jacobs TM, Williams B, Williams T, Xu X, Eletsky A, Federizon JF, Szyperski T, Kuhlman B.
##Input
The input files required by the sewing_hasher application depend on the mode being used to run the application (see the Command line options section below for details). Possible required inputs include a database (created using the [[FeatureReporters]] framework) to be used when generating SEWING models; a list of PDBs to be used when generating SEWING models; a SEWING model file; a SEWING edge file; and/or a PDB file.
##Output
The sewing_hasher's output again varies depending on the mode being used. Possible outputs include a SEWING model file, a SEWING edge file (text), a SEWING alignment file, or a binary SEWING edge file.
##Command Line Options

###SEWING-specific options
```
-sewing:mode   Mode used to run the application. Options are:
               generate: Used to generate a model file
               generate_five_ss_model: Generate a model file with five segments per model (under development)
               hash:     Used to generate an edge file
               pregenerate_alignments: Used to generate an alignment file
               convert:  Convert an edge file from text to binary format
               test:     Prints the name of the edge file and exits
-sewing:model_file_name Name of output model file (for generate mode) or input model file (for all other modes)
-sewing:score_file_name Name of SEWING edge file to output (hash mode) or input (align/convert modes)
-sewing:min_hash_score  Minimum number of overlapping atoms per segment to generate an edge
-sewing:max_clash_score Maximum number of clashing atoms (in the same bin but not superimposed) per alignment
-sewing:num_segments_to_match How many segments to overlay to generate alignments (default 1)
-sewing:match_segments  Which segments of each substructure should be scored by the hasher? 
                        (ex: 1 3 to score helices in a helix-loop-helix motif)
-sewing:max_models      Maximum number of models to hash (for testing only)
-sewing:starting_model  Specify a specific model ID to begin hashing
-sewing:num_procs       Number of processors to split up hashing with (hash mode only)
```
###Structure Input Options
These options are required for certain sewing_hasher modes.

```
-in:file:l     In generate mode, can be used to provide a list of PDBs containing SEWING models.
               In align mode, can be used to list starting PDBs for which to generate alignment files
-inout:dbms:database_name  In generate mode, used to provide a Features database containing SEWING models
-in:file:s     In align mode, can be used to list a single starting PDB for which to generate an alignment file.

```



##Usage

For instructions on using the sewing_hasher application to prepare input files for SEWING, see the [[Model generation]] and [[Model comparison with geometric hashing]] pages. 
**Note: Only hash mode currently supports running on multiple processors**


##See Also
* [[Model Generation]] More information on LegacySEWING model generation
* [[Model comparison with geometric hashing]] More information on LegacySEWING score file generation
* [[ModelTrimmer]] Application used to prune models from SEWING model files (LegacySEWING)
* [[SEWING]] The SEWING home page
* [[SEWING Dictionary]]
* [[Utilities Applications]]




