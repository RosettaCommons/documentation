#The BuildPeptide utility application

Metadata
========

Author: Barak Raveh

Last updated July 24, 2011 ; PI: Ora Schueler-Furman (oraf@ekmd.huji.ac.il).

Code and Demo
=============

-   Application source code: `        rosetta/main/source/src/apps/public/flexpep_docking/BuildPeptide.cc       `
-   For a demonstration of a basic run of the BuildPeptide utility application, see `        rosetta/main/tests/integration/tests/BuildPeptide       `

Application purpose
===========================================

Building an extended peptide or protein structure from a FASTA file (to help preparing input for peptide docking protocol, etc.).

Input Files
===========

BuildPeptide requires a fasta file in standard format as input.
/Users/amw579/Rosetta/documentation/application_documentation/utilities/ca-to-allatom.md
Options
=======

|Flag|Description|Type|
|----|-----------|----|
|-in:file:fasta|FASTA file with peptide sequence|string|
|-out:file:o|output PDB file name|string|
|-helix|(optional) Make a helical, rather than extended, peptide|bool|
|-phi|(advanced) Specify the phi backbone angle to repeat, default -135.0|real|
|-psi|(advanced) Specify the psi backbone angle to repeat, default 135.0|real|

Tips
====

```
 BuildPeptide.{ext} -database ${mini_db} -in:file:fasta input.fasta -out:file:o peptide.pdb
```

Expected Outputs
================

The output of a BuildPeptide run is a PDB-format file of the peptide in an extended full-atom conformation. Side-chain rotamers are arbitrary. This can be used for e.g., creating an initial structure for a [[FlexPepDock|flex-pep-dock]] ab-initio run.

## See Also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
