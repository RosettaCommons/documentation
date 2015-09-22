# simple_cycpep_predict app

Page created 21 September 2015 by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).

## Overview

The **simple_cycpep_predict** app is intended to be a fragment-free design validation tool for small, backbone-cyclized peptide designs analogous to AbinitioRelax for proteins designs.  It sets up a chain with backbone-cyclization, uses GeneralizedKIC to sample conformations and close the geometry, then applies a few rounds of FastRelax.  User options permit users to filter based on the number of mainchain hydrogen bonds.

## User options

- **nstruct [integer]**:  The number of jobs that will be attempted.  This is the maximum number of structures that will be returned (if none of the attempts fails).
- **in::file::native [filename]**:  An optional PDB file for the native or design state.  This must be a cyclic peptide with the same number of residues as the sequence provided.  If this option is used, an RMSD value will be calculated for each job returning a structure.
- **sequence_file [filename]**:  Required input.  A text file containing the sequence, as full building block names separated by whitespace (e.g. "ALA DPRO DLYS B3F ARG PHE VAL").
- **genkic_closure_attempts [integer]**:  The maximum number of closure attempts that will be made for each job specified with the **nstruct** flag.
- **genkic_min_solution_count [integer]**:  The minimum number of solutions that the GeneralizedKIC algorithm must have found before the search is abandoned and the lowest-energy solution is chosen.  By default, this is set to 1 (which picks a solution as soon as any are found).  Setting this to 0 means that solutions will be sought until the number of attempts equals the number set with the **genkic_closure_attempts** flag, at which point one will be chosen.
- **cyclic permutations [boolean]**:  Should cyclic permutations of the sequence be generated during sampling, to minimize artefacts or biases introduced by the choice of the GeneralizedKIC closure points?  Default true.
- **use_rama_filter [boolean]**:  Should GeneralizedKIC filters be rejected if alpha-amino acid pivot residues have poor Ramachandran scores?  Default true.
- **rama_cutoff [real]**:  If the **use_rama_filter** option is used, this is the Ramachandran energy above which solutions are rejected.  Defaults to 0.3 Rosetta energy units.

## Planned future features
- Support for backbone torsion sampling of beta- and gamma-amino acids.
- Bin transition based sampling.