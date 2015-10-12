##Dictionary
* AssemblyScore: ClashScore + InterModelMotifScore + InterfaceMotif (0 for monomer) + MotifScore

* atom: A collection of xyz coordinates and element

* cycle (during assembly of models): “cycle iteration” requires a monte carlo accept (not just a trial). For example, if the cycle # is set to 50,000, the actual number of trials of model assembly would be even much larger than "cycle #".

* InterModelMotifScore: A type of MotifScore, but it is calculated only between non-adjacent models. Without consideration of this 'InterModelMotifScore', the "best" assembled model would be just linear helices etc. With this 'InterModelMotifScore' in mind, the "best" assembled model would be more globular-like.

* linker segments: When there are 5 secondary structures in each model, 3 middle secondary structures are "linker segments". 2 N-terminal/C-terminal secondary structures are not "linker segments".

* model: A substructure that can be connected by their edges through their nodes. For example, a smotif model has 2 nodes (N-term/C-term) and 3 secondary structures. A collection of segments. Generally, 2-5 pieces of segment constitute the model. Currently for continuous SEWING, 3 pieces of secondary structures called smotif (like HLH, or HLE) is a model (5 pieces of secondary structures as a model for continuous SEWING are in active development). Defined as struct whose elements are model_id, pdb_code, structure_id, distance, hoist_angle, packing_angle and meridian_angle. 

* MotifScore: Designability score. Basically it shows that how well hydrophobic parts of secondary structures are well pack with each other. Will Sheffler in Baker lab made this.

* node: Single secondary structure. Not all nodes can be merged with other node through their edge. For example, a smotif model has 3 nodes (secondary structures), but only two of them (N-term/C-term) can be merged with other nodes. 5-ss based model has 5 nodes (secondary structures), but only two of them (N-term/C-term) can be merged with other nodes.

* PartnerMotifScore:  A type of MotifScore, but it will not be calculated in monomer design

* residue: composition (seq_pos, residue_type, chi angles)

* secondary structures: H, L, E

* segment: composition (segment_number, secondary_structure, linkage_Boolean_to_other_segment_for_model_build), original definition (A collection of secondary structures), practical definition (As of now just 1 secondary structure equals 1 segment)

* sewing_hasher: Four modes are possible
``` 
generate: generates a model file from an sqlite database
generate_five_ss_model: generates a model file that is consisted with 5 secondary structures from an sqlite database
hash: score all models against each other and create a plain text score file (MPI required)
convert: convert a plain text score file to a binary score file. This is required by the SEWING movers
```

* "score": edge information (has nothing to do with common rosetta fa/centroid score)
``` 
<example of score file>
1300 277 57 1299 277 57 56

<explanation of score file>
1300 and 1299 are model_ids (node ids)
277 is the first residue number of sharing (chimeric) segment between two models
57 is id of the sharing (chimeric) segment between two models
56 is id of the segment that just precedes the sharing (chimeric) segment between two models
```

Example of "model", "segment", "residue", "atom"
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