#Solving a Biological Problem

Metadata
========

Author: Jeliazko Jeliazov and Andrew Watkins 

This document was last updated June 8, 2015, by both authors.

Solving a Biological Problem
=============


Incorporating Experimental Data
==========

Potentially useful experimental data takes many forms.
The very nature of Monte Carlo simulation strongly supports the incorporation of any type of experimental constraint, because all you need it to do is allow it to influence the distribution of generated structures.

Rosetta has individual modules to handle particular forms of experimental constraint:

* [mr_protocols](application_documentation/mr-protocols) is typically used _alongside_ Phaser; it uses Rosetta's comparative modeling to rebuild gaps and insertions in the template, as well as missing density, from fragments, followed by relaxation with constraints to experimental density.
You can then use Phaser again to re-score against crystallographic data.
* [ERRASER](application_documentation/erraser) refines RNA structures from electron density (crystallographic data); it constitutes a workflow of _erraser_minimize_, _swa_rna_analytical_closure_, and _swa_rna_main.
It requires the use of the refinement program PHENIX.
* [loops from density](application_documentation/loops-from-density) is a script to take badly fit electron data and a cutoff suggesting how much of the pose you're willing to rebuild and to generate input "loops" files for loop modeling. 
* [Chemical shift files](rosetta_basics/chemical-shift-file) provide data to a variety of protocols often collectively referred to as CSROSETTA that incorporate NMR constraints to refine structures

Frequently, you will encounter situations where you have knowledge about the experimental system that does not neatly fit into any of the above situations, or which provides very sparse or even conflicting information.
This is all right: Rosetta's capacity for [working with constraints](rosetta_basics/constraint-file) will help to encode these sorts of weak information.
In particular:
* AmbiguousNMRDistance constraints encode distances between two atoms; importantly, rotationally equivalent/experimentally indistinguishable hydrogens are not distinguished.
* SiteConstraint constraints penalize or reward the proximity of a residue in one chain to another chain.
So, if you know that a residue has a large ddG upon mutation to alanine, you can probably apply a correspondingly large SiteConstraint to require that it be in the binding site.
(Though, notably, you may not want it to have the same magnitude as the ddG.)
* You can group constraints in a number of ways to accomodate mutually inconsistent data:
** An AmbiguousConstraint only applies the lowest energy penalty of several constraints.
Thus, if you know that two distant residues both ought to have a SiteConstraint applied, but they can't both bind at once, wrap them in an AmbiguousConstraint and you'll only evaluate the one your pose best satisfies.
** Similarly, a KofNConstraint will apply the lowest k of n constraints.
