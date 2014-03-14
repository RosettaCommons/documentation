#Score Commands

Metadata
========

This document was edited 3/14/2014 by Jared Adolf-Bryfogle. This application in Rosetta3 was created and documented by Mike Tyka,et al.

Purpose and Algorithm
=====================

This application simply rescores PDBs, silent files, and PDBs within relational databases. It also can be used for conversion - aka convert to/from silent files, PDBs, and relational databases.  Use Rosetta's [[general output options | rosetta_basics/output-options]] for file type conversions.

The default behavior is to not echo PDBs, so only the scorefile will be output, but this can be controlled via cmd-line options.

Command Line Options
====================

```
* Sample command:  score_jd2.linuxgccrelease -database db_path -l PDBLIST.txt


Score Application Specific Options
-score_app:linmin                           Run a quick linmin before scoring
-rescore:verbose                            display score breakdown
-rescore:output_only                        dont rescore


Quick Start Options
-in:file:native                             native PDB if CaRMS is required
-score:weights  weights                     weight set or weights file
-score:patch  patch                         patch set
-nooutput                                   don't print PDB structures (default now)
-output                                     force printing of PDB structures
-out:file:silent                            write silent-out file
-out:prefix  myprefix                       prefix the output structures with a string

```

General Options
-  [[Input Options | rosetta_basics/input-options]]
-  [[Database options | rosetta_basics/Database-options]]
-  [[Output Options | rosetta_basics/output-options]]
-  [[Score Options | rosetta_basics/score-options]]

Call optH when reading silent files (useful for HisD/HisE determination)

