#SEWING Dictionary
* **AssemblyScore**: The score function used when generating and filtering SEWING assemblies. Calculated as ClashScore + 10*InterModelMotifScore + InterfaceMotifScore (0 for monomer) + MotifScore

* **atom**: In a SEWING model file, a collection of xyz coordinates and element

* **ClashScore**

* **cycle**: During assembly, a cycle is only counted in the case of a Monte Carlo accept (not just a trial). For example, if the number of cycles is set to 50,000, the actual number of Monte Carlo trials would be even larger.

* **InterfaceMotifScore**:  A type of MotifScore used (typically by the AppendAssemblyMover) to score how well the designed protein packs against a provided partner PDB.

* **InterModelMotifScore**: A type of MotifScore, but it is calculated only between non-adjacent models. This is intended to promote the formation of more globular proteins. Without considering the InterModelMotifScore, a planar sheet of helices containing only native interactions scores very favorably.

* **linker segments**: Segments that are not scored by the Hasher and are not overlaid with other segments. For example, a helix-loop-helix substructure contains one linker segment (the loop). When there are 5 secondary structure elements in each model, the 3 middle secondary structures are "linker segments".

* **model** (node/substructure): This can be connected by their edges through their nodes. For example, a smotif model has 2 nodes (N-term/C-term) and 3 secondary structures. A collection of segments. Generally, 2-5 pieces of segment constitute the model. Currently for continuous SEWING, 3 pieces of secondary structures called smotif (like HLH, or HLE) is a model (5 pieces of secondary structures as a model for continuous SEWING are in active development). Defined as struct whose elements are model_id, pdb_code, structure_id, distance, hoist_angle, packing_angle and meridian_angle. 

* **model file**: Text file containing the models/substructures that will be used in SEWING assembly.
Example model file:
```
MODEL 80 6 11.9294 130.065 159.192 -27.0884 /Users/tjacobs2/PROJECTS/datasets/top8000/top8000_chains_70//1a2zFH_C.pdb
SEGMENT 7 E 1
RESIDUE 35 0 ALA -1
ATOM 1 17.602 46.603 -24.591
ATOM 2 16.364 46.555 -23.862
ATOM 3 15.398 47.642 -24.323
ATOM 4 15.74 48.774 -24.711
RESIDUE 36 0 MET 176.763 56.221 51.5357
ATOM 1 14.138 47.299 -24.189
ATOM 2 13.007 48.172 -24.336
...
```

* **ModelTrimmer**: Application used to filter SEWING models by secondary structure type and segment length.
* **MotifScore**: Designability score. Basically it shows that how well hydrophobic parts of secondary structures are well packed with each other. Will Sheffler in the Baker lab made this.

* **node**: The term "node" in SEWING can refer to two things:
  - Sometimes, a model/substructure is referred to as a "node". This is technically a misnomer, as a model is actually a cluster of connected nodes.
  - Actual nodes in the SewGraph are **segments** consisting of a single secondary structure element. Not all nodes can be merged with other node through their edge. For example, a smotif model has 3 nodes (secondary structures), but only two of them (N-term/C-term) can be merged with other nodes. 5-ss based model has 5 nodes (secondary structures), but only two of them (N-term/C-term) can be merged with other nodes.



* **residue**: In the model file, indicates the sequence position in the original PDB, the residue type, and the chi angles for a particular residue.

* **secondary structure**: Helix, loop, or beta strand (H, L, E)

* **segment**: A single secondary structure element. Segments are identified by their model ID and segment ID (both integers) and store information about their secondary structure and whether we can build off of them. 
In the model file, the SEGMENT field lists the segment ID, the DSSP of the segment, and whether to hash the segment.

* **sewing_hasher**: Application used to generate SEWING input files. See the [[SEWING Hasher application]] page for details.

* **score file**: Current name for files containing edge information (has nothing to do with common rosetta fa/centroid scores)
``` 
<example of score file>
4 94 17 3 43 9 29
4 67 13 3 67 13 32
...

<explanation of score file, line 1>
4 and 3 are model_ids (node ids).
94 and 43 are the basis residue numbers of sharing (chimeric) segment between two models (of course, this resnum may happen to be same between two combining models).
17 and 9 are ids of the sharing (chimeric) segment between two models (of course, this 'segment id' may happen to be same between two combining models).
29 is the average_segment_score (= sum/segment_matches.size())
```


##See Also
* [[SEWING homepage|SEWING]]
* [[Glossary]]