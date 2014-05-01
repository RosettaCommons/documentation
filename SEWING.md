The SEWING protocol is a method for the rapid generation of denovo backbones that uses large segments of natural protein structure.

##SewingHasher
The SewingHasher is the first step in the SEWING protocol. This step generates the input files used during later steps.

###Model Generation
First we need a generate a set of models. The only currently supported mechanism for model generation is through the use of a Features database. The following set ReportToDB tag contains the minimal set of features.

```
<ReportToDB name=features database_name=scores.db3>
    <feature name=ResidueFeatures />
    <feature name=PoseConformationFeatures />
    <feature name=ResidueConformationFeatures />
    <feature name=ProteinResidueConformationFeatures />
    <feature name=ResidueSecondaryStructureFeatures />
    <feature name=SecondaryStructureSegmentFeatures />
    <feature name=SmotifFeatures />
</ReportToDB>
```

SewingHasher model generation flags
```
-sewing:generate_models_from_db    Set to true for model generation
-inout:dbms:database_name          The SQL database file to generate models from
-sewing:model_file_name            The name of the model file to be generated
```

An example command line for generation of model files:
```
/path/to/rosetta/bin/SewingHasher.linuxgccrelease \
-generate-models_from_db \
-database_name pdb.db3 \
-model_file_name pdb.models
```

###Model comparison with geometric hashing
Once a Mode

SewingHasher hashing flags
```
-model_file_name    The name of the file to read models from
-score_file_name    The name of the score file to output (used in later stages of SEWING)

