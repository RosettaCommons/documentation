Application purpose
===========================================

A collection of tools for PDB editing, cluster submission, 'silent-file' processing, and setting up rna_denovo and ERRASER jobs. Under active development by the Das laboratory (Stanford). 

Code
====

This documentation describes how to set up code in:

`tools/rna_tools/bin`

Setup
======
Include the following lines in your `.bashrc` (may be `.bash_profile` on some systems):

```
export ROSETTA='/home/yourhomedirectory/src/rosetta/'
export PATH=$ROSETTA/tools/rna_tools/bin/:$PATH
export PATH=$PATH:$ROSETTA/tools/ERRASER/
source $ROSETTA/tools/rna_tools/INSTALL
```

Instead of `/home/yourhomedirectory/`, use your actual path to Rosetta.

Then open a new terminal or type `source ~/.bashrc` to activate these paths.

Some useful tools
==================



