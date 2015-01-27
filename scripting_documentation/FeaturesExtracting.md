#Features Extracting

FeaturesReporter
================

Implementing a FeaturesReporter involves the following steps:

1.  Implement the FeaturesReporter class interface (see directly below).
2.  Implement the FeaturesReporterCreator class interface (like you would for a mover).
3.  Register the FeatureReporter with the FeaturesReporterRegistrator (rosetta/main/source/src/protocols/init/init.FeaturesReporterCreators.ihh and rosetta/main/source/src/protocols/init/init.FeaturesReporterRegistrators.ihh)
4.  Add the FeatureReporter to the FeatureReporterTests (rosetta/main/source/test/protocols/features/FeaturesReporterTests.cxxtest.hh) Unit Test.
5.  Consider adding the FeatureReporter to the features integration test (rosetta/main/tests/integration/tests/features).
6.  Document the FeatureReporter in the [[Features Database Schema|FeatureReporters]] page.
7.  Add new types in <FeatureReporters> organizational page

FeatureReporter Class Interface
-------------------------------

The FeatureReporter (rosetta/main/source/src/protocols/features/FeaturesReporter.hh) base class interface has the following components, which should be implemented by a new FeaturesReporter:

**Required Methods**

-   **type\_name** : Returns the a string for the type of the feature reporter
-   **schema** : Return SQL statements that setup tables in the database to contain the features. To support all database backends, use the [[schema generation|FeaturesSchemaGeneration]] framework (write\_schema\_to\_db function).
-   **report\_features** : Extract all features to the database

**Optional Methods**

-   **features\_reporter\_dependencies** : Returns a vector of the names of the features reporters that this one depends on. (In the rosetta\_scripts, the ReportToDB mover enforces this dependency by requiring the FeaturesReporters listed here to be defined higher in the list.)
-   **parse\_my\_tag** : How in rosetta scripts the \<Feature name=(& type\_name string)/\> subtag to the ReportToDB mover is parsed.
-   **load\_into\_pose** : If the data is used to initialize an aspect of a pose, put the logic here.
-   **delete\_records** : Delete all records from the database associated with a structure.

As an example consider the PoseCommentsFeatures (rosetta/main/source/protocols/features/PoseCommentsFeatures.hh) feature reporter. Arbitrary textual information may be associated with a pose in the form of *(key, val)* comments (See rosetta/main/source/src/core/pose/util.hh). The PoseCommentsFeatures FeaturesReporter extracts all defined comments to a table *pose\_comments* using the *struct\_id* and *key* as the primary key. The *struct\_id* references the the structures table that identifies each of the structures in the database.

In the report\_features function, sessionOP is an owning pointer to the database where the features should be written. See the [[database interface|DatabaseIO]] for how to obtain and interact with database sessions.

    string
    PoseCommentsFeatures::type_name() const { return "PoseCommentsFeatures"; }

    string
    PoseCommentsFeatures::schema() const {
      return
        "CREATE TABLE IF NOT EXISTS pose_comments (\n"
        " struct_id INTEGER,\n"
        " key TEXT,\n"
        " value TEXT,\n"
        " FOREIGN KEY (struct_id)\n"
        " REFERENCES structures (struct_id)\n"
        " DEFERRABLE INITIALLY DEFERRED,\n"
        " PRIMARY KEY(struct_id, key));";
    }

    Size
    PoseCommentsFeatures::report_features(
      Pose const & pose,
      Size struct_id,
      sessionOP db_session
    ){  
      typedef map< string, string >::value_type kv_pair;
      foreach(kv_pair const & kv, get_all_comments(pose)){
        statement stmt = (*db_session) <<
          "INSERT INTO pose_comments VALUES (?,?,?)" <<
          struct_id << kv.first << kv.second;
        stmt.exec();
      }
      
      return 0;
    }

-   A FeatureReporter may optionally be constructed with a ScoreFunction. For example, see the RotamerRecoveryFeatures class (rosetta/main/source/protocols/features/RotamerRecoveryFeatures.hh).

ReportToDB
==========

Use the ReportToDB mover with the Rosetta XML scripting to specify which features should be extracted to the features database. (Note: The TrajectoryReportToDB mover can also be used in Rosetta scripts or C++ to report features in trajectory form multiple times to DB for a single output).

-   \<ReportToDB\> tag
    -   **name** : Mover identifier so it can be included in the PROTOCOLS block of the RosettaScripts
    -   [[Database Connection Options|RosettaScripts-database-connection-options]] : for options of how to connect to the database
    -   **sample\_source** : Short text description stored in the *sample\_source* table
    -   **protocol\_id** : (optional) Set the *protocol\_id* in the *protocols* table rather than auto-incrementing it.
    -   **cache\_size** : The maximum amount of memory to use before writing to the database ( [sqlite3 only](http://www.sqlite.org/pragma.html#pragma_cache_size) ).
    -   **tast\_operations** : Restrict extracting features to a relevant subset of residues. Since task operations were designed as tasks for side-chain remodeling, residue features are reported when the residue is "packable". If a features reporter involves more than one residue, the convention is that it is only reported if each residue is specified.

-   \<feature\> tag (subtag of \<ReportToDB\>)
    -   **name** : Specify a FeatureReporter to include in database

<!-- -->

        <ROSETTASCRIPTS>
            <SCOREFXNS>
                <s weights=score12_w_corrections/>
            </SCOREFXNS>
            <MOVERS>
                <ReportToDB name=features database_name=scores.db3>
                    <feature name=ScoreTypeFeatures/>
                    <feature name=StructureScoresFeatures scfxn=s/>
                </ReportToDB>
            </MOVERS>
            <PROTOCOLS>
                    <Add mover_name=features/>
            </PROTOCOLS>
        </ROSETTASCRIPTS>

Since ReportToDB is simply a mover, it can be included in any Rosetta Protocol. For example, to extract the features from a set of pdb files listed in *structures.list* , and the above script saved in *parser\_script.xml* , execute the following command:

       rosetta_scripts.linuxgccrelease -output:nooutput -l structures.list -parser:protocol parser_script.xml

This will generate an SQLite3 database file *scores.db3* containing the features defined in each of the specified FeatureReporters for each structure in *structures.list* . See the features integration test (rosetta/main/test/integration/tests/features) for a working example.

Extracting Features In Parallel
===============================

Currently the ReportToDB mover is not compatible with MPI runs. There is support however for partitioning a sample source into batches, generating features database for each batch and merging them together. See the features\_parallel integration test (rosetta/main/test/integration/tests/features_parallel) for a working example.

For example if there are 1000 structures split into 4 batches then the scripts for the run processing the first batch would contain:

       <ReportToDB name=features_reporter db="features.db3_01" sample_source="batch1" protocol_id=1 first_struct_id=1>
          ...
       </ReportToDB>

and the script for the run processsing the second batch would contain:

       <ReportToDB name=features_reporter db="features.db3_02" sample_source="batch2" protocol_id=2 first_struct_id=26>
          ...
       </ReportToDB>

After the runs are complete, locate the merge.sh script (rosetta/main/test/scientific/cluster/features/sample_sources/merge.sh) and run

       bash merge.sh features.db3 features.db3_*

Which will merge the features from each of the *features.db3\_xx* database into *features.db3* .

-   **TIP1** : Merging feature databases should be done for batches of structures that conceptually come from the same sample source. It is best to keep structures coming from different sample sources in separate databases and only during the analysis use the sqlite3 [ATTACH](http://www.sqlite.org/lang_attach.html) statement to bring them together.
-   **TIP2** : If you run postgres, merging part is not necessary. If you use sqlite, merging is needed.
-   **WARNING** : Extracting many databases in parallel generates high data transfer rates. This can be taxing on cluster with a shared file system.

