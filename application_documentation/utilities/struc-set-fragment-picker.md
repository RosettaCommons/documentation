#Documentation for the struc_set_fragment_picker

Metadata
========

Authors:  
Ingemar André (ingemar.andre@biochemistry.lu.se)  
Sebastian Rämisch (sebastian.ramisch@biochemistry.lu.se)  

Last edited 10/15/15. Corresponding PI: Ingemar André

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

Generate fragment sets for Rosetta protein structure modeling using a predefined set of protein structures as fragment source.
*The original intention was to predict coiled-coil structures using exclusively fragments taken from coiled-coil structures.* 

How to run
===========================================
1. Download all pdb files you intend to use as sources to some directory. 
2. Run the struc_set_fragment_picker from inside that directory and copy the generated fragment files to wherever you need them. This will be changed later.

Input
=====
The only input file is a list of the pdb names to be used. E.g.:   
```
1e5t
3tg7
2guv
...
```

Required options
============================================

| Option | Explanation |
| --- | --- | --- |
| -in::file::l <list file>    | list of structures |
| -cc_frag_app::frag_length <int> | Fragment length. Usually 3 or 9. |
| -cc_frag_app::sequence_length <int> | Length of target sequence. |
| -cc_frag_app::frag_name <string> | Name of the output fragment file. Usually 5 characters.|

Output
======
The output is a standard Rosetta fragment file to be used for structure prediction.