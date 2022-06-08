# Quantum mechanical energy calculations in Rosetta

Back to [[Rosetta basics|Rosetta-Basics]].
Page created 16 November 2021 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

## Summary

Traditionally, Rosetta has used a quasi-Newtonian force field for energy calculations.  This has allowed Rosetta protocols to score a large macromolecular structure rapidly (typically in milliseconds) and repeatedly, permitting large-scale sampling of conformation and/or sequence space.  The downside, however, has been that force fields are of finite accuracy.  In late 2021, we added support for carrying out quantum mechanical energy and geometry optimization calculations in the context of a Rosetta protocol, by calling out to a third-party quantum chemistry software package.  This page summarizes how to set up and use this functionality.

## Important considerations

### Molecular system size, level of theory, and computation time

TODO

### Computer memory

TODO

### CPU usage (especially in multi-threaded or multi-process contexts)

TODO

### Disk usage

TODO

## Supported third-party quantum chemistry software packages

All Rosetta QM calculations are performed through calls to third-party quantum chemistry software packages.  These must be downloaded and installed separately, and users must have appropriate licences and privilegse to use these.  Supported packages include:

### The General Atomic and Molecular Electronic Structure System (GAMESS)

[[GAMESS|https://www.msg.chem.iastate.edu/index.html]] is a versatile quantum chemistry package written in FORTRAN, and developed by the [[Gordon group at Iowa State University|https://www.msg.chem.iastate.edu/group/members.html]].  Users may agree to the licence agreement and obtain the software from [[the GAMESS download page|https://www.msg.chem.iastate.edu/gamess/download.html]].

#### Installation and setup

To use GAMESS with Rosetta... TODO

#### Compiling GAMESS

#### Using GAMESS with Rosetta

##### Point energy calculations with GAMESS within a Rosetta protocol

TODO

##### Geometry optimization with GAMESS within a Rosetta protocol

TODO

##### Transition state identification with GAMESS within a Rosetta protocol

TODO

#### Rosetta-GAMESS bridge code organization

TODO

### Psi4

TODO

### Orca

TODO

### NWChem

TODO
