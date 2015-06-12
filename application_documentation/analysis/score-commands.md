#Score Commands

Metadata
========

This document was edited 3/14/2014 by Jared Adolf-Bryfogle. This application in Rosetta3 was created and documented by Mike Tyka,et al.

Purpose and Algorithm
=====================

This application simply rescores PDBs, silent files, and PDBs within relational databases. It also can be used for conversion - aka convert to/from silent files, PDBs, and relational databases.  Use Rosetta's [[general output options|output-options]] for file type conversions.

The default behavior is to not echo PDBs, so only the scorefile will be output. This can be controlled via cmd-line options.

Command Line Options
====================

```
* Sample command:  score_jd2.linuxgccrelease -database db_path -l PDBLIST.txt


Score Application Specific Options
-score_app:linmin                           Run a quick linmin before scoring
-rescore:verbose                            display score breakdown


Quick Start Options
-in:file:native                             native PDB if CaRMS is required
-score:weights  weights                     weight set or weights file
-score:patch  patch                         patch set

-out:nooutput                               don't print PDB structures (default now)
-out:output                                 force printing of PDB structures

-out:file:score_only                        Only output score file (supress all other filetypes)
-out:file:scorefile name.sc                 Name of scorefile (default score.sc)
-out:file:silent                            write silent-out file
-out:prefix  myprefix                       prefix the output structures with a string

```

General Options
-  [[Input Options | rosetta_basics/input-options]]
-  [[Database options | rosetta_basics/Database-options]]
-  [[Output Options | rosetta_basics/output-options]]
-  [[Score Options | rosetta_basics/score-options]]

Call optH when reading silent files (useful for HisD/HisE determination)

Tips
====

* If you want to find the lowest energy structure easily, use the <code>sort</code> command.  You can sort on a particular column using the -kx option. See [this page](http://www.skorks.com/2010/05/sort-files-like-a-master-with-the-linux-sort-command-bash/) for more.
 - Sort by total score: <code>sort my_score_file.sc</code> 
 - Sort by energy term: <code>sort -k5 my_score_file.sc</code>, which would sort by the 5th column, or the 4th score term.


##See Also

* [[Analysis applications | analysis-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs

