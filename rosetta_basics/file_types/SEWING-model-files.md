#SEWING model files



Model files contain structural information about substructures to be used in [[SEWING]] protocols. They are required for all SEWING movers. 

Model files are generated using the [[SEWING Hasher application]] and can be filtered using the [[ModelTrimmer]] application.

##Sample
```
#Model file created on 2015-9-24
#This model file contains of models from parent file ./giant_unwieldy_file.models
#All models with a segment containing dssp code(s) H have been removed
#Any model with helical (H) segment(s) fewer than 0 residues or greater than 1000 residues have been removed
#Any model with strand (E) segment(s) fewer than 18 residues or greater than 1000 residues have been removed
#Any model with loop (L) segment(s) fewer than 0 residues or greater than 5 residues have been removed

VERSION 1530590163
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

##Explanation
* The top of the model file contains comments (printed by sewing_hasher or ModelTrimmer) indicating the date the file was generated and what input was used to generate it. 
* The VERSION line assigns a version number to each model file. This is used to ensure that SEWING edge files are only used with the SEWING model file from which they are generated. A model file and an edge file must have matching version numbers to be used together.
* Each MODEL line has the following elements:
  * model_id: An integer used to identify the model
  * structure_id: An integer used to identify the structure from which the model was taken
  * distance
  * hoist_angle
  * packing_angle
  * meridian_angle
  * pdb_code: The PDB file from which the model was taken
* Each SEGMENT line has the following elements:
  * segment ID: An integer used to identify the segment (unique within a model, but not between models)
  * Segment secondary structure (H, L, or E)
  * Should this segment be used for hashing? (1 or 0)
* Each RESIDUE line has the following elements:
  * Residue number (w/respect to the starting structure)
  * Residue type
  * Chi angles
* Each ATOM line has the following elements:
  * Element type (1, 2, 3, or 4). Only four backbone atoms (N, Calpha, C, and O) are stored.
  * x, y, and z coordinates

##See Also
* [[SEWING]]: The SEWING home page
* [[SEWING Hasher application]]
* [[ModelTrimmer]]
* [[SEWING Dictionary]]
