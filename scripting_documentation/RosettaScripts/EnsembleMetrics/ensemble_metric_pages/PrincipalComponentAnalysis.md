# PrincipalComponentAnalysis Ensemble Metric
*Back to [[SimpleMetrics]] page.*
## PrincipalComponentAnalysis Ensemble Metric

[[_TOC_]]

### Description

The PrincipalComponentAnalysis EnsembleMetric is intended to be applied to an ensemble of structures that represent small perturbations of an input structure.  For each structure, it generates a vector of user-defined degrees of freedom.  These are typically backbone (and, optionally, side-chain) torsions, but they can include bond angles, bond lengths, rigid-body translations and rotations, and even Cartesian coordinates.  Once a degree-of-freedom vector has been stored for each pose in an ensemble, this EnsembleMetric performs principal component analysis.  This identifies the linear combinations of degrees of freedom that allow the greatest motion.  When the analysis is weighted by Rosetta energy, the combined degrees of freedom that allow the greatest motion _while remaining in low-energy regions of conformation space_ are identified.

This EnsembleMetric can be used in conjunction with the [[visualize_principal_components_of_motion]] application in order to make movies showing these motion vectors.

### Author and history

Created Thursday, 25 February 2022 by Vikram K. Mulligan, Center for Computational Biology, Flatiron Institute (vmulligan@flatironinstitute.org).  This was the second [[EnsembleMetric|EnsembleMetrics]] implemented

### Interface

[[include:ensemble_metric_PrincipalComponentAnalysis_type]]

### Note about weighting by energy

By default, the analysis is weighted by energy.  This has two effects:

- When computing the centre of the distribution of conformations, each sample contributes in proportion to its Boltzmann probability, computed as `exp(-E_i/(kbT))/Z`, where `E_i` is the energy of the sample, `kbt` is the user-specified Boltzmann temperature (with 0.62 kcal/mol representing physiological temperature), and `Z` is the partition function (equal to the sum of `exp(-E_i/(kbT))` for all samples `i`).
- Once the centre is subtracted off of each degree-of-freedom vector, each one is scaled by its Boltzmann probability.  This reduces the influence of the highest-energy samples and increases the influence of the lowest-energy.

The net effect of all of this is that the analysis ends up extracting degrees of freedom of motion that represent allowed motions that keep the protein in (mostly) low-energy conformations while still permitting as much motion as possible.

### Use with residue selectors

TODO TODO TODO

### Example

TODO TODO TODO

### Outputs

#### Report and report file

The primary output is a machine- and human-readable degree-of-freedom file.  This contains:

- A binary silent structure that allows reconstruction of a pose representing the centre (or energy-weighted centre) of the ensemble of degree-of-freedom vectors.
- A vector of degree-of-freedom identities, annotating the subsequent degree-of-freedom vectors.
- A set of degree-of-freedom eigenvectors from principal component analysis.  These are arranged in order, with the first accounting for the greatest part of the variance in structure, the second for the second-greatest, etc.  All are normalized.
- A set of degree-of-freedom eigenvalues from principal component analysis.  These indicate the relative contributions of each motion vector to the variance.

This file may be read by Rosetta's [[visualize_principal_components_of_motion]] application in order to generate pose series animating the major degrees of freedom of motion.  Future support is also planned for connecting this to the [[parametric design code|MakeBundleMover]] so that one may sample along the first few motion vectors during protein design or docking, allowing limited backbone flexibility while still restricting the dimensionality of the degree-of-freedom space.

#### Named values produced

TODO TODO TODO

### Limitations

Principal component analysis is fundamentally a linear algebra technique.  This means that it is restricted to identifying motion vectors that are _linear combinations_ of the degrees of freedom being considered.  While it is a good approximation to say that motions are linear on a small scale, larger-scale motions cannot be captured in this way.  Various nonlinear principal manifold analysis methods exist which could be applied more generally, but that is the subject of future research.

## See Also

* [[SimpleMetrics]]: Available SimpleMetrics.
* [[CentralTendency EnsembleMetric|CentralTendency]]: An EnsembleMetric that computes mean, median, and mode of values produced by a [[SimpleMetric|SimpleMetrics]].
* [[EnsembleMetrics]]: Available EnsembleMetrics.
* [[I want to do x]]: Guide to choosing a tool in Rosetta.