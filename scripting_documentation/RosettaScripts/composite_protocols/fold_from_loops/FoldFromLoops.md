The **FoldFromLoops (FFL)** protocol is a variant of the _grafting protocol_.  
The protocol is aimed towards the insertion of structural motifs with a high RMSD distance to the insertion region in the target scaffold.

> This documentation refers to the **FFL2.0** protocol, integrated as part of _RosettaScripts_. To learn about the first version of the protocol (**FFL1.0** or **FFL_legacy**) as described in [Correia _et al._, 2014](http://doi.org/10.1038/nature12966) see [apps/fold_from_loops]()

# Overview:

**FFL** requires two input structures: one containing the **motif** or structural segment that we want to keep/transfer into a new protein and the **template** or the scaffold that will define the structure that will support the motif.  
Broadly, the steps that the protocol follows are (**M**-Mandatory, **R**-Recommended):  

1.  Extract constraints from the **template** (_R_).
2.  Generate structure-based fragments from the **template** (_M_).
3.  Unfold the **template** and attach it to the **motif** region (_M_).
4.  Perform _ab initio_ allowing movement in all the **template** regions but keeping the **motif** regions fixed (_M_).
5.  Design/Relax the final structure without allowing movement in the **motif** (_R_).

## Highlights
### 