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

### Examples

Add some examples, probably from the demos.

## mhc_gen_db.py

The `mhc_gen_db.py` script uses a lot of the same machinery as `mhc_score.py`, and so many of the same options work the same way as described above.

### Input sequences

The input options work in the same way as `mhc_score.py`, but only one sequence can be used.  This means the only available options are as follows:
- `--fa`
- `--pdb`/`--chain`

You may not specify a multi-FASTA file (`--fsa`), a peptides file (`--pep`), or sequences from standard input or the command line.

### Controlling design space

Inherent in making a database of scores is the need to determine what your design space should be.  This is a complex question to do the combinatorial aspects of sliding window peptides, as outlined in detail [[here|MHCEpitopeEnergy#how-to-generate-an-external-database_why-external-databases_the-combinatorial-problem]].  Because it is impossible to score all of design space even in a very small region, we provide a number of ways of describing which amino acids to allow at each position, and which positions to sample.

Note that regardless of these options, the entire input sequence will be scored and stored in the database.

####Amino acid diversity

You may use one (AND ONLY ONE?) of the following ways of specifying what amino acids to try at each position.

- `--aa_csv CSV_FILE` specifies a CSV file where each line includes a position number followed by all allowed amino acids (one-letter code) at each position, each separated by commas.  (Wild-type is automatically added in if missing.)  See `tools/mhc_energy_tools/demo/in/2sak_A.region_muts.csv` for an example.
- `--pssm PSSM_FILE` specifies a PSSM to use.  Two PSSM formats are officially supported, though the script will try to parse unsupported formats as well.  The two formats are the output from the web and command line versions of PSIBLAST.  For more details on how to make a PSSM, see [[here|MHCEpitopeEnergy#how-to-generate-an-external-database_how-to-make-a-pssm]].  For examples of supported PSSMs, see `tools/mhc_energy_tools/pssm_examples`.
 - `--pssm_thresh PSSM_THRESH` sets the PSSM threshold above which a residue will be allowed.  The PSSM should contain the log (base 2) of the observed substitution frequency at a given position divided by the expected substitution frequency at that position.  A score > 1 means that the residue is observed more often than would be expected at random.  The default is 1, though this can lead to very large database sizes if not increased.

####Positions to sample

There are two options to limit which positions to sample.  This is useful if, for example, you have a PSSM for the entire protein, but only want to score epitopes in specific regions.

- `--positions` allows you to specify which regions to allow to mutate.  Anything not included will not be scores (except the wild-type sequence).  It should be formatted as follows: `--positions 3-30` to target a single region (residues 3-30, inclusive) and `--positions 3-30,113-142` to target multiple regions (residues 3-30 and 113-142, inclusive).
- `--lock` prevents regions from mutating.  It is specified in the same format as `--positions`.
- WHAT HAPPENS IF A RESIDUE IS SPECIFIED IN BOTH --POSITIONS AND --LOCK?

### Predictors

All predictors available in `mhc_score.py` are available with `mhc_gen_db.py`, and are configured in the same way.  Specifically:
- `--propred`
- `--netmhcii`
- `--matrix`

In addition, the `--netmhcii_raw NETMHC_OUTPUT` option allows the raw output from a NetMHCII run to be used as input.

### Scoring Details

All of the options from `mhc_score.py` are available with `mhc_gen_db.py` to configure the predictors, except `--db_unseen`.  Specifically:
- `--allele_set`
- `--alleles`
- `--epi_thresh`
- `--noncanon`
- `--netmhcii_score` (for NetMHCII only)

### Output

The database will be output to a file specified by a positional argument.  If the database already exists at that location, the script will verify that it is using the same type of predictor and same list of alleles.  If so, it will add any peptides that are missing from that database to the database.  If no database is given, the script will run, following instructions from the additional output options, without scoring or saving the database.

Additional output options:
- `--estimate_size` will calculate the number of peptides to be scored as configured.  This is a good check to do before actually creating your database to get an idea of how big it will be.
- `--peps_out PEPTIDE.TXT` will save all of the peptides to be scored in `PEPTIDES.TXT`, with one peptide per line.
- `--res_out RESFILE.RES` will generate a resfile based on the design space specified.  Only positions with more than one allowed amino acid will be listed in the resfile, using PIKAA to list them.  Recall that wild-type is always allowed, so this is listing PIKAA lines for all positions that allow at least one non-native amino acid to be sampled.
 - `--chain X`, in addition to specifying what chain to use when a PDB file is used as input, will decide what chain ID to use in the resfile if a FASTA file is used as input.  If input is using `--fa`, `--chain` is mandatory.
 - `--res_header COMMAND` applies `COMMAND` to the resfile header, above the `start` keyword, which will apply that command to all unspecified residues.  By default, no header is included.

### Multiprocessing

Because NetMHCII is slow compared to matrix-based scoring, spreading the computation for NetMHCII databases over multiple processors is enabled.  Use the following commands to control multiprocessor database generation:
- `--nproc #` determines the number of processors to use.  By default, it uses 1 (no multiprocessing).
- `--batch #` determines the number of peptides to pass to each processor at a time.  NetMHCII will score that batch, and then another batch will be submitted to that processor until all peptides are scored.

### Examples

Add some examples, probably from the demos.

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