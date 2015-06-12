#RNA pharmacophore Commands

Metadata
========

This document was last updated on May 28, 2015, by Ragul Gowthaman (ragul@ku.edu).

The corresponding principal investigator is John Karanicolas (johnk@ku.edu).

Purpose and Algorithm
=====================

Building hotspot pharmacophores

To select deeply buried RNA bases, the solvent accessible surface area (SASA) of each base in the RNA was calculated in the presence and absence of the protein. A base was carried forward if the change in SASA upon complexation was greater than a preset cutoff value (46.81 Å2 for adenine, 31.09 Å2 for cytosine, 45.06 Å2 for guanine and 52.66 Å2 for uracil); these values correspond to the median values of 344 non-redundant protein-RNA complexes retrieved from the Protein-RNA Interface Database (PRIDB) in March 2013 (http://pridb.gdcb.iastate.edu/download/RB344.txt).
Polar groups from the RNA that participate in intermolecular hydrogen bonding (as defined using the Rosetta energy function) are also included.

The resulting interaction maps are then clustered using a modified version of Kruskal’s minimum spanning tree algorithm. We first build a complete graph, in which vertices are the ring moieties, and the edge weights are the Euclidean distances between vertices. Then we take edges in ascending order and cluster the end vertices of that edge if no cycle would be caused. We halt the clustering when the distance is greater than a user-specified cutoff value (default 5.0 Å). The donor/acceptor atoms are then assigned to the closest ring moieties if the distance is less than another user-specified value (default 5.0 Å). Finally, we output the pharmacophore templates if the cluster contains at least two ring moieties. 

References
==========

Xia Y*, Gowthaman R*, Lan L, Rogers S, Wolfe A, Gomez C, Ramirez O, Tsao BW, Marquez RT, Yu J, Pillai M, Neufeld KL, Aubé J, Xu L, and Karanicolas J. (2015). Rationally designing inhibitors of the Musashi protein–RNA interaction by hotspot mimicry (in review)
*Authors contributed equally

Command Line Options
====================

**Sample command**

```
RNA_pharmacophore.macosclangrelease -input_protein protein.pdb -input_rna rna.pdb 
```

***RNA_pahrmacophore options***

```

   -min_num_ring                Minimum number of ring moieties required to be present in the output clusters, default=2
   -ring_ring_dist_cutoff       ring - ring distance cutoff to include in the cluster, default=5
   -ring_atm_dist_cutoff        ring - atom distance cutoff to include in the cluster, default=5

General Rosetta Options
   -database                   Path to rosetta databases

```

##See Also

* [[RNA applications]]: The RNA applications home page
* [[Utilities Applications]]: List of utilities applications
* [[Tools]]: Python-based tools for use in Rosetta
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Application Documentation]]: Home page for application documentation
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files