#Features Schema Generation

Overview
--------

The schema generator is a framework for generating SQL schemas that are backend independent. Currently supported backends are sqlite, postgresql, and mysql.

The general organization of the schema generator is as follows:

Schema object
-------------

A Schema object is the highest level object and has a "print" command that will generate a string that represents a table's schema. A schema is a container for the rest of the objects used to generate database schemas. Specifically, a schema has a PrimaryKey, a set of ForeignKeys, a set of Columns, and a set of Constraints.

Column object
-------------

Columns are the most basic building block of schemas and are used in all higher-level schema generation objects. In its most basic form a column is simply a string representing the column name and a DbDatatype the specifies the type of data stored in this column. Additional information, such as non-null constraints and autoincrementation, can be added to columns as well.

Example: Column example\_column("example\_column", DbInteger());

PrimaryKey object
-----------------

The PrimaryKey object is simply a container of columns. Usually tables in a relational database have a single column as the primary key. Primary keys are guaranteed to be unique.

Example: PrimaryKey example\_pkey(example\_column);

ForeignKey object
-----------------

A foreign key is a special column that references a unique column from another table (usually the primary key of that table). The ForeignKey object therefore contains a single column, and two strings that represent the table and column name to be referenced.

Example:

ForeignKey example\_fkey(example\_column, "other\_table", "column\_name\_from\_other\_table");

Constraint object
-----------------

A constraint object is a base class used to represent a specific constraint that can be added to a schema. Example constraints are uniqueness and arithmetic constraints (e.g. some\_column \> 5).

Currently supported datatypes
-----------------------------

DbText:

DbInteger:

DbBoolean:

DbBigInt:

DbReal:

DbUUID:

Example
-------

Please see protocols/features/StructureFeatures.cc for a full example of how to use the SchemaGenerator
