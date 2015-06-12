#Rotamer Recovery Scientific Benchmark

Introduction
============

Rotamer Recovery measures how far Rosetta's optimal conformation differs from some reference conformation. Along with sequence recovery and ddG prediction, rotamer recovery is one of the major methods of benchmarking the quality of the Rosetta score function.

By specifying a different components, the RotamerRecovery framework can preform a range of tests. In general, recovery tests that have fewer degrees of freedom test Rosetta's accuracy closer to the *native* state and require less optimization, while recovery tests with more degrees of freedom test Rosetta's accuracy farther from the *native* state and require more optimization.

To preform a rotamer recovery test requires providing or specifying the following:

-   A reference structural conformation. For example, an X-ray crystal structure for a protein sequence.
-   **RRProtocol** : the degrees of freedom for the test and how Rosetta should optimize them
-   **RRComparer** : how the predicted conformation should be evaluated
-   **RRReporter** : how the results should be reported

RRProtocol
==========

Each *RRProtocol* has a *run* method that executes one or more optimization procedures using a *ScoreFunction* on a subset of a *pose* restricted by a *PackerTask* , and then uses a *RRComparer* to evaluate the accuracy of the predicted conformaiton and sends the results to a *RRComparer* .

RRProtocolMinPack
-----------------

The *MinPack* protocol predicts the conformation of a subset of sidechain degrees of freedom given a fixed backbone. First, for each residue, a discrete set of 'rotameric' conformations are defined and these are optimized via stochastic MCMC protocol called *PackRotamers* . Then, all the sidechain degrees of freedom are jointly optimized using the gradient based *Minimization* optimization algorithm. At the completion of the *min\_pack* protocol, the recovery of each residue is measured.

RRProtocolPackRotamers
----------------------

The *PackRotamers* protocol predicts the conformation of a subset of sidechain degrees of freedom given a fixed backbone. First, for each residue, a discrete set of 'rotameric' conformations are defined and these are optimized via stochastic MCMC protocol called *PackRotamers* . At the completion of the *PackRotamers* protocol, the recovery of each residue is measured.

RRProtocolRTMin
---------------

The *RTMin* protocol predicts the sidechain conformation of each residue in the *PackerTask* that is *packable* --one at a time--while keeping the conformation of all other residues fixed in their reference conformation. For each residue, the optimization procedure the defines discrete set of *rotameric* conformation states and for each state, the sidechain degrees are jointly optimized using the gradient based *Minimization* optimization algorithm and the recovery is reported.

RRProtocolRotamerTrials
-----------------------

The *RotamerTrails* protocol predicts the sidechain conformation of each residue in the *PackerTask* that is *packable* --one at a time--while keeping the conformation of all other residues fixed in their reference conformation. After optimizing each residue in turn, the recovery is reported.

RRProtocolMover
---------------

A *Mover* is a generic protocol that takes a *Pose* and applies an operation to it. Since movers are composable and build into the *RosettaScripts* framework, this can be a flexible way to specify a preform a variety of optimizaiton protocols. Once the *Mover* has been applied, the recovery of each residue is measured.

RRComparer
==========

Each *RRComparer* measures the divergence between two *Residues* each in their own *Pose* . The information returned is a real valued *score* and a boolean valued *recovered* variable. Being a divergence score, 0 means perfectly recovered and increasingly positive values mean worse recovery. When a rotamer is considered as recovered when the score is below a specified threshold.

RRComparerRotBins
-----------------

For each of the two residues, the torsional degrees of freedom are mapped to discrete *rotameric* conformation states. Then identity of the rotamer bin for each sidechain angle are compared, one at a time, until they do not match. The score is the number of bins that did not match and the rotamer is *recovered* if all of the bins do match.

Note: The definitions of the rotamer bins is defined by the Dunbrack libraries in the path/to/rosetta/main/database. See for example the *-corrections::score::dun10* flag. Since the rotamer bins depend on the rotamer library used, this score is not meaningful results across different rotamer libraries.

Note: Currently this comparer will fail if the residues are not the same canonical amino acid.

RRComparerAutomorphicRMSD
-------------------------

The RMSD between two sets of atoms each with a labeling that pairs of the atoms is the square root of the sum of the squares of the distances between the atoms in each pair. An automorphism of a residue is a relabeling of the names of the atoms that has the same chemical identity and atomic conformation. The *automorphic\_rmsd* between two residue conformations is the minimum of RMSD over all automorphisms of each residue conformation. Since RMSD is computed over all atoms, this comparer will usually have greater values for residue types that have more atoms, so care must be taken when interpreting the results.

Note: Currently this comparer will fail if the residues are not the same canonical amino acid.

RRComparerChiDiff
-----------------

The chi difference score between two side chain conformations is the maximum over the angle differences for each of the torsional angles. Since the angles are radians, the range of scores is between zero and pi. An asset of this comparer is that the score range does not depend on the number of chi angles for the amino acid type. A limitation of this comparer is that torsional angles that make compensating variation are treated equally as bad as torsional angles that have amplifying variation.

For protein sidechains with symmetry, the chi-diff is relative to the closest symmetric version. For example, flipping the last chi angle for ASP will result in a chi-diff of 0.

RRReporter
==========

Each *RRReporter* collects recovery statistics and reports either the full or summarized resulsts of the test.

RRReporterSimple
----------------

The *RRReporterSimple* reporter only keeps track of the number of residues considered for recovery and number of residues that were actually recovered. This reporter can be used, for example, if the rotamer recovery is used as a criteria for optimizing a prediction protocol or ScoreFunction and little textual information is needed.

RRReporterHuman
---------------

The *RRReporterHuman* reports back a human readable table summarizing the rotamer recovery results.

The rotamer recovery will be output to the screen. Output looks like:

    # native_structure_tag1                                                                                                                                                                                                                   
    # total = 30                                                                                                                                                                                                                              
       resi_idx  nat_bb_bin      pct_bb    nat_rot1    pct_rot1    nat_rot2    pct_rot2    nat_rot3    pct_rot3    nat_rot4    pct_rot4                                                                                                       
              1           E      1.0000           1      1.0000           2      1.0000           1      1.0000         999      0.0000                                                                                                       
              2           B      1.0000           2      1.0000           1      1.0000         999      0.0000         999      0.0000                                                                                                       
       ...                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                              
    # native_structure_tag2                                                                                                                                                                                                                   
    # total = 30                                                                                                                                                                                                                              
       resi_idx  nat_bb_bin      pct_bb    nat_rot1    pct_rot1    nat_rot2    pct_rot2    nat_rot3    pct_rot3    nat_rot4    pct_rot4                                                                                                       
              1           E      1.0000           1      1.0000           2      1.0000           1      1.0000         999      0.0000                                                                                                       
              2           B      1.0000           2      1.0000           1      1.0000         999      0.0000         999      0.0000                                                                                                       
       ...                                                                                                                                                                                                                                    

Where the \# total is how many proteins compared.

-   resi\_idx = residue index
-   nat\_bb\_bin = dssp naming for bb
-   pct\_bb = fraction matching backbone bins
-   nat\_rot1 = chi 1
-   pct\_rot1 = fraction matching chi bins
-   If 999 appears, that means that the amino acid does not have that chi angle

RRReporterSQLite
----------------

The *RRReporterSQLite* reporter writes the recovery data to an sql database for further analysis. The following output formats are available can be specified:

-   **full** : Record all information about the rotamer recovery test
    -   **struct\*\_name** , **chain\*** , **res\*** : How the reference and predicted residues are identified.
    -   **protocol\_name** , **protocol\_params** : Information about the *RRProtocol*
    -   **comparer\_name** , **comparer\_params** : Informaiton about the *RRComparer*
    -   **score** , **recovered** : The *score* positive real number and *recovered* bool from the *RRComparer*

<!-- -->

        CREATE TABLE IF NOT EXISTS nchi (
            name3 TEXT,  
            nchi INTEGER,
            PRIMARY KEY (name3));

        INSERT OR IGNORE INTO nchi VALUES('ARG', 4);
        INSERT OR IGNORE INTO nchi VALUES('LYS', 4);
        INSERT OR IGNORE INTO nchi VALUES('MET', 3);
        INSERT OR IGNORE INTO nchi VALUES('GLN', 3);
        INSERT OR IGNORE INTO nchi VALUES('GLU', 3);
        INSERT OR IGNORE INTO nchi VALUES('TYR', 2);
        INSERT OR IGNORE INTO nchi VALUES('ILE', 2);
        INSERT OR IGNORE INTO nchi VALUES('ASP', 2);
        INSERT OR IGNORE INTO nchi VALUES('TRP', 2);
        INSERT OR IGNORE INTO nchi VALUES('PHE', 2);
        INSERT OR IGNORE INTO nchi VALUES('HIS', 2);
        INSERT OR IGNORE INTO nchi VALUES('ASN', 2);
        INSERT OR IGNORE INTO nchi VALUES('THR', 1);
        INSERT OR IGNORE INTO nchi VALUES('SER', 1);
        INSERT OR IGNORE INTO nchi VALUES('PRO', 1);
        INSERT OR IGNORE INTO nchi VALUES('CYS', 1);
        INSERT OR IGNORE INTO nchi VALUES('VAL', 1);
        INSERT OR IGNORE INTO nchi VALUES('LEU', 1);
        INSERT OR IGNORE INTO nchi VALUES('ALA', 0);
        INSERT OR IGNORE INTO nchi VALUES('GLY', 0);


        CREATE TABLE IF NOT EXISTS rotamer_recovery (
            struct1_name TEXT,
            name1 TEXT,
            name3 TEXT,
            residue_type TEXT,
            chain1 TEXT,
            res1 INTEGER,
            struct2_name TEXT,
            chain2 TEXT,
            res2 INTEGER,
            protocol_name TEXT,
            protocol_params TEXT,
            comparer_name TEXT,
            comparer_params TEXT,
            score REAL,
            recovered BOOLEAN,
            PRIMARY KEY (struct1_name, chain1, res1, struct2_name, chain2, res2));

-   **features** : Record the minimal yet complete amount of information for the rotamer recovery test.
    -   **struct\_id** , **resNum** : These are the primary keys for the *residues* table in the ResidueFeatures reporter
    -   **divergence** : This is the *score* that the *RRProtocol* returns.

<!-- -->

        CREATE TABLE IF NOT EXISTS nchi (
            name3 TEXT,  
            nchi INTEGER,
            PRIMARY KEY (name3));

        INSERT OR IGNORE INTO nchi VALUES('ARG', 4);
        INSERT OR IGNORE INTO nchi VALUES('LYS', 4);
        INSERT OR IGNORE INTO nchi VALUES('MET', 3);
        INSERT OR IGNORE INTO nchi VALUES('GLN', 3);
        INSERT OR IGNORE INTO nchi VALUES('GLU', 3);
        INSERT OR IGNORE INTO nchi VALUES('TYR', 2);
        INSERT OR IGNORE INTO nchi VALUES('ILE', 2);
        INSERT OR IGNORE INTO nchi VALUES('ASP', 2);
        INSERT OR IGNORE INTO nchi VALUES('TRP', 2);
        INSERT OR IGNORE INTO nchi VALUES('PHE', 2);
        INSERT OR IGNORE INTO nchi VALUES('HIS', 2);
        INSERT OR IGNORE INTO nchi VALUES('ASN', 2);
        INSERT OR IGNORE INTO nchi VALUES('THR', 1);
        INSERT OR IGNORE INTO nchi VALUES('SER', 1);
        INSERT OR IGNORE INTO nchi VALUES('PRO', 1);
        INSERT OR IGNORE INTO nchi VALUES('CYS', 1);
        INSERT OR IGNORE INTO nchi VALUES('VAL', 1);
        INSERT OR IGNORE INTO nchi VALUES('LEU', 1);
        INSERT OR IGNORE INTO nchi VALUES('ALA', 0);
        INSERT OR IGNORE INTO nchi VALUES('GLY', 0);

        CREATE TABLE IF NOT EXISTS rotamer_recovery (
            struct_id INTEGER,
            resNum INTEGER,
            divergence REAL,
            recovered INTEGER,
            PRIMARY KEY(struct_id, resNum));

Rotamer Recovery Scientific Benchmark
=====================================

There are two versions of the rotamer recovery scientific benchmark:

Biweekly Rotamer Recovery
-------------------------

The *biweekly* rotamer recovery test is over a set of 54 small monomeric structures and is meant to be run on a single machine and take about an hour.

         #initialize input
         cd Rosetta/main/tests/scientific/biweekly/rotamer_recovery
         svn checkout https://svn.rosettacommons.org/source/trunk/mini.data/tests/scientific/tests/rotamer_recovery/inputs inputs
         cd ../..

         #run test: by default, out is generated in 'biweekly_statistics/'
         ./scientific_biweekly.py [OPTIONS] rotamer_recovery

Available versions:

-   **rotamer\_recovery** :
    -   ScoreFunction: *score12prime*
    -   Protocol: *RRProtocolRTMin* with *ex 1* , *ex 2* , and *extra\_chi 1* [[chi parameters|TaskOperations-RosettaScripts#ExtraRotamersGeneric]] .
    -   Comparer: *RRComparerRotBins*
    -   Reporter: *RRReporterSQLite:Features*

-   **rotamer\_recovery\_correct** :
    -   ScoreFunction: *score12\_w\_corrections*
    -   Protocol: *RRProtocolRTMin* with *ex 1* , *ex 2* , and *extra\_chi 1* [[chi parameters|TaskOperations-RosettaScripts#ExtraRotamersGeneric]] .
    -   Comparer: *RRComparerRotBins*
    -   Reporter: *RRReporterSQLite:Features*

-   **rotamer\_recovery\_sp2** :
    -   ScoreFunction: *sp2\_correction*
    -   Protocol: *RRProtocolRTMin* with *ex 1* , *ex 2* , and *extra\_chi 1* [[chi parameters|TaskOperations-RosettaScripts#ExtraRotamersGeneric]] .
    -   Comparer: *RRComparerRotBins*
    -   Reporter: *RRReporterSQLite:Features*

Features Rotamer Recovery
-------------------------

The *features* rotamer recovery is meant to be run on a large set of native conformations, such as the top8000 set from the Richardson's lab, on a computer cluster. Here, the computed the rotamer recovery results and additional structural features are extracted to a relational database, which can be used to classify and analyze patterns of rotamer recovery. See the features documentation for detailed instruction for how to [[run the features scientific benchmark|FeaturesTutorialRunSciBench]] .

#### This directory no longer exists

        cd Rosetta/main/tests/features/sample_sources/top8000_rotamer_recovery_score12prime_MinPack
        # follow directions in README.txt and input/README.txt to initialize input
        # check the sample source configuration.
        cd ..
        
        # add 'top8000_rotamer_recovery_score12prime_MinPack' to benchmark.list
        cd ..

        #submit jobs to cluster
        ./features.py [OPTIONS] submit

rotamer\_recovery application
=============================

The rotamer recovery application is a stand alone method for measuring the rotamer recovery for a set of native structures.

       Rosetta/main/source/bin/rotamer_recovery.<platform><compiler><mode> \
            -database Rosetta/main/database/ > \
            [Additional options]
            -l <inputs.list> \
            -rotamer_recovery:protocol <RRProtocol> \
            -rotamer_recovery:comparer <RRComparer> \
            -rotamer_recovery:reporter <RRReporter> \
            -out:file:rotamer_recovery <results_output_file>

RotamerRecoveryMover
====================

RotamerRecoveryFeatures
=======================
