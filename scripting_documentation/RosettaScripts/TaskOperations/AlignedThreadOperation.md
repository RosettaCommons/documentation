# AlignedThread
## AlignedThread

A task operation that enables threading of aligned residues between a query and a template. receives a FASTA format sequence alignment (file may hold multiple sequences), and allows the threading only of residues that are aligned between query and structure. positions where either the template structure or the query sequence have a gap '-' are skipped. suitable for when you wish to model a sequence over a structure, and they are of different lengths

```
<AlignedThread name=(&string) query_name=(&string) template_name=(&string) alignment_file=(&string) start_res=(&int 1)/>
```

- query_name: the name of the query sequence, as written in the alignment file
- template_name: the name of the template sequence, as written in the alignment file. the same sequence as that of the structure passed with -s.
- alignment_file: the name of the alignment file in FASTA format. should be in the usual ('>name_of_sequence' followed by the amino acid single letter sequence on the next line or lines) for this to work.
- start_res: the residue at which to start threading. useful for threading the non-first chain. 

