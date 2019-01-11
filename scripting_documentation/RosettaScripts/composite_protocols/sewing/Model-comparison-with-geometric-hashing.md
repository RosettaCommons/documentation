#Model comparison with geometric hashing
##Note: This page is for LegacySEWING.
**This is an outdated page. For information on the current version of sewing, please visit the [[Structural Comparison of Substructures]] page.

Once a Model file has been generated (see [[Model Generation]]), the models need to be structurally compared to one another using a geometric hashing algorithm implemented in the [[SEWING Hasher application]].

sewing_hasher hashing flags
```
-sewing:mode hash               Set the sewing mode to 'hash' for geometric hashing
-sewing:model_file_name         The name of the file to read models from
-sewing:score_file_name         The name of the score file to output (used in later stages of SEWING)
-sewing:num_segments_to_match   The exact of model segments to look for structural matches for. Any matches with less than, or more than, this number of segment matches will fail. For continuous SEWING, only a value of 1 is supported
-sewing:min_hash_score          The minimum number over overlapping atoms **per segment** that is considered a structure match (recommended value: >=10)
-sewing:max_clash_score         The tolerance for number of atoms/segment of different atom types that end up in the same quarter-angstrom bin during geometric hashing (recommended value: 0)
```

An example command line for comparison of model files:
```
/path/to/rosetta/bin/sewing_hasher.linuxgccrelease \
-sewing:mode hash \
-sewing:model_file_name pdb.models \
-sewing:score_file_name pdb.scores \
-sewing:num_segments_to_match 1 \
-sewing:min_hash_score 20 (default: 10) \ (here 20 atoms (N,CA,C,O) should be superimposed between two superimposing terminal secondary structures)
-sewing:max_clash_score 0
```

Due to the computational expense, it is recommended to run the above command using a large number of processors using MPI. The result will be one score plain-text file per MPI process (e.g. pdb.scores.0, pdb.scores.1, etc). For most production-size databases, the resultant score files will be very large. To increase speed during assembly, it is required that the entire set of plain-text score files be converted into a single, binary score file. To accomplish this conversion, first combine the plain text score files:
```
cat pdb.scores.* > pdb.scores
```

Then, use the sewing_hasher executable to convert this plain-text file to binary (see [[SEWING Hasher Application]]):
```
/path/to/rosetta/bin/sewing_hasher.linuxgccrelease \
-sewing:mode convert \
-sewing:model_file_name pdb.models \
-sewing:score_file_name pdb.scores
```

The final result should be a score file named pdb.scores.bin, this is the score file that will be used during the Assembly of SEWING backbones.

##See Also
* [[Model Generation]] for an additional use of the sewing_hasher application
* [[SEWING]]: The SEWING homepage
* [[SEWING Hasher Application]]
* [[ModelTrimmer]]: Used to prepare SEWING model files for hashing