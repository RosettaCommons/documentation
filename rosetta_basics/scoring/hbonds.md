#Hydrogen Bond Energy Term

**TODO: This page is out of date and in need of an update by someone familiar with the material.**

The hydrogen bond energy term identifies and scores hydrogen bonds.

Metadata
========

This document was written by Matthew O'Meara on 6/18/2008


HBEvalType
==========

Each hydrogen bond has an HBEvalType that identifies what type it is. All hydrogen bonds of a given type are treated in the same way. If one wanted to break out a class of hydrogen bonds to have different behavior, a new HBEvalType should be created.

Overview
========

To use the hydrogen bond energy term there are three conceptual steps. First, identify all the relevent bonds; second, classify the hydrogen bonds based on their chemical type, environment, background hbonds, etc.; and third, score the hydrogen bonds.

Identification
==============

The goal of the identification step is to create an HBondSet object that contains exactly the hydrogen bonds of interest. If it contains too many, then they will need to be filtered more later; if they contain not enough then more will need to be found later, when all that should happen in this step.

-   Create new HBondSet set to receive identified hbonds. Set pass in or set hbond options for hbond\_set. Call fill\_hbond\_set excluding unwanted hbonds to fill hbond\_set.
-   Extract a portion of an existing HBondSet such as from pose.energies().data().get( HBOND\_SET ).
-   Create HBondSet by giving explicit donor acceptor residues identify\_hbonds\_1way.

Classification
==============

Currently hydrogen bonds are classified by backbone/sidechain protein-dna / generic, and hybridization type of the acceptor (sp2, sp3, ring). These types are refined by sequence separation. For bonds involving protein backbones this indicates secondary structure. Backbone-sidechain hydrogen bonds are split into short-range and long-range.

Hydrogen bonds are classified by hbond\_evaluation\_type() in hbonds\_geom.cc

Evaluation
==========

Currently the evaluation for hydrogen bonds follows

Kortemme, T., A. V. Morozov and D. Baker (2003). "An orientation-dependent hydrogen bonding potential improves prediction of specificity and structure for proteins and protein-protein complexes." J Mol Biol 326(4): 1239-59.

Jack Snoeyink has re-implemented it as a efficient polynomial evaluation.

The derivative evaluation follows what is described in,

Wedemeyer, W., Baker, D., "Efficient minimization of angle-dependent potentials for polypeptides in internal coordinates", Proteins: Structure, Function, and Bioinformatics Volume 53 Issue 2, Pages 262-272

Definition of Hydrogen Bonding
==============================

A hydrogen bond donor and a hydrogen bond acceptor are considered hydrogen bonded if they contribute favorably to the overall energy.

Note: If there is a backbone-backbone hydrogen bond then neither the donor nor the acceptor residues are allowed to participate in a backbone-sidechain hydrogen bond. According to Brian Kuhlman, this was put in the early days of Rosetta because the hydrogen bond energy term at the time put overly favored serines on helixes because they would form backbone-backbone hbonds for the helix and backbone-sidechain bonds away from the helix.

Refactoring and plan for improvements
====================================

1) Move options into HBondOptions class

2) Use emap to assign energies from hbonds

3) Only put hbonds in HBondSets that are actually relevant (rather than filtering when they are used)

4) Merge non-protein/non-dna hbond code with rest of hbond code.

5) Make new HBEvalTypes so evaluation and energy assignment can be handled uniformly

6) Clean up header files

7) Add a hbond unit test for energy evaluation over geometric parameter range

8) Add doxygen documentation for hbond code

Plans:

1) Create new HBEvalTypes based off of functional group of donor and acceptor and secondary structure for protein backbone backbone bonds.

2) Implement improved 1d polynomials for new types.

3) Add "chi" out-of-plane dependence as a 4th geometric dimension

5) Implement evaluation functions for distributions with coupled parameters.

##See Also


* [[Rosetta overview]]
* [[Units in Rosetta]]: Gives a description of Rosetta energy units
* [[Scoring explained]]
* [[Score functions and score terms|score-types]]
* [[Additional score terms|score-types-additional]]
* [[Scorefunctions for noncanonical residues and molecules|NC-scorefunction-info]]
