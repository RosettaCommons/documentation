#The dump_capped_residue utility application

Metadata
========

Author: Andrew Watkins (amw579@stanford.edu)

Last updated July 4, 2017; PI: Rhiju Das (rhiju@stanford.edu).

Code and Demo
=============

-   Application source code: `        rosetta/main/source/src/apps/public/dump_capped_residue.cc       `
-   A few integration tests depend on dump_capped_residue, including: 
`        rosetta/main/tests/integration/tests/farfar_mrna       `
`        rosetta/main/tests/integration/tests/read_polymeric_components       `

Application purpose
===========================================

Exporting a PDB file of a given residue -- which can be specified via Rosetta nomenclature (i.e., the base name followed by a colon-separated list of patches).

Input Files
===========

BuildPeptide requires no particular input files.

Options
=======

|Flag|Description|Type|
|----|-----------|----|
|-dumper:residue_name|Full or base name of the desired residue|string|
|-nopatch|(optional) If true, don't add polymeric capping groups|bool|
|-fiveprime|(optional) If RNA, add the FIVEPRIME_CAP variant and also instantiate a 7-methyl guanosine, then optimize the connected geometry.|bool|

Tips
====

It's a great idea to run this application as you construct a params file for a new residue type, so you can visualize what it looks like. Finally, you may want to use this application to prepare a capped PDB file for QM optimization.

Expected Outputs
================

The output of a dump_capped_residue run is a PDB-format file of the residue in an extended full-atom conformation. 

## See Also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
