#AlignmentGapInserterFilter

Documentation by Christoffer Norn (ch.norn@gmail.com).  Page created 14 August 2017.

*Back to [[Filters|Filters-RosettaScripts]] page.*

##AlignmentGapInserterFilter

Scans through an alignment and inserts gaps where positions in the alignment are not representative of the chemical environment of the pose sequence.

Reads available_AAs_file (generated with AlignmentAAFinderFilter) containing all amino acids that can fit into the pose sequence. Next iterates through all aligned sequences, threads them onto the pose sequence (ignoring insertions, substituting gaps with glycines) ask for each trusted* position: Is the chemical environment the same here as in the pose sequence? To determine if it is the same, the available amino acids are scored in both environments if the maximum scoring difference of any two available amino acids is >max_score_diffs, a gap is inserted for that position, for that aligned sequence.

*trusted position: Trust is build using three tests: (1) Are the indels surrounding (+/- 2 (indel_motif_radius)) the target amino acid the same in the aln sequence and the pose sequence? (2) If in a loop: Is the sequence identity high enough (list of seq id cutoffs) of the entire loop, and is the indels the same for the entire loop? (3) Do we trust that the neighboring residue are in the same positions for the aln sequences as in the pose sequence? (3a) For each neighbor: Are the indels surrounding (+/- 2 (indel_motif_radius)) the target amino acid the same in the aln sequence and the pose sequence? (3b) For each neighbor: If in a loop: Is the sequence identity high enough (list of seq id cutoffs) of the entire loop, and is the indels the same for the entire loop?

## Options and Usage

```xml
< AlignmentGapInserterFilter name="(&string)" 
    scorefxn="(beta_nov16 &string)" 
    nbr_e_threshold="(0.1 &float)" 
    indel_motif_radius="(2 &int)" 
    alignment_file="(null &string)" 
    available_AAs_file="(null &string)"
    cleaned_alignment_file="(null &string)"
    loop_seqid_threshold="(comma separated floats)" 
    max_score_diffs="(comma separated floats)"
    only_clean_seq_num="(null &int)"
/>
```

**scorefxn** -- The scorefxn to be used during repacking.

**nbr_e_threshold** -- The absolute(res-res-energy) used to define what is a neighboring residue.

**indel_motif_radius** -- The indel motif radius.

**alignment_file** -- The input alignment file.

**available_AAs_file** -- List of available amino acids for each position (this is typically generated with AlignmentAAFinderFilter).

**cleaned_alignment_file** -- Output alignment.

**loop_seqid_thresholds** -- Comma separated list of sequence ids used to decide trust.

**max_score_diffs** -- The maximum score difference that will not result in a gap-insertion.

**only_clean_seq_num** -- Clean only one of the aligned sequences. This is especially useful for large alignment, where one want to split it up and run embarrassing-parallel across multiple cores.

## See also

* [[AlignmentAAFinder|AlignmentAAFinderFilter]] filter.