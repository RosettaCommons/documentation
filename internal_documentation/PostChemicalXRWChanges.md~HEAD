# Additional changes made after the Chemical XRW

Page created 9 February 2016 by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory.

## Changes to PDB formatting:
- PDB files now have TER records at the end of every chain (pull request #1066), and atom indices increment appropriately after TER records.  This matches the PDB standard.  Legacy behaviour (only writing TER records at the end of all of the ATOM records) can be restored with the ```-out:file:no_chainend_ter``` flag.
- CONECT records are written by default for all noncanonicals (anything that's not a canonical L-alpha amino acid or a canonical nucleotide).  CONECT record output can be suppressed with the -skip_connect_info flag, or forced for all atoms with the -write_all_connect_info flag.  The cutoff distance default has been changed to 0.0 from 3.0.  (Pull request #1064.)