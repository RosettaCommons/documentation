## MHC Epitope energy (mhc_epitope)

mhc_epitope is currently under development, and not available in master.
<!--- BEGIN_INTERNAL -->
If you want to try it out, feel free to checkout branch ```BYachnin/mhc-epitope-new``` or Pull Request #3390 (https://github.com/RosettaCommons/main/pull/3390/).  Note that this documentation is incomplete and subject to change.

Documentation created by Brahm Yachnin (brahm.yachnin@rutgers.edu), Khare laboratory and Chris Bailey-Kellogg (cbk@cs.dartmouth.edu).  Parts of this documentation are copied/adapted from Vikram K. Mulligan's (vmullig@uw.edu) design-centric guidance documentation.
Last edited September 3, 2018.

[[_TOC_]]

## Purpose and algorithm

A common problem with therapeutically useful proteins is the immune response to these foreign proteins.  This scoring term iterates through a pose's sequence and identifies immune epitopes based on one of several epitope prediction algorithms.  Any identified epitopes will be penalized in the scorefunction and then designed away by the packer.  This scoring term is intended to work with Alex Ford's changes to the packer that permit fast-to-calculate but non-pairwise-decomposable scoring terms to be used during packing or design.

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
- ```method matrix``` uses a matrix to score each peptide.  For example, the propred matrices can be used to score any peptide without precomputing epitope scores.  ```method matrix propred8``` uses the propred8 scoring matrix for scoring.
- ```method external``` uses a pre-computed, SQL database to score each peptide.  The filename should be to the SQL database.  For example, ```method external yfp_netmhcii.db```.
- Note that additional prediction methods can easily be implemented by writing new MHCEpitopePredictor derived classes.

Subsequent lines in the ```.mhc``` file are optional, and control how scoring is performed.
- ```alleles``` can be used to select a subset of alleles present in your matrix/database to use.  This option is not currently supported, except to select all alleles (the default).  To select all alleles, use ```alleles *```.
- ```threshold``` applies to matrix-based predictors only.  This option sets the threshold above which a peptide is considered a hit.  Default is ```threshold ****```.
- ```unseen``` applies to external predictors only.  As these predictors use an external database that does not necessarily include all possible peptides, this option sets the behavior for any peptide not found in the database (i.e. that is "unseen").  This option can take different handlers, which decide how to handle unseen peptides.  Currently, only ```penalize``` is implemented.   The default is ```unseen penalize ****```.
 - ```penalize``` adds a specific, constant penalty score for any peptide not found in the database, thereby discouraging Rosetta from designing to these sequences.
- ```xform``` transforms the score returned by the predictor.  In any case, if the transformed score is less than 0, a score of 0 is used.  It can run in one of three modes:
 - ```raw``` is the default.  This takes the raw score and subtracts a threshold from it.  The default is ```xform raw ***```.
 - ```relative+``` is a score relative to the native sequence, in additive mode.  The score is calculated as (raw score - native score + score threshold).  For example, ```raw relative+ 5``` means that a score that is 5 units worse than native or better will get a score of 0.
 - ```relative*``` is a score relative to the native sequence, in multiplicative mode.  The score is calculated as (raw score - native score * score threshold).  For example, ```raw relative* 1.2``` means that any score that is 20% higher than native or less will get a score of 0.
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

## How to generate an external database

To do.

## Strategies/guidelines for de-immunization in Rosetta

To do (things like what csts to use, looking at hotspots vs. global, etc.)

## Use with symmetry
The ```mhc_energy``` score term should be fully compatible with symmetry.  Each subunit will contribute to the ```mhc_energy```.

## Organization of the code

- The scoring term lives in ```core/scoring/mhc_energy/MHCEpitopeEnergy.cc``` and ```core/scoring/mhc_energy/MHCEpitopeEnergy.hh```.
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