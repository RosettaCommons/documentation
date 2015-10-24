# Simple Cyclic Peptide Prediction (simple_cycpep_predict) Application

Created 24 October 2015 by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).

# Description

The **simple_cycpep_predict** application is intended for rapidly sampling closed conformations of small peptides constrained by backbone cyclization.  These peptides may be composed of any mixture of L- and D-amino acids (and/or glycine).  Optionally, the user may specify that solutions must have a certain number of backbone hydrogen bonds.  Unlike sampling performed with the [[Abinitio-Relax|abinitio-relax]] application, sampling is fragment-_independent_; that is, no database of known structures is required.

# Inputs

1.  The user must prepare a ASCII (text) file specifying the peptide sequence.  This file must consist of whitespace-separated residue names (e.g. ```PHE LYS ARG DLEU DASP DALA TYR ASN```).  The program will throw an error if not provided with such a file.  _Note that FASTA-formatted files are **not** acceptable, since they do not permit facile specification of non-canonical amino acids._

2.  All other inputs are based on flags.  Relevant flags are:
**-cyclic_peptide:sequence_file \<filename\>** Mandatory input.  The sequence file, described above.<\br>
**-out:nstruct \<int\>** The number of structures that the application will attempt to generate.  Since closed conformations satisfying hydrogen bonding criteria might not be found for every attempt, the actual number of structures produced will be less than or equal to this number.<\br>
**-cyclic_peptide:genkic_closure_attempts \<int\>**  For each structure attempted, how many times should the application try to find a closed conformation?  Default 10,000.  Values from 250 to 50,000 could be reasonable, depending on the peptide.<\br>
**-cyclic_peptide:genkic_min_solution_count \<int\>**  For each structure attempted, the application will keep looking for closed solutions until either **genkic_closure_attempts** has been reached or this number of solutions has been found.  At this point, it will pick the lowest-energy solution from the set found.  Defaults to 1 (takes a solution as soon as one is found).<\br>
**-cyclic_peptide:cyclic_permutations \<bool\>**  If true (the default setting), then random cyclic permutations of the sequence are used to avoid biases introduced by the choice of cutpoint.  (For example, if the user provides "ALA LYS PHE ASP DILE PRO", then we might try "PHE ASP DILE PRO ALA LYS" for the first structure, "DILE PRO ALA LYS PHE ASP" for the second, etc.)  All structures are de-permuted prior to final output for easy alignment.<\br>
**-cyclic_peptide:use_rama_filter \<bool\>**  The kinematic closure algorithm uses three "pivot residues" to close the loop.  These pivot residues can end up with nonsensical phi and psi values.  If this flag is set to true (the default setting), then pivot residues for all solutions are filtered and solutions with poor Ramachandran scores are discarded.<\br>
**-cyclic_peptide:rama_cutoff \<float\>**  If the **use_rama_filter** option is true (the default), then solutions with pivot residues with Ramachandran scores above this value will be discarded.  Defaults to 0.3 (somewhat permissive).<\br>
**-cyclic_peptide:min_genkic_hbonds \<int\>**  This is the minimum number of mainchain hydrogen bonds that a tentatively-considered closure solution must have in order to avoid rejection.  Default 3.  If this is set to 0, the hydrogen bond criterion is not applied.
**-cyclic_peptide:min_final_hbonds \<int\>**  This is the minimum number of mainchain hydrogen bonds that a final closure solution must have post-relaxation in order to avoid rejection.  This defaults to 0 (which means that the final number of hydrogen bonds is reported, but is not used as a filter).
**-cyclic_peptide:hbond_energy_cutoff \<float\>**  The maximum hydrogen bond energy, above which a hydrogen bond is not counted.  Defaults to -0.25.
**-cyclic_peptide:high_hbond_weight_multiplier \<float\>**  For portions of the protocol that perform relaxation with an upweighted mainchain hydrogen bond score value (see the algorithm description, below), this is the factor by which the mainchain hydrogen bond score term is upweighted.  Defaults to 10.0 (tenfold increase).<\br>
**-cyclic_peptide:count_sc_hbonds \<bool\>**  Should sidechain-mainchain hydrogen bonds be counted as mainchain hydrogen bonds?  Defaults to false.
**-cyclic_peptide:fast_relax_rounds \<int\>**  At steps of the protocol at which relaxation is invoked, this is the number of rounds of the [[FastRelax|FastRelaxMover]] protocol that will be applied.  Default 3.

# Algorithm

The algorithm is as follows:

1.  For each sampling attempt, the application generates a linear