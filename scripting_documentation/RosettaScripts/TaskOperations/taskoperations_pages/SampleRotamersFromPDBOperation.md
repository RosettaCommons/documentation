# SampleRotamersFromPDB
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## SampleRotamersFromPDB

Limit rotamer sampling to rotamers that are similar (+/- 5 deg. difference) to rotamers from either input PDBs or a rotamer database file (see [RotLibOut](https://www.rosettacommons.org/docs/latest/scripting_documentation/RosettaScripts/Movers/RotLibOut)). The PDB files are given through the "-packing::unboundrot" flag. For each residue in the input pose a vector of rotamers is constructed from all residues that are structurally aligned between the pose residue and all the input PDBs. Note that the taskoperation **__does not align__** the input PDBs and the pose, it only determines which residues are structurally aligned. The alignment should be done before using this TaskOperation. 

```xml
<SampleRotamersFromPDB name="(&string;)" add_rotamer="(1 &bool;)"
        debug="(0 &bool;)" ccd="(1 &bool;)" aligned_positions="(&int_cslist;)" >
    <Segments name="(&string;)" >
        <Segment name="(&string;)" pdb_profile_match="(&string;)" rot_lib="(&string;)" />
    </Segments>
</SampleRotamersFromPDB>
```
-   **add_rotamer**: If true, add the sampled rotamer to rotamer vector, otherwise just delete rotamers that are not in input pdbs/rotamer database
-   **debug**: make output more verbose
-   **ccd**: do not modify residues with CUT_LOWER/CUT_UPPER property
-   **aligned_positions**: only apply to this taskoperation to specific positions.

Subtag **Segments**:   Wrapper for multiple segments tags



Subtag **Segment**:   individual segment tag

-   **pdb_profile_match**: text file matching pdb name to profile
-   **rot_lib**: string mapping profile to rotamer database file

---
##Examples
### Example 1 - Using input pdbs to modify pose rotamers
```xml
<SampleRotamersFromPDB name="example1" add_rotamer="1" debug="0" ccd="0"/>
```
### Example 2 - Using Rotamer database files to modify the pose's rotamer vector
```xml
<SampleRotamersFromPDB name="example2" add_rotamer="1" debug="0" ccd="1">
  <Segments>
    <Segment name="frm1" pdb_profile_match="pdb_profile_match" rot_lib="2vc5B:2vc5B_frm1.dat,1hzyB:1hzyB_frm1.dat"/>
    <Segment name="frm2" pdb_profile_match="pdb_profile_match" rot_lib="2vc5B:2vc5B_frm2.dat,1hzyB:1hzyB_frm2.dat"/>
    <Segment name="frm3" pdb_profile_match="pdb_profile_match" rot_lib="2vc5B:2vc5B_frm3.dat,1hzyB:1hzyB_frm3.dat"/>
  </Segments>		
</SampleRotamersFromPDB>
```

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta