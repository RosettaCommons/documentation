# RepeatPropagationMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RepeatPropagationMover

Propagates a protein X times

    <RepeatPropagationMover name="( &string)" numb_repeats="(&int)" first_template_res="(&int)" last_template_res="(&int)" ideal_repeat="(true &bool)" repeat_without_replacing_pose="false &bool) maintain_cap="(false &bool)" maintain_cap_sequence_only="(false &bool)" nTerm_cap_size="(&int)" cTerm_cap_size="(&int)" maintain_ligand="(true &bool)" extract_repeat_info_from_pose="(false &bool)" extract_repeat_template_repeat=(false &bool) start_pose_numb_repeats="(&int)" start_pose_length="(&int) start_pose_duplicate_residues="(&int)/>
 
-  numb_repeats : numb of repeats in output pose
Use case 1: You know where the pose starts & stops

Use case 2: One repeat in the original pose + some extra non repeating stuff
-  name
-  numb_repeats
-  extract_repeat_info_from_pose="true"
-  start_pose_numb_repeats="1"
-  ideal_repeat="false" #copies bond lengths in addition to phi/psi/omega
-  start_pose_duplicate_residues="19" #number of extra residue