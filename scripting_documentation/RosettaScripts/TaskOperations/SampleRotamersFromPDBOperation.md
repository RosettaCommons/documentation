# SampleRotamersFromPDB
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## SampleRotamersFromPDB

Limit rotamer sampling to rotamers that are similar (+/- 5 deg. difference) to rotamers from input PDBs. The PDB files are given through the "-packing::unboundrot" flag. For each residue in the input pose a vector of rotamers is constructed from all residues that are structurally aligned between the pose residue and all the input PDBs. Note that the taskoperation **__does not align__** the input PDBs and the pose, it only determines which residues are structurally aligned. The alignment should be done before using the TaskOperation. 

    <SampleRotamersFromPDB name=(&string)/>


