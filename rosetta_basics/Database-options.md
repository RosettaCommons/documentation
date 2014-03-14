Options for using relational databases such as with Rosetta.

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
