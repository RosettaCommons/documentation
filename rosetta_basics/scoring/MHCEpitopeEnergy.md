## MHC Epitope energy (mhc_epitope)

mhc_epitope is currently under development, and not available in master.
<!--- BEGIN_INTERNAL -->
If you want to try it out, feel free to checkout branch ```BYachnin/mhc-epitope-new``` or Pull Request #3390 (https://github.com/RosettaCommons/main/pull/3390/).  Note that this documentation is incomplete and subject to change.

Documentation created by Brahm Yachnin (brahm.yachnin@rutgers.edu), Khare laboratory, and Chris Bailey-Kellogg (cbk@cs.dartmouth.edu).  Parts of this documentation are copied/adapted from Vikram K. Mulligan's (vmullig@uw.edu) design-centric guidance documentation.
Last edited October 22, 2018.

[[_TOC_]]

## Purpose and algorithm

A major obstacle to the clinical application of proteins with potentially beneficial therapeutic functions is the fact that macromolecules are subject to immune surveillance, and initial recognition of a therapeutic protein via antigen presenting cells and T cells can lead to a potent antidrug antibody response that can reduce efficacy or even cause life-threatening complications ([Griswold+2016](https://www.ncbi.nlm.nih.gov/pubmed/27322891)). A key step in the development of this immune response is the binding by MHC molecules of peptides that have been proteolytically processed from the protein. The premise behind deimmunization by epitope deletion is that mutagenic modification of the protein to reduce recognition of its constituent peptides by MHC can forestall the activation of T cells that in turn provide help in the development of potent antidrug antibodies. The maturation of computational predictors of MHC binding, combined with methods to evaluate and optimize the effects of mutations on protein structure and function, have enabled the development and successful application of computationally-directed protein deimmunization methods, using both Rosetta ([Choi+2013](https://www.ncbi.nlm.nih.gov/pubmed/23299435), [King+2014](https://www.ncbi.nlm.nih.gov/pubmed/24843166)) and other protein design platforms ([Parker+2013](https://www.ncbi.nlm.nih.gov/pubmed/23384000), [Zhao+2015](https://www.ncbi.nlm.nih.gov/pubmed/26000749), [Salvat+2017](https://www.ncbi.nlm.nih.gov/pubmed/28607051), etc.).

Rosetta readily supports epitope deletion by incorporating into its scoring an evaluation of the epitope content of a protein sequence. This then naturally enables packing and design to be pushed toward sequences with reduced epitope content. The mhc_epitope scoring term supports this process by leveraging Alex Ford's changes to the packer that support the use of fast-to-calculate but non-pairwise-decomposable scoring terms. The mhc_epitope term is computed by iterating over the constituent peptiders of a pose's sequence and applying one (or more) of several epitope prediction algorithms to independently evaluate each peptide. When considering a proposed mutation, the scoring term only reevaluates the contributions of those peptides containing the mutation. In addition to supporting global evaluation and design of epitope content, mhc_epitope can be differentially applied to distinct regions (e.g., focusing on identified or predicted "hot spots") by employing it as a constraint to residues defined by selectors.

## Epitope prediction

An epitope predictor takes as input a peptide and returns an evaluation of its relative risk to bind MHC, typically as some form of predicted binding affinity or as a relative rank with respect to a distribution (see e.g., [Wang+2008](https://www.ncbi.nlm.nih.gov/pubmed/18389056)). The predictions are specific to the MHC allele, and while there are thousands of different alleles, due to their degeneracy in peptide binding, a relatively small representative set can be used to capture population diversity (e.g., [Southwood+1998](http://www.ncbi.nlm.nih.gov/pubmed/9531296), [Greenbaum+2011](https://www.ncbi.nlm.nih.gov/pubmed/25862607), [Paul+2015](https://www.ncbi.nlm.nih.gov/pubmed/25862607)). The core unit of MHC-II binding is 9 amino acids, defined by the MHC-II groove and the pockets in which is accommodates peptide side chains. The overhanging amino acids can also contribute. Some epitope predictors focus on just the core 9mer, while others use longer peptides (15mers) in order to capture overhangs as well as capture the combined effect of multiple binding frames/registers as the core 9mer slides up and down the groove.

Since epitope content is repeatedly evaluated during the course of design (for multiple peptides for each proposed mutation), mhc_epitope must be efficient in its use of epitope prediction. One way to do this is with a position-specific scoring matrix, e.g., the pocket profile method Propred ([Singh+2001](http://www.ncbi.nlm.nih.gov/pubmed/11751237)) which was based on TEPITOPE ([Sturniolo+1999](https://www.ncbi.nlm.nih.gov/pubmed/10385319)). The current implementation includes the [Southwood+1998](http://www.ncbi.nlm.nih.gov/pubmed/9531296) representative set of Propred matrices, downloaded from the [Propred site](http://crdd.osdd.net/raghava/propred/) courtesy of Dr. Raghava. Another way to enable efficient epitope prediction within the design loop, even when an external stand-alone program must be invoked, is to precompute and cache predictions. The current implementation supports this by using a sqlite database of predicted epitopes, which can be precomputed (e.g., using NetMHCII ([Jensen+2018](https://www.ncbi.nlm.nih.gov/pubmed/29315598))) using python scripts described below. There are also plans to incorporate the SVM method previously developed by ([King+2014](https://www.ncbi.nlm.nih.gov/pubmed/24843166)) for Rosetta-based deimmunization.

## User control

This scoring term is controlled by ```.mhc``` files, which define the desired residue type composition of a protein.  The ```.mhc``` file is passed to scorefunction using the ```<Set>``` tag in the scorefunction:
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

Each ```.mhc``` file should begin with a ```method``` line.  The syntax is the keyword ```method```, followed by the prediction method, and then by the input filename.  There are two prediction methods currently supported:
- ```method matrix``` uses a matrix to score each peptide.  For example, the propred matrices can be used to score any peptide without precomputing epitope scores.  ```method matrix propred8``` uses the propred8 scoring matrices (i.e., the 8 representative alleles mentioned above)
- ```method external``` uses a pre-computed, sqlite database to score each peptide.  The filename should be that of the sqlite database.  For example, ```method external yfp_netmhcii.db```.
- Note that additional prediction methods can easily be implemented by writing new MHCEpitopePredictor derived classes.

Subsequent lines in the ```.mhc``` file are optional, and control how scoring is performed.
- ```alleles``` can be used to select a subset of alleles present in your matrix/database to use.  This option is not currently supported, except to select all alleles (the default).  To select all alleles, use ```alleles *```.
- ```threshold``` applies to matrix-based predictors only.  This option sets the percentile cutoff for binding that is considered a hit.  For example, a threshold of 2 means that the top 2% of binders are hits.  Default is ```threshold 5.0```.  For Propred matrices (currently the only supported matrix type), threshold must be an integer from 1-10.
- ```unseen``` applies to external predictors only.  As these predictors use an external database that does not necessarily include all possible peptides, this option sets the behavior for any peptide not found in the database (i.e. that is "unseen").  This option can take different handlers, which decide how to handle unseen peptides.  Currently, only ```penalize``` is implemented.   The default is ```unseen penalize 100```.
 - ```penalize``` adds a specific, constant penalty score for any peptide not found in the database, thereby discouraging Rosetta from designing to these sequences.  The default (```unseen penalize 100```) adds 100 to the score if an unknown peptide is encountered.
- ```xform``` transforms the score returned by the predictor.  In any case, if the transformed score is less than 0, a score of 0 is used.  It can run in one of three modes:
 - ```raw``` is the default.  This takes the raw score and subtracts an offset from it.  The default is ```xform raw 0```.
 - ```relative+``` is a score relative to the native sequence, in additive mode.  The score is calculated as (raw score - native score + offset).  For example, ```raw relative+ 5``` means that a score that is 5 units worse than native, or better, will get a score of 0.
 - ```relative*``` is a score relative to the native sequence, in multiplicative mode.  The score is calculated as (raw score - native score * factor).  For example, ```raw relative* 1.2``` means that any score that is at most 20% higher than native will get a score of 0.
 - Note that the "native" sequence is the sequence when the packer first starts, not the sequence as read in.  A protocol that uses multiple movers will see its "native" sequence change throughout the protocol.

### Examples of ```.mhc``` files

This is the ```.mhc``` file provided with Rosetta (```database/scoring/score_functions/mhc_epitope/propred8_5.mhc```).  This will use the provided ProPred matrices (```database/scoring/score_functions/mhc_epitope/propred8.txt```) with a threshold of 5:
```
method matrix propred8
alleles *
threshold 5
```

This is a ```.mhc``` file that uses an external database provided by the user.  Any peptide encountered by the packer that is not found in the database will be assigned a score penalty of 100.
```
method external user_sql_database.db
unseen penalize 100
```

## MHCEpitope Constraints

A ```.mhc``` setup file passed to the scorefunction in ```<SCOREFXNS>``` block will be applied to the entire pose.  It is possible that in addition/instead of applying the ```.mhc``` setup to the entire pose, you would want to target specific regions that, for example, those that are known or predicted to be highly immunogenic.  This can be achieved using the [[AddMHCEpitopeConstraintMover]], which accepts a ```.mhc``` setup file as well as an optional residue selector and weighting term.  An arbitrary number of [[AddMHCEpitopeConstraintMover]]s can be applied.

If you only want to use constraints to deimmunize your protein, you do not need to pass a ```.mhc``` setup file in the ```<SCOREFXNS>``` section.  Note that you _must still turn on ```mhc_epitope``` term in the scorefunction_ for the constraints to function, even if you do not have a globally applied ```.mhc``` file.

## How to generate an external database

### Why external databases?

Propred, the epitope prediction method that is supplied with Rosetta, can be used to score any peptide sequence "on-the-fly" quickly enough to be usable with the packer.  You may wonder, in that case, why generating an external database is useful.

While Propred remains a very useful epitope prediction tool, it is nearly 20 years old, and better/more sophisticated epitope prediction methods are now available.  NetMHCII, the other predictor primarily supported by the ```mhc_energy_tools```, requires the use of an external executable to predict epitopes in a peptide.  As such, it is much too slow for "on-the-fly" use with the packer.

In order to compromise between having packer-speed epitope prediction and a state-of-the-art predictor, ```mhc_epitope``` supports the use of an external database that can be pre-computed with relevant peptides for your protein of interest.  Because the peptide length is 15 residues, clearly a subset of all possible residues must be chosen, and only specific regions of the protein can be considered.  We recommend that you use a PSIBLAST-generated PSSM to determine likely substitutions to consider, and generate a database containing all of those peptides using the provided ```db.py``` tool.  In this way, you can target the hotspots in your protein using NetMHCII, and use Propred to score the rest of the protein.

Alternatively, hand-picked substitutions can be listed using a CSV format, or a PSSM could be derived in another way.  Virtually any sensible method of restricting design space (computational or experimental) could be appropriate, depending on your circumstance.  The goal is to arrive at a subset of residue identities that are unlikely to "break" the protein during de-immunization.  We recommend PSIBLAST as a general solution as it is applicable to any protein target, but it is by no means the only option.

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

Once you have a PSSM (or other way of determining what sequences to look at), you need to generate your database using ```db.py```, located in ```tools/mhc_energy_tools/```.  For complete documentation of these tools, see ******.

Note that you will probably want to use this in the "constraint" mode to look at the hotspot regions in your protein, as making a database to cover the entire protein sequence is likely prohibitively expensive.  To cover non-hotspot regions, the Propred matrices are probably sufficient to ensure that the immunogenicity stays low.

Assuming you want to use NetMHCII as your predictor, you will first need to download and install NetMHCII (http://www.cbs.dtu.dk/cgi-bin/nph-sw_request?netMHCII), and set the environment variable ```NMHOME``` to the location of the NetMHCII binary.

Especially when using a PSSM, you need to be very careful to avoid a combinatorial explosion of peptides to process.  Consider the following advice:

-Select only those regions you have previously determined to have strong binding, and keep those regions as small as possible (minimum 15, the peptide length).  Use the ```--positions``` and ```--lock``` parameters to identify only the regions you want to target from the PSSM.

-The default ```--pssm_thresh``` value is 1, which effectively means that any residue that appears more than would be expected at random will be sampled.  Increasing this number to 2 or even 3 will greatly decrease the number of peptides to sample.  The downside, though, is that you shrink your possible design space.  (Typically, you will penalize any sequence not present in the database using the ```unseen penalize``` parameter in the ```.mhc``` file.)

-Of the three sets of alleles to test, the ```paul15``` set is smaller than the ```greenbaum11``` set and may be almost as good.  This decreases the amount of time it takes for each peptide.

As an example, this might be how you want to generate your database, assuming your protein sequence is in a file ```sequence.fas```, your PSSM is in ```pssm.txt```, and you want to look at the sequences 15-31 and 90-110:
```
db.py --fa sequence.fas --positions 15-31,90-110 --pssm pssm.txt --pssm_thresh 2 --peps_out list_of_peptides.txt --netmhcii --allele_set paul15 mydatabase.db
```

If you want to also generate a resfile to limit design space in those regions that are not covered by the database, you can use the following (assuming the protein is chain A):
```
db.py --fa sequence.fas --positions 15-31,90-110 --pssm pssm.txt --pssm_thresh 2 --peps_out list_of_peptides.txt --netmhcii --allele_set paul15 --chain A --res_out myresfile.res mydatabase.db
```

Note that a database can also be used to provide experimentally known epitopes, for which a high penalty can be imposed.

## Strategies/guidelines for deimmunization in Rosetta

To do (things like what csts to use, looking at hotspots vs. global, etc.)

## Use with symmetry
The ```mhc_energy``` score term should be fully compatible with symmetry.  Each subunit will contribute to the ```mhc_energy``` (though for efficiency, the calculation is performed only on the asymmetric units and scaled appropriately).

## Organization of the code

- The scoring term lives in ```core/scoring/mhc_energy/MHCEpitopeEnergy.cc``` and ```core/scoring/mhc_energy/MHCEpitopeEnergy.hh```.
- The term handles the updating of energies upon proposed mutation, calling an epitope predictor for affected peptides. The base class for epitope prediction is ```core/scoring/mhc_energy/MHCEpitopePredictor.hh```, and current implementations include ```core/scoring/mhc_energy/MHCEpitopePredictorMatrix.cc``` and ```core/scoring/mhc_energy/MHCEpitopePredictorExternal.cc```. The core method for an epitope predictor is ```score()```, which takes a peptide string and returns a score.
- Like any whole-body energy, the MHCEpitopeEnergy class implements a ```finalize_total_energy()``` function that takes a pose.  This calculates the score.  Internally, it calls ```full_rescore()```, which takes a vector of owning pointers to Residues (which can be called directly during packing).
- On initialization, the term creates an internal MHCEpitopeEnergySetup object that stores the user-defined settings from the ```.mhc``` file.  This class is defined in ```core/scoring/mhc_energy/MHCEpitopeEnergySetup.cc``` and ```core/scoring/mhc_energy/MHCEpitopeEnergySetup.hh```.  MHCEpitopeEnergySetup objects can also be stored in MHCEpitopeConstraint associated with a Pose.  At scoring or packing time, the MHCEpitopeEnergy constructs a vector of owning pointers to its internal MHCEpitopeEnergySetup objects and to all those stored in the pose, and uses all of these for scoring.
- A ```.mhc``` file is located in ```/database/scoring/score_functions/mhc_epitope/```.

##See Also

* [[Scoring explained]]
* [[Score functions and score types |score-types]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
* [[Design-centric guidance terms|design-guidance-terms]]
* [[AddMHCEpitopeConstraintMover]]
<!--- END_INTERNAL -->