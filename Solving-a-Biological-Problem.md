#Solving a Biological Problem

Metadata
========

Author: Jeliazko Jeliazkov and Andrew Watkins 

This document was last updated June 8, 2015, by both authors.

[[_TOC_]]

Solving a Biological Problem
=============

There are many biological problems of interest, often stemming from the central idea that sequence confers structure which in turn confers function.
Rosetta is a macromolecular modeling software capable of tackling some of these problems.
Common problems which are in the realm of Rosetta are listed below.

## Protein Structure Prediction

Note: put fold and dock in here as well as symmetry.

The general question to be answered below: given a sequence, can I predict the protein structure?
There are two approaches to predicting protein structure from sequence alone: _de novo_ and comparative or homology modeling.

### De Novo Modeling

Rosetta was initially created with _de novo_ protein structure prediction in mind.
_De novo_ structure prediction is useful when modeling a protein with low homology. 
_De novo_ structure prediction is accurate when modeling a small (<100 residues), globular protein.

### Comparative Modeling (Homology Modeling)

Comparative modeling on the other hand tends to be successful when the target sequence (sequence of interest) has a high degree of sequence homology (>50%) with a protein whose structure has been determined.

## Protein—Protein Docking

Another general question which can be interrogated by Rosetta is: given protein A and protein B, can I generate a plausible model for protein—protein interactions?
This problem can be conflated with the protein structure prediction problem when the structure of either protein A, protein B, or both are unknown.
Protein flexibility can play a role in protein docking. 
For example, high RMSD between the bound and unbound states makes prediction of the bound state from the unbound states difficult. 
On the other hand, biochemical information can be implemented as constraints in the scoring function during docking to (hopefully) improve model accuracy.

### Docking Two Partners With Known Structures

Reasonable.

### Docking Two Partners Where One Structure Is Unknown

Difficult.

### Docking Two Partners With Two Unknown Structures

Just do not.

## Protein—Ligand Docking

## Protein Design

### De Novo Protein Design

### Protein Redesign

### Protein Interface Design

### Enzyme Design

## Caveats

## Publicly Available Resources (Servers)

Incorporating Experimental Data
==========

