#Challenges in Macromolecular Modeling

## Introduction
Clearly, the computational modeling of biological macromolecules is not a closed field.
Rosetta cannot precisely model every single given macromolecule.
Barring human/operator error, there are two general problems which make modeling challenging.

The first problem is referred to as the *scoring problem*: given a set of models of macromolecular structures, say proteins, can the Rosetta scoring function (or any scoring function) rank the models such that the best scoring (lowest energy) model is representative of the protein/macromolecule occurring in nature?

The second problem is known as the *sampling problem*: how do we know that, during a simulation, enough of conformational space has been explored to sample the conformation occurring in nature?

[[_TOC_]]

## The Scoring Problem
As stated in the introduction, the scoring problem is the challenge of developing a scoring function which can identify the native conformation.
Inaccurate scoring is a difficult problem to overcome, but should be relatively straightforward to diagnose.
If a native structure is available, this can be done by scoring the native structure and comparing the score of the native to that of the models.
If the native score is much higher than that of the models, then either the native was not relaxed (see [[here|preparing-structures]]) or the score function is flawed.
The most direct way to fix this problem is the either (a) develop a different metric for scoring (whether it be using a different score function or developing one of your own) or (b) implement a [[constraint|constraint-file]] which effectively appends a term to the scoring function.

## The Sampling Problem
As stated in the introduction, the sampling problem is the challenge of _actually_ sampling the native conformation or even sampling about native in conformation space.

Generally, this problem can be subdivided into two categories:
1. Does the algorithm sample enough?
2. Does the algorithm sample the relevant degrees of freedom?

### Sampling the Wrong Degrees of Freedom
In theory, protocols should be designed to sample relevant degrees of freedom and this is not something an end user should be concerned with.
However, if working with a scripting language or a particular problem which is not directly address by a published protocol, this can be a concern.

### Not Sampling Enough
Often times, a new user will not "sample enough". 
This means that the user has not generated (or simulated) enough models.
See [[Rosetta on different scales|Rosetta-on-different-scales]] for more on how much sampling should be done.


