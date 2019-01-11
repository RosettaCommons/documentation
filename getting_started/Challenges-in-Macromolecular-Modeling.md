#Challenges in Macromolecular Modeling

## Introduction
No single modeling system, Rosetta included, can produce perfect solutions to every modeling problem.
Barring human/operator error, issues that prevent perfect solutions owe to either scoring or sampling.

The *scoring problem* asks whether, given a set of models, the scoring function can rank the models such that the best scoring model is representative of the natural or optimal macromolecular sequence and structure?

The *sampling problem* asks whether a set of models includes the naturally occurring or optimal sequence and structure in the first place.

[[_TOC_]]

## The Scoring Problem
You may simply be getting the wrong answer because the scoring function favors a non-native conformation or sequence.
This is quite easy to diagnose if you _know_ the native conformation or sequence.
Simply score a relaxed ensemble derived from it and compare to the ensemble of your models; if the native score is much higher than that of the models, then either the native was not relaxed (see [[here|preparing-structures]]) or the score function is flawed.
In such a case, you can test your hypothesis about the discrepancy involved by implementing a [[constraint|constraint-file]] which effectively appends a term to the scoring function.
For example, if a few residues ought to form a strand (by experimental data), restrain their dihedrals and see if that produces native-like structures.

When you do not have a native structure, you can't determine whether you're scoring properly or not nearly so easily. At best, you could obtain some weak evidence if you have structures of very closely related proteins; if the scoring function consistently fails them in this sense, it may be a poor choice for your case as well.

## The Sampling Problem
There are two reasons you may not be sampling the native sequence or structure: 
### Sampling the Wrong Degrees of Freedom
Your [[choice of protocol|I want to do x]] is critical. If you want to fold a protein sequence _ab initio_, do not build an extended peptide, run the minimizer, and hope.
(Similarly, do not build an extended peptide and run a Monte Carlo trajectory of [[SmallMoves|SmallMover]] for several decades.) 

There are subtle errors, too.
For example, maybe your protein has a cis peptide bond (at a non proline position).
These are rare but hardly unheard of, and in many situations you will not sample that conformation unless you force Rosetta to consider the possibility.
Furthermore, what if your protein has a strained bond angle because of a highly constrained geometry? You may not even realize that Cartesian minimization, or other modalities for bond angle and length optimization, are an option.

### Not Sampling Enough
Often times, a new user will not "sample enough". 
This means that the user has not generated enough models.
See [[Rosetta on different scales|Rosetta-on-different-scales]] for more on how much sampling should be done.


##See Also

* [[Rosetta on different scales]]: A guide on the number of structures to generate for different Rosetta protocols
* [[Analyzing Results]]: How to interpret results generated using Rosetta
* [[Scoring explained]]
* [[I want to do x]]: Guide on performing different forms of sampling in Rosetta
* [[Units in Rosetta]]: Discusses Rosetta units, including energy units
* [[Comparing structures]]: Essay on comparing structures
* [[Resources for learning biophysics and computational modeling]]
* [[Getting Started]]: A page for people new to Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta