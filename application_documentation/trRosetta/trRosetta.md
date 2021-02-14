# trRosetta: Neural network-enhanced protein structure prediction

Documentation added 4 February 2021 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

## Application purpose
=====================

TODO

## trRosetta algorithm
======================

TODO

## Options
==========

TODO

## Limitations
==============

TODO

## Code 
=======

TODO

## References
=============

TODO

## History
==========

- The trRosetta neural network was developed by Jianyi Yang, Ivan Anishchenko, and Sergey Ovchinnikov in 2019.
- A PyRosetta-based protocol was developed for use in the 2020 CASP14 protein structure prediction competition.  This protocol converted trRosetta generated distance and inter-reside orientation probability distributions into Rosetta constraints, applied them to a pose, and used constrained minimization to generate the final structure (followed by all-atom relaxation with the [[FastRelax]] protocol.
- The C++ implementation was written in Jan-Feb 2021 by Vikram K. Mulligan, Flatiron Institute.

### Differences from original Python version

- The original PyRosetta implementation mutated all glycine residues to alanine during centroid phases of the protocol, and back again during the full-atom phase.  This allowed the CA1-CB1-CB2-CA2 dihedral to be defined even for glycine residues during centroid minimization, but during full-atom minimization, glycine orientation constraints were ignored.  The C++ implementation follows nearly the same protocol, with two exceptions:
    - Although glycine residues are temporarily mutated to alanine during the centroid phase, and then reverted to glycine for full-atom refinement, as in the Python protocol, _if_ this were overridden, the C++ code uses the CEN atom in place of CB for glycine residues when constraining dihedrals in centroid mode.
    - In fullatom mode, the C++ code uses 1HA in place of CB for glycine residues when constraining dihedrals.  This means that orientation constraints for glycine are _not_ ignored in fullatom refinement phases.

##See Also
* [[Structure prediction applications]]: Includes links to these and other applications for loop modeling
* [[RosettaScripts]]: The RosettaScripts home page
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
