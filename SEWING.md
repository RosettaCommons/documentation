The SEWING protocol is a method for the rapid generation of denovo backbones that uses large segments of natural protein structure.

##Basic concepts
SEWING stands for **S**tructure **E**xtension **WI**th **N**ative-fragment **G**raphs. SEWING functions by identifying relatively large sub-structures, called models (2-5 pieces of secondary structure) from native PDBs, and then assembling these models based on structural similarity. SEWING can be broken down into three basic steps:

1. [[Model Generation|SEWING#Model-Generation]] - Extraction of 'models' from native structures
2. [[Model comparison|SEWING#Model-comparison-with-geometric-hashing]] - Structurally compare models to one another using a geometric hashing algorithm
3. [[Assembly|SEWING#Assembly-of-models]] - Stitch models together based on structural superimposition to form novel backbones

##Model Generation
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
-sewing:model_file_name pdb.models
```

##Model comparison with geometric hashing
Once a Model file has been generated, the models need to be structurally compared to one another using a geometric hashing algorithm implemented in the SewingHasher.

SewingHasher hashing flags
```
-sewing:mode hash    Set the sewing mode to 'hash' for geometric hashing
-sewing:model_file_name    The name of the file to read models from
-sewing:score_file_name    The name of the score file to output (used in later stages of SEWING)
-sewing:num_segments_to_match    The exact of model segments to look for structural matches for. Any matches with less than, or more than, this number of segment matches will fail. For continuous SEWING, only a value of 1 is supported
-sewing:min_hash_score    The minimum number over overlapping atoms **per segment** that is considered a structure match
-sewing:max_clash_score    The tolerance for number of atoms/segment of different atom types that end up in the same bin (default: 0)
```

An example command line for comparison of model files:
```
/path/to/rosetta/bin/SewingHasher.linuxgccrelease \
-sewing:mode hash \
-sewing:model_file_name pdb.models \
-sewing:score_file_name pdb.scores \
-sewing:num_segments_to_match 1 \
-sewing:min_hash_score 20 \
-sewing:max_clash_score 0
```

Due to the computational expense of is recommended to run the above command using a large number of processors using MPI. The result will be one score plain-text file per MPI process (e.g. pdb.scores.0, pdb.scores.1, etc). For most production-size databases, the resultant score files will be very large. To increase speed during assembly it is required that the entire set of plain-text score files be converted into a single, binary score file. To accomplish this conversion, first combine the plain text score files:
```
cat pdb.scores.* > pdb.scores
```

Then, use the SewingHasher executable to convert this plain-text file to binary:
```
/path/to/rosetta/bin/SewingHasher.linuxgccrelease \
-sewing:mode convert \
-sewing:model_file_name pdb.models \
-sewing:score_file_name pdb.scores
```

The final result should be a score file named pdb.scores.bin, this is the score file that will be used during the Assembly of SEWING backbones.

##Assembly of models

Assembly of backbones is accomplished by a Mover, and thus can be accessed via the [[RosettaScripts]] interface. There are currently several Movers implemented, each designed to accomplish different design goals. A brief outline of each is below.

###Flags common to all SEWING movers

###RandomAssemblyMover

###MotifDirectedAssemblyMover

###SewingAppendMover

###RepeatAssemblyMover

###NodeConstraintAssemblyMover 
