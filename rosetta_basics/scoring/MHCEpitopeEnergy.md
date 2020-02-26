## MHC Epitope energy (mhc_epitope)

Documentation created by Brahm Yachnin (brahm.yachnin@rutgers.edu), Khare laboratory, and Chris Bailey-Kellogg (cbk@cs.dartmouth.edu).  Parts of this documentation are copied/adapted from Vikram K. Mulligan's (vmullig@uw.edu) design-centric guidance documentation.
Last edited December 12, 2019.

[[_TOC_]]

## Purpose and algorithm

A major obstacle to the clinical application of proteins with potentially beneficial therapeutic functions is the fact that macromolecules are subject to immune surveillance, and initial recognition of a therapeutic protein via antigen presenting cells and T cells can lead to a potent antidrug antibody response that can reduce efficacy or even cause life-threatening complications ([Griswold+2016](https://www.ncbi.nlm.nih.gov/pubmed/27322891)). A key step in the development of this immune response is the binding by MHC molecules of peptides that have been proteolytically processed from the protein. The premise behind deimmunization by epitope deletion is that mutagenic modification of the protein to reduce recognition of its constituent peptides by MHC can forestall the activation of T cells that in turn provide help in the development of potent antidrug antibodies. The maturation of computational predictors of MHC binding, combined with methods to evaluate and optimize the effects of mutations on protein structure and function, have enabled the development and successful application of computationally-directed protein deimmunization methods, using both Rosetta ([Choi+2013](https://www.ncbi.nlm.nih.gov/pubmed/23299435), [King+2014](https://www.ncbi.nlm.nih.gov/pubmed/24843166)) and other protein design platforms ([Parker+2013](https://www.ncbi.nlm.nih.gov/pubmed/23384000), [Zhao+2015](https://www.ncbi.nlm.nih.gov/pubmed/26000749), [Salvat+2017](https://www.ncbi.nlm.nih.gov/pubmed/28607051), etc.).

Rosetta readily supports epitope deletion by incorporating into its scoring an evaluation of the epitope content of a protein sequence. This then naturally enables packing and design to be pushed toward sequences with reduced epitope content. The mhc_epitope scoring term supports this process by leveraging Alex Ford's changes to the packer that support the use of fast-to-calculate but non-pairwise-decomposable scoring terms. The mhc_epitope term is computed by iterating over the constituent peptiders of a pose's sequence and applying one (or more) of several epitope prediction algorithms to independently evaluate each peptide. When considering a proposed mutation, the scoring term only reevaluates the contributions of those peptides containing the mutation. In addition to supporting global evaluation and design of epitope content, mhc_epitope can be differentially applied to distinct regions (e.g., focusing on identified or predicted "hot spots") by employing it as a constraint to residues defined by selectors.

## Epitope prediction

An epitope predictor takes as input a peptide and returns an evaluation of its relative risk to bind MHC, typically as some form of predicted binding affinity or as a relative rank with respect to a distribution (see e.g., [Wang+2008](https://www.ncbi.nlm.nih.gov/pubmed/18389056)). The predictions are specific to the MHC allele, and while there are thousands of different alleles, due to their degeneracy in peptide binding, a relatively small representative set can be used to capture population diversity (e.g., [Southwood+1998](http://www.ncbi.nlm.nih.gov/pubmed/9531296), [Greenbaum+2011](https://www.ncbi.nlm.nih.gov/pubmed/21305276), [Paul+2015](https://www.ncbi.nlm.nih.gov/pubmed/25862607)). The core unit of MHC-II binding is 9 amino acids, defined by the MHC-II groove and the pockets in which is accommodates peptide side chains. The overhanging amino acids can also contribute. Some epitope predictors focus on just the core 9mer, while others use longer peptides (15mers) in order to capture overhangs as well as capture the combined effect of multiple binding frames/registers as the core 9mer slides up and down the groove.

Since epitope content is repeatedly evaluated during the course of design (for multiple peptides for each proposed mutation), mhc_epitope must be efficient in its use of epitope prediction. One way to do this is with a position-specific scoring matrix, e.g., the pocket profile method Propred ([Singh+2001](http://www.ncbi.nlm.nih.gov/pubmed/11751237)) which was based on TEPITOPE ([Sturniolo+1999](https://www.ncbi.nlm.nih.gov/pubmed/10385319)). The current implementation includes the [Southwood+1998](http://www.ncbi.nlm.nih.gov/pubmed/9531296) representative set of Propred matrices, downloaded from the [Propred site](http://crdd.osdd.net/raghava/propred/) courtesy of Dr. Raghava. Another way to enable efficient epitope prediction within the design loop, even when an external stand-alone program must be invoked, is to precompute and cache predictions. The current implementation supports this by using a sqlite database of predicted epitopes, which can be precomputed (e.g., using NetMHCII ([Jensen+2018](https://www.ncbi.nlm.nih.gov/pubmed/29315598))) using python scripts described below. The SVM method previously developed by ([King+2014](https://www.ncbi.nlm.nih.gov/pubmed/24843166)) for Rosetta-based deimmunization is also available, though the currently available SVMs are a bit slow to use in the context of the packer.  It is still very reasonable, from a speed perspective, to use the SVM-based predictor with mhc_epitope during scoring.

## Citation information

The mhc_epitope scoreterm itself is unpublished for the time being.  If you make use of it, please check back here to see if the paper has been published.

In addition to the Rosetta functionality, mhc_epitope makes use of several de-immunization resources developed outside of the Rosetta community.  As a condition for using this code, it is imperative that the resources that you use are appropriately cited in any resulting publication.

### ProPred

The ProPred matrices are provided in the Rosetta database (`/main/database/scoring/score_functions/mhc_epitope/propred8.txt`) and are used by the "default" configuration file, `propred8_5.mhc`.

The matrices are obtained from http://crdd.osdd.net/raghava/propred/  If you use results based on these predictions, please cite Singh, H. and Raghava, G.P.S. (2001) ProPred: Prediction of DR binding sites. Bioinformatics, 17(12):1236-37.  http://www.ncbi.nlm.nih.gov/pubmed/11751237

### NetMHCII

NetMHCII can be incorporated into external databases using the [[mhc-energy-tools]].  If you use NetMHCII, please cite Improved methods for predicting peptide binding affinity to MHC class II molecules.  Jensen KK, Andreatta M, Marcatili P, Buus S, Greenbaum JA, Yan Z, Sette A, Peters B, Nielsen M. Immunology. 2018 Jan 6. doi: 10.1111/imm.12889

### NMer
nmer is an existing epitope predictor that runs within Rosetta.  Unlike mhc_epitope, it is not packer-compatible in its original form.  mhc_epitope can now use nmer as a predictor.

If you use nmer within mhc_epitope, please cite the original paper:
King C, Garza EN, Mazor R, Linehan JL, Pastan I, Pepper M, Baker D. Removing T-cell epitopes with computational protein design. Proc Natl Acad Sci U S A 2014;111:8577–82. https://doi.org/10.1073/pnas.1321126111

### IEDB
IEDB is a public database of experimentally-validated immune epitopes.  The `iedb_data.mhc` file, available in the Rosetta database, references the database file `iedb_data.db` that contains data derived from the IEDB.  If you use either of these files, you must cite the IEDB.  In addition, the [[mhc-energy-tools]] provides resources to update and build custom database files based on IEDB data.

Please see the following instructions from the IEDB related to using any of these resources:

Users are requested to cite the IEDB when they present information obtained from the IEDB: http://www.iedb.org. The journal reference for the IEDB was updated in 2018 and should be cited as: Vita R, Mahajan S, Overton JA, Dhanda SK, Martini S, Cantrell JR, Wheeler DK, Sette A, Peters B. The Immune Epitope Database (IEDB): 2018 update. Nucleic Acids Res. 2019 Jan 8;47(D1):D339-D343. doi: 10.1093/nar/gky1006. PMID: 30357391

All publications or presentations referring to data generated by use of the IEDB Resource Analysis tools should include citations to the relevant reference(s), found at http://tools.iedb.org/main/references/

## User control

This scoring term is controlled by ```.mhc``` files, which define the desired deimmunization protocol and settings.  The ```.mhc``` file is passed to scorefunction using the ```<Set>``` tag in the scorefunction:
```xml
<SCOREFXNS>
	<ScoreFunction name="ref_deimm" weights="ref2015.wts">
		<Reweight scoretype="mhc_epitope" weight="1"/>
		<Set mhc_epitope_setup_file="propred8_5.mhc"/>
	</ScoreFunction>
</SCOREFXNS>
```

Alternatively, the user can apply the ```.mhc``` file as a constraint using the ```<AddMHCEpitopeConstraintMover>``` mover.  The constraint mechanism allows multiple or targeted epitope predictors to be used.
```xml
<SCOREFXNS>
	<ScoreFunction name="ref_deimm" weights="ref2015.wts">
		<Reweight scoretype="mhc_epitope" weight="1"/>
	</ScoreFunction>
</SCOREFXNS>
<MOVERS>
	<AddMHCEpitopeConstraintMover name="mhc_csts" filename="propred8_5.mhc" selector="my_residue_selectors" weight="1.0"/>
</MOVERS>
```
Note that for the `mhc_epitope` term to be applied, a scorefunction with `mhc_epitope` re-weighted to a non-zero weight needs to be used with your mover, even if you only applying this scoreterm using the constraint mover.  Both the scorefunction and the constraint will have a weight associated with them; to figure out the "net weight" of the constraint, you must multiply the two weights together.  For example, if the scorefunction has a weight of 0.5 and the constraint mover has a weight of 3.0, the weight of the constraint will be 1.5.

In its simplest form, you can use mhc_epitope by simply setting the mhc_epitope weight in your scorefunction to 1 and use ```<Set mhc_epitope_setup_file="propred8_5.mhc"/>``` in your scorefunction definition, as in the first example above.  In any mover that uses that scorefunction, the ProPred matrices provided within Rosetta will be used to de-immunize the entire (designable) pose.

## Setting up your .mhc files

If you would like to start using ```mhc_epitope``` right away, take a look at the example ```.mhc``` files below and then consult the relevant options here to understand how they work.  You can then customize your configuration as needed.

Each ```.mhc``` file should begin with a ```method``` line.  The syntax is the keyword ```method```, followed by the prediction method, and then by the input filename.  There are three prediction methods currently supported:
- ```method matrix``` uses a matrix to score each peptide.  For example, the propred matrices can be used to score any peptide without precomputing epitope scores.  ```method matrix propred8``` uses the propred8 scoring matrices (i.e., the 8 representative alleles mentioned above)
- ```method external``` uses a pre-computed, sqlite database to score each peptide.  The filename should be that of the sqlite database.  For example, ```method external yfp_netmhcii.db```.
- ```method preloaded``` also uses a pre-computed database, like ```method external```.  Unlike ```external```, ```preloaded``` loads the entire contents of the database into memory.  This will speed up your trajectories, at the cost of a larger memory footprint.  ```preloaded``` also accepts CSV files with the epitope information, so the filename must be preceded by the keywords ```db``` or ```csv``` to indicate a sqlite database or a CSV file.  The filename should be that of the database, in the appropriate format.  For example, ```method preloaded db yfp_netmhcii.db``` or ```method preloaded csv yfp_netmhcii.csv```.
- See below for ```method svm``` and ```method svm_rank```.
- Note that additional prediction methods can easily be implemented by writing new MHCEpitopePredictor derived classes.

Subsequent lines in the ```.mhc``` file are optional, and control how scoring is performed.
- ```alleles``` can be used to select a subset of alleles present in your matrix/database to use.  This option is not currently supported, except to select all alleles (the default).  To select all alleles, use ```alleles *```.
- ```threshold``` applies to matrix-based predictors only.  This option sets the percentile cutoff for binding that is considered a hit.  For example, a threshold of 2 means that the top 2% of binders are hits.  Default is ```threshold 5.0```.  For Propred matrices (currently the only supported matrix type), threshold must be an integer from 1-10.
- ```unseen``` applies to external or preloaded predictors only.  As these predictors use an external database that does not necessarily include all possible peptides, this option sets the behavior for any peptide not found in the database (i.e. that is "unseen").  This option can take different handlers, which decide how to handle unseen peptides.  The default is ```unseen score 100```.
 - ```score``` or ```penalize``` (which are identical) adds a specific, constant penalty score for any peptide not found in the database, thereby discouraging Rosetta from designing to these sequences.  The default (```unseen score 100```) adds 100 to the score if an unknown peptide is encountered.
 - ```ignore``` simply ignores any peptide that is not present in the database, and is a shorthand for ```unseen score 0```.  This is suited for databases of confirmed "bad" peptides.
- ```xform``` transforms the score returned by the predictor.  In any case, if the transformed score is less than 0, a score of 0 is used.  It can run in one of three modes:
 - ```raw``` is the default.  This takes the raw score and subtracts an offset from it.  The default is ```xform raw 0```.
 - ```relative+``` is a score relative to the native sequence, in additive mode.  The score is calculated as (raw score - native score + offset).  For example, ```raw relative+ 5``` means that a score that is 5 units worse than native, or better, will get a score of 0.
 - ```relative*``` is a score relative to the native sequence, in multiplicative mode.  The score is calculated as (raw score - native score * factor).  For example, ```raw relative* 1.2``` means that any score that is at most 20% higher than native will get a score of 0.
 - Note that the "native" sequence is the sequence when the packer first starts, not the sequence as read in.  A protocol that uses multiple movers will see its "native" sequence change throughout the protocol.

An additional Predictor, based off of the NMerSVMEnergy terms introduced in the [King+2014](https://www.ncbi.nlm.nih.gov/pubmed/24843166) paper, can also be used in the context of the `mhc_epitope` scoreterm.  It's configuration is slightly different from the other Predictors, so will be described separately here.

 - Two method-level configurations are available: ```method svm``` and ```method svm_rank```.  The latter uses ranked SVM scores, while the former does not.  All other configuration settings are optional.
 - ```svm_file``` allows the user to specify a whitespace-delimited list of SVM files to use.  See below for the default settings (equivalent to -nmer_svm_list command line option).
 - ```svm_rank``` allows the user to specify a whitespace-delimited list of rank files to use.  See below for the default settings (equivalent to -nmer_svm_rank_list command line option).
 - ```svm_pssm_features``` allows the user to specify a whitespace-delimited list of PSSM files to use.  See below for the default settings.  If you do not want to use PSSMs, the configuration should be set to ```svm_pssm_features off```  (equivalent to -nmer_pssm_list command line option).
 - ```svm_sequence_length``` allows the user to specify the length of the core peptide and overhang peptides.  The first number is the core length, and the second is the overhang length.  The default is ```svm_sequence_length 9 3```, which indicates a core 9mer with a 3mer overhang on both sides totally 15 residues: OOOCCCCCCCCCOOO (O = overhang, C = core).  Don't change this unless you know what you're doing  (equivalent to -nmer_ref_seq_length and -nmer_svm_term_length command line options).
 - ```svm_aa_matrix``` allows to specify an amino acid encoding matrix.  The default is ```svm_aa_matrix sequence/substitution_matrix/BLOSUM62.prob.rescale``` (equivalent to -nmer_svm_aa_matrix command line option).
 - ```xform``` can be used exactly as described above.  For this reason, nmer options ```nmer_svm_scorecut``` and ```nmer_gate_svm_scores``` are disabled in this context.
 - Default ```svm_file```:
  - sequence/mhc_svms/HLA-DRB10101_nooverlap.libsvm.dat.noscale.nu0.5.min_mse.model
  - sequence/mhc_svms/HLA-DRB10301_nooverlap.libsvm.dat.noscale.nu0.5.min_mse.model
  - sequence/mhc_svms/HLA-DRB10401_nooverlap.libsvm.dat.noscale.nu0.5.min_mse.model
  - sequence/mhc_svms/HLA-DRB10701_nooverlap.libsvm.dat.noscale.nu0.5.min_mse.model
  - sequence/mhc_svms/HLA-DRB10802_nooverlap.libsvm.dat.noscale.nu0.5.min_mse.model
  - sequence/mhc_svms/HLA-DRB11101_nooverlap.libsvm.dat.noscale.nu0.5.min_mse.model
  - sequence/mhc_svms/HLA-DRB11302_nooverlap.libsvm.dat.noscale.nu0.5.min_mse.model
  - sequence/mhc_svms/HLA-DRB11501_nooverlap.libsvm.dat.noscale.nu0.5.min_mse.model
 - Default ```svm_rank``` (or empty if using ```method svm```):
  - sequence/mhc_rank_svm_scores/HLA-DRB10101.libsvm.test.out.sort.gz
  - sequence/mhc_rank_svm_scores/HLA-DRB10301.libsvm.test.out.sort.gz
  - sequence/mhc_rank_svm_scores/HLA-DRB10401.libsvm.test.out.sort.gz
  - sequence/mhc_rank_svm_scores/HLA-DRB10701.libsvm.test.out.sort.gz
  - sequence/mhc_rank_svm_scores/HLA-DRB10802.libsvm.test.out.sort.gz
  - sequence/mhc_rank_svm_scores/HLA-DRB11101.libsvm.test.out.sort.gz
  - sequence/mhc_rank_svm_scores/HLA-DRB11302.libsvm.test.out.sort.gz
  - sequence/mhc_rank_svm_scores/HLA-DRB11501.libsvm.test.out.sort.gz
 - Default ```svm_pssm_features```:
  - sequence/mhc_pssms/HLA-DRB10101_nooverlap.9mer.norm.pssm
  - sequence/mhc_pssms/HLA-DRB10301_nooverlap.9mer.norm.pssm
  - sequence/mhc_pssms/HLA-DRB10401_nooverlap.9mer.norm.pssm
  - sequence/mhc_pssms/HLA-DRB10701_nooverlap.9mer.norm.pssm
  - sequence/mhc_pssms/HLA-DRB10802_nooverlap.9mer.norm.pssm
  - sequence/mhc_pssms/HLA-DRB11101_nooverlap.9mer.norm.pssm
  - sequence/mhc_pssms/HLA-DRB11302_nooverlap.9mer.norm.pssm
  - sequence/mhc_pssms/HLA-DRB11501_nooverlap.9mer.norm.pssm

### Examples of ```.mhc``` files

This is an ```.mhc``` file provided with Rosetta (```database/scoring/score_functions/mhc_epitope/propred8_5.mhc```).  This will use the provided ProPred matrices (```database/scoring/score_functions/mhc_epitope/propred8.txt```) with a threshold of 5:
```
method matrix propred8
alleles *
threshold 5
```

Another ```.mhc``` file provided with Rosetta (```database/scoring/score_functions/mhc_epitope/iedb_data.mhc```) penalizes peptides found in the public IEDB database, while ignoring (scoring 0) all other peptides:
```
method preloaded db iedb_data.db
unseen ignore
```
A Rosetta-compatible database derived from the IEDB is reference by this ```.mhc``` file (```database/scoring/score_functions/mhc_epitope/iedb_data.db```), which is described in more detail in the file ```database/scoring/score_functions/mhc_epitope/iedb_data.info```.

This is a ```.mhc``` file that uses an external database provided by the user.  Any peptide encountered by the packer that is not found in the database will be assigned a score penalty of 100.
```
method external user_sql_database.db
unseen score 100
```

This is a ```.mhc``` file that preloads a CSV-based database provided by the user.  Any peptide encountered by the packer that is not found in the database will be assigned a score penalty of 0.
```
method preloaded csv user_csv_database.csv
unseen ignore
```

## MHCEpitope Constraints

A ```.mhc``` setup file passed to the scorefunction in ```<SCOREFXNS>``` block will be applied to the entire pose.  It is possible that in addition/instead of applying the ```.mhc``` setup to the entire pose, you would want to target specific regions that, for example, those that are known or predicted to be highly immunogenic.  This can be achieved using the [[AddMHCEpitopeConstraintMover]], which accepts a ```.mhc``` setup file as well as an optional residue selector and weighting term.  An arbitrary number of [[AddMHCEpitopeConstraintMover]]s can be applied.

If you only want to use constraints to deimmunize your protein, you do not need to pass a ```.mhc``` setup file in the ```<SCOREFXNS>``` section.  Note that you _must still turn on ```mhc_epitope``` term in the scorefunction_ for the constraints to function, even if you do not have a globally applied ```.mhc``` file.

## How to generate an external database

### Why external databases?

Propred ([Singh+2001](http://www.ncbi.nlm.nih.gov/pubmed/11751237)) is a pocket profile based epitope prediction method, supporting prediction of peptide-MHC binding for constituent peptides of a protein, in a manner that is fast enough to be usable within the packer and also reliable enough to have enabled other deimmunization (as well as vaccine design) efforts. Thus matrices for some representative alleles are supplied with Rosetta. You may wonder, in that case, why generating an external database is useful.

While Propred remains a very useful epitope prediction tool, and was one of the better predictors in a major benchmark ([Wang+2008](https://www.ncbi.nlm.nih.gov/pubmed/18389056)), it is nearly 20 years old, and more sophisticated epitope prediction methods are now available that are trained on the large amount of peptide-MHC binding data available in the [IEDB](http://www.iedb.org). NetMHCII ([Jensen+2018](https://www.ncbi.nlm.nih.gov/pubmed/29315598)), the other predictor primarily supported by the ```mhc_energy_tools```, requires the use of an external executable to predict epitopes in a peptide. As such, it is much too slow for "on-the-fly" use with the packer.

In order to compromise between having packer-speed epitope prediction and a state-of-the-art predictor, ```mhc_epitope``` supports the use of an external database that can be pre-computed with relevant peptides for your protein of interest.  Because the peptide length is 15 residues, clearly a subset of all possible residues must be chosen, and only specific regions of the protein can be considered.  We recommend that you use a PSIBLAST-generated PSSM to determine likely substitutions to consider, and generate a database containing all of those peptides using the provided ```mhc_gen_db.py``` tool.  In this way, you can target the hotspots in your protein using NetMHCII, and use Propred to score the rest of the protein.

Alternatively, hand-picked substitutions can be listed using a CSV format, or a PSSM could be derived in another way.  Virtually any sensible method of restricting design space (computational or experimental) could be appropriate, depending on your circumstances. The goal is to arrive at a subset of residue identities that are unlikely to "break" the protein during de-immunization. We recommend PSIBLAST as a general solution as it is applicable to any protein target, but it is by no means the only option.

#### The combinatorial problem

Rosetta users will typically be aware of the standard protein sequence combinatorial problem: a N-length protein has 20^N possible sequences.  Because we are dealing with a sliding window situation, however, it gets even worse.  If we have 5 identities we want to sample at one position, that gives us 5 unique sequences.  With a sliding window of 15 residues, however, that means that we will have 5 sequences in each of the 15 windows that include that position.  In other words, 15 x 5 = 75 peptides to cover variability in that one position.

Now, if we add another 5 identities to sample in the adjacent position, you will need to sample 5x5 = 25 possibilities for every peptide window that contains both positions (all but the first and last, so 13), and 5 possibilities for the positions that contain only one or the other.  For our hypothetical situation, that produces 5 + 13 x 25 + 5 = 335 unique peptides.

Even with a pre-computed database, you will still need to be selective in how many positions and how many identities to sample in order to avoid needing to pre-score millions of peptides.

### How to make a PSSM

The easiest way to make a PSSM is using PSIBLAST:

1. Run blastp using the PSI-BLAST algorithm.  You will need to run at least two iterations to get a PSSM.  On the first results page, click on the ```Go``` button next to ```Run PSI-Blast iteration N``` to start the second or higher iteration.

2. Once you have completed your final PSI-BLAST iteration, download the PSSM is ASN format by clicking ```Download```-->```PSSM```.

3. Convert the ASN format PSSM to the matrix form by going to https://www.ncbi.nlm.nih.gov/Class/Structure/pssm/pssm_viewer.cgi, entering the ASN file as the "Scoremat file" in box 1, and clicking ```Matrix view```.  You can download the matrix by clicking ```Download Matrix to File```.


Alternatively, you can download PSI-BLAST and the appropriate database and run this locally:

1. Download the blast suite and appropriate database.

2. Run the following command:
```
psiblast -db /path/to/blast/database -query my_sequence.fas -num_iterations N -out_ascii_pssm pssm_matrix.txt -out logfile.log
```

   -```my_sequence.fas``` is your fasta file

   -```N``` is the number of iterations (>=2)

   -```pssm_matrix``` is your output matrix, and ```logfile.log``` is the psiblast log.

### Generating the database

Once you have a PSSM (or other way of determining what sequences to look at), you need to generate your database using ```mhc_gen_db.py```, located in ```tools/mhc_energy_tools/```.  For complete documentation of these tools, see [[the tools documentation|mhc-energy-tools]].

Note that you will probably want to use this in the "constraint" mode to look at the hotspot regions in your protein, as making a database to cover the entire protein sequence is likely prohibitively expensive.  To cover non-hotspot regions, the Propred matrices are probably sufficient to ensure that the immunogenicity stays low.

Assuming you want to use NetMHCII as your predictor, you will first need to download and install NetMHCII (http://www.cbs.dtu.dk/cgi-bin/nph-sw_request?netMHCII), and set the environment variable ```NMHOME``` to the location of the NetMHCII binary.

Especially when using a PSSM, you need to be very careful to avoid a combinatorial explosion of peptides to process.  Consider the following advice:

-Select only those regions you have previously determined to have strong binding, and keep those regions as small as possible (minimum 15, the peptide length).  Use the ```--positions``` and ```--lock``` parameters to identify only the regions you want to target from the PSSM.

-The default ```--pssm_thresh``` value is 1, which effectively means that any residue that appears more than would be expected at random will be sampled.  Increasing this number to 2 or even 3 will greatly decrease the number of peptides to sample.  The downside, though, is that you shrink your possible design space.  (Typically, you will penalize any sequence not present in the database using the ```unseen penalize``` parameter in the ```.mhc``` file.)

-Of the three sets of alleles to test, the ```paul15``` set ([Paul+2015](https://www.ncbi.nlm.nih.gov/pubmed/25862607)) is smaller than the ```greenbaum11``` set ([Greenbaum+2011](https://www.ncbi.nlm.nih.gov/pubmed/21305276)) and may be almost as good. This decreases the amount of time it takes for each peptide.

As an example, this might be how you want to generate your database, assuming your protein sequence is in a file ```sequence.fas```, your PSSM is in ```pssm.txt```, and you want to look at the sequences 15-31 and 90-110:
```
mhc_gen_db.py --fa sequence.fas --positions 15-31,90-110 --pssm pssm.txt --pssm_thresh 2 --peps_out list_of_peptides.txt --netmhcii --allele_set paul15 mydatabase.db
```

If you want to also generate a resfile to limit design space in those regions that are not covered by the database, you can use the following (assuming the protein is chain A):
```
mhc_gen_db.py --fa sequence.fas --positions 15-31,90-110 --pssm pssm.txt --pssm_thresh 2 --peps_out list_of_peptides.txt --netmhcii --allele_set paul15 --chain A --res_out myresfile.res mydatabase.db
```

Note that a database can also be used to provide experimentally known epitopes, for which a high penalty can be imposed.

### Limitations of databases

- The external databases are significantly slower than matrix-based predictors, as the database must be accessed from disk continuously during packing.
- If you have multiple processes accessing the same database, this will create an additional slowdown, as the database will be accessed by multiple processes continuously during packing.  If storage constraints do not pose an issue, consider temporarily making a copy of the database for each process.
- One solution to this is to use the preloaded predictor to load the entirety of the database into RAM.  The drawback here is that large databases must reside in memory, potentially greatly increasing Rosetta's memory footprint.
- The database predictor is currently disabled in multithreading situations.  If you would like to use an external database in a multi-threaded Rosetta run, please contact Brahm (brahm.yachnin@rutgers.edu) and/or Chris (cbk@cs.dartmouth.edu), as we would be interested in figuring out how to make this possible.  (You can attempt this on your own by removing the `utility_exit_with_message()` line in `core/scoring/mhc_epitope_energy/MHCEpitopeEnergySetup.cc` (~line 229), but we have not tested this.)  Note that preloaded databases are usable in a multi-threading environment.

## Strategies/guidelines for deimmunization in Rosetta

We have developed a scientific benchmark and have tested various configurations of MHCEpitopeEnergy trajectories in order to build a recommended starting point for de-immunization.  Ultimately, de-immunization is a trade-off between getting native-like, fully active proteins and elimination of sequences predicted to be immunogenic.  Our recommended configuration aims to balance these two orthogonal objectives.

We can make a few suggestions:
- Using Propred as a Predictor is fast, and has been previously shown to be fairly effective, if not as comprehensive as other Predictors.  The default Propred Predictor is a good starting point for de-immunization.
- For Propred, mhc_epitope weights of 0.5-1.5 yield a good balance of de-immunization and good Rosetta scores.  This weight can be tweaked to determine how "aggressively" you would like to de-immunize.  Note that mhc_epitope scores scale with the number of alleles being considered.  While Propred uses up to 8 alleles, NetMHCII can use as many as 27, which can significantly inflate the scores.  If a large number of alleles are being considered, lower mhc_epitope weights should be used.
- You almost certainly should use [[FavorNativeResidue|FavorNativeResidueMover]] or similar constraints to avoid spurious mutations.
- Design should be turned off for any residue known to be important for structure and function.  Provided that this is a relatively small number of residues, de-immunization should not be greatly influenced by these restrictions.
- A PSI-BLAST generated PSSM can be used to restrain design space to amino acid substitutions that are conserved in evolution.  We have found that allowing residues with a PSSM score of 1 or greater from a PSI-BLAST PSSM generates similar results with respect to structure quality and degree of de-immunization, while preserving native-like characteristics and greatly decreasing runtime.  The documentation above describes how to make a PSI-BLAST PSSM.  The database tools can be used to generate a resfile that limits design space to that specified by the PSSM.
- A common issue with de-immunization is the strong tendency to introduce acidic residues.  The total charge of the protein should be monitored.  We recommend using [[AACompositionEnergy]] as a means to restrain positive (Arg+Lys) and negative (Glu+Asp) charges separately.  The following configuration of a AAComposition file, with an aa_composition weight of 0.5, is a reasonable starting point:
```
PENALTY_DEFINITION
PROPERTIES POSITIVE_CHARGE
ABSOLUTE <enter the number of arg+lys residues in the native structure here>
PENALTIES 3 2 1 0 1 2 3
DELTA_START -3
DELTA_END 3
END_PENALTY_DEFINITION

PENALTY_DEFINITION
PROPERTIES NEGATIVE_CHARGE
ABSOLUTE <enter the number of asp+glu residues in the native structure here>
PENALTIES 3 2 1 0 1 2 3
DELTA_START -3
DELTA_END 3
END_PENALTY_DEFINITION
```
- Alternatively, [[NetChargeEnergy]] can be used to monitor the global netcharge, rather than managing the positive and negative charges separately.  While this is very effective, note that the tendency is to increase the number of positive and negative charges while maintaining global net charge.
- Initial testing shows that de-immunizing with Propred does not necessarily effectively remove all epitopes predicted by, for example, NetMHCII.  For complex de-immunization problems, we recommend targeting hotspot regions using a constraint-based approach with a NetMHCII database for those regions.
- The most effective way of de-immunizing proteins is to target the strongest hotspots (i.e. hits on the largest number of alleles) while leaving regions that only hit one or two alleles alone.  This can be accomplished either by using an xform offset, or by using constraints.

These details are discussed at length in our manuscript.  The scientific test, available on the [[benchmark server|https://benchmark.graylab.jhu.edu/]], also provides access to our current recommended approach, as run on the bleeding edge version of Rosetta, and the corresponding results.

To assess whether your trajectories are successful, we recommend monitoring the following parameters:
- The immunogenicity scores, compared to native.  You should re-score with Propred and NetMHCII (use the [[tools|mhc-energy-tools]] to do so) and evaluate both, regardless of which Predictors were used during design.
- Rosetta total_score, relative to native, removing contributions from mhc_epitope and other constraints.
- packstat, relative to native, as an additional metric for structure quality.
- Sequence recovery and/or sequence similarity, as a metric for "native-ness" of your protein.
- Buried unsatisfied hydrogen bonds, relative to native.  Because de-immunization tends to replace hydrophobic residues with charged residues, this can increase.
- Netcharge and number of positive and negative charges, relative to native.

## Use with symmetry
The ```mhc_energy``` score term should be fully compatible with symmetry.  Each subunit will contribute to the ```mhc_energy``` (though for efficiency, the calculation is performed only on the asymmetric units and scaled appropriately).

## Organization of the code

- The scoring term lives in ```core/scoring/mhc_energy/MHCEpitopeEnergy.cc``` and ```core/scoring/mhc_energy/MHCEpitopeEnergy.hh```.
- The term handles the updating of energies upon proposed mutation, calling an epitope predictor for affected peptides. The base class for epitope prediction is ```core/scoring/mhc_energy/MHCEpitopePredictor.hh```, and current implementations include ```core/scoring/mhc_energy/MHCEpitopePredictorMatrix.cc``` and ```core/scoring/mhc_energy/MHCEpitopePredictorExternal.cc```. The core method for an epitope predictor is ```score()```, which takes a peptide string and returns a score.
- Like any whole-body energy, the MHCEpitopeEnergy class implements a ```finalize_total_energy()``` function that takes a pose.  This calculates the score.  Internally, it calls ```full_rescore()```, which takes a vector of owning pointers to Residues (which can be called directly during packing).
- On initialization, the term creates an internal MHCEpitopeEnergySetup object that stores the user-defined settings from the ```.mhc``` file.  This class is defined in ```core/scoring/mhc_energy/MHCEpitopeEnergySetup.cc``` and ```core/scoring/mhc_energy/MHCEpitopeEnergySetup.hh```.  MHCEpitopeEnergySetup objects can also be stored in MHCEpitopeConstraint associated with a Pose.  At scoring or packing time, the MHCEpitopeEnergy constructs a vector of owning pointers to its internal MHCEpitopeEnergySetup objects and to all those stored in the pose, and uses all of these for scoring.
- A ```.mhc``` file is located in ```/database/scoring/score_functions/mhc_epitope/```.

## Integration with C++ Applications

Generally, any app that supports the use of custom scorefunctions through the command line should be able to use MHCEpitopeEnergy.  To do so, users should set the ```-mhc_epitope_setup_file``` to point to the configuration file you want to use, and also turn on the `mhc_epitope` scoreterm using ```-score:set_weights mhc_epitope 0.75``` (if you wanted a weight of 0.75).  Consult the documentation for the specific app to see if customized scorefunctions are supported.

## Integration with PyRosetta

MHCEpitopeEnergy should be broadly supported using PyRosetta.  Like with C++ apps, a global config file can be set by passing the ```-mhc_epitope_setup_file``` to ```init()``` when you start Pyrosetta, and then set the weight in your scorefunction:
```
pyrosetta.init("-mhc_epitope_setup_file my_config_file.mhc")  # Will apply to all sfxns with non-zero mhc_epitope weights
default_scorefxn = pyrosetta.get_fa_scorefxn()
custom_scorefxn = pyrosetta.get_fa_scorefxn()
custom_scorefxn.set_weight(pyrosetta.rosetta.core.scoring.score_type_from_name("mhc_epitope", 0.5))  # Will apply to custom_scorefxn, but not default_scorefxn.
```

Alternatively, you can associate different config files with different scorefxns using ```EnergyMethodOptions``` configuration:
```
pyrosetta.init()
options = pyrosetta.rosetta.core.scoring.methods.EnergyMethodOptions()
config = pyrosetta.rosetta.utility.vector1_string()
config.append("my_config_file.mhc")
options.set_mhc_epitope_setup_files(config)

custom_scorefxn = pyrosetta.get_fa_scorefxn()
custom_scorefxn.set_energy_method_options(options)  # Associate the custom options with custom_scorefxn only
custom_scorefxn.set_weight(pyrosetta.rosetta.core.scoring.score_type_from_name("mhc_epitope"), 0.5)  # Will apply to custom_scorefxn, but not default_scorefxn.
```

##See Also

* [[AddMHCEpitopeConstraintMover]]
* [[mhc-energy-tools]]
* [[Scoring explained]]
* [[Score functions and score types |score-types]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
* [[Design-centric guidance terms|design-guidance-terms]]