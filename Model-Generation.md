##Model Generation
First we need to generate a set of models. The only currently supported mechanism for model generation is through the use of a [[Features database|FeaturesTutorials]]. The following set ReportToDB tag contains the minimal set of features.

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

SewingHasher model generation flags
```
-sewing:mode generate           Set to SewingHasher mode to 'generate' for model generation
-inout:dbms:database_name       The SQL database file to generate models from
-sewing:model_file_name         The name of the model file to be generated
```

An example command line for generation of model files:
```
/path/to/rosetta/bin/SewingHasher.linuxgccrelease \
-sewing:mode generate \
-database_name pdb.db3 \
-sewing:model_file_name pdb.models
```