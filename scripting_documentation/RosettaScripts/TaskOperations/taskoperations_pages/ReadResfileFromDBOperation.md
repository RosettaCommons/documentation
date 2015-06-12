# ReadResfileFromDB
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## ReadResfileFromDB

Lookup the resfile in the supplied relational database. This is useful for processing different structures with different resfiles in the same protocol. The database *db* should have a table *table\_name* with the following schema:

        CREATE TABLE <table_name> (
            tag TEXT,
            resfile TEXT,
            PRIMARY KEY(tag));

When this task operation is applied, it tries to look up the *resfile* string associated with the *tag* defined by

        JobDistributor::get_instance()->current_job()->input_tag()

This task operation takes the following parameters:

-   **[[database_connection_options|RosettaScripts-database-connection-options]]** : Options to connect to the relational database
-   table=("resfiles" &string)

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta