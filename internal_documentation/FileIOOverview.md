#Molecular Structure File I/O Overview

Document created 31 January 2016 by Vikram K. Mulligan (vmullig@uw.edu) as part of the 2016 Chemical XRW (eXtreme Rosetta Workshop).

## Supported molecular structure file formats in Rosetta

Rosetta currently supports Protein Data Bank format (PDB).  Recently, support for the new macromolecular Crystallographic Information File (mmCIF) format has been added.  A number of third-party applications exist for viewing and manipulating these formats.  Examples include <a href="https://www.pymol.org/">PyMOL</a>, <a href="https://www.cgl.ucsf.edu/chimera/">Chimera</a>, and <a href="http://spdbv.vital-it.ch/">Swiss-PDB Viewer</a>.

Additionally, Rosetta has a proprietary structure file format called "silent" format.  Rosetta's silent files have the advantage of being a compact means of storing multiple structures, with the full information needed to reconstruct a Rosetta pose, at full machine numerical precision.  (Re-importing a structure that was exported to a third-party format, on the other hand, can lead to information loss.)  However, silent files must be converted to a third-party format (<i>e.g.</i> PDB format) to view structures with third-party viewers (<i>e.g.</i>PyMOL).

## User control of input

<b>-in:file:s \<filename\></b>: Import a structure from a third-party format (PDB, mmCIF).  Rosetta detects the format from the file.<br/>
<b>-in:file:l \<list file\></b>: Import structures from a list of files contained in an ASCII text file (one file per line).  Rosetta detects the format of each file on import.<br/>

## User control of output

TODO

## Overview of the code

Rosetta's handling of third-party file formats was considerably overhauled in January of 2016, during the Chemical XRW (eXtreme Rosetta Workshop).

For file import, all third-party formats are parsed by separate Rosetta modules and converted to a <b>StructFileRep</b> object (namespace core::io), which is a data storage class that serves as an intermediary between Rosetta's internal structural representation (the <b>Pose</b>) and the third-party format.  The Pose is then built from the StructFileRep using the <b>core::io::pose_from_sfr::PoseFromSFRBuilder</b> class.  Functions for parsing PDB files to produce a StructFileRep are found in <b>core/io/pdb/pdb_reader.hh</b>, and functions for parsing mmCIF files to produce a StructFileRep are found in <b>core/io/mmcif/mmCIFReader.hh</b>.  Support for additional file formats can be added easily by writing a converter from the new file format to the StructFileRep.

For file export, the process occurs in reverse: the Pose is converted to a StructFileRep using the <b>core::io::pse_to_sfr::PoseToStructFileRepConverter</b> class.  Functions for writing PDB files from a StructFileRep are found in <b>core/io/pdb/pdb_writer.hh</b>, and functions for writing mmCIF files from a StructFileRep are found in <b>core/io/mmCIFReader.hh</b> (though this may be moved to a writing-specific file).  To add write support for additional file formats, a developer need only add a converter from StructFileRep to the new file format.

<<RawHtml(
<img src="../images/FileIODiagram_small.png" alt="Overview of the third-party structure file import/export machinery in Rosetta." />
)>>

Conversion from Pose to other proprietary Rosetta formats (<i>e.g.</i> silent file format) is handled by other modules, and does <i>not</i> go through the StructFileRep object.  The StructFileRep object is only intended for output to third-party formats, in which there might not be 1:1 correspondence between the way in which data are stored in the Pose and the way in which data are stored in the file.