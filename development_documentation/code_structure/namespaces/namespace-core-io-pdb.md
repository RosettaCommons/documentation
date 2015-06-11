#core::io::pdb Namespace Reference

Classes used to read and write PDB files.

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

##See Also

* [[Input options]]: Command line options for input files
* [[src Index Page]]: Explains the organization of Rosetta code in the `src` directory
* More namespaces in core:
  * [[core::chemical|namespace-core-chemical]]
  * [[core::conformation namespace|namespace-core-conformation]]
  * [[core::conformation::idealization|namespace-core-conformation-idealization]] **NO LONGER EXISTS**
  * [[core::fragments|namespace-core-fragments]]
  * [[core::scoring|namespace-core-scoring]]
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page