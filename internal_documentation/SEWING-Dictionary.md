##Dictionary
* atom: A collection of xyz coordinates and element

* linker segments: When there are 5 secondary structures in each model, 3 middle secondary structures are "linker segments". 2 N-terminal/C-terminal secondary structures are not "linker segments".

* model: A node that can be connected by edges. A collection of segments. Generally, 2-5 pieces of segment constitute the model. Currently for continuous SEWING, 3 pieces of secondary structures called smotif (like HLH, or HLE) is a model (5 pieces of secondary structures as a model for continuous SEWING are in active development). Defined as struct whose elements are model_id, pdb_code, structure_id, distance, hoist_angle, packing_angle and meridian_angle. 

* motif: Designability score. Basically it shows that how well hydrophobic parts of secondary structures are well pack with each other. Will Sheffler in Baker lab made this.

* residue: composition (seq_pos, residue_type, chi angles)

* secondary structures: H, L, E

* segment: composition (segment_number, secondary_structure, linkage_Boolean_to_other_segment_for_model_build), original definition (A collection of secondary structures), practical definition (As of now just 1 secondary structure equals 1 segment)

* SewingHasher: Four modes are possible
``` 
generate: generates a model file from an sqlite database
generate_five_ss_model: generates a model file that is consisted with 5 secondary structures from an sqlite database
hash: score all models against each other and create a plain text score file (MPI required)
convert: convert a plain text score file to a binary score file. This is required by the SEWING movers
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