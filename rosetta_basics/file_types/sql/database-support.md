#SQL database support

Metadata
========

Last edited 01/14/11. Matthew O'Meara (mattjomeara@gmail.com).

[[_TOC_]]

Overview of Relational Databases
================================

Relational Databases are standard datastructures for persistent management of large quantities of data. Compared with flat file formats, relational databases offer the following advantages:

-   Data are stored in separate, but interconnected tables, which can be joined together upon request with queries made in the Structure Query Language.

-   Data modification is transactional, that is, multiple operations can be grouped together and guaranteed to be preformed successfully or rolled back. In the presence of resource failure, this can offer greater guarantees of data integrity.

-   Most standard implementations use sophisticated datastructures optimized for performance on a variety of architectures and for a variety of use cases.

-   Relational databases have been in use for over 30 and the standard implementations are quite robust and have strong support in the the computer science community.

Database Support In Rosetta
===========================

While standard implementations such as SQLite, PostgreSQ, MySQL and Oracle are in many ways quite similar, they each have unique details. To be useful in different contexts, Rosetta uses an abstraction library, cppdb, to present a common interface within the code supporting multiple databases backends.

Why the cppdb library?
----------------------

When choosing to use cppdb as the database abstraction layer we evaluated several approaches and projects. The general strategy of an abstraction layer is to have backend drivers that each connect with a different library–in this case database engine–and frontend drivers that present an interface for a different programming environment. Effective abstraction layers should simplfy software design by avoiding having to implement interfaces for all combinations of programming environments and libraries.

-   ODBC Is a widely implemented database abstraction layer that support many database engines and implementations for many programming environments. However because of the complexity of the ODBC specification many backends for standard database engines have poor implementations that hard to use and proportedly buggy.

-   SOCI Is a well supported c++ centric database abstraction layer. However it has evolved from a Oracle-centric interface and strives to be behave like standard template library data structures. The result is that the SOCI C++ api is strange and overly compilcated. There seems to be active development, however there has not been a stable release since 2008, which is troublesome.

-   DBI Is also a well supported multilanguage database abstraction layer. It has originally grown out of a perl module. We tried using this with the dbixx front end for C++ and it seemed like it would have worked relatively well. One problem with DBI is that inorder to support loading database drivers on the fly at runtime, it requires using libtool, a relatively standard component of the autotools toolchain. However since we don't use make for out build system, this would have required adding libtool as an additional dependency. While libtool is available on most commercial operating systems, rosetta is run on many different clusters which may not have this capability. An further problem with the DBI abstraction layer is that the developer of dbixx has stopped development on it. Instead he has rewritten a simplified C++ centric database abstraction layer cppdb.

-   ccpdb is a relatively new, clean, and simple database abstraction layer. It supports SQLite3, MySQL, PostgreSQL as well as a connection to ODBC out of the box. It is MIT/BOOST licensed so definitely suitable for inclusion in Rosetta. It supports on the fly library loading however we have disabled this to remove the libtool dependency. It supports thread safe behavior, however to prevent adding pthreads as a general dependency, thread safety has ben disable for now. The documentation is sparse but so far that hasn't been too much of an issue as the looking directly at the api has been staright forwared enough. When issues were discovered including cppdb in Rosetta, Artyom has been quite responsive in helping.

Usage of Databases
==================

Usage Overview
--------

The general process of using a database involves the following three basic tasks steps:

-   Establish a database session
-   Execute statements or
-   Execute queries

Session Management
------------------

Currently only SQLite3 databases are supported, though if adding more database types will be doable. To establish a session, resquest a session from the DatabaseSessionManager.

```
  #include <utility/sql_database/DatabaseSessionManager.hh>

  //...

  using utility::sql_database::DatabaseSessionManager;
    using utility::sql_database::sessionOP;

  DatabaseSessionManager * dsm = DatatabaseSessionManager::get_instance();
    sessionOP db_session = dsm->get_session(database_filename);
```

The DatabaseSessionManager is singleton mananaged on non-mpi builds and boost::auto\_ptr managed for mpi builds. One thing to note: In order to use owning pointers with a session object use the utility::sql\_database::session. It derives from cppdb::session.

Usually your application will want to use the database filename the user specifies in the option system:

```
  -inout:database_filename
```

by looking it up like this:

```
  #include <basic/options/option.hh>
  #include <basic/options/keys/inout.OptionKeys.gen.hh>
    #include <string>

  // ...

  using namespace basic::options;
  using OptionKeys::inout;

    std::string database_filename(option[database_filename].value());
```

Once a database session has been established. One of the main tasks it to execute statements. For example to create a table:

```
  #include <cppdb/frontend.h> // for 'statement' and 'result' classes

    // ...

    using cppdb::statement;

  statement create_table_stmt = (*db_session) <<
        "CREATE TABLE table1 ("
        "   column1 INTEGER PRIMARY KEY,"
        "   value1 TEXT);";
    create_table_stmt.exec();

    statement insert_row_stmt = (*db_session) <<
        "INSERT INTO table1 (null,?)" << "hi";
    insert_row_stmt.exec();
```

Another main task is to execute queries over a database. For example:

```
  #include <cppdb/frontend.h> // for 'statement' and 'result' classes

    // ...

    using cppdb::statement;

  result res = (*db_session) <<
        "SELECT * FROM table1;";
    while(res.next()){
      int col1;
        string val;
      res >> col1 >> val;
        // use col1 and val
    }
```

For a working expanded example see test/utility/sql\_database/DatabaseSessionManagerTests.cxxtest.hh

For more documentation on the cppdb API see the [CppDB Online Documentation](http://cppcms.sourceforge.net/sql/cppdb/index.html) and external/dbio/cppdb/frontend.h.

##See Also

* [[Database IO]]: Information on input/output to different database formats using Rosetta
* [[Rosetta Database Output Tutorial]]
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database options]]: List of options related to using databases with Rosetta
* [[RosettaScripts database connection options]]
* [[The Rosetta database|database]]: Information about the main database included with Rosetta and specified by the -in:path:database flag (separate topic)