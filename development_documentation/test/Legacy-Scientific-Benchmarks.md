Scientific Benchmarks
=====================

# **THIS PAGE CONTAINS LEGACY INFORMATION ABOUT SCIENTIFIC TESTS BEFORE THEY WERE RE-IMPLEMENTED IN 2018**

See [[Scientific Benchmarks]] for information about the current set of scientific benchmarks

----

Scientific Benchmarks are tests that compare Rosetta generated structure
predictions with experimental observations. Assessing the accuracy of
Rosetta predictions will

-   Inform researchers on the trustworthiness of Rosetta as a molecular
    modeler
-   Guide tuning Rosetta to improve structural predictions

Scientific benchmarks are meant to measure the physical realism of the
energy function and how well a protocol is at sampling physically
realistic structures.

Scientific Benchmarks
=====================

Types of Scientific Benchmarks
------------------------------

There are two types of scientific benchmarks:

-   **Biweekly Scientific Benchmarks**:
    - *Note that in practice, biweekly benchmarks are run at best effort (repeatedly when they finish).
    -   These are meant to be either:
        -   unit tests that can catch bugs and unintended changes to the
            energy function and protocols that cannot be detected by the
            integration tests because of run to run variation.
        -   fast tests of energy function / protocol predictive
            accuracy.
    -   These tests take less than 128 hours to run on a single CPU and are run on a regular basis.
    -   Biweekly tests can be found in main/tests/scientific/biweekly/.  They are organized in a similar way to [[integration tests]].

    -   ----------------------------
    -   [[Detailed Balanced|DetailedBalanceScientificBenchmark]]
    -   RNA de novo
    -   RNA Design
    -   [[Rotamer Recovery|RotamerRecoveryScientificBenchmark]]
    -   Sequence Recovery
    -   ab initio
    -   [[Docking|DockingScientificBenchmark]]
    -   DNA Interface Design
    -   [[Features|FeaturesScientificBenchmark]]
    -   Ligand Docking
    -   Loop
    -   Membrane
    -   Relax

-   -   ----------------------------

-   **Cluster Scientific Benchmarks** (Energy Function Scientific Benchmarks): These are meant to test
    the quality of an energy function across a broad set of tests that
    represent realistic scientific prediction protocols. They are
    intended to be run by a researcher who wants to test a candidate
    energy function for becoming the standard energy function in
    Rosetta.

    -   These tests are found in main/tests/scientific/cluster/.
    -   Unlike biweekly tests, these tests must provide two bash scripts instead of one:
    	- The "submit" script is called first and is expected to prepare and submit the 
	appropriate number of jobs to run your test and then exit.
	- The "analyze" script runs after these jobs are finished. It creates the proper log
	file and yaml file and places them in the "/output" folder. Any additional files that you
	want to save as "results" should also be saved there.
    -   Each test should be able to run in less than 50,000 cpu hours
    -   ----------------------------
    -   LoopHash decoy discrimination
    -   Ligand Docking
    -   Relax into electron density
    -   Flexible peptide docking
    -   Flexible monomer design
    -   Single mutant scan
    -   Loop prediction
    -   NMR

Usage
=====

### How to Create a Local Scientific Benchmark

*If your test requires you to create a new application, please commit it to this location: source/src/apps/benchmark/scientific/*

​1) Create a folder in main/test/scientific/tests/\<test\_name\>.  
   Each individual test can have the following subdirectories:
-   /input : stores all input data. 
-   /output : stores important output data. Contents of this folder will stored along with log and yaml in the database and will be accessible from the web.
-   /tmp : place for temporary files (like \~1000 decoys, if you need it). Contents of this folder will be ignored by the testing daemon and not stored anywhere. (You can store temp files in /input too if you really need too, just make sure it is not overwriting any input files).
   
​2) Collect a small sample of experimental data such as crystal
structures, NMR data for the new test.

​3) Write a script called 'command' that generates structure predictions
and/or processes the input structures and experimental data to generates
raw results.

​4) Write another script to analyze the results from step 3) to generate
numerical statistics and/or plots. Have this analysis script write a
file **.results.yaml**, which contains valid yaml text and have at least
one boolean field, '\_isTestPass'. Here is an example

       { 'rotamer_recovery_rate_at_all_positions' : .37, '_isTestPass' : True }

With this file, when tests are run on the Testing Server, the results
can be processed and reported on the testing web page.

Also have the analyze script write a file **.results.log**, to contain human-readable text-based results. The contents
of this file will be appended to the Nightly Tests email sent to the
*Rosetta-logs* mailing list.

### How To Run Local Scientific Benchmarks

To run the local scientific benchmarks, go to test/scientific and
execute

      scientific.py -d path/to/database -j<num_processors>

This will generate for each test a directory
test/scientific/statistics/\<test\_name\> containing protocol log
information, statistics and plots. Each test should take about an hour
to run. Additionally, each test is run regularly on the Testing Server
with possibly more extensive input or a more extensive protocol.

### How to Create a Cluster Scientific Benchmark

​1) Put together a more extensive input dataset or put together
parameters for more a extensive protocol that can be used when the test
is run on the Testing Server cluster at JHU.

​2) Add input data to
[mini.data](https://svn.rosettacommons.org/trac/browser/trunk/mini.data#tests/scientific)
as needed.

​3) Tell sergey to create the symbolic link for the test so it will
automatically run on the Testing Server

​4) Monitor the results of the testing server and verify that the new
test is running correctly.

Scorefunction Benchmarking
==========================

Rotamer Recovery (ONE)
----------------------

**Creator Name:** Matthew O'Meara

**Prediction Task / Description:** Given the native conformation of a
whole structure except for a single sidechain, predict the conformation
of the sidechain. [[Rotamer Recovery Benchmark|RotamerRecoveryScientificBenchmark]]

**Experimental Data Used:** The input structures is a selection of the
Richardson's Top5200 dataset. The Top5200 set was constructed as
follows. Daniel Keedy and others the Richardson Lab clustered all
structures in the PDB on April 5th 2007 into 70% sequence homology
clusters. Each structure with resolution 2.2A or better and was not
filtered by hand was run through MolProbity. Then from each group the
structure with the best average resolution and MolProbity score was
selected provided it had resolution at least 2.0A. All structures from
the Top5200 having between 50 and 200 residues and resolution less than
1.2A were selected for this benchmark. This leaves 152 structures with
17463 residues.

**How to interpret the results:** Using the
[[ChiDiff|RotamerRecoveryScientificBenchmark#RRComparerChiDiff]]
comparison, the score is the maximum over the angle differences for each
of the torsional angles. A residue is considered recovered if all angles
differences are less than 20. The reported scores include:

-   the average recovery over all residues
-   the average recovery for each amino acid type
-   the average recovery for buried (23 \< \#10A\_nbrs), intermediate(17
    \<= \#10A\_nbrs \< 23) and exposed (\#10A\_nbrs \< 17)
-   the average recovery for each amino acids for each burial level

Significance is determined by a permutation test or bootstrap analysis.

**Preliminary Results:** See [Leaver-Fay et al., Methods in Enzymology
2013](http://www.sciencedirect.com/science/article/pii/B9780123942920000060)

**Caveats:** ...

**Approximate computational cost:** ...

**How to run:** ...

Protein stability prediction (DDG)
----------------------------------

**Creator Name:** This will be a joint effort. Shane O'Connor, Kortemme
Lab will admin the benchmarking system.

**Prediction Task / Description:** Given experimental DDG measurements
in protein stability assays, predict the DDG in Rosetta.

**Experimental Data Used:** Our set of experimental data mainly comes
from the extensive ProTherm database, Kyushu Institute of Technology,
Japan. A smaller number of records come from [Guerois et
al.](http://www.ncbi.nlm.nih.gov/pubmed/12079393) and [a paper on
Rosetta DDG protocols](http://www.ncbi.nlm.nih.gov/pubmed/21287615) by
Liz Kellogg, Andrew, and David Baker. At present, we have three curated
sets which take different subsets (sometimes using average values over
multiple experiments with the same protein/mutation) of the total set of
DDG values. These curated sets were compiled by Guerois et al., Kellogg
et al., and [Potapov et
al.](http://www.ncbi.nlm.nih.gov/pubmed/19561092). Other curated sets
exist in the literature which we hope to incorporate in time.

We will define our own curated datasets for the shootout. Details will
be posted when the sets are concretely defined although I expect there
to be a large overlap with the datasets above. The Guerois set has just
under 1,000 different point mutations, the Kellogg set has @1,200, the
Potapov set has @2,100. The entire set of point mutations and associated
DDG values stored in our database is around the order of 4,000.

**How to interpret the results:**

Analysis is run using a Python package. At present, we have basic
analysis scripts which generate scatter plots of experimental vs
predicted values and compute the Pearson correlation coefficient and
mean absolute error values. More refined analysis (large-to-small
mutations, mutations to x, etc.) as well as more statistical measures
will be added.

**Preliminary Results:** None as yet.

**Caveats:** Currently requires an SGE cluster to run (see below).

**Approximate computational cost:** No useful data at present. We
currently run predictions using protocol 16 from the Kellogg et al.
paper on a Sun Grid Engine cluster. We measure time from job start in
our scheduler to job completion which includes the cluster wait time as
well as computational time. This could be refined. As well as score
function changes, we aim to test different protocols for the shootout so
times may vary.

**How to run:**

We run the jobs using a Python scheduler which communicates with a MySQL
database and submits jobs to the SGE cluster. The scheduler takes care
of intermediate steps (file-passing and command-line argument values
between steps in the protocol). This is not currently portable to labs
who do not have access to an SGE cluster so this backend be abstracted
in the future. Analysis is run using a simple API (in Python) to the
database, calling R to generate PDF output.

To avoid the necessity of using a MySQL database, one possibility is to
dump the relevant data to an SQLite database which would be easier to
set up. However, this would require adding a database abstraction layer
into our code which is currently not present.

Scientific benchmark fragmentset setup
======================================

Fragment sets, or infile sets, live in the BENCH\_HOME/fragments
directory. Each fragment set has to be in a separate directory. A
benchmark type specific directory structure is neccessary in these
fragment set directories. See below for details. Once the directories
are setup, the fragment set has to be imported into the database. This
is (currently) done each time anybody loads the fragment overview page
(accessible from the main menu) - only the fragment set is imported.
Edit the newly imported fragment set - it needs a description and a
benchmark type. Once the fragment set is setup, import the fragments by
the command bench.pl -mode fragment -submode insert\_fragmentset -id
\<id\> where \<id\> is the fragmentset id.

Ab Initio
---------

A fragment set, say abinitio\_set01
(BENCH\_HOME/fragments/abinitio\_set01) has a 5-letter subdirectory for
each target. In the CVS repository, there is an example, 1a32\_.tbz. To
setup, create the directory BENCH\_HOME/fragments/abinitio\_set01 and
untar the file (tar -xvjf 1a32\_.tbz) in that directory.

##See Also

* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]
* [[RosettaEncyclopedia]]
* [[Glossary]]
