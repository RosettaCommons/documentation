<!-- --- title: Rosettascripts Database Connection Options -->### RosettaScripts Database Connection Options

Tags that require access to a [[relational database|Database-IO]] all take options to setup the connection. As an example, consider the [[ReportToDB|Movers-RosettaScripts#ReportToDB]] mover, e.g.

       <ReportToDB database_mode="postgres" database_name="interface_design" pq_schema="stage4"/>

where rosetta has been compiled with postgres support. The *host* , *port* , *username* , and *password* options are specified in a file `   ~/.pgpass  ` for security reasons.

If an option not provided, the options described below fall back on options in the option system replacing *database\_* with `   -inout:dbms:  `

General Options
---------------

-   **database\_mode** : Which database backend should be used. Valid options are [ *sqlite3* , *postgres* , *mysql* ]. If it is not specified--even in the option system--it falls back to *sqlite3* .
-   **transaction\_mode** : Specify when transactions should be committed to the database. A transaction groups together statements and executes them in a block. This is beneficial maintain database consistency for statements are semantically related. Also, by grouping statements together this cuts down on communication costs in client-server database setups. A risk of making too large of transactions is it requires hanging on to more data before passing it to the database. This wastes memory and, if there is a failure in the middle, then partial results aren't saved to the database.
    -   Valid values are
        -   *none* : Each statement is committed as it's on transaction. This is good for debugging.
        -   *standard* (default): Each call to `        commit()       ` causes a transaction to be committed.
        -   *chunk* : Requires specification of the *chunk\_size* option. Sets of transactions of size *chunk\_size* are committed to the database as a single transaction. For example in cluster use cases where there are *1000* cores trying to all write to a database server with *8* cores and the load is too high, consider using a chunk size of *100* . NOTE: To take full advantage of chunking it is helpful to use the resource manager to hang on to database session for the life-time of the protocol.

-   **chunk\_size** : Number of transactions to group together before committing them to the database. NOTE: This is requires `    transaction_mode=chunk   ` .

Sqlite3 Specific Options
------------------------

-   **database\_name** : The path and filename of the sqlite3 database. Usually it has a *.db3* extension.
-   **database\_separate\_db\_per\_mpi\_process** : Append to the end of the database filename *\_\<mpi\_rank\>* . This is useful, for example in writing out separate database in parallel and then merging them together afterwards [(See main/tests/features/sample\_sources/merge.sh)](https://github.com/RosettaCommons/main/blob/master/tests/features/sample_sources/merge.sh) .
-   **database\_readonly** : Open the database file so it cannot be modified.

PostgreSQL Specific Options
---------------------------

-   **database\_host** : The URI to the database server.
-   **database\_port** : The *port* for access to the database server.
-   **database\_user** : The *username* for access to the database server.
-   **database\_password** : The *password* for access to the database server. Consider setting up a [.pgpass](http://wiki.postgresql.org/wiki/Pgpass) file in your home directory for greater security control.
-   **database\_name** : The name of the database.
-   **pq\_schema** : The schema name within the database. This is a 1-level namespace that is used to store related databases together. The benefit of using schemas is that Postgres doesn't allow querying across databases but it does allow querying across schemas. See the Postgres documentation on [schemas](http://www.postgresql.org/docs/9.1/static/ddl-schemas.htm) for more information.

MySQL Specific Options
----------------------

-   **database\_host** : The URI to the database server.
-   **database\_port** : The *port* for access to the database server.
-   **database\_user** : The *username* for access to the database server.
-   **database\_password** : The *password* for access to the database server. Consider setting up a [.my.cnf](http://dev.mysql.com/doc/refman/5.1/en/option-files.html) file in your home directory for greater security control.
-   **database\_name** : The name of the database.

##See Also

* [[RosettaScripts]]: The RosettaScripts home page
* [[Database IO]]: Information on input/output to different database formats using Rosetta
* [[Rosetta Database Output Tutorial]]
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: List of database-related command line options
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[RosettaScripts Movers|Movers-RosettaScripts]]
* [[RosettaScripts Filters|Filters-RosettaScripts]]
* [[I want to do x]]: Guide for making specific structural perturbations using RosettaScripts
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Getting Started]]: A page for people new to Rosetta
* [[Glossary]]
* [[RosettaEncyclopedia]]
