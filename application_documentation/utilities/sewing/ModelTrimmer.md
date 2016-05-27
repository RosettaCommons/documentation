#ModelTrimmer
##Purpose
The ModelTrimmer application is used to filter models in an existing [[SEWING]] model file needs to trim models leaving only relavent models to speed up during 'model comparison' and 'assembly of models'.

###Command line options
```
-in:file:s                      The input PDB (ignored, but still required)
-sewing:model_file_name         The name of the input SEWING model file
-sewing:new_model_file_name     The name of the output trimmed model file
-sewing::remove_any_dssp        Remove any model that contain this DSSP (H,E,L) (Default "")
-sewing::min_helix_length       Remove any model that has less helical residues than this (Default 0)
-sewing::max_helix_length       Remove any model that has more helical residues than this (Default 1000)
-sewing::min_strand_length      Remove any model that has less strand residues than this (Default 0)
-sewing::max_strand_length      Remove any model that has more strand residues than this (Default 1000)
-sewing::min_loop_length        Remove any model that has less loop residues than this (Default 0)
-sewing::max_loop_length        Remove any model that has more loop residues than this (Default 1000)
-sewing::leave_models_with_E_terminal_ss Remove any model whose two terminal secondary structures are not beta-strands
-sewing::leave_parallel_way_H_bonded_models_by_terminal_strands_only (b-a-b)
-sewing::leave_antiparallel_way_H_bonded_models_by_terminal_strands_only (b-a-b)
-sewing::model_should_have_at_least_one_E Model should have at least one 'E' segment
-sewing::model_should_have_at_least_one_E_at_terminal_segment Model should have at least one 'E' segment at terminal segment
```
###Location
An example command line for ModelTrimmer:
```
/path/to/rosetta/main/source/bin/ModelTrimmer.default.linuxgccrelease @flags_ModelTrimmer
```

An example of flags_ModelTrimmer:
```
-s input_files/1_1_1TEN_A_res-renum.pdb #just for jd2
-mute basic.io core protocols.jd2

-sewing:model_file_name basic.models
-new_model_file_name basic_trimmed.models

-sewing::remove_any_dssp H
```