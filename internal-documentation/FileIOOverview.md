#Molecular Structure File I/O Overview

Document created 31 January 2016 by Vikram K. Mulligan (vmullig@uw.edu) as part of the 2016 Chemical XRW (eXtreme Rosetta Workshop).

## Supported molecular structure file formats in Rosetta

Rosetta currently supports Protein Data Bank format (PDB).  Recently, support for the new macromolecular Crystallographic Information File (mmCIF) format has been added.  A number of third-party applications exist for viewing and manipulating these formats.  Examples include <a href="https://www.pymol.org/">PyMOL</a>, <a href="https://www.cgl.ucsf.edu/chimera/">Chimera</a>, and <a href="http://spdbv.vital-it.ch/">Swiss-PDB Viewer</a>.

Additionally, Rosetta has a proprietary structure file format called "silent" format.  Rosetta's silent files have the advantage of being a compact means of storing multiple structures, with the full information needed to reconstruct a Rosetta pose, at full machine numerical precision.  (Re-importing a structure that was exported to a third-party format, on the other hand, can lead to information loss.)  However, silent files must be converted to a third-party format (<i>e.g.</i> PDB format) to view structures with third-party viewers (<i>e.g.</i>PyMOL).

## Control of input

``` -in:file:s <filename> ```: Import a structure from a third-party format (PDB, mmCIF).  Rosetta detects the format from the file.
``` -in:file:l <list file> ```: Import structures from a list of files contained in an ASCII text file (one file per line).  Rosetta detects the format of each file on import.