#Legacy SEWING Dictionary
* **AssemblyScore**: The score function used when generating and filtering SEWING assemblies. Calculated as ClashScore + 10*InterModelMotifScore + InterfaceMotifScore (0 for monomer) + MotifScore

* **ClashScore**

* **cycle**: During assembly, a cycle is only counted in the case of a Monte Carlo accept (not just a trial). For example, if the number of cycles is set to 50,000, the actual number of Monte Carlo trials would be even larger.

* **edge file**: See **score file**

* **InterfaceMotifScore**:  A type of MotifScore used (typically by the AppendAssemblyMover) to score how well the designed protein packs against a provided partner PDB.

* **InterModelMotifScore**: A type of MotifScore, but it is calculated only between non-adjacent models. This is intended to promote the formation of more globular proteins. Without considering the InterModelMotifScore, a planar sheet of helices containing only native interactions scores very favorably.

* **linker segments**: Segments that are not scored by the Hasher and are not overlaid with other segments. For example, a helix-loop-helix substructure contains one linker segment (the loop). When there are 5 secondary structure elements in each model, the 3 middle secondary structures are "linker segments".

* **model** (node/substructure): This can be connected by their edges through their nodes. For example, a smotif model has 2 nodes (N-term/C-term) and 3 secondary structures. A collection of segments. Generally, 2-5 pieces of segment constitute the model. Currently for continuous SEWING, 3 pieces of secondary structure (like HLH, or HLE) constitute a model (5 pieces of secondary structures as a model for continuous SEWING are in active development). 

* **model file**: Text file containing the models/substructures that will be used in SEWING assembly. See [[SEWING model files]] for format.

* **ModelTrimmer**: Application used to filter SEWING models by secondary structure type and segment length. See the [[ModelTrimmer]] page for details.

* **MotifScore**: Designability score. Basically it shows that how well hydrophobic parts of secondary structures are well packed with each other. Will Sheffler in the Baker lab made this.

* **node**: The term "node" in SEWING can refer to two things:
  - Sometimes, a model/substructure is referred to as a "node". This is technically a misnomer, as a model is actually a cluster of connected nodes.
  - Actual nodes in the SewGraph are **segments** consisting of a single secondary structure element. Not all nodes can be merged with other node through their edge. For example, a smotif model has 3 nodes (secondary structures), but only two of them (N-term/C-term) can be merged with other nodes. 5-ss based model has 5 nodes (secondary structures), but only two of them (N-term/C-term) can be merged with other nodes.

* **score file** (edge file): Current name for files containing edge information (has nothing to do with common rosetta fa/centroid scores)
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

* **secondary structure**: Helix, loop, or beta strand (H, L, E)

* **segment**: A single secondary structure element. Segments are identified by their model ID and segment ID (both integers) and store information about their secondary structure and whether we can build off of them. 

* **sewing_hasher**: Application used to generate SEWING input files. See the [[SEWING Hasher application]] page for details.

* **substructure**: See **model**

##See Also
* [[SEWING homepage|SEWING]]
* [[Glossary]]