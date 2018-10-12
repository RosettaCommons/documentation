# RepeatPropagationMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RepeatPropagationMover

Propagates a protein X times

    <RepeatPropagationMover name="( &string)" numb_repeats="(&int)" first_template_res="(&int)" last_template_res="(&int)" ideal_repeat="(true &bool)" repeat_without_replacing_pose="false &bool) maintain_cap="(false &bool)" maintain_cap_sequence_only="(false &bool)" nTerm_cap_size="(&int)" cTerm_cap_size="(&int)" maintain_ligand="(true &bool)" extract_repeat_info_from_pose="(false &bool)" extract_repeat_template_repeat=(false &bool) start_pose_numb_repeats="(&int)" start_pose_length="(&int) start_pose_duplicate_residues="(&int)/>

General options 
-  numb_repeats : numb of repeats in output pose
-  ideal_repeat="false" #copies bond lengths in addition to phi/psi/omega

Use case 1: extract all necessary info from the repeat itself
-  numb_repeats=length
-  extract_repeat_info_from_pose="true"
-  start_pose_numb_repeats="3"

Use case 2: You know where the pose starts/stops and has some cap sequence
-  first_template_res="51"
-  last_template_res="100"
-  maintain_cap_sequence_only="true"
-  numb_repeats="6"
-  nTerm_cap_size="50" #will maintain the sequence of these 50 residues
-  cTerm_cap_size="50" #will maintain the sequence of these 50 residues


Use case 3: One repeat in the original pose + some extra non repeating stuff
-  name
-  numb_repeats
-  extract_repeat_info_from_pose="true"
-  start_pose_numb_repeats="1"
-  ideal_repeat="false" #copies bond lengths in addition to phi/psi/omega
-  start_pose_duplicate_residues="19" #number of extra residue