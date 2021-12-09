#MergePDBMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MergePDBMover


##Author
TJ Brunette; tjbrunette@gmail.com

##Overview 

Combines two poses along a common secondary structure element and redesigns the sequence as appropriate.

```xml
<MergePDB name="(&string;)" symm_file="(&string;)"
        attachment_termini="(n_term &attachment_termini_type;)"
        chain="(A &string;)" overlap_length="(4 &non_negative_integer;)"
        overlap_rmsd="(0.3 &real;)"
        overlap_scan_range_cmdLine_pose="(20 &non_negative_integer;)"
        overlap_scan_range_xml_pose="(20 &non_negative_integer;)"
        attach_pdb="(&string;)" design_range="(9 &real;)"
        packing_range="(8 &real;)" detect_disulf_before_pack="(true &bool;)"
        do_minimize="(true &bool;)" no_design_label="(&string;)"
        duplicate_rmsd_pose_threshold="(1.0 &real;)"
        init_overlap_sequence="[input_pose|xml_pose|both]"
        scorefxn="(&string;)" output_only_first="(false &bool;)"
        output_overlap_positions="(false &bool;)" do_design="(true &bool;)"
        clash_threshold="(10 &real;)"
        task_operations="(&task_operation_comma_separated_list;)"
        packer_palette="(&named_packer_palette;)" />
```

Options:

* **task_operations:** By default, any residue within packing_range will be repacked and any residue within design_range designed.

* **scorefxn:** The score function used for design and packing.  Required if not being used as 
  a subtag within some other LoopMover.

* **attachment_termini:** [n_term or c_term] do you want the xml_pose attached to the n_term or c_term of the input_pose (-in:file:s pose)

* **attach_pdb:** pdb to attach

* **overlap_length:** Number of residues that overlap

* **overlap_rmsd:** cutoff for what is considered an overlap

* **design_range:** distance in ang from the overlap that is being designed

* **packing_range:** distance from the designed residues that is allowed to pack

* **overlap_scan_range_cmdLine_pose:** how many residues on the -in:file pdb that are checked for overlap

* **overlap_scan_range_xml_pose:** how many residue on the attach_pdb are checked for overlap

* **symm_file:** if using symmetry(input pose symmetric) must rebuild symmetry after overlap. Give a path to the symmetry definition

* **no_design_label:** Use the add_residue_label to define parts you don't want designed

* **init_overlap_sequence:[input_pose|xml_pose|both]:** which pose do you want initialize the overlap rotamers

* **duplicate_rmsd_pose_threshold:** rmsd for eliminating duplicate poses. For speed does not work >1.0

* **chain:** Which chain to operate on. Defaults to 'A'.

* **do_design**: Perform sequence design (default:true)

* **do_minimize**: Perform energy minimization (default:true)

**Notes:**

* PDBInfoLabels are added to the output pose:

**overlap** - residues that are superimposed from input_pose and xml_pose

**other_overlap** - residues that were detected around the design_range that were designed

**other_overlap_sym** - residues that were detected by symmetry that were designed

**Caveats:**

* The pose must start symmetric to use the symm_file option.
* if no_design_label is defined you must use the (default)init_overlap_sequence="input_pose"(default)