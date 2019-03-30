#Documentation for `rna_cluster`

Metadata
========

Author: Andrew Watkins

Added to documentation: Feb 2018

Code and Demo
=============

The central code for the `rna_score` application is in `       apps/public/rna/util/rna_score.cc      `

Application purpose
===========================================

This code is intended to cluster silent files (ideally, those containing RNA) in a manner that's fairly robust to features that the original "SWA legacy clusterer" could not have anticipated but that are common today (for example, noncanonical/chemically modified nucleic acids).

Input Files
===========

Required files
-------------

-   A silent file(s) containing RNA to cluster 

Options
=======

```
-cluster:radius                A radius in Angstroms separating cluster centers
-cluster:score_diff_cut        What score cutoff (from the minimum score)  of the silent file(s)
                               should be clustered? Defaults to clustering everything (well, within
                               1000000 units)
-cluster:auto_tune             As clustering proceeds, increase radius from 0.1 to 50.0A (default false)
```

Sample command line
-------------------

```
rna_cluster –in:file:silent swm_rebuild_full_model.out –nstruct 100 –cluster:radius 2.0 –out:file:silent TOP_ENERGY_CLUSTERS/top_energy_clusters.rna_cluster.out -in:file:native t_loop_modified_fixed_NATIVE_1ehz.pdb 
```


##See Also

* [[RNA applications]]: List of RNA applications
* [[Utilities Applications]]: List of utilities applications
* [[Application Documentation]]: Home page for application documentation
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Fixbb]]: App commonly used for design and/or threading with proteins
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
