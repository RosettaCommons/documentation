##Model Generation
First we need to generate a set of models. The only currently supported mechanism for model generation is through the use of a [[Features database|FeaturesTutorials]]. 

----------------------

###Feature Database Building
The following set ReportToDB tag contains the minimal set of features.

```xml
<MOVERS>
<ReportToDB name=features database_name=scores.db3>
    <feature name=ResidueFeatures />
    <feature name=PoseConformationFeatures />
    <feature name=ResidueConformationFeatures />
    <feature name=ProteinResidueConformationFeatures />
    <feature name=ResidueSecondaryStructureFeatures />
    <feature name=SecondaryStructureSegmentFeatures />
    <feature name=SmotifFeatures />
</ReportToDB>
</MOVERS>
```

An example command line for generation of 'Features database' that will be used to generate model files:
```
/path/to/rosetta/bin/rosetta_scripts.default.linuxgccrelease \
-protocol features.xml \
-dbms:database_name pdb.db3 
```

----------------------

###Actual Model Generation
After building features database, let's generate real models from this DB.

SewingHasher model generation flags
```
-sewing:mode generate           Set to SewingHasher mode to 'generate' for model generation
-inout:dbms:database_name       The SQL database file to generate models from
-sewing:model_file_name         The name of the model file to be generated
```

An example command line for generation of model files:
```
/path/to/rosetta/bin/SewingHasher.linuxgccrelease \
-sewing:mode generate # it will generate three secondary structures (smotif)' models \
-sewing:mode generate_five_ss_model # it will generate five secondary structures' models \
-database_name pdb.db3 \
-sewing:model_file_name pdb.models
```


----------------------

###ModelTrimmer

Unless the target backbone to design is random, ModelTrimmer needs to trim models leaving only relavent models to speed up during 'model comparison' and 'assembly of models'.

###Possible flags for ModelTrimmer
```
-s                              The input PDB (ignored, but still required, for many SEWING Movers)
-sewing:model_file_name         The name of the file to read models from
-new_model_file_name            The name of the trimmed model file
-sewing::remove_any_dssp        Remove any model that contain this DSSP (H,E,L)
-sewing::min_helix_length       Remove any model that has less number of helix residues than this
-sewing::max_helix_length       Remove any model that has more number of helix residues than this
-sewing::min_strand_length      Remove any model that has less number of strand residues than this
-sewing::max_strand_length      Remove any model that has more number of strand residues than this
-sewing::min_loop_length        Remove any model that has less number of loop residues than this
-sewing::max_loop_length        Remove any model that has more number of loop residues than this
-sewing::leave_models_with_E_terminal_ss Remove any model whose two terminal secondary structures are not beta-strands
-sewing::leave_H_bonded_models_by_terminal_strands Remove any model that is not H-bonded by their terminal beta-strands
-sewing::model_should_have_at_least_one_E model_should_have_at_least_one_E segment
```

An example command line for ModelTrimmer:
```
/path/to/rosetta/bin/ModelTrimmer.default.linuxgccrelease @flags_ModelTrimmer
```

An example of flags_ModelTrimmer:
```
-s input_files/1_1_1TEN_A_res-renum.pdb #just for jd2
-mute -mute basic.io core.chemical core.conformation core.io core.pack core.scoring protocols.jd2

-sewing:model_file_name basic.models
-new_model_file_name basic_trimmed.models

-sewing::remove_any_dssp H
```