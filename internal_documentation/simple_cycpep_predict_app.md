# simple_cycpep_predict app

Page created 21 September 2015 by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).

## Overview

The **simple_cycpep_predict** app is intended to be a fragment-free design validation tool for small, backbone-cyclized peptide designs analogous to AbinitioRelax for proteins designs.  It sets up a chain with backbone-cyclization, uses GeneralizedKIC to sample conformations and close the geometry, then applies a few rounds of FastRelax, in two batches (a first with the mainchain hydrogen bond terms turned up to preserve hydrogen bonds, and a second with the mainchain hydrogen bond terms set to their normal values).  User options permit users to filter based on the number of mainchain hydrogen bonds.

## Typical usage

Let's say we want to generate energy landscape plots for a six-residue peptide with sequence VAL-DPRO-ARG-ILE-DPRO-GLU, and that we have a design for this peptide in the file inputs/native.pdb.  Let's also suppose that we want every solution to have at least one hbond, and to be based on an initial closure with at least two hbonds.  We would first generate a sequence file (let's call it sequence.txt, also in the inputs/ directory) containing the sequence "VAL DPRO ARG ILE DPRO GLU" (no quotation marks).  We would then run simple_cycpep_predict on a single processor, dumping output to out.log, using the following command-line flags:

```
nohup <path to Rosetta bin directory>/simple_cycpep_predict.default.<os><compiler><mode> -sequence_file inputs/sequence.txt -in:file:native inputs/native.pdb -ex1 -ex2 -out:file:silent output.silent -genkic_closure_attempts 5000 -min_genkic_hbonds 2 -min_final_hbonds 1 -nstruct 1000 >out.log &
```

The output log will contain lines listing the RMSD, energy, and number of hbonds for each solution found.  One can find these using the following command:

```
grep RMSD out.log -A1 | grep -v -P '\-\-|RMSD'
```

## User options

- **nstruct [integer]**:  The number of jobs that will be attempted.  This is the maximum number of structures that will be returned (if none of the attempts fails).
- **in::file::native [filename]**:  An optional PDB file for the native or design state.  This must be a cyclic peptide with the same number of residues as the sequence provided.  If this option is used, an RMSD value will be calculated for each job returning a structure.
- **out::file::o [prefix]**:  Prefix for PDB files to be written out.  Default "S_".
- **out::file::silent [name]**:  Alternative to **out::file::o**.  Writes all output to a single binary silent file.  Good for large-scale sampling.
- **sequence_file [filename]**:  Required input.  A text file containing the sequence, as full building block names separated by whitespace (e.g. "ALA DPRO DLYS B3F ARG PHE VAL").
- **genkic_closure_attempts [integer]**:  The maximum number of closure attempts that will be made for each job specified with the **nstruct** flag.
- **genkic_min_solution_count [integer]**:  The minimum number of solutions that the GeneralizedKIC algorithm must have found before the search is abandoned and the lowest-energy solution is chosen.  By default, this is set to 1 (which picks a solution as soon as any are found).  Setting this to 0 means that solutions will be sought until the number of attempts equals the number set with the **genkic_closure_attempts** flag, at which point one will be chosen.
- **cyclic permutations [boolean]**:  Should cyclic permutations of the sequence be generated during sampling, to minimize artefacts or biases introduced by the choice of the GeneralizedKIC closure points?  Default true.
- **use_rama_filter [boolean]**:  Should GeneralizedKIC filters be rejected if alpha-amino acid pivot residues have poor Ramachandran scores?  Default true.
- **rama_cutoff [real]**:  If the **use_rama_filter** option is used, this is the Ramachandran energy above which solutions are rejected.  Defaults to 0.3 Rosetta energy units.
- **high_hbond_weight_multiplier**:  GenKIC solutions are chosen, and the initial rounds of FastRelax are performed, with a scoring function with the mainchain hydrogen bond term weights turned up by this factor.  Default 10.
- **min_genkic_hbonds**:  GenKIC solutions are rejected that have fewer than this number of mainchain hydrogen bonds.  Default 3.
- **min_final_hbonds**:  Final solutions are rejected that have fewer than this number of mainchain hydrogen bonds.  Defaults to 0 (no solutions rejected).
- **count_sc_hbonds**:  If false, only mainchain hydrogen bonds are included in the counts when filtering GenKIC and final solutions.  If true, all hydrogen bonds are counted.  Default false.

## Planned future features
- Support for backbone torsion sampling of beta- and gamma-amino acids.
- Bin transition based sampling.