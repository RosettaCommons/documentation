#Enzyme design application

Metadata
========

Author: Jason Fell (jsfell@ucdavis.edu)

This document was mostly written by Jason Fell (jsfell@ucdavis.edu), last updated May 2020. Other contributors are Stephanie C. Contreras, Steve J. Bertolani and Justin B. Siegel. 

Code and Demo
=============

This script is in rosetta/tools/protein_tools/scripts/RosettaEnzCM.py

Input Files
===========

Input files that are needed:

-   a cleaned pdb for each template
-   a file containing all catalytic residues for each template
-   an aligned fasta file with all template and target sequences

Setup
=====

This script will first check all template catalytic residues are properly aligned with each other. If any of the catalytic residues are not aligned the script will stop and give an error. Once template catalytic residues have been checked, the script will then predict the what are the catalytic residues are for each target sequence.

At this stage, if a predicted catalytic residue is either an alanine or glycine the script will stop and print an error. The catalytic residues are printed for each template in a .data file, and all target catalytic residues are printed in a _residues.txt file.

Next, the script will utilize PyRosetta and import each template pdb. The distances for each CA-CA, CB-CB, CA-CB and CB-CA atom pairs for each catalytic residue is measured for each template, and then these distances are averaged and saved to a _distances.txt file. 

Lastly, the script will combine the predicted target residues and average atomic distances and create a <target>.dist_csts file that will have the proper catalytic distance constraints that can be called from/appended to in the form of:

AtomPair Cx <Residue1> Cy <Residue2> SCALARWEIGHTEDFUNC 1000 HARMONIC <distance> 1.0

####General syntax:

```
 python RosettaEnzCM.py -c <catalytic-residues> -a <aligned-fasta> -n <output-name>"
```

Command line options are:

```
-c File containing catalytic residues
-a aligned fasta sequences
-n optional name for output
```

####Catalytic Residue Syntax

A file containing the catalytic residue information should be written as:

```
TEMPLATE RES1,RES2,RES3
TEMPLATE RES1,RES2,RES3
```

Where TEMPLATE is the name of your template (no .pdb required), and each catalytic residue is comma separated and capitalized.

References
========

Bertolani SJ, Siegel JB (2019) A new benchmark illustrates that integration of geometric constraints inferred from enzyme reaction chemistry can increase enzyme active site modeling accuracy. PLoS ONE 14(4): e0214126. 

https://doi.org/10.1371/journal.pone.0214126

##See Also

* [RosettaCM](https://www.rosettacommons.org/docs/latest/application_documentation/structure_prediction/RosettaCM)

