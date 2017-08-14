Scans through an alignment and inserts gaps where the alignment positions in the alignment are not representative of the chemical environment of the pose sequence.

Reads available_AAs_file (generated with AlignmentAAFinderFilter) containing all amino acids that can fit into the pose sequence. Next iterates through all aligned sequences, threads them onto the pose sequence (ignoring insertions, substituting gaps with glycines) ask for each trusted* position: Is the chemical environment the same here as in the pose sequence? To determine if it is the same, the available amino acids are scored in both environments if the maximum scoring difference of any two available amino acids is >max_score_diffs, a gap is inserted for that position, for that aligned sequence.

*trusted position: Trust is build using two tests: (1) Are the indels surrounding (+/- 2 (indel_motif_radius)) the target amino acid the same in the aln sequence and the pose sequence? (2) If in a loop: Is the sequence identity high enough (list of seq id cutoffs) of the entire loop, and is the indels the same for the entire loop? 

<AlignmentGapInserterFilter name="(&string)" scorefxn="(beta_nov16 &string)" nbr_e_threshold="(0.1 &float)" loop_seqid_threshold="(0.50 &float)" indel_motif_radius="(2 &int)" alignment_file="(null &string)" available_AAs_file="(null &string)" cleaned_alignment_file="(null &string)" loop_seqid_thresholds="(comma separated list)" relax_mover_name="(null &string)" only_clean_seq_num="(null &int)" max_score_diffs="(comma separated list)"/>

-   filter: Used only for reporting the value for the pose in the tracer report


