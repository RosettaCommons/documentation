#Sqlite3 Interface

Metadata
========

Last edited 10/18/10. Code and documentation by Matthew O'Meara (mattjomeara@gmail.com) .

Overview
========

The [SQLite3](http://www.sqlite.org) library is simple SQL database engine. The Sqlite3Interface class makes SQLite databases from within Rosetta.

Why Use a database? Why use SQLite?
===================================

Do your csv tables have way to many columns? Do they not fit into memory anymore? Are you protocols turning into multiple phases and you are having trouble keeping track of which paramters go with which structure predictions? Are your runs so long they sometimes die and your data may be getting corrupted? Have you hacked together code to read several tables of parameters? Do you wish you could do "SELECT ... FROM ... WHERE ..." queries over all your data tables?

It may be time to think about using a database.

Data management tasks of different scales require different levels of sophistication. Simetimes using a spreadsheet is the right way to go. Sometimes having several comma separated tables in various directories is the right way to. And sometimes using a full fledged SQL database is the right way to go.

Don't be afraid, SQLite3 is pretty easy to use as far as databases go and the Sqlite3Interface makes about as easy as writing to a Tracer.

Databases like PostgreSQL or MySQL run as in a client-server server architecture. In contrast, SQLite is library linked directly into the program. Since each SQLite database is stored in memory or as a single, they are quite portable and easy to configure.

Setup for SQLite
================

Although SQLite is in the public domain it is not (currently) distributed with Rosetta. To prevent it from being global dependency, Developers using the Sqlite3Interface must specify they intend to use SQLite at compile time by adding 'sqlite' to the list of 'extra' options passed to scons.

```
./scons.py extras=sqlite  <other commands>
```

This will instruct gcc to define DB\_SQLITE3 as a preprocessing variable which is used in \#ifdef blocks in the code. Here is simple example which is fleshed out in the unit test test/utility/sql\_database/Sqlite3Interface.cxxtest.hh.

```
#ifdef DB_SQLITE
// This requires the external dependency of the sqlite3 library
// To use compile with $scons.py extras=sqlite

#include <utility/sql_database/sqlite3_interface.hh>
using utility::sql_database;


Sqlite3Interface sqlite3_interface("/tmp/test_db.db3");

// A transaction groups together multiple statements to be more
// efficient.
sqlite3_interface.begin_transaction();

sqlite3_interface.execute_sql( "\
TABLE table1 (\
    id INTEGER PRIMARY KEY AUTOINCREMENT,\
    value REAL,\
    math_const TEXT,\
    awesome BOOL );");


sqlite3_interface
    << Sqlite3Interface::begin_row("table1")
    << Sqlite3Interface::sqlite3_null
    << 3.14
    << "pi"
    << true
    << Sqlite3Interface::end_row;

sqlite3_interface.end_transaction();


#endif // DB_SQLITE
```

##See Also

* [[Database IO]]: Information on input/output to different database formats using Rosetta
* [[Rosetta Database Output Tutorial]]
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: Command line options for working with databases
* [[RosettaScripts database connection options]]
* [[The Rosetta database|database]]: Information about the main database included with Rosetta and specified by the -in:path:database flag (separate topic)