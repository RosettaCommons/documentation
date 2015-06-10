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

## The Sampling Problem
As stated in the introduction, the sampling problem is the challenge of _actually_ sampling the native conformation.
This problem can be subdivided into two:
- does the algorithm sample enough?
- does the algorithm sample the relevant degrees of freedom?

### Not Sampling Enough
Link to Rosetta scales.

### Sampling the Wrong Degrees of Freedom
