<!-- --- title: Relational Database Options -->

Options for using relational databases within Rosetta.

**NOTE:** Not to be confused with the option to specify the [[Rosetta database|database]], which is found in the [[input options]].

Currently supported backends include: sqlite3, mysql, and postgres

General
=================

```
-inout:dbms:mode                            Specify database backend. default: 'sqlite3'
                                             legal=["sqlite3", "mysql", "postgres"],
-inout:dbms:database_name                   If sqlite3, the filename for the database
-inout:dbms:pq_schema                       For PostgreSQL, the schema namespace in the database to use
-inout:dbms:host                            NOTE to use mysql or postgres as a backend:
-inout:dbms:user                               compile with 'extras=mysql' or 'extras=postgres' and use
-inout:dbms:password                           the '-inout:dbms:mode mysql' or
-inout:dbms:port                               the '-inout:dbms:mode postgres' flag
                                                  Consider using ~/.pgpass or ~/.my.cnf to store connection info
```

Input
============================
```
-in:use_database                          Indicate that structures should be read from the given database
-in:select_structures_from_database       An sql query to select which structures should be extracted. 
                                           ex:  "SELECT tag FROM structures WHERE tag = '7rsa';"
```

Output
====================

```
-out:use_database          Write out structures to database.
                            Specify database via -inout:dbms:database_name and wanted structures with
                            -in:file:tags [Boolean]
-out:database_filter       Filter to use with database output.  Arguments for filter follow filter name [StringVector]
-out:resume_batch          Specify 1 or more batch ids to finish an incomplete protocol.
                            Only works with the DatabaseJobOutputter.
                            The new jobs will be generated under a new protocol and batch ID
```

##See Also

* [[Full options list]]
* [[Options overview]]: Description of options in Rosetta
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Database IO]]: Information on input/output to different database formats using Rosetta
* [[Rosetta Database Output Tutorial]]
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[RosettaScripts database connection options]]
* [[The Rosetta database|database]]: Information about the main database included with Rosetta and specified by the -in:path:database flag (separate topic)