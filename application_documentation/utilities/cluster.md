#Cluster application

Metadata
========

This document was edited May 25th 2014 by Jared Adolf-Bryfogle. This application in mini was created and documented by Mike Tyka,et al.

Purpose and Algorithm
=====================

The "cluster" application in Rosetta carries out a simple clustering of structures (either PDB or silent file format). The algorithm is based on one of Phil Bradley's old programs (silent\_cluster\_c). Starting with a subset of structures (the first 400 structures) the algorithm finds the structure with the largest number of neighbors within the cluster radius and creates a first cluster with that structure as the cluster center and the neighbors part of and claimed by the cluster. The structures are removed from the pool of "unclaimed" structures. The algorithm is then repeated untill all structures are assigned a cluster. The remainder of structures are then assigned to clusters (this avoids having to calculate a full rms matrix) one by one. The rule is that any structure joins the cluster to who's cluster center it is most similar to. If the closest cluster is more then "cluster\_radius" away the structure will form a new cluster. This rule is applied to all remaining structures. Clusters can be size limited, sorted by energy etc.. (see options) 

Note that the cluster application cannot sometimes handle very large sets of structures.  It is recommended to use a program that has been optimized for such a purpose such as [Calibur](http://sourceforge.net/projects/calibur/) instead.

Command Line Options
====================

Sample command\*

```
cluster.linuxgccrelease @flags > cluster.log
```

cluster can take all general file IO options common to all Rosetta applications

```
   -database                 Path to rosetta databases
   -in:file:s                Input pdb file(s)
   -in:file:silent           Input silent file
   -in:file:fullatom         Read as fullatom input structure
   -out:file:silent          Output silent structures instead of PDBs
   -score:weights            Supply a different weights file (default is score12)
   -score:patch              Supply a different patch file (default is score12)
   -run:shuffle              Use shuffle mode
```

Options specific to cluster

```
   -cluster:radius  <float>                    Cluster radius in A (for RMS clustering) or in inverse GDT_TS for GDT clustering. Use "-1" to trigger automatic radius detection
   -cluster:gdtmm                              Cluster by gdtmm instead of rms
   -cluster:input_score_filter  <float>        Ignore structures above certain energy
   -cluster:exclude_res <int> [<int> <int> ..] Exclude residue numbers from structural comparisons
   -cluster:radius        <float>              Cluster radius
   -cluster:limit_cluster_size      <int>      Maximal cluster size
   -cluster:limit_clusters          <int>      Maximal number of clusters
   -cluster:limit_total_structures  <int>      Maximal number of structures in total
   -cluster:sort_groups_by_energy              Sort clusters by energy.

Examples:
cluster -database /path/to/rosetta/main/database -in:file:silent silent.out -in::file::binary_silentfile -in::file::fullatom -native 1a19.pdb
clustered Poses are given output names in the form of:
c.i.j, which denotes the jth member of the ith cluster.
```

Limitations
===========
The app can only reasonably handle up to around 2000 poses.  After that, it WILL run into memory issues.
Please see [[calibur-clustering]] for an alternative clustering app that does not run into these problems.

## See also

* [[The energy_based_clustering application | energy_based_clustering_application]].
* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Preparing structures]]: How to prepare structures for use in Rosetta