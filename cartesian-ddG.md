#cartesian\_ddg application

Metadata
========
The documentation was last updated November 2nd, 2016, by Hahnbeom Park. Questions about this documentation should be directed to Frank DiMaio: dimaio(@u.washington.edu). The documentation is only for monomeric ddg calculation for now.

Reference
==========

The algorithm was published in:

Hahnbeom Park, Philip Bradley, Per Greisen Jr., Yuan Liu, Vikram Khipple Mulligan, David E Kim, David Baker, and Frank DiMaio (2016) "Simultaneous optimization of biomolecular energy function on features from small molecules and macromolecules", JCTC. 

How to run
==========
First, input pdb should be properly relaxed in cartesian space with restrained backbone and sidechain coordinates. Please refer to *[[here|relax]] for more information. 

Command line for ddg calculation:
$ROSETTA/source/bin/cartesian\_ddg.linuxgccrelease 
-database $ROSETTADB
-s [inputpdb] 
–ddg:mut\_file [mutfile] 
-ddg:iterations 3 -ddg::cartesian 
-ddg::dump\_pdbs false 
-bbnbr 1 -fa\_max\_dis 9.0
[any other options for score function containing cart_bonded term, for example, -beta_cart or -score:weights talaris2014_cart]

-ddg:mut\_file has the same syntax with what being used in ddg-monomer application; see *[[here | ddg-monomer]].

Expected Outputs & post-processing
===============
Running application will produce a file named [pdbfile_prefix]_[mutationindex].ddg; for example 1ctf_G44S.ddg. 

The file contains lines:
BEFORE_JUMP: RoundX: [WT or MUT_XXXX]: [totalscore] fa_atr: [fa_atr] .....

In the paper, the difference in totalscores averaged over 3 rounds for WT and MUT is taken as ddG:

ddG = <MUT totalscore> - <WT totalscore>, <> is average

##See Also
* [[Analysis applications | ddg-monomer]]: 