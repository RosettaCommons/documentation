#RECCES: Reweighting of Energy-function Collection with Conformational Ensemble Sampling

Metadata
========

Author: Fang-Chieh Chou

May 2015 by Fang-Chieh Chou (fcchou [at] stanford.edu).

Code and Demo
=============

The main RECCES application is `main/source/src/apps/public/rna_util/recces_turner.cc`. It is accompanied by a set of python codes in `tools/recces`. A  README file for the python codes is included. The optimized RECCES score function is `main/database/scoring/stepwise/rna/turner.wts`.

For a minimal demonstration of RECCES, see: `demos/public/recces/`. 
[Online documentation for the RECCES demo](https://www.rosettacommons.org/demos/latest/public/recces/README) is also available.

Application purpose
===================

This code provides a way to compute the free energy of an RNA molecule using
comprehensive sampling to account for the conformational entropy. RECCES also
allows rapid reweighting of the score function by caching the sub-scores of
each sampled conformation.

Algorithm
=========

RECCES uses simulated-tempering Monte Carlo methods to efficiently sample the
conformational ensemble. Standard Rosetta score terms are used for the
calculation; the terms are then reweighted to fit against experimental folding

Limitations
===========

-   RECCES currently works for RNA duplexes and dangling-ends only. While it
is possible to extend the framework to other non-canonical RNA motifs and even
protein applications, such work has not yet been performed.

-   The score terms being cached are currently hard-coded in the source code 
(recces_turner.cc) and the Python scripts; therefore adding new score terms 
requires editing the codes, which is not convenient. This can be make more 
general in the future by including a `current_score_terms` file for both the 
Rosetta and Python codes.

Modes
=====

There is only one mode to run RECCES at present.

Input Files
===========

There is no specific input file required RECCES. One may use a different score
function file for the simulated tempering simulation, other than the standard
`stepwise/rna/turner.wts` (but if the score terms are different than in those
turner.wts, then you need to modify the source code).

Tutorial
========

See `demos/public/recces/` for the latest demo for running RECCES.


Options
=======

Below are a list of available arguments for the `recces_turner` application.

```
-seq1 <String>
The sequence of the first strand (or the full sequence if it is single-stranded).

-seq2 <String>
The sequence of the second strand (skip if it is single-stranded).

-n_cycle <Int>
The number of Monte Carlo cycles.

-temps <Double/List of Doubles>
The simulation temperature. If it is a single value, the code performs
standard Monte Carlo at the given temperature. If the input is a list of
values, the code will run simulated tempering (ST).

-st_weights <List of Doubles>
The ST weights for simulations. Need to be specified if multiple temperatures
are given. Can be determined by short pre-runs (see demo).

-out_prefix <String>
Prefix for the RECCES output files.

-save_score_terms
If this option is supplied, RECCES will cache the values for each score terms.
Otherwise only the score histograms are returned.

-a_form_range <Double>
The sampling range for A-form conformations (duplex). Default is 60
(+/- 60 degress from ideal values).

-dump_pdb
If suppiled, the program will dump pdb files for examination.

-n_intermediate_dump <Int>
Dump the given amount of pdb structures for illustration purposes.
```

Expected Outputs
================

Each RECCES run will generate one or several (depending whether ST is used)
score histograms. If `-save_score_terms` is used, it also outputs the cached
score terms for each sampled conformation. The result can then be analyzed
using the Python scripts (see demo and `tools/recces/README`).


##See Also

* [[RNA applications]]: The RNA applications home page
* [[Analysis Applications]]: List of analysis applications
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Application Documentation]]: Home page for application documentation
* [[Application Documentation]]: Home page for application documentation
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files