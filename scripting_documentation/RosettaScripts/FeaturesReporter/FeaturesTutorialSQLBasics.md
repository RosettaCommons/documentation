#Features Tutorial: SQL basics

SQL stands for *Structured Query Language* and is used to get information in and out of a relational database. The main benefit of storing information in a relational database is that the data can be quickly extracted using SQL.

This tutorial covers the basics of working with and extracting information from an SQLite3 database, which is just a *.db3* file in the filesystem.

To follow along, you will need to have the command line program *sqlite3* installed. It is probably already installed, but in case it is not, you can download it from the [sqlite download](http://sqlite.org/download.html) page.

Useful to read in parallel:

-   [Basic Syntax](http://www.w3schools.com/sql/sql_syntax.asp)
-   [A bit More](http://souptonuts.sourceforge.net/readme_sqlite_tutorial.html)

Getting the Schema for a Database
---------------------------------

The first step is to see what tables are in the database

        sqlite3 example.db3 '.schema'

and it returns something like this

        CREATE TABLE table_name (
            tag TEXT,
            category1 TEXT,
            value1 REAL,
            PRIMARY KEY(tag));

In this case, the table *table\_name* has three columns *tag* , *category1* , *value1* and the tag column for each row must be unique and not NULL.

Extracting a Whole Table
------------------------

To get the contents of an entire table you can run this from the command line:

        sqlite3 example.db3 'SELECT * FROM table_name;'

This says to extract all of the rows from table *table\_name* and it will write them to the screen. To change the column separator from the "|" symbol to the "," symbol, add column headers, and write the results to the a file, first write a query file, *query.sql* , like this:

        --FILENAME: query.sql
        --DESCRIPTION: query the entire contents of the table 'table_name'
        --(This is a comment, by the way)

        .seperator ','
        .header on

        SELECT
            *
        FROM
            table_name;

Then from the command line run,

        sqlite3 example.db3 < query.sql > results.csv

The next few sections will describe other types of queries that can be used in a query file like *query.sql*

Extract Some of the Columns and Rows
------------------------------------

To restrict to only some of the columns and only some of the rows, you can use a query like this:

        SELECT
            table_name.tag,
            table_name.value1
        FROM
            table_name
        WHERE
            table_name.category1 = 'catA';

This will return only the rows where the value in the *category1* column is *catA* and for those rows, only return the *tag* and *value1* columns.

Extract Information from Multiple Tables
----------------------------------------

Relational database often store different information about the same objects in different tables. For example say the *example.db3* database had an another table like this

        CREATE TABLE another_table (
            tag TEXT,
            value2 REAL,
            PRIMARY KEY (tag));

Where the objects are identified by their "tag" values in both *table\_name* and *another\_table* . These two tables can be joined together to make a query

        SELECT
            table_name.tag,
            table_name.value1,
            another_table.value2
        FROM
            table_name,
            another_table
        WHERE
            table_name.tag = another_table.tag;

More Information
----------------

SQL can be used to describe more complicated queries. To learn more,

-   See the page [SQL as Understood by SQLite](http://sqlite.org/lang.html) for a description of the SQL syntax.
-   I recommend the book [The Definitive Guide to SQLite](http://www.amazon.com/Definitive-Guide-SQLite-Michael-Owens/dp/1590596730) by Michael Owens.

