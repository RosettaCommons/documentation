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
source $ROSETTA/tools/rna_tools/INSTALL
```

Instead of `/home/yourhomedirectory/`, use your actual path to Rosetta.

Then open a new terminal or type `source ~/.bashrc` to activate these paths & tools.

Some useful tools
==================
Following are example command lines for several of these Python-based tools:

pdb utilities
-------------
To change the residue numbers and chains in a file:

`renumber_pdb_in_place.py mymodel.pdb A:1-4 B:5-9`

or

`renumber_pdb_in_place.py mymodel.pdb 1-4 5-9`

To generate a fasta file with the sequences from a PDB:

`pdb2fasta.py mymodel.pdb  [ > mymodel.fasta ]`

To pull out a particular chain from a PDB file:

`extract_chain.py mymodel.pdb A `

To slice out particular residues from a PDB file:

`pdbslice.py mymodel.pdb -subset 1-5 9-12  mysubset_ `

The last argument is a prefix for the sliced PDB file.

To excise particular residues from a PDB file:

`pdbslice.py mymodel.pdb -excise 6-8  excised_ `

Again, the last argument is a prefix for the sliced PDB file.



silent file utilities
----------------------
job setup
---------
cluster setup
-------------




