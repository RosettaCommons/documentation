#pocket_suggest_target_residues_by_ddg Commands

Metadata
========

This application in Rosetta3 was created and documented by David Johnson, et al.

Purpose and Algorithm
=====================

This application takes in a PDB file of a protein complex and Robetta ddg prediction output and suggests optimal target residues for pocket optimization with the goal of directly inhibiting the protein-protein interaction. It does so by identifying how much ddg would be contained in the PocketGrid derived from every pair of interface residues. The best target residue pairs will be those whose PocketGriod containts the most ddg, implying the most likely location for an inhibitor to inhibit the interaction.

References
==========

Johnson DK and Karanicolas J. Selectivity by small-molecule inhibitors of protein interactions can be driven by protein surface fluctuations. PLoS Comput Biol. 2015;11(2):e1004081

Command Line Options
====================

**Sample command**

```
pocket_suggest_target_residues_by_ddg.linuxgccrelease -database ~/Rosetta/main/database -in:file:s complex.pdb -ddg_list ddg.txt -target_chain_list A
```

***pocket_suggest_target_residues_by_ddg options***

```
General Rosetta Options
   -database                   Path to rosetta databases
   -in:file:s                  Input pdb file(s)

Other Mandatory Options
   -ddg_list                   Text file of ddg output from Robetta server
   -target_chain_list          List of chains of the protein on which pocket optimization will be performed

```

Tips
====

* Only the ddg output related to the chains in the target_chain_list is needed in the ddg_list file       

## See Also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
