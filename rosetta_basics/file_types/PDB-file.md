#PDB file
##PDB file

The PDB file format is an industry standard file format for storage of biomolecular structures. The [official description](http://www.wwpdb.org/documentation/file-format) of the file format is kept by the wwPDB.

Rosetta currently only reads a subset of the records in the PDB format.

The major records read are the ATOM and HETATM records that define atom coordinates.

Most other records are ignored.

One point of confusion for new users concerns the treatment of PDB residue IDs in Rosetta. Residue IDs are represented in columns 23-27 of a PDB file (the sequence number and insertion code) for the appropriate records _e.g._ ATOM, HETATM, _etc._ When a PDB file is read into Rosetta, this residue numbering is represented internally as a sequential list of integer IDs (no insertion codes) starting with the ID 1. In some cases, this numbering coincides with the PDB numbering but in general it does not. Some of the Rosetta input files use PDB numbering and some use Rosetta numbering so it is important to realize which numbering scheme each input file expects. On a related note, Rosetta may keep or discard certain atoms (_e.g._ those with zero occupancy) or residues (_e.g._ those without the required backbone atoms) depending on the command flags passed which should be borne in mind.

TODO: Insert comments about the specialty usage of other records

##See Also
* [[Preparing structures]]: Preparing PDBs for use with Rosetta
* [[File types list]]: List of file types used in Rosetta
* [[Input options]]: Command line options for Rosetta input
* [[Output options]]: Command line options for Rosetta output
* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications