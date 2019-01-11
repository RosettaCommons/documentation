#Features Tutorial: Run Scientific Benchmark

Introduction
============

The **Features Scientific Benchmark** is used to compare batches of structures coming from different sources with respect to local chemical and geometric features. This tutorial describes how to run the features scientific benchmark. The general steps are

1.  For each sample source obtain or generate a batch of structure conformations
2.  For each sample source extract features into a features database
3.  For each analysis script compare 2 or more sample sources

[[_TOC_]]

Database Support Requirements
=============================

The features scientific benchmark stores feature data databases. 

-   **SQLite** : Rosetta is distributed with support for *SQLite3* databases. 
-   **MySQL** , **PostgreSQL** : To use interface with *MySQL* and *PostgreSQL* the appropriate drivers must be compiled into Rosetta. See the [[database input/output|Database-IO]] page for more information.


Generate Feature Databases
==========================

Generating the feature database involves extracting feature information from each structure. Usually this requires specifying the following information

Inputting Structures
--------------------

The coordinates of the structures for used to extract the feature information can be supplied in any format recognized by the *rosetta\_scripts* application.

-   **pdb** :
    -   *-in:path path/to/structures* : the directory containing the pdbs
    -   *-in:file:l \<pdbfile.list\>* : A file containing a list of PDB filenames which hould be processed NOTE: The filenames in the *\<pdbfile.list\>* file will be the *tags* in the *structures* table.
    -   If the structures come from the protein databank, follow the steps to make Rosetta more [[robust to bad input|robust]].

-   **Silent Files** :
    -   *-in:file:silent \<structures.silent\>* : the filename of the silentfile
    -   *-in:file:silent\_struct\_type \<type\>* : the type of the silentfile
    -   *-in:file:tags* : the tags of the structures to be used in the silent file NOTE these will be the *tags* in the *structures* table
    -   *-in:file:tagfile* : the name of a file containing the list of tags for the structures to be used in the silent file NOTE these will be the *tags* in the *structures* table

-   **Database Input** :
    -   *-inout:database\_mode \<mode\>* : Which database backend to use ( *sqlite3* , *mysql* , or *postgresql* ).
    -   *-inout:database\_filename \<database\_name\>* : This is filename of the database for *sqlite3* and the name of the database for *MySQL* and *PostgreSQL* . NOTE: The database where the features are extracted is specified in the \< [[ReportToDB|Movers-RosettaScripts#ReportToDB]] /\> tag in the *rosetta\_scripts* script
    -   *-{postgresql, mysql}:{host, user, password, port}* : information about how to connect with the *MySQL* and *PostgreSQL* databases
    -   *-in:use\_database* : This indicates that the database should be used as input
    -   *-in:select\_structures* : An SQL query to select which structures should be used e.g. "SELECT tag FROM structures WHERE tag= '7rsa';"

Selecting Feature Reporters 
---------------------------


Use the ReportToDB mover with the Rosetta XML scripting to specify which features should be extracted to the features database. (Note: The TrajectoryReportToDB mover can also be used in Rosetta scripts or C++ to report features in trajectory form multiple times to DB for a single output).

Each FeaturesReporter is responsible for extracting a certain type of features to the features database. Select a set [[FeaturesReporters|FeaturesDatabaseSchema]] and then include them as subtags to the ReportToDB mover tag in the *rosetta\_scripts* XML.  See [[this page | Movers-RosettaScripts#ReportToDB]] for more information on the mover beyond what is covered here. The [[SimpleMetricFeatures]] allows the use of ANY [[Simple Metric |SimpleMetrics]] to be output in a features database.


```xml

        <ROSETTASCRIPTS>
            <SCOREFXNS>
                <ScoreFunction name="s" weights="score12_w_corrections"/>
            </SCOREFXNS>
            <MOVERS>
                <ReportToDB name="features" database_name="scores.db3">
                    <ScoreTypeFeatures/>
                    <StructureScoresFeatures scorefxn="s"/>
                </ReportToDB>
            </MOVERS>
            <PROTOCOLS>
                    <Add mover_name="features"/>
            </PROTOCOLS>
        </ROSETTASCRIPTS>

```

-   \<ReportToDB\> tag
    -   _name_ : Mover identifier so it can be included in the PROTOCOLS block of the RosettaScripts

    -   _database_name_ (&string): Name of the output database.  Can also be specified via cmd-line.

    -   _batch_description_ (&string): (Optional) Batch description.  Can also be specified via cmd-line. 

    -   [[Database Connection Options|RosettaScripts-database-connection-options]] : for options of how to connect to the database

    -   _sample\_source_ (&string) : Short text description stored in the *sample\_source* table

    -   _protocol\_id_ (&int) : (optional) Set the *protocol\_id* in the *protocols* table rather than auto-incrementing it.

    -   _task\_operations_ (&task): Restrict extracting features to a relevant subset of residues. Since task operations were designed as tasks for side-chain remodeling, residue features are reported when the residue is "packable". If a features reporter involves more than one residue, the convention is that it is only reported if each residue is specified; however, this feature is supported by every Reporter.

    -   _database_separate_db_per_mpi_process_ (&bool) (Default=false) : For use with [[MPI-Sqlite3 | FeaturesTutorialRunSciBench#extracting-features-in-parallel_mpi ]] Features Reporter running. 

    -   _cache\_size_ (&int) : The maximum amount of memory to use before writing to the database ( [sqlite3 only](http://www.sqlite.org/pragma.html#pragma_cache_size) ).

-   \<feature\> tag (subtag of \<ReportToDB\>)
    -   _name_ : Specify a FeatureReporter to include in database

Running RosettaScripts 
----------------------

Since ReportToDB is simply a mover, it can be included in any Rosetta Protocol. For example, to extract the features from a set of pdb files listed in *structures.list* , and the above script saved in *parser\_script.xml* , execute the following command:

       rosetta_scripts.linuxgccrelease -output:nooutput -l structures.list -parser:protocol parser_script.xml

This will generate an SQLite3 database file *scores.db3* containing the features defined in each of the specified FeatureReporters for each structure in *structures.list* . See the features integration test (rosetta/main/test/integration/tests/features) for a working example.



Extracting Features In Parallel
===============================

The Features Reporters can be run in parallel either through MPI or through a batch-type run.  

MPI
---

For MPI-based runs, make sure to [[ compile MPI-mode Rosetta | Build-Documentation#setting-up-rosetta-3_alternative-setup-for-individual-workstations_message-passing-interface-mpi ]]. 


### Sqlite3

By default, Rosetta is compiled with Sqlite3 Support.  Sqlite3 does not support parallel process writing to one database, so they are split during the MPI run for each processor and merged at the end through a script.  

In order to use MPI with Features runs for Sqlite3 database output, just add <code> -separate_db_per_mpi_process</code> to the command line or add an option to ReportToDB in your xml script, for example:

```xml
<ROSETTASCRIPTS>
	<MOVERS>
		<ReportToDB name=features database_name=example.db3 batch_description=example database_separate_db_per_mpi_process=1>

```
Run Features (for example): <code>mpiexec -np 101 rosetta_scripts.mpi.linuxclangrelease -parser:protocol antibody_features.xml -ignore_unrecognized_res</code>


On completion, merge the databases (see [[merging | FeaturesTutorialRunSciBench#extracting-features-in-parallel_merging]] for more)


### MySQL and PostGres

These work without any additional MPI flags, but you will need compile and run Rosetta with the appropriate flags and drivers.  See the [[database input/output|Database-IO]] page for more information.


Batch
-----

Batch runs can be done by manually partitioning a sample source into batches, generating features database for each batch and merging them together. See the features_parallel integration test (rosetta/main/test/integration/tests/features_parallel) for a working example.

For example if there are 1000 structures split into 4 batches then the scripts for the run processing the first batch would contain:

```xml
       <ReportToDB name=features_reporter db="features.db3_01" sample_source="batch1" protocol_id=1 first_struct_id=1>
          ...
       </ReportToDB>
```

and the script for the run processsing the second batch would contain:

```xml
       <ReportToDB name=features_reporter db="features.db3_02" sample_source="batch2" protocol_id=2 first_struct_id=26>
          ...
       </ReportToDB>
```

On completion, merge the databases (see [[merging | FeaturesTutorialRunSciBench#extracting-features-in-parallel_merging]] for more)

Merging
-------

After the runs are complete, locate the merge.sh script (rosetta/main/test/scientific/cluster/features/sample_sources/merge.sh) and run

       bash /path/to/merge.sh features.db3 features.db3_*

Which will merge the features from each of the *features.db3\_xx* database into *features.db3* .

-   **TIP1** : Merging feature databases should be done for batches of structures that conceptually come from the same sample source. It is best to keep structures coming from different sample sources in separate databases and only during the analysis use the sqlite3 [ATTACH](http://www.sqlite.org/lang_attach.html) statement to bring them together.
-   **TIP2** : Adding the merge script to your $PATH variable is very helpful.
-   **WARNING** : Extracting many databases in parallel generates high data transfer rates. This can be taxing on cluster with a shared file system.

Sample Source Templates
=======================

The features scientific benchmark has sample source templates which are used to setup configuration information to do feature extraction for an input dataset.

Each *sample\_source template* is a folder in *main/tests/features/sample\_sources/* with the following files:

-   **submit.py** : This is a python script that implements and runs a class derived from the *BaseSampleSource* .

Specify which sample sources to use by editing rosetta/main/test/scientific/cluster/features/sample\_sources/benchmark.list. See the [[Sample Sources|FeaturesSampleSources]] page for details about each sample source.\</li\>

Run features scientific benchmark using the features.py script

        Rosetta/main/tests/features/features.py [OPTIONS] [RUN]

### Options for features.py

These are the command line options used to run *features.py*

-   **[ACTION]**
    -   *submit* : Generate feature databases for all sample sources in benchmarks.list
    -   *analyze* : Finalize the databases generated during the submit phase.

-   **[OPTIONS]**
    -   **--run-type** :
        -   *condor* : Run on a condor server
        -   *lsf* : Run on a load sharing facility server (eg you submit jobs with bsub)
        -   *local* : Run as a single process job locally
        -   *dryrun* : Setup files and directories as if it had just finished the action

    -   **--output-dir** : The base directory into which the feature databases will be generated (each sample sources will be in it's own directory).
    -   **--lsf-queue\_name** : The queue in which to submit jobs to (use with the *lsf* run-type
    -   **--num-cores** : How many cores you wish to allocate to running this test
    -   **--mini\_home** : The path to rosetta\_source, with ../../rosetta\_source being default
    -   **--compiler** : The compiler used to compile Rosetta (e.g. gcc, icc, clang), with gcc being default
    -   **--mode** : The mode used to compile Rosetta (e.g. release, debug), with release being default
    -   **--database** : Path to /path/to/rosetta/main/database (it will use the value in \$ROSETTA3\_DB by default)


General Requirements
============

Computational Requirements
--------------------------

The features scientific benchmark can be run locally or on a MPI-based cluster. The computational time and space requirements differ for the different stages of the analysis.

-   **Feature Extraction** : Computational cost and space requirements for extracting features depends upon which *FeaturesReporters* are used. The default features for the *top8000* sample source use \~1Mb per structure.
-   **Feature Analysis** : Each feature analysis script makes a database query and then preforms the analysis. depending on how efficiently the database can be accessed and the complexity of the feature analysis and plot generation, each analysis usually takes between a minute or two to tens of minutes.
-   **Batch Generation** : Prediction protocols to generate batches of structures are usually very computationally intensive, ranging from hundreds to thousands of CPU hours. Das and Baker have a nice [review](http://depts.washington.edu/bakerpg/drupal/system/files/das08A_0.pdf) of the Rosetta prediction protocols. Consult the documentation for specific protocol for more information.


Batch Requirements
------------------

Each batch of structures should be as large and representative as possible. If you are generating structure predictions to compare against experimental data, here are some guidelines:

-   Aim to generate similar structural diversity as in your experimental data set, this will allow for more interpretable comparisons.
-   If your prediction protocol is highly constrained (e.g. within some RMSD of a target conformation) be aware that increasing the number of structures will have diminishing returns. Consider withholding some sequences, targets etc. to make a an independent test set or do K-fold cross validation.
-   If you are new to experimental design, consider consulting with a statistician or studying it yourself. For example see the [NSIT handbook on Engineering Statistics](http://www.itl.nist.gov/div898/handbook/index.htm) .


Optional Cluster Environment Requirements
--------------------------------

The features scientific benchmark supports **single-threaded** , **MPI** and **Condor** computational environments. The feature extraction process only uses the *rosetta\_scripts* application and the *jd2* job distributor. So if you are to get those to work on your platform, it should be possible to get the features scientific benchmark to work as well. Specific configuration information for the following job schedulers is provided.

-   **MPI Support** : To enable MPI support provide the necessary headers and libraries and compile Rosetta with scons using the *extras=mpi* flag.  See [[Running Features in Parallel | FeaturesTutorialRunSciBench#extracting-features-in-parallel ]]
-   **Load Sharing Facility Clusters** : The [Load Sharing Facility](http://en.wikipedia.org/wiki/Platform_LSF) (LSF) is job schedule for MPI parallel applications. For example, the [killdevil](http://help.unc.edu/6214) cluster at UNC uses LSF. When setting up feature extraction jobs, use the *--run-type lsf* with the *features.py* script.
-   **Condor Clusters** : [Condor](http://research.cs.wisc.edu/condor/) is a job scheduler often used for heterogeneous cluster resources. When setting up feature extraction jobs, use the *--run-type condor* with *features.py* .



##See Also

* [[Running Features R Scripts | FeaturesTutorialRunFeaturesAnalysis]]
* [[FeatureReporters]]
* [[FeaturesTutorials]]
* [[TrajectoryReportToDBMover]]
* [[RosettaScripts database connection options]]
* [[Database IO]]: information on database input/output in Rosetta
* [[Rosetta Database Output Tutorial]]
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: Database-related command line options
* [[I want to do x]]: Guide to choosing a mover