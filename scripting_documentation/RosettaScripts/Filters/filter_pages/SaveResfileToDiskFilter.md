# SaveResfileToDisk
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SaveResfileToDisk

Saves a resfile to the output directory that specifies the amino acid present at each position defined by a set of input task operations. Outputs "PIKAA X", where X is the current amino acid in the pose at that position.

```xml
<SaveResfileToDisk name="(&string)" task_operations="(comma-delimited list of task operations)" designable_only="(0 &bool)" resfile_prefix="(&string)" resfile_suffix="(&string)" resfile_name="(&string)" resfile_general_property="(NATAA &string)" selected_resis_property="(&string)" renumber_pdb="(0 &bool)" />
```

-   task\_operations - Used to define which residues are output to the resfile.
-   designable\_only - If true, only designable positions are output, otherwise all repackable positions are output.
-   resfile\_prefix - A prefix that will be appended to each output resfile.
-   resfile\_suffix - A suffix that will be appended to each output resfile.
-   resfile\_name - A name for the output resfile, that will go between the prefix and suffix, if specified. If resfile\_name is not specified, will get the current job name from the job distributor and use that.
-   resfile\_general\_property - What general property should go at the top of the output resfile.
-   selected\_resis\_property - What property to use for the selected residues (defaults to "PIKAA X", where X is the current amino acid in the pose.
-   renumber\_pdb - If true, use the numbering of residues corresponding to what would be output with the flag -out:file:renumber\_pdb. Otherwise use the current PDB numbering. (If you've already renumbered the residues, there should be no difference.)

## See also

* [[TaskOperations-RosettaScripts]]
* [[Protein-protein docking|docking-protocol]]
