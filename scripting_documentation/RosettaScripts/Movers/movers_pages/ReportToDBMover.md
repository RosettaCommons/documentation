# ReportToDB
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ReportToDB

Report structural data to a [[relational database|Database-IO]] using a modular schema. Each [[FeaturesReporter|FeatureReporters]] is responsible for a set of tables that conceptually represents a type of geometric, chemical, or meta property of a structure. All features reportered though a single instance of the ReportToDB Mover will be grouped into a **batch** of structures.

```xml
<ReportToDB name="&string" {database_connection_options}  cache_size="(&integer)" batch_description="&string" protocol_id="(&integer)" task_operations="(&task_operations)" relevant_residues_mode="[explicit,implicit]">
   <&string {feature_specific_options}/>
   <&string {feature_specific_options}/>
   .
   .
   .
</ReportToDB>
```

**ReportToDB Tag** :

-   **name** *(&string)* : The name assigned to this mover to be referenced in the MOVERS section of the RosettaScript.
-   **[[database_connection_options|RosettaScripts-database-connection-options]]** : Options to connect to the relational database
-   **sample\_source** *(&string)* : A description for the *batch* of structures. This ends up in the `      description     ` column of the [[batches|MetaFeaturesReporters#BatchFeatures]] table.
-   **[[task_operations|TaskOperations-RosettaScripts]]** : Restrict extraction of features to a subset of residues in a structure. A residue is *relevant* if it is *packable* . For multi-residue features, all residues must be *packable* for it to be reported.
-   **relevant\_residues\_mode** [ *explicit* `      default     ` , *implicit* ]: Determines which features should be reported given the set of relevant residues. With *explicit* all residues in a feature must be *relevant* to be reported. With *implicit* at least one residues in a feature must be *relevant* to be reported.

**Feature Subtags** : Each features subtag applies a [[features reporter|FeatureReporters]] to the structure.

-   **name** *(&string)* : This is the name of the feature, e.g. *RotamerRecoveryFeatures* .
-   **feature\_specific\_options** : See individual FeaturesReporters to for details.
-   The following FeaturesReporters are included automatically:
    -   **[[ProtocolFeatures|MetaFeaturesReporters#ProtocolFeatures]]** : About the Rosetta application execution.
    -   **[[BatchFeatures|MetaFeaturesReporters#BatchFeatures]]** : About the set of features extracted by this ReportToDB instance.
    -   **[[StructureFeatures|MultiBodyFeaturesReporters#StructureFeatures]]** : About each structure reportered by this ReportToDB instance. Note, currently each structure has a universally unique id, **struct\_id** that is used as a composite primary key in almost all feature tables.
-   The following tables are created to help organize the features database:
    -   **features\_reporters** : The FeaturesReporters used in any batch in the database

<!-- -->

        CREATE TABLE IF NOT EXISTS features_reporters (
            report_name TEXT,
            PRIMARY KEY (reporter_name));

-   **batch\_reports** : The features reporters used by this ReportToDB instance.

<!-- -->

        CREATE TABLE IF NOT EXISTS batch_reports (
            report_name TEXT,
            batch_id INTEGER,
            FOREIGN KEY (report_name) REFERENCES features_reporters (report_name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (report_name, batch_id));

Additional Information:

-   General information using the a features database to do [[features analysis|FeaturesScientificBenchmark]] .
-   How to [[create|FeaturesExtracting]] a new FeaturesReporter.
-   Usage of features analysis for doing [scientific benchmarking](http://contador.med.unc.edu/features/paper/features_optE_methenz_120710.pdf) of the Rosetta ScoreFunction.


##See Also

* [[TrajectoryReportToDBMover]]
* [[RosettaScripts database connection options]]
* [[Database IO]]: information on database input/output in Rosetta
* [[Rosetta Database Output Tutorial]]
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: Database-related command line options
* [[I want to do x]]: Guide to choosing a mover
