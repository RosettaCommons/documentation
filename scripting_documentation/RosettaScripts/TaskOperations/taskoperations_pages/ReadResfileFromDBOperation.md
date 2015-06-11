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

