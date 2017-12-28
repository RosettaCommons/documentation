#MergePDBMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MergePDBMover


##Author
TJ Brunette; tjbrunette@gmail.com; 

##Overview 

Combines two poses along a common secondary structure element and redesigns the sequence as appropriate
```xml
<MergePDB name="(&string)" task_operations="(&string)" scorefxn="(&string)" attachment_termini="[n_term|c_term]" overlap_length="(&int) overlap_rmsd="(&int)" attach_pdb="(&string) design_range="*(&int)" packing_range="(&int) overlap_scan_range_cmdLine_pose="(&int)" overlap_scan_range_cmdLine_xml_pose="(&int)" symm_file="(&string) no_design_label="(&string) init_overlap_sequence="[input_pose|xml_pose|both]"/>
```

Options:

* task_operations: The residues to pack and/or design.  By default, any residue 
  within packing_range will be repacked and any residue within design_range designed.  I

* scorefxn: The score function used for design and packing.  Required if not being used as 
  a subtag within some other LoopMover.

Caveats:

* The pose must start symmetric to use the symm_file option
* if no_design_label is defined you must use the (default)init_overlap_sequence="input_pose"(default)