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

In the report\_features function, sessionOP is an owning pointer to the database where the features should be written. See the [[database interface|Database IO]] for how to obtain and interact with database sessions.

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


Extracting Features
==============================
See [[Generating Feature Databases | FeaturesTutorialRunSciBench#generate-feature-databases ]] for more information.

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

##See Also

* [[FeatureReporters]]
* [[FeaturesTutorials]]
* [[FeaturesRScripts]]
* [[TrajectoryReportToDBMover]]
* [[RosettaScripts database connection options]]
* [[Database IO]]: information on database input/output in Rosetta
* [[Rosetta Database Output Tutorial]]
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: Database-related command line options
* [[I want to do x]]: Guide to choosing a mover
