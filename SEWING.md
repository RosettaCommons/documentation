The SEWING protocol is a method for the rapid generation of denovo backbones that uses large segments of natural protein structure.

##SewingHasher
The SewingHasher is the first step in the SEWING protocol. This step generates the input files used during later steps.

###Model Generation
First we need a generate a set of models. The only currently supported mechanism for model generation is through the use of a [[Features database|FeaturesTutorials]]. The following set ReportToDB tag contains the minimal set of features.

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
-sewing:mode generate    Set to SewingHasher mode to 'generate' for model generation
-inout:dbms:database_name          The SQL database file to generate models from
-sewing:model_file_name            The name of the model file to be generated
```

An example command line for generation of model files:
```
/path/to/rosetta/bin/SewingHasher.linuxgccrelease \
-sewing:mode generate \
-database_name pdb.db3 \
-model_file_name pdb.models
```

###Model comparison with geometric hashing
Once a Model file has been generated, the models need to be structurally compared to one another using a geometric hashing algorithm implemented in the SewingHasher.

SewingHasher hashing flags
```
-sewing:mode hash    Set the sewing mode to 'hash' for geometric hashing
-sewing:model_file_name    The name of the file to read models from
-sewing:score_file_name    The name of the score file to output (used in later stages of SEWING)
-sewing:num_segments_to_match    The exact of model segments to look for structural matches for. Any matches with less than, or more than, this number of segment matches will fail 
-sewing:min_hash_score    The minimum number over overlapping atoms **per segment** that is considered a structure match
-sewing:max_clash_score    The tolerance for number of atoms/segment of different atom types that end up in the same bin (default: 0)
```
