DetailedBalanceScientificBenchmark
==================================

# **THIS PAGE CONTAINS LEGACY INFORMATION ABOUT SCIENTIFIC TESTS BEFORE THEY WERE RE-IMPLEMENTED IN 2018**

A Markov process preserves [detailed balance](http://en.wikipedia.org/wiki/Detailed_balance) if the ratio
transition probability between any two states states is equal to the
ratio of the probability of the states themselves. If it can be shown
that it does, then the Markov process is reversible and evolving the
system will equilibrate it to the stationary distribution.

The **detailed\_balance** scientific benchmark tests if the
*BackrubMover*, *SidechainMover*, and *SmallMover* satisfy detailed
balance.

BackrubMover Detailed Balance
-----------------------------

The first test defines a Markov process where the states are the
conformations of an 8 residue poly-alanine peptide and the transitions
are those defined by the
*[[BackrubMover]]* with
weight 0.99 and the *SmallMover* with weight 0.01. The process is
evolved for 5,000,000 steps.

The *BackrubMover* satisfies detailed balance if the observed
distribution over all degrees of freedom is uniform according to the
spherical coordinate Jacobian (i.e. uniform for azimuth angles and
sinusoidal for zenith angles). To test this, the *DOFHistogramRecorder*
is used to construct a histogram over the torsion angles (*PHI*) and
bond angles (*THETA*) in the backbone. The detailed\_balance scientific
benchmark records the mean squared error (*MSE*) away from the expected
uniform distribution. Given the amount of sampling used in the test, the
expected average MSE should be below 1e-5. Here is an example of a
successfull run:

        BackrubMover average PHI MSE : 6.10506e-06
        BackrubMover average THETA MSE : 1.98768e-07

SmallMover Detailed Balance
---------------------------

Here is an example of a successfull run:

        SmallMover average MSE : 3.01119e-06

SidechainMover Detailed Balance
-------------------------------

The second test measures the detailed balance of the
*[[SidechainMover]]*, which samples off-rotamer sidechain conformations. By default,
*SidechainMover* samples sidechain conformations with respect to
Boltzmann distribution associated with the dunbrack rotamer energy. When
testing the detailed balance, the *SidechainMover* samples sidechain
conformations uniformly over the torsional angle degrees of freedom.

For each of the 20 canonical amino acids, a single residue pose is
constructed and sidechain conformations are sampled with a within
rotamer weight of 0.45 for 200000 steps. The detailed\_balance
scientific benchmark records the mean squared error (MSE) away from the
expected uniform distribution averaged over all amino acid types. Given
the amount of sampling used in the test, the expected average MSE should
be below 1e-5. Here is an example of a successfull run:

        SidechainMover average MSE : 9.23451e-06

##See Also

* [[Scientific Benchmarks]]: Main scientific tests page
    - [[Docking scientific tests|DockingScientificBenchmark]]
* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]
* [[RosettaEncyclopedia]]
* [[Glossary]]