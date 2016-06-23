#Writing a new Features Reporter class


Implementing a FeaturesReporter involves the following steps:

1.  Implement the FeaturesReporter class interface (see directly below). In addition to below, you can also use code_templates to generate the the class .hh and .cc files. 
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
