<!--- BEGIN_INTERNAL -->
Documentation created by Brahm Yachnin (brahm.yachnin@rutgers.edu), Khare laboratory, and Chris Bailey-Kellogg (cbk@cs.dartmouth.edu).
Last edited November 6, 2018.

[[_TOC_]]

## Purpose

The `mhc_energy_tools` are companion Python scripts for use with the [[MHCEpitopeEnergy]] [[design-centric guidance scoreterm|design-guidance-terms]].  In brief, the `mhc_score.py` script is used to analyze existing protein sequences, PDB files, or lists of peptides to identify immunogenic hotspot sequences.  The `mhc_gen_db.py` script is used to generate a SQL database based from a FASTA or PDB file, with various methods of indicating designable residues and their identities.  These databases can then be used to score poses while packing with a `mhc_energy` term and the `MHCEpitopePredictorExternal` predictor (see [[MHCEpitopeEnergy]] for more details).

## mhc_score.py

### Input sequences

`mhc_score.py` can take various types of input for scoring.

- A sequence can be provided as a positional argument on the command line.  For example, `mhc_score.py ILVEQACFPSL`.
- `--fa mysequence.fas` names a file in FASTA-ish format with a **SINGLE** sequence to be used as input.  The `>` title line is optional.
- `--fsa sequences.fas` names a file in FASTA-ish format with **MULTIPLE** sequences to be used as input.  The `>` title line is mandatory for each sequence.
- `--pdb myprotein.pdb` names a PDB file, from which the sequence will be pulled and used as input.
 - `--chain X` specifies which chain of the PDB file to look at.  If not specified, the entire PDB file will be scored.
- `--pep peptides.txt` names a file with one sequence per line.  Each line will be used as an input sequence.
- If no input is given, the user can type individual sequences into the terminal.  Each sequence will be scored before the next sequence is input.

Additional notes:
- Only uses one source for sequences, checking in order: command-line, specified input file, stdin
- Sequences can include '_' characters, treated as noncanonicals, which in the current implementation forces the containing peptides to be non-epitopes
- The "fasta-ish" header can end in "@pos" to start residue numbering there; default 1
- Pretty rudimentary handling of PDB files, padding missing residues with '_' (i.e., no epitopes) and generally dealing only with the standard twenty 3-letter AA codes
- In all cases, if the sequence is shorter than the epitope peptide length for that predictor (9 for Propred, 15 for NetMHCII), a score of 0 will be returned.

### Predictors

The Predictors determine how to score the sequences.

- `--propred` uses the Propred matrices to score the sequences.  This is the default behaviour.  It will look first in the current directory, then in the Rosetta database.  It will attempt to look for the Rosetta database first using relative paths, assuming `tools` and `main` are cloned in the same directory.  If that fails, if the environment variable `$ROSETTA` exists, it will assume `main` is cloned within that directory and will look for the database there.
- `--matrix MATRIX` uses the `MATRIX` file to score the sequences.
- `--netmhcii` uses the netmhcII executable, pointed to by the environment variable `$NMHOME`, to score the sequences.
- `--db DB` uses a pre-computed database, as generated using `mhc_gen_db.py`, to score the sequences.

### Scoring Details

- `--allele_set SET` tells the Predictor to use `SET` as the set of alleles.
 - With Propred, only `all` or `test` are allowed.  If using `test`, only the DRB1_0101 allele will be used.  The default (`--allele_set all`) is to use all alleles specified in the matrix.
 - With NetMHCII, there are four options: `test` will score only the DRB1_0101 allele, and `greenbaum11` (27 alleles) and `paul15` (7 alleles) will use published lists of alleles.  `all` will use all 61 available alleles.  `test` is the default.  More alleles takes longer (not a huge issue with a single protein sequence), but may be more accurate.
- `--alleles ALLELE_LIST` allows you to provide a custom list of alleles to use.  Not used by default.
- `--epi_thresh EPI_THRESH` sets the threshold of what constitutes a "hit."  By default, this is 5.00, which means that the top 5% of binders are considered hits.
- `--noncanon {error,warn,silent}` allows you to specify the behaviour if a residue other than the 20 canonical AAs is encountered (for example, ligands, non-canonical amino acids, etc.).  Options are `error` (script will exit), `warn` (a warning will be printed), or `silent`.  HOW ARE NCAAS DEALT WITH HERE?  AS CHAIN BREAKS?  WHAT IS THE DEFAULT BEHAVIOUR?
- `--netmhcii_score {rank,absolute}` specifies whether to use the ranked score (i.e. is this in the top X% of binders) or absolute score (i.e. the affinity of binding) to determine if something is a hit.  This will have an impact on the `--epi_thresh` parameter.  By default, `rank` is used.
- `--db_unseen {error,warn,score}` specifies, in a database predictor, what to do if a peptide that is absent from the database is encountered.  Options are `error` (script will exit), `warn` (a warning will be printed, and a score of 0 will be assigned to that peptide), or `score` (the peptide will be scored using `--db_unseen_score`).  `warn` is the default.  IS THIS AN ACCURATE DESCRIPTION OF THE BEHAVIOUR?
 - `--db_unseen_score SCORE` specifies the penalty to apply if we encounter an "unseen" peptide and we are using `--db_unseen score`.  A penalty of 100 is the default.

### Output

The scoring results can be output in various ways.  In any case where a filename is specified, using the `$` character will substitute the sequence name in cases where multiple sequences are being scored.

- `--report {total,hits,full}` specifies what kind of report to output to standard output.  `total` will provide the total score for each sequence.  `hits` will provide a report by allele for each peptide that is identified as a hit (i.e. score > 0).  `full` will provide a report by allele for all peptides in the sequence.  Default is `total`.
 - `--report_file FILE` will output the report generated by `--report` to a file in CSV format.  If using multiple sequences, the `$` symbol in the filename will be substituted with the sequence name or number.
- `--plot_hits_file FILE` will output the results to a graphical file format.  `matplotlib` must be installed for this to work.  Plot format will be determined by the filename extension given.

## mhc_gen_db.py

To do

## Using NetMHCII

To do (installation and setting environment)

## List of alleles

The following is the complete list of alleles supported for each Predictor.  In brackets, which allele_sets it occurs in is indicated (test, paul15, greenbaum11).

- The paul15 set is taken from [Paul+2015](https://www.ncbi.nlm.nih.gov/pubmed/25862607).
- The greenbaum11 set is taken from [Greenbaum+2011](https://www.ncbi.nlm.nih.gov/pubmed/21305276).

### Propred

- DRB1_0101 (test)
- DRB1_0301
- DRB1_0401
- DRB1_0701
- DRB1_0801
- DRB1_1101
- DRB1_1301
- DRB1_1501

### NetMHCII

- DRB1_0101 (test, greenbaum11)
- DRB1_0103 (
- DRB1_0301 (paul15, greenbaum11)
- DRB1_0401 (greenbaum11)
- DRB1_0402
- DRB1_0403
- DRB1_0404
- DRB1_0405 (greenbaum11)
- DRB1_0701 (paul15, greenbaum11)
- DRB1_0801
- DRB1_0802 (greenbaum11)
- DRB1_0901 (greenbaum11)
- DRB1_1001
- DRB1_1101 (greenbaum11)
- DRB1_1201 (greenbaum11)
- DRB1_1301
- DRB1_1302 (greenbaum11)
- DRB1_1501 (paul15, greenbaum11)
- DRB1_1602
- DRB3_0101 (paul15, greenbaum11)
- DRB3_0202 (paul15, greenbaum11)
- DRB3_0301
- DRB4_0101 (paul15, greenbaum11)
- DRB4_0103
- DRB5_0101 (paul15, greenbaum11)
- H-2-IAb
- H-2-IAd
- H-2-IAk
- H-2-IAs
- H-2-IAu
- H-2-IEd
- H-2-IEk
- HLA-DPA10103-DPB10201 (greenbaum11)
- HLA-DPA10103-DPB10301
- HLA-DPA10103-DPB10401 (greenbaum11)
- HLA-DPA10103-DPB10402
- HLA-DPA10103-DPB10601
- HLA-DPA10201-DPB10101 (greenbaum11)
- HLA-DPA10201-DPB10501 (greenbaum11)
- HLA-DPA10201-DPB11401 (greenbaum11)
- HLA-DPA10301-DPB10402 (greenbaum11)
- HLA-DQA10101-DQB10501 (greenbaum11)
- HLA-DQA10102-DQB10501
- HLA-DQA10102-DQB10502
- HLA-DQA10102-DQB10602 (greenbaum11)
- HLA-DQA10103-DQB10603
- HLA-DQA10104-DQB10503
- HLA-DQA10201-DQB10202
- HLA-DQA10201-DQB10301
- HLA-DQA10201-DQB10303
- HLA-DQA10201-DQB10402
- HLA-DQA10301-DQB10301
- HLA-DQA10301-DQB10302 (greenbaum11)
- HLA-DQA10303-DQB10402
- HLA-DQA10401-DQB10402 (greenbaum11)
- HLA-DQA10501-DQB10201 (greenbaum11)
- HLA-DQA10501-DQB10301 (greenbaum11)
- HLA-DQA10501-DQB10302
- HLA-DQA10501-DQB10303
- HLA-DQA10501-DQB10402
- HLA-DQA10601-DQB10402

##See Also

* [[MHCEpitopeEnergy]]
* [[AddMHCEpitopeConstraintMover]]
* [[Design-centric guidance terms|design-guidance-terms]]
<!--- END_INTERNAL -->