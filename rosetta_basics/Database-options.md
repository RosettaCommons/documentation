<!-- --- title: Relational Database Options -->
Options for using relational databases within Rosetta.

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
