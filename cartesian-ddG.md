#cartesian\_ddg application

Metadata
========
The documentation was last updated November 2nd, 2016, by Hahnbeom Park and Yuan Liu. Questions about this documentation should be directed to Frank DiMaio: dimaio(@u.washington.edu). The documentation is only for monomeric ddg calculation for now (PPI mode and small molecule mode are not well tested).


Reference
==========

The algorithm is developed by Phil Bradley and Yuan Liu. Details about the method and benchmark result on monomeric ddg dataset (Kellogg et al) was published in:

Hahnbeom Park, Philip Bradley, Per Greisen Jr., Yuan Liu, Vikram Khipple Mulligan, David E Kim, David Baker, and Frank DiMaio (2016) "Simultaneous optimization of biomolecular energy function on features from small molecules and macromolecules", JCTC.


Command Line Options
====================
First, input pdb should be properly relaxed in cartesian space with restrained backbone and sidechain coordinates. Please refer to [[here|relax]] for more information.

### Protein stability mode

An example of command line is
```
cartesian_ddg.linuxgccrelease
 -database $ROSETTADB
 -s [inputpdb]
 –ddg:mut_file [mutfile] # same syntax with what being used in ddg-monomer application; see [[here | ddg-monomer]].
 -ddg:iterations 3 # can be flexible; 3 is fast and reasonable
 -ddg::cartesian
 -ddg::dump_pdbs false # you can save mutants pdb if you want
 -bbnbr 1 # bb dof, suggestion: i-1, i, i+1
 -fa_max_dis 9.0 # modify fa_atr and fa_sol behavior, really important for protein stability (default: 6)  
 -[scorefunction option]: any other options for score function containing cart_bonded term, for example, -beta_cart or -score:weights talaris2014_cart]
```

### Interface mode

This app can do PPI and Protein small molecule simulation (not well tested).

Optional options:
```
-mut_only #skip native structure
-interface_ddg -1 #jump number for interface (-1 means the last jump)
```


Expected Outputs & post-processing
===============

Running application will produce a file named [pdbfile_prefix]\_[mutationindex].ddg; for example 1ctf\_G44S.ddg.

The file contains lines:
```
BEFORE_JUMP: RoundX: [WT or MUT\_XXXX]: [totalscore] fa_atr: [fa\_atr] .....
```

In the paper, the difference in totalscores averaged over 3 rounds for WT and MUT is taken as ddG:

```
ddG = avrg(MUT totalscore) - avrg(WT totalscore)
```



##See Also

* [[Analysis applications | ddg-monomer]]:
