#Strucutural Comparison of Substructures
Once a [[Segment File|segment-file-generation]] has been generated, the segments must then be compared to determine which substructures are structurally compatible. For Hashed SEWING this is done before generating an Assembly and uses a geometric hashing algorithm. This information is stored in an Edge File and (optionally) an Alignment File.

This step only needs to be done for a Hashed SEWING run. For a Hashless SEWING run (recommended for helical substructures), you can skip to the next step, [[Assembly Generation|AssemblyMover]].

##Edge File
An Edge File stores the segment ids of all structurally compatible segments within the provided segment file. An example Edge File is shown below:

```
There will be an edge file here
```

###Edge File Generator Application
####Command-Line Options
#####Required Flags
* ```-model_file_name``` : Path to the segment file, See [[Segment File Generation|segment-file-generation]]
* ```-edge_file_name``` : Path to save generated edge file

#####Optional Flags
* ```-max_clash_score``` : Maximum number of clashed atoms to allow during alignment
* ```-min_hash_score``` : The minimum number of aligned atoms to determine whether two segments are structurally compatible
* ```-boxes_per_dimension``` : The number of bins to consider in the geometric hash. 3 and 5 are the only acceptable values
* ```-hash_opposite_termini``` : Hashing will occur between segments with opposite termini (N to C or C to N )

####Example

```
./edge_file_generator.default.xxx -model_file_name smotifs_H_1_100_L_1_100_H_1_100.segments -edge_file_name smotifs_H_1_100_L_1_100_H_1_100.edges -boxes_per_dimension 3
```




##Alignment File
An Alignment File stores the specific residues that can be used to create an alignment with a provided segment.  Using an alignment file is completely optional, but may be useful in [[AppendAssembly|AppendAssemblyMover]] runs where the starting segment will be added to multiple times while generating the assembly. An example Alignment File is shown below:

```
There will be an alignment file here
```

An Alignment File can be generated via [[RosettaScripts]] using the [[AlignmentFileGeneratorMover]].



##See Also
* [[SEWING]] SEWING Home Page
* [[Segment File Generation]]
* [[AlignmentFileGeneratorMover]]
* [[AssemblyMover]]