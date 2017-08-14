#AlignmentAAFinderFilter

Documentation by Christoffer Norn (ch.norn@gmail.com).  Page created 14 August 2017.

*Back to [[Filters|Filters-RosettaScripts]] page.*

##AlignmentAAFinderFilter

This filter is typically combined with AlignmentGapInserter. It scans through all positions in the pose sequence, and tests whether amino acids present in homologous sequences (from alignment) would be able to fit into the pose sequence. It only tests amino acids in homologous sequences if we trust that their backbone is the same as in the pose structure. This trust is build on two tests: (1) Are the indels surrounding (+/- 2 (indel_motif_radius)) the target amino acid the same in the aln sequence and the pose sequence? (2) If in a loop: Is the sequence identity high enough (>0.5) of the entire loop, and is the indels the same for the entire loop?


## Options and Usage

```xml
< AlignmentAAFinder name="(&string)" 
    scorefxn="(beta_nov16 &string)" 
    exclude_AA_threshold="(10.0 &float)" 
    alignment_file="(null &string)" 
    loop_seqid_threshold="(0.50 &float)" 
    indel_motif_radius="(2 &int)" 
    available_AAs_file="(null &string)"
/>
```

**scorefxn** -- The scorefxn to be used during repacking.

**exclude_AA_threshold** -- The energy threshold used to decide whether or not a residue fits in the pose sequence

**alignment_file** -- Input alignment (fasta format).

**loop_seqid_threshold** -- Minimum sequence identity of loops from which available amino acids can be considered.

**indel_motif_radius** -- The indel motif radius.

**available_AAs_file** -- Output file name.

## See also

* [[AlignmentGapInserter|AlignmentGapInserterFilter]] filter.