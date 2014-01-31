<!-- --- title: Namespacerosetta 1 1Io 1 1Pdb -->[Classes](#nested-classes)

rosetta::io::pdb Namespace Reference

Classes used to read and write PDB files. [More...](#details)

Classes
-------

class

PDBReader

Detailed Description
--------------------

Classes used to read and write PDB files.

```
A PDB file is broken up into records, made up of one line each, and
identified by a record name in the first six columns.  The different
kinds of records are described at:

  http://www.pdb.org/pdb/file_formats/pdb/pdbguide2.2/part_11.html

Each record is made up of fields belonging to one of sixteen different
types.  The different kinds of fields are described at:

  http://www.pdb.org/pdb/file_formats/pdb/pdbguide2.2/part_13.html

The primary public interface is @c PDBReader, which turns a PDB file
into a series of records.  It behaves as an iterator through a
PDB file.  PDBReader allows for varying implementations of file readers,
which among other things allows for investigating different levels of
efficiency.   At this point the only implementation of @c PDBReader is
the @c SimplePDBReader_.

Using a PDBReader looks like this:
```

      #include <rosetta/io/pdb/PDBReader.hh>

      using rosetta::io::pdb::PDBReader;
      using rosetta::io::pdb::PDBReaderOP;
      using rosetta::io::pdb::records::Record;
      using rosetta::io::pdb::records::RecordOP;

      PDBReaderOP reader_p( new <PDBReader implementation>( PDB filename ) );
      PDBReader & reader ( *reader_p );


      {
        RecordOP record_p ( reader.read() );
        Record & record ( *record_p );

        // Check the record's type and take appropriate action.
      }
      

```
An equivalent @c PDBWriter has not yet been written.  
```
