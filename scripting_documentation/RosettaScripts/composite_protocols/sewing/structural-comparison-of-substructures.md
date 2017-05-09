#Strucutural Comparison of Substructures
Once a [[Segment File|segment-file-generation]] has been generated, the segments must then be compared to determine which substructures are structurally compatible. For Hashed SEWING this is done before generating an Assembly and uses a geometric hashing algorithm. This information is stored in an Edge File and (optionally) an Alignment File.

This step only needs to be done for a Hashed SEWING run. For a Hashless SEWING run (recommended for helical substructures), you can skip to the next step, [[Assembly Generation|AssemblyMover]].

##Edge File
An Edge File stores the segment ids of all structurally compatible segments within the provided segment file. An example Edge File is shown below:

```
There will be an edge file here
```

###Edge File Generator Application


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