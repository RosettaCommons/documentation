#Structure-Set-Fragment-Picker

Metadata
========

Authors:  
Ingemar André (ingemar.andre@biochemistry.lu.se)  
Sebastian Rämisch (raemisch@scripps.edu)  

Corresponding PI: Ingemar André  

Last edited 10/26/15.

Code 
====

-   Application source code: `        rosetta/main/source/src/apps/public/struc_set_fragment_picker.cc       `

References
==========

This simple fragment set generator was first used in:

Sebastian Rämisch, Robert Lizatovic and Ingemar André,   
**Exploring alternate states and oligomerization preferences of coiled-coils by de novo structure modeling**,  
*Proteins* (2015)  
http://onlinelibrary.wiley.com/doi/10.1002/prot.24729/abstract;jsessionid=3B2AAEB6FBFDD42007B1A8DF5EABEA41.f04t03

Purpose
===========================================

Generate fragment sets for Rosetta protein structure modeling using a predefined set of protein structures as fragment source. The fragments are **randomly** picked from a set of structures, **irrespective of sequence and secondary structure**.
*The original intention was to predict coiled-coil structures using exclusively fragments taken from coiled-coil structures.*  

Algorithm
==========

First, all possible fragments from a given set of PDB files are generated. Then, for each position of the target sequence, a set of fragments (default=200) is randomly picked. Secondary structure and sequence are not considered at any point.

Notes
======
* It does not use the scoring scheme used by the standard fragment picker
* **This will not work with JD2**

How to run
===========================================
1. Download all pdb files you intend to use as sources to some directory. 
2. Prepare a list file that contains path/name.pdb for each source structure (see below)
3. Run struct_set_fragment_picker

Input
=====
The only input file is a list of the pdb names to be used. E.g.:   
```
input/struct_files/1e5t.pdb
input/struct_files/3tg7.pdb
input/struct_files/2guv.pdb
...
```

Options
============================================

| Option | Explanation |
| --- | --- | --- |
| -in::file::l <list file>    | list of structures |
| -frags:n_frags | number of fragments per position (optional; default = 200) |
| -struc_set_fragment_picker::frag_length <int> | Fragment length. Usually 3 or 9. |
| -struc_set_fragment_picker::sequence_length <int> | Length of target sequence. |
| -struc_set_fragment_picker::frag_name <string> | Name of the output fragment file. Usually 5 characters.|

Output
======
The output is a standard Rosetta fragment file to be used for structure prediction.

New things since last release
=============================

This is the first public release

## See Also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Fragment picker | app-fragment-picker]]: Standard fragment picking
* [[fragment-file]]: fragment files
* [[Old fragment picker | fragment-picking-old]]: the old fragment picker.
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.