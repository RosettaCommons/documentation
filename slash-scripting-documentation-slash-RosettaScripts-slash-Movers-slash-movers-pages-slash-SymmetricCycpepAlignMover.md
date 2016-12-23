# SymmetricCycpepAlignMover

Documentation created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory, on 23 December 2016.
*Back to [[Mover|Movers-RosettaScripts]] page.*

## SymmetricCycpepAlignMover

[[_TOC_]]

### Description

Given a quasi-symmetric cyclic peptide, this mover aligns the peptide so that the cyclic symmetry axis lies along the Z-axis and the centre of mass is at the origin.  It then optionally removes all but one symmetry repeat, so that true symmetry may be set up with the [[SetupForSymmetry|SetupForSymmetryMover]] mover.