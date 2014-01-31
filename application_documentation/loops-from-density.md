<!-- --- title: Loops From Density -->Documentation for the loops\_from\_density application

Metadata
========

Last edited Oct 31 2010 by Frank DiMaio. Code by Frank DiMaio ( [dimaio@u.washington.edu](#) ). P.I.: David Baker.

Code and Demo
=============

The code for this application is in src/apps/public/scenarios/loops\_from\_density.cc. Most of the work is done in subroutines in src/core/scoring/electron\_density/ElectronDensity.cc. This code is also used as part of a tutorial on using Rosetta to refine structures into density. The complete demo is in demo/electron\_density/cryoEM\_tutoral. The portions of the tutorial using this application are in 'scenario4\_loop\_remodel' and 'scenario8\_iterative\_loopmodel'.

References
==========

-   DiMaio F, Tyka MD, Baker ML, Chiu W, Baker D (2009). Refinement of protein structures into low-resolution density maps using rosetta. J. Mol. Biol. 392, 181-90.

Application purpose
===========================================

This is a simple routine aimed at automatically creating loopfiles for remodeling structures into density. It finds the regions of the structure with worst local fit to density, and rebuilds them, limiting how far into secondary structure elements are rebuilt.

Limitations
===========

This routine does not perform loop modeling. Rather, it creates input files for the [[loopmodeling application|loopmodel]] automatically. Please the the demo in 'demo/electron\_density/cryoEM\_tutoral/scenario4\_loop\_remodel' to see the role this application plays in a model-building pipeline.

Input Files
===========

Data must be input as a PDB file(s) with -s/-l.

Density maps must be provided with -edensity:map\_file (see [[density-fitting|density-map-scoring]] ).

Options
=======

There are only 4 options that are useful to the protocol's output:

-   -frac\_loop - the fraction of the structure we want to rebuild (the \# of residues rebuilt will not be exactly this fraction, but aim for this value)
-   -max\_strand\_melt - the maximum distance to rebuild into a strand (-1 means unlimited)
-   -max\_helix\_melt - the maximum distance to rebuild into a helix (-1 means unlimited)
-   -edensity:sliding\_window - compute local correlation scores using this window width

Tips
====

Generally '-frac\_loop 0.3 -max\_strand\_melt 1 -max\_helix\_melt -1 -edensity:sliding\_window 9' provides good results. If many short loops are predicted you might want to increase 'sliding\_window' or decrease 'frac\_loop'.

Expected Outputs
================

For each input PDB, a .loopfile is output. This may be used directly by [[loopmodeling|loopmodel]] . The output file also contains per-residue real-space correlations.
