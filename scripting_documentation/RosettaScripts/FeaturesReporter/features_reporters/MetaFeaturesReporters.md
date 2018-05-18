<!-- --- title: Metafeaturesreporters -->Meta Features
=============

A meta features reporter reports information about the batch of structures and the protocol that was used to generate it.

ProtocolFeatures
----------------

A protocol is represented as all the information necessary to reproduce the results of the Rosetta application execution. The features associated of each application execution are ultimately linked with a single row in the protocols table through the *BatchFeatures* reporter.

-   **protocols** :
    -   *command\_line* : The complete command line used to execute Rosetta
    -   *specified\_options* : The non-default options specified in the option system.
    -   *svn\_url* : The url for the SVN repository used for the Rosetta source code.
    -   *svn\_version* : The SVN revision number of the svn repository.
    -   *script* : The contents of the rosetta\_scripts XML script if run via the rosetta\_scripts system.

<!-- -->

        CREATE TABLE IF NOT EXISTS protocols (
            protocol_id INTEGER PRIMARY KEY AUTOINCREMENT,
            command_line TEXT,
            specified_options TEXT,
            svn_url TEXT,
            svn_version TEXT,
            script TEXT);

BatchFeatures
-------------

        CREATE TABLE IF NOT EXISTS batches (
            batch_id INTEGER PRIMARY KEY AUTOINCREMENT,
            protocol_id INTEGER,
            name TEXT,
            description TEXT,
            FOREIGN KEY (protocol_id) REFERENCES protocols(protocol_id) DEFERRABLE INITIALLY DEFERRED));

JobDataFeatures
---------------

Store *string* , *string* - *string* , and *string* - *real* data associated with a job. As an example, the ligand docking code this way when it uses the DatabaseJobOutputter.

-   **job\_string\_data**
    -   *data\_key* : Associate labeled keys with a structure

<!-- -->

        CREATE TABLE IF NOT EXISTS string_data (
             struct_id INTEGER,
             data_key TEXT,
             FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
             PRIMARY KEY (struct_id, data_key));

-   **job\_string\_string\_data** :
    -   *data\_key* , *data\_value* : Associate labeled text strings with a structure

<!-- -->

        CREATE TABLE IF NOT EXISTS string_string_data (
             struct_id INTEGER,
             data_key TEXT,
             data_value TEXT,
             FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
             PRIMARY KEY (struct_id, data_key));

-   **job\_string\_real\_data** :
    -   *data\_key* , *data\_value* : Associate labeled, real numbers with a structure

<!-- -->

        CREATE TABLE IF NOT EXISTS string_real_data (
             struct_id INTEGER,
             data_key TEXT,
             data_value REAL,
             FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
             PRIMARY KEY (struct_id, data_key));

PoseCommentsFeatures
--------------------

Arbitrary textual information may be associated with a pose in the form of *(key, val)* comments. The PoseCommentsFeatures reporter stores this information as a feature.

-   **pose\_comments** : All pose comments are extracted using.

<!-- -->

        CREATE TABLE IF NOT EXISTS pose_comments (
            struct_id INTEGER,
            key TEXT,
            value TEXT,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, key));

RuntimeFeatures
---------------
Report how much time it took for each structure to be processed.  The database is populated with two fields: a string 'timestamp' telling the date & time when the protocol started and an integer 'elapsed_time' telling the number of seconds that elapsed while the protocol was running.

Example:

```xml
<RuntimeFeatures/>
```

Options: None

Schema:

```sql
CREATE TABLE `runtimes` (
  `struct_id` bigint(20) NOT NULL DEFAULT '0',
  `timestamp` varchar(20) DEFAULT NULL,
  `elapsed_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`struct_id`),
  FOREIGN KEY (`struct_id`) REFERENCES `structures` (`struct_id`)
)
```