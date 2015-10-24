# Simple Cyclic Peptide Prediction (simple_cycpep_predict) Application

Back to [[Application Documentation]].

Created 24 October 2015 by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).

# Description

The **simple_cycpep_predict** application is intended for rapidly sampling closed conformations of small peptides constrained by backbone cyclization.  These peptides may be composed of any mixture of L- and D-amino acids (and/or glycine).  Optionally, the user may specify that solutions must have a certain number of backbone hydrogen bonds.  Unlike sampling performed with the [[Abinitio-Relax|abinitio-relax]] application, sampling is fragment-_independent_; that is, no database of known structures is required.

# Inputs

1.  The user must prepare a ASCII (text) file specifying the peptide sequence.  This file must consist of whitespace-separated residue names (e.g. ```PHE LYS ARG DLEU DASP DALA TYR ASN```).  The program will throw an error if not provided with such a file.  _Note that FASTA-formatted files are **not** acceptable, since they do not permit facile specification of non-canonical amino acids._

2.  All other inputs are based on flags.  Relevant flags are:<br/><br/>
**-cyclic_peptide:sequence_file \<filename\>** Mandatory input.  The sequence file, described above.<br/><br/>
**-out:nstruct \<int\>** The number of structures that the application will attempt to generate.  Since closed conformations satisfying hydrogen bonding criteria might not be found for every attempt, the actual number of structures produced will be less than or equal to this number.<br/><br/>
**-cyclic_peptide:genkic_closure_attempts \<int\>**  For each structure attempted, how many times should the application try to find a closed conformation?  Default 10,000.  Values from 250 to 50,000 could be reasonable, depending on the peptide.<br/><br/>
**-cyclic_peptide:genkic_min_solution_count \<int\>**  For each structure attempted, the application will keep looking for closed solutions until either **genkic_closure_attempts** has been reached or this number of solutions has been found.  At this point, it will pick the lowest-energy solution from the set found.  Defaults to 1 (takes a solution as soon as one is found).<br/><br/>
**-cyclic_peptide:cyclic_permutations \<bool\>**  If true (the default setting), then random cyclic permutations of the sequence are used to avoid biases introduced by the choice of cutpoint.  (For example, if the user provides "ALA LYS PHE ASP DILE PRO", then we might try "PHE ASP DILE PRO ALA LYS" for the first structure, "DILE PRO ALA LYS PHE ASP" for the second, etc.)  All structures are de-permuted prior to final output for easy alignment.<br/><br/>
**-cyclic_peptide:use_rama_filter \<bool\>**  The kinematic closure algorithm uses three "pivot residues" to close the loop.  These pivot residues can end up with nonsensical phi and psi values.  If this flag is set to true (the default setting), then pivot residues for all solutions are filtered and solutions with poor Ramachandran scores are discarded.<br/><br/>
**-cyclic_peptide:rama_cutoff \<float\>**  If the **use_rama_filter** option is true (the default), then solutions with pivot residues with Ramachandran scores above this value will be discarded.  Defaults to 0.3 (somewhat permissive).<br/><br/>
**-cyclic_peptide:min_genkic_hbonds \<int\>**  This is the minimum number of mainchain hydrogen bonds that a tentatively-considered closure solution must have in order to avoid rejection.  Default 3.  If this is set to 0, the hydrogen bond criterion is not applied.<br/><br/>
**-cyclic_peptide:min_final_hbonds \<int\>**  This is the minimum number of mainchain hydrogen bonds that a final closure solution must have post-relaxation in order to avoid rejection.  This defaults to 0 (which means that the final number of hydrogen bonds is reported, but is not used as a filter).<br/><br/>
**-cyclic_peptide:hbond_energy_cutoff \<float\>**  The maximum hydrogen bond energy, above which a hydrogen bond is not counted.  Defaults to -0.25.<br/><br/>
**-cyclic_peptide:high_hbond_weight_multiplier \<float\>**  For portions of the protocol that perform relaxation with an upweighted mainchain hydrogen bond score value (see the algorithm description, below), this is the factor by which the mainchain hydrogen bond score term is upweighted.  Defaults to 10.0 (tenfold increase).<br/><br/>
**-cyclic_peptide:count_sc_hbonds \<bool\>**  Should sidechain-mainchain hydrogen bonds be counted as mainchain hydrogen bonds?  Defaults to false.<br/><br/>
**-cyclic_peptide:fast_relax_rounds \<int\>**  At steps of the protocol at which relaxation is invoked, this is the number of rounds of the [[FastRelax|FastRelaxMover]] protocol that will be applied.  Defaults to 3.<br/><br/>
**-in:file:native \<pdb_filename\>**  A PDB file for the native structure.  Optional.  If provided, an RMSD value will be calculated for each generated structure.<br/><br/>
**-out:file:s \<pdb_filename\>** OR **-out:file:silent \<silent_filename\>**  Prefix for PDB files that will be written out, OR name of the binary silent file that will be generated.<br/><br/>

# Output

This application generates PDB or binary silent file output.  If the latter is used (recommended), hydrogen bond counts and RMSD values to native (if a native file was provided) are in the ```SCORE``` lines in the silent file.  Additionally, these values are reported in the output log.

# Algorithm

The algorithm is as follows:

1.  For each sampling attempt, the application generates a linear peptide with the given sequence (randomly circularly permuted if the **-cyclic_peptide:cyclic_permutations** flag is set to true, the default).  The starting conformation is randomized, with each residue's phi/psi pair biased by the Ramachandran plot for that residue type.  All omega angles are set to 180 degrees.
2.  The [[Generalized Kinematic Closure|GeneralizedKICMover]] (GenKIC) protocol is used to find closed (cyclic) conformations of the peptide.  A single residue is chosen at random to be an "anchor" residue (excluding the two end residues).  The rest of the peptide is now a giant loop to be closed with GenKIC.  The first, last, and a randomly-chosen middle residue are selected as "pivot" residues.  GenKIC performs a series of samples (up to a maximum specified with the **-cyclic_peptide:genkic_closure_attempts** flag) in which it:
     - 2a.  Randomizes all residues in the loop, biased by the Ramachandran map.
     - 2b.  Analytically solves for phi and psi values for the pivot residues to close the loop.  At this step, anywhere from 0 to 16 solutions might result from the linear algebra performed.
     - 2c.  Filters each solution based on internal backbone clashes, the Ramachandran score for the pivot residues (controlled with the **-cyclic_peptide:rama_cutoff** flag), and the number of backbone hydrogen bonds (controlled with the **-cyclic_peptide:min_genkic_hbonds** flag).  Solutions passing all filters are relaxed using [[FastRelax|FastRelaxMover]] with an elevated hydrogen bond weight (set using the **-cyclic_peptide:high_hbond_weight_multiplier** flag), then stored.
     - 2d.  Repeats 2a through 2c until the maximum number of samples is reached, or until GenKIC has stored the number of solutions (passing filters) specified with the **-cyclic_peptide:genkic_min_solution_count** flag.
     - 2e.  Chooses the lowest-energy solution, based on the scorefunction with the exaggerated hydrogen bonding weight.
3.  The resulting solution is then relaxed using the conventional scorefunction (hydrogen bond weight reset to normal value).
4.  A final hydrogen bond filter is applied (controlled with the **-cyclic_peptide:min_final_hbonds** flag).
5.  The structure, if one is found, is written to disk, and the application proceeds to the next attempt until the number of attempts specified with the **-out:nstruct** flag is reached.

# Large-scale sampling with BOINC

The **simple_cycpep_predict** protocol is one of the protocols that can be run from the [[minirosetta]] application, using the ```-protocol simple_cycpep_predict``` flag.  Custom BOINC OpenGL graphics have been written for this application.  See [[minirosetta]]'s documentation for more information.

# Known issues

- Glycine's Ramachandran plot should be completely symmetric, but it is not, since it is based on statistics from the PDB.  (PDB structures disproportionately have glycine in the region of Ramachandran space that only it can access).  A flag will be added in the future to permit a symmetrized version of the glycine Ramachandran map to be used for sampling and scoring.
- Currently, there is no sampling of omega values, though these can deviate a bit from 180 degrees during final relaxation.
- Currently, only alpha-amino acids are supported, though it will be possible to generalize this to arbitrary backbones in the near future.
- Currently, there is no support for cyclic peptides with disulfides, or for any sort of cyclization other than head-to-tail backbone cyclization.  These limitations will be addressed in the future.