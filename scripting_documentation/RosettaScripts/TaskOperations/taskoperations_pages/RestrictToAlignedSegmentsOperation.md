# RestrictToAlignedSegments
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## RestrictToAlignedSegments

(This is a devel TaskOperation and not available in released versions.)

Restricts design to segments that are aligned to the segments in source pdb files. The pdbs should have been pre-aligned. The start and stop residues must be at most 3A from a residue on the input pose, or else the alignment fails (the segment will not be aligned). The segments that are not aligned will be turned to restrict to repacking.

     <RestrictToAlignedSegments name="(&string)" source_pdb="(&string)" start_res="(&string)" stop_res="(&string)" repack_shell="(6.0 &real)">
    <Add source_pdb="(&string)" start_res="(&string)" stop_res="(&string)"/>
    .
    .
    .
    </RestrictToAlignedSegments>

-   source\_pdb: pdb file name to which to align. the start and stop res refer to it. As many lines as needed can be added, including from different pdb files. PDBs will only be loaded if they differ from the previous line's pdb file name, to save on reads from disk.
-   from\_res: start residue. Refers to source pdb. Rosetta/pdb numbering.
-   stop\_res: stop residue. ditto.
-   repack\_outside: residues not specified by the alignment will be allowed to repack if true, will be prevented from repacking if false.

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