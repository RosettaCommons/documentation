Units in Rosetta
================

This is a description of how Rosetta handles various units. Unlike some molecular mechanics packages, Rosetta does not necessarily have a fixed system of units. Different parts of Rosetta may use different units for the same quantities, depending on their underlying application and usage. 

Distance
========

The most common distance unit in Rosetta is the Angstrom (1x10^-10 meter, or 0.1 nm), unless otherwise specified.

Angles
======

Most user-facing usage of angular measures are in degrees. However, radian measures are used internally in parts of Rosetta, so use of angular measures in radians for input/output is possible, depending on protocol. In particular, angle and dihedral constraints (including their specification in input constraint files) are specified in radians.

Time
====

Because Rosetta primarily uses non-timestep based Monte Carlo procedures, there isn't a concept of an intrinsic timestep in Rosetta, as there is in molecular mechanics based applications. The most common application for time in Rosetta is to represent protocol runtimes, which are typically measured in seconds, unless otherwise specified.

Mass
====

Mass is infrequently specified in Rosetta. When it is, it's often given in atomic mass units (a.m.u.).

Energy
======

Because the Rosetta energy function is a combination of physic-based and statistics-based potentials it doesn't attempt to to match up with actual physical energy units (e.g. kcal/mol or kJ/mol). Rosetta energies are on an arbitrary scale, sometimes referred to as REU (for "Rosetta Energy Unit").

Furthermore, Rosetta employs a mix of differing energy functions which vary based on how detailed the sampling is. For example, many protocols use a coarse-grained "centroid" representation of proteins to speed early-stage sampling. The energy functions used with this coarse-grained representation is by necessity different than that used for full atom sampling. In practice it is difficult to calibrate the values of such a coarse-grained energy function against that of the full atom energy function, so no attempt is made to match the values of the two energy functions. The same applies even for different full-atom energy functions used for different protocols, so an "REU" for one protocol might not be comparable to an "REU" for another protocol.

The one consistency there is between energy functions is that structures with lower energies are considered to be better than structures with higher energies. So while the absolute values of Rosetta energies are not necessarily comparable between protocols, energies within each protocol should be comparable among each other.

With those caveats in mind, in many cases it is possible to derive a conversion from Rosetta-produced energy values to absolute experimental values in kcal/mol or kJ/mol. The approach is to run the particular protocol you wish to use against a set of benchmark cases with know experimental energies. From these data points you can derive a line of best fit between the experimental values and the Rosetta-produced values, yielding a conversion factor. (See [Kellogg et al.](http://www.ncbi.nlm.nih.gov/pubmed/21287615) for an example.) When such conversions are produced, they are almost always linear, although the slope and intercept values may vary depending on protocol and the exact quantity being measured.

Temperature
===========

Most often when "temperature" is referred to in Rosetta, it's not the true thermodynamic temperature (in Kelvin), but rather the equivalent of kT (the Boltzmann constant times the temperature) in the corresponding Rosetta energy unit. That is, it's the denominator of the Boltzman factor exponent in units of REU. 

##See Also

* [[Analyzing Results]]: Tips for analyzing results in Rosetta
* [[Glossary]]: Brief definitions of Rosetta terms
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Score functions and score terms|score-types]]
* [[Solving a Biological Problem]]: Guide for applying Rosetta to your biological problem