# Additional changes made after the Chemical XRW

Page created 9 February 2016 by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory.

## Changes to PDB formatting:
- PDB files now have TER records at the end of every chain (pull request #1066), and atom indices increment appropriately after TER records.  This matches the PDB standard.  Legacy behaviour (only writing TER records at the end of all of the ATOM records) can be restored with the ```-out:file:no_chainend_ter``` flag.