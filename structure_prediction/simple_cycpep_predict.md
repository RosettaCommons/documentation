# Simple Cyclic Peptide Prediction (simple_cycpep_predict) Application

Back to [[Application Documentation]].

Created 24 October 2015 by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).  Last updated 23 May 2016.

[[_TOC_]]

# Description

The **simple_cycpep_predict** application is intended for rapidly sampling closed conformations of small peptides constrained by backbone cyclization.  These peptides may be composed of any mixture of L- and D-amino acids (and/or glycine).  Optionally, the user may specify that solutions must have a certain number of backbone hydrogen bonds.  The user may also require disulfides between disulfide-forming residues, in which case all disulfide permutations are sampled using the [[TryDisulfPermutations|TryDisulfPermuationsMover]] mover.  Unlike sampling performed with the [[Abinitio-Relax|abinitio-relax]] application, sampling is fragment-_independent_; that is, no database of known structures is required.

# Sample command-lines

A sample command-line invocation of this application would be:

```
/my_rosetta_path/main/source/bin/simple_cycpep_predict.default.linuxgccrelease -cyclic_peptide:sequence_file inputs/seq.txt -cyclic_peptide:genkic_closure_attempts 1000 -cyclic_peptide:min_genkic_hbonds 2 -mute all -unmute protocols.cyclic_peptide_predict.SimpleCycpepPredictApplication -in:file:native inputs/native.pdb -out:file:silent output.silent
```

This protocol can also be run from the BOINC [[minirosetta build|minirosetta]], with graphics, as follows:

```
/my_rosetta_path/main/source/bin/minirosetta.boincstatic.linuxgccrelease -protocol simple_cycpep_predict -cyclic_peptide:sequence_file inputs/seq.txt -cyclic_peptide:genkic_closure_attempts 1000 -cyclic_peptide:min_genkic_hbonds 2 -mute all -in:file:native inputs/native.pdb -out:file:silent output.silent -boinc:graphics true -cyclic_peptide:checkpoint_job_identifier job1 &

/my_rosetta_path/main/source/bin/minirosetta_graphics.boincstatic.linuxgccrelease
```

(The first command, above, launches the computation, and the second launches the graphics window.  See the [[minirosetta]] documentation for more information.)

The application is also available in MPI form for sampling large numbers of conformations in parallel on multiple processors (possibly on a massive scale on a high-performance computing cluster like the Blue Gene/Q architecture).  A custom job distribution system has been written to allow efficient distribution of computational work.  Additional command-line options are available in MPI mode to control the multi-level job distribution system.  A sample command-line would be:

```
mpirun -np 25 /my_rosetta_path/main/source/bin/simple_cycpep_predict.mpi.linuxgccrelease -cyclic_peptide:MPI_processes_by_level 1 24 -cyclic_peptide:MPI_batchsize_by_level 10 -cyclic_peptide:MPI_output_fraction 0.1 -nstruct 2500 -cyclic_peptide:sequence_file inputs/seq.txt -cyclic_peptide:genkic_closure_attempts 1000 -cyclic_peptide:min_genkic_hbonds 2 -mute all -unmute protocols.cyclic_peptide_predict.SimpleCycpepPredictApplication_MPI_summary -in:file:native inputs/native.pdb -out:file:silent output.silent
```

See the [[Build Documentation]] for details on the MPI (Message Passing Interface) build, and the MPI section below for more information about the MPI-specific options.

# Full inputs

1.  The user must prepare a ASCII (text) file specifying the peptide sequence.  This file must consist of whitespace-separated residue names (e.g. ```PHE LYS ARG DLEU DASP DALA TYR ASN```).  The program will throw an error if not provided with such a file.  _Note that FASTA-formatted files are **not** acceptable, since they do not permit facile specification of non-canonical amino acids.

2.  Optionally, the user may provide a PDB file for the native structure with the **-in:file:native** flag.

3.  All other inputs are based on flags.  (See the MPI section, below for additional flags specific to that version.)  Relevant flags for the non-MPI version are:<br/><br/>
**-cyclic_peptide:sequence_file \<filename\>** Mandatory input.  The sequence file, described above.<br/><br/>
**-out:nstruct \<int\>** The number of structures that the application will attempt to generate.  Since closed conformations satisfying hydrogen bonding criteria might not be found for every attempt, the actual number of structures produced will be less than or equal to this number.<br/><br/>
**-cyclic_peptide:genkic_closure_attempts \<int\>**  For each structure attempted, how many times should the application try to find a closed conformation?  Default 10,000.  Values from 250 to 50,000 could be reasonable, depending on the peptide.<br/><br/>
**-cyclic_peptide:genkic_min_solution_count \<int\>**  For each structure attempted, the application will keep looking for closed solutions until either **genkic_closure_attempts** has been reached or this number of solutions has been found.  At this point, it will pick the lowest-energy solution from the set found.  Defaults to 1 (takes a solution as soon as one is found).<br/><br/>
**-cyclic_peptide:cyclic_permutations \<bool\>**  If true (the default setting), then random cyclic permutations of the sequence are used to avoid biases introduced by the choice of cutpoint.  (For example, if the user provides "ALA LYS PHE ASP DILE PRO", then we might try "PHE ASP DILE PRO ALA LYS" for the first structure, "DILE PRO ALA LYS PHE ASP" for the second, etc.)  All structures are de-permuted prior to final output for easy alignment.<br/><br/>
**-cyclic_peptide:use_rama_filter \<bool\>**  The kinematic closure algorithm uses three "pivot residues" to close the loop.  These pivot residues can end up with nonsensical phi and psi values.  If this flag is set to true (the default setting), then pivot residues for all solutions are filtered and solutions with poor Ramachandran scores are discarded.<br/><br/>
**-cyclic_peptide:rama_cutoff \<float\>**  If the **use_rama_filter** option is true (the default), then solutions with pivot residues with Ramachandran scores above this value will be discarded.  Defaults to 0.8 (somewhat permissive).<br/><br/>
**-cyclic_peptide:default_rama_sampling_table \<string\>**  By default, mainchain torsion sampling for alpha-amino acids is biased by the Ramachandran map for the residue in question.  This option allows the user to specify a custom Ramachandran map that will be used for sampling (unless the **-rama_sampling_table_by_res** option is used to override this flag).  Not used if not specified.  Current supported custom maps include: flat_l_aa_ramatable, flat_d_aa_ramatable, flat_symm_dl_aa_ramatable, flat_symm_gly_ramatable, flat_symm_pro_ramatable, flat_l_aa_ramatable_stringent, flat_d_aa_ramatable_stringent, flat_symm_dl_aa_ramatable_stringent, flat_symm_gly_ramatable_stringent, and flat_symm_pro_ramatable_stringent.<br/><br/>
**-cyclic_peptide:rama_sampling_table_by_res \<integer\> \<string\> \<integer\> \<string\> ...**  This flag allows the user to specify a custom Ramachandran to be used for sampling, by amino acid residue.  For example, "-cyclic_peptide:rama_sampling_table_by_res 3 flat_symm_pro_ramatable 4 flat_d_aa_ramatable_stringent" will assign a symmetric proline table to residue 3 and a high-stringency d-amino acid table to residue 4.  Not used if not specified.<br/><br/>
**-cyclic_peptide:min_genkic_hbonds \<int\>**  This is the minimum number of mainchain hydrogen bonds that a tentatively-considered closure solution must have in order to avoid rejection.  Default 3.  If this is set to 0, the hydrogen bond criterion is not applied.<br/><br/>
**-cyclic_peptide:min_final_hbonds \<int\>**  This is the minimum number of mainchain hydrogen bonds that a final closure solution must have post-relaxation in order to avoid rejection.  This defaults to 0 (which means that the final number of hydrogen bonds is reported, but is not used as a filter).<br/><br/>
**-cyclic_peptide:hbond_energy_cutoff \<float\>**  The maximum hydrogen bond energy, above which a hydrogen bond is not counted.  Defaults to -0.25.<br/><br/>
**-cyclic_peptide:do_not_count_adjacent_res_hbonds \<bool\> When counting hydrogen bonds, should we ignore hydrogen bonds between adjacent residues?  Default true.<br/><br/>
**-cyclic_peptide:high_hbond_weight_multiplier \<float\>**  For portions of the protocol that perform relaxation with an upweighted mainchain hydrogen bond score value (see the algorithm description, below), this is the factor by which the mainchain hydrogen bond score term is upweighted.  Defaults to 10.0 (tenfold increase).<br/><br/>
**-cyclic_peptide:count_sc_hbonds \<bool\>**  Should sidechain-mainchain hydrogen bonds be counted as mainchain hydrogen bonds?  Defaults to false.<br/><br/>
**-cyclic_peptide:fast_relax_rounds \<int\>**  At steps of the protocol at which relaxation is invoked, this is the number of rounds of the [[FastRelax|FastRelaxMover]] protocol that will be applied.  Defaults to 3.<br/><br/>
**-cyclic_peptide:checkpoint_job_identifier \<string\>**  If this option is used, jobs will checkpoint themselves so that the minirosetta or simple_cycpep_predict apps can be interrupted and can pick up where they left off, without repeating failed jobs or re-doing successful jobs.  The string must be a unique session identifier used to distinguish between re-attempts of the current prediction or new runs.  Highly recommended for BOINC jobs.<br/><br/>
**-cyclic_peptide:rand_checkpoint_file \<string\>**  If the **-checkpoint_job_identifier** flag is used, this flag sets the name of the checkpoint file used for the random number generator.  Defaults to "rng.state.gz" if not specified.  Typically, this need only be specified if multiple checkpointed jobs are sharing the same working directory.<br/><br/>
**-cyclic_peptide:checkpoint_file \<string\>**  If the **-checkpoint_job_identifier** flag is used, this flag sets the name of the checkpoint file used for keeping track of what jobs have completed and what jobs still have to run.  Defaults to "checkpoint.txt" if not specified.  Typically, this need only be specified if multiple checkpointed jobs are sharing the same working directory.<br/><br/>
**-cyclic_peptide:require_disulfides \<bool\>**  If true, then the application attempts to form disulfides between all disulfide-forming residues, trying permutations using the [[TryDisulfPermutations|TryDisulfPermuationsMover]] mover.  False by default.<br/><br/>
**-cyclic_peptide:disulf_cutoff_prerelax \<Real\>**  If require_disulfides is true, this is the maximum disulfide energy per disulfide bond that is allowed prior to relaxation.  If the energy exceeds this value, the solution is rejected.  Default is 15.0, but a much larger value might be appropriate.<br/><br/>
**-cyclic_peptide:disulf_cutoff_postrelax \<Real\>**  If require_disulfides is true, this is the maximum disulfide energy per disulfide bond that is allowed following relaxation.  If the energy exceeds this value, the solution is rejected.  Default 0.5.<br/><br/>
**-cyclic_peptide:user_set_alpha_dihedrals \<RealVector\>**  Optionally, the user may fix certain mainchain dihedrals at user-specified values.  This flag must be followed by a list of groups of four numbers, in which the first represents a sequence position and the second, third, and fourth are the phi, psi, and omega values, respectively.  Unused if not specified.<br/><br/>
**-cyclic_peptide:user_set_alpha_dihedral_perturbation \<Real\>**  If the **user_set_alpha_dihedrals** option is used, this is a small gaussian perturbation added to all dihedrals that were set.  Default 0.<br/><br/>
**-in:file:native \<pdb_filename\>**  A PDB file for the native structure.  Optional.  If provided, an RMSD value will be calculated for each generated structure.<br/><br/>
**-cyclic_peptide:filter_oversaturated_hbond_acceptors \<bool\>** Should sampled conformations with more than the allowed number of hydrogen bonds to an acceptor be discarded?  Default true.<br/><br/>
**-cyclic_peptide:hbond_acceptor_energy_cutoff \<Real\>** If we are filtering out conformations with oversaturated hydrogen bond acceptors, this is the hydrogen bond energy threshold above which a hydrogen bond is not counted.  Default -0.1.<br/><br/>
**-cyclic_peptide:sample_cis_pro_frequency \<Real\>** If this option is used, *cis*-peptide bonds will be sampled with the given frequency (between 0 and 1) for residues preceding D- or L-proline.  If the option is not specified, all peptide bonds will be *trans*.  Note that this is based on the input sequence, and is not recommended for design.
**-out:file:o \<pdb_filename\>** OR **-out:file:silent \<silent_filename\>**  Prefix for PDB files that will be written out, OR name of the binary silent file that will be generated.<br/><br/>

# Other useful flags

For mixed D/L peptides, the **-score:symmetric_gly_tables** flag can be a beneficial flag to use.  This flag symmetrizes the Ramachandran and p_aa_pp tables used for sampling and scoring glycine, so that it is equally likely to be in the D- or L-regions of Ramachandran space.  As of 23 February 2016, this flag also symmetrizes the gly tables used by the RamaPrePro energy term.

# Output

This application generates PDB or binary silent file output.  If the latter is used (recommended), hydrogen bond counts and RMSD values to native (if a native file was provided) are in the ```SCORE``` lines in the silent file.  Additionally, these values are reported in the output log.

The BOINC compilation also has some groovy graphics.

# Algorithm

The algorithm is as follows:

1.  For each sampling attempt, the application generates a linear peptide with the given sequence (randomly circularly permuted if the **-cyclic_peptide:cyclic_permutations** flag is set to true, the default).  The starting conformation is randomized, with each residue's phi/psi pair biased by the Ramachandran plot for that residue type.  All omega angles are set to 180 degrees.
2.  The [[Generalized Kinematic Closure|GeneralizedKICMover]] (GenKIC) protocol is used to find closed (cyclic) conformations of the peptide.  A single residue is chosen at random to be an "anchor" residue (excluding the two end residues).  The rest of the peptide is now a giant loop to be closed with GenKIC.  The first, last, and a randomly-chosen middle residue are selected as "pivot" residues.  GenKIC performs a series of samples (up to a maximum specified with the **-cyclic_peptide:genkic_closure_attempts** flag) in which it:
     - 2a.  Randomizes all residues in the loop, biased by the Ramachandran map.
     - 2b.  Analytically solves for phi and psi values for the pivot residues to close the loop.  At this step, anywhere from 0 to 16 solutions might result from the linear algebra performed.
     - 2c.  Filters each solution based on internal backbone clashes, the Ramachandran score for the pivot residues (controlled with the **-cyclic_peptide:rama_cutoff** flag), the presence of oversaturated hydrogen bond acceptors (controlled with the **-cyclic_peptide:filter_oversaturated_hbond_acceptors** flag), and the number of backbone hydrogen bonds (controlled with the **-cyclic_peptide:min_genkic_hbonds** flag).  Solutions passing all filters are relaxed using [[FastRelax|FastRelaxMover]] with an elevated hydrogen bond weight (set using the **-cyclic_peptide:high_hbond_weight_multiplier** flag), then stored.
     - 2d.  Repeats 2a through 2c until the maximum number of samples is reached, or until GenKIC has stored the number of solutions (passing filters) specified with the **-cyclic_peptide:genkic_min_solution_count** flag.
     - 2e.  Chooses the lowest-energy solution, based on the scorefunction with the exaggerated hydrogen bonding weight.
3.  The resulting solution is then relaxed using the conventional scorefunction (hydrogen bond weight reset to normal value).
4.  A final hydrogen bond filter is applied (controlled with the **-cyclic_peptide:min_final_hbonds** flag).
5.  The structure, if one is found, is written to disk, and the application proceeds to the next attempt until the number of attempts specified with the **-out:nstruct** flag is reached.

Optionally, step 2c can be performed with [[FastDesign|FastDesignMover]] instead of FastRelax.  See the section on design, below, for more information about this.

# Design mode

Although originally intended solely for structure prediction, the simple_cycpep_predict application can also design sequences for each sampled conformation using [[FastDesign|FastDesignMover]].  Design-specific flags are as follows:

**-cyclic_peptide:design_peptide \<Bool\>** If true, then the application attempts to design the sequence of each sampled conormation.  If false (the default), only fixed-sequence relaxation is performed.<br/><br/>
**-cyclic_peptide:allowed_residues_by_position \<String\>** This is the name of a file in which lists of allowed residues (full names) are provided for each numbered position in the peptide.  Each line corresponds to one position, and the first column must be the index of the position (or "DEFAULT" to specify default settings applied to all non-specified positions).  If a position is not specified (and no DEFAULT is given), non-specified positions are assumed to be fixed (<i>i.e.</i>not designable).  If no file is provided but the **-cyclic_peptide:design_peptide** flag is used, then the application will design with all canonical L-amino acids, and their D-equivalents, except for methionine and cysteine.  (Glycine will also be excluded by default).  A sample allowed residue file would be:<br/>
```
DEFAULT ALA VAL LEU ILE ASP GLU LYS ARG DALA DVAL DLEU DILE DASP DGLU DLYS DARG
1 VAL LEU ILE DVAL DLEU DILE #Only hydrophobics at this position.
2 VAL THR DVAL DTHR #Only beta-branched at this position.
3 ASP GLU DASP DGLU ARG LYS DARG DLYS #Only charged residues at this position.
4 ASP GLU DASP DGLU ARG LYS DARG DLYS #Only charged residues at this position.
5 ASP GLU DASP DGLU #Only negatively-charged residues at this position.
```
<br/>**-cyclic_peptide:prohibit_D_at_negative_phi \<Bool\>** If true, only L-amino acids are permitted at positions in the negative-phi region of Ramachandran space.  Default true.<br/><br/>
**-cyclic_peptide:prohibit_L_at_positive_phi \<Bool\>** If true, only D-amino acids are permitted at positions in the positive-phi region of Ramachandran space.  Default true.<br/><br/>
**-cyclic_peptide:L_alpha_comp_file \<String\>** An optional [[aa_composition|AACompositionEnergy]] file for biasing the amino acid composition of residues in the negative-phi (right-handed) alpha-helical region of Ramachandran space.  Not used if not specified.<br/><br/>
**-cyclic_peptide:D_alpha_comp_file \<String\>** An optional [[aa_composition|AACompositionEnergy]] file for biasing the amino acid composition of residues in the positive-phi (left-handed) alpha-helical region of Ramachandran space.  Not used if not specified.<br/><br/>
**-cyclic_peptide:L_beta_comp_file \<String\>** An optional [[aa_composition|AACompositionEnergy]] file for biasing the amino acid composition of residues in the negative-phi beta-strand region of Ramachandran space.  Not used if not specified.<br/><br/>
**-cyclic_peptide:D_beta_comp_file \<String\>** An optional [[aa_composition|AACompositionEnergy]] file for biasing the amino acid composition of residues in the positive-phi beta-strand region of Ramachandran space.  Not used if not specified.<br/><br/>

Note that the global amino acid composition may also be biased by providing an [[aa_composition|AACompositionEnergy]] file with the **-score:aa_composition_setup_file** flag, as in other protocols.  In the context of the simple_cycpep_predict application, using any aa_composition flag will automatically turn on the aa_composition energy term in the scoring function used.

# Large-scale sampling with BOINC

The **simple_cycpep_predict** protocol is one of the protocols that can be run from the [[minirosetta]] application, using the **-protocol simple_cycpep_predict** flag.  Custom BOINC OpenGL graphics have been written for this application.  It is strongly recommended that the **-cyclic_peptide:checkpoint_job_identifier** option be used to allow jobs to checkpoint themselves if run on BOINC (since BOINC jobs can be interrupted by the user).  See [[minirosetta]]'s documentation for more information.

# Large-scale sampling on HPC clusters with MPI (the Message Passing Interface)

When Rosetta is compiled with the "extras=mpi" flag, the compiled version of the **simple_cycpep_predict** app (bin/simple_cycpep_predict.mpi.[os][compiler][release/debug]) has some additional features, with additional flags controlling those features.  In MPI mode, the app has a custom-written scalable job distribution and collection system, suitable for parallel sampling on systems as small as a laptop or as large as the IBM Blue Gene/Q infrastructure (hundreds of thousands of parallel CPUs).

The job distribution system consists of a single **emperor** process, an arbitrary number of levels of **intermediate master** processes that send information up and down the hierarchy, and a large number of **slave** processes that actually do the sampling work.  Each level in the hierarchy has a number of nodes greater than or equal to its parent level.  The number of nodes in the hierarchy is specified with the **-cyclic_peptide:MPI_processes_by_level** flag, followed by a series of whitespace-separated integers representing the number of processes at each level, starting with the emperor and ending with the slaves.  The sum of these numbers must equal the total number of MPI processes launched.  For example, the following would specify one emperor, 50 intermediate masters (in a single level of intermediate masters), and 4949 slaves, for a total of 5000 processes (the same number launched):

```
mpirun -np 5000 /my_rosetta_path/main/source/bin/simple_cycpep_predict.mpi.linuxgccrelease -cyclic_peptide:MPI_processes_by_level 1 50 4949 ...(other options)...
```

In the above, the slaves would be assigned to masters to make the distribution as even as possible.

At the start of a run, slaves send requests for jobs up the hierarchy.  Jobs are distributed to each level of the hierarchy in batches, with user-controlled batch sizes.  If batches are too small, the risk is that nodes spend all of their time requesting jobs and responding to job requests; if they are too large, the risk is that slaves are locked in to completing a large number of jobs even if another slave is free to do those jobs (<i>i.e.</i> poor load-balancing).  The number of jobs per batch at each level of the hierarchy is controlled with the **-cyclic_peptide:MPI_batchsize_by_level** flag, followed by a whitespace-separated list of integers.  One less value should be provided than was provided with the **-cyclic_peptide:MPI_processes_by_level** flag, since slaves do not pass batches of jobs any further down the hierarchy.  Using the example above, we could specify that the emperor would send out 200 jobs at a time to each master, and that each master would send 2 jobs at a time to each slave, with the following:

```
mpirun -np 5000 /my_rosetta_path/main/source/bin/simple_cycpep_predict.mpi.linuxgccrelease -cyclic_peptide:MPI_processes_by_level 1 50 4949 -cyclic_peptide:MPI_batchsize_by_level 200 2 ...(other options)...
```

The total number of jobs is controlled with the **-nstruct** flag.  One may also trigger premature termination using the **-cyclic_peptide:MPI_stop_after_time \<Integer\>** flag, and specifying a time in seconds.  If this flag is used, then after the elapsed time, the emperor will send a halt signal down the hierarchy.  Slaves that have been assigned jobs will complete all jobs assigned to them, but no subsequent jobs will be assigned to them.  This is useful for large-scale sampling on systems that have job time limits.

When jobs complete, they are not output automatically, since there might be far more output than could be reasonably written out to disk.  Instead, the slaves send job summaries up the hierarchy.  These are sorted during passage up the hierarchy by a criterion specified by the user using the **-cyclic_peptide:MPI_sort_by \<criterion\>** flag, where \<criterion\> is one of **energy**, **rmsd**, or **hbonds**.  By default, lowest values are first in the list, but this can be changed with **-cyclic_peptide:MPI_choose_highest true**.  The emperor node receives the sorted list, then sends requests down the hierarchy to the originating nodes for only the top N% (based on the sort criterion) of output structures, which are sent up the hierarchy to the emperor for output to disk.  The fraction of structures written to disk is set with the **-cyclic_peptide:MPI_output_fraction** flag, with a value from 0 to 1.  So if we wanted to do 20,000 samples, then write out the 5% of output structures with lowest energy from the run in the example above, we would use:

```
mpirun -np 5000 /my_rosetta_path/main/source/bin/simple_cycpep_predict.mpi.linuxgccrelease -cyclic_peptide:MPI_processes_by_level 1 50 4949 -cyclic_peptide:MPI_batchsize_by_level 200 2 -nstruct 20000 -cyclic_peptide:MPI_sort_by energy -cyclic_peptide:MPI_output_fraction 0.05 ...(other options)...
```

The details of sampling are controlled with the same flags used for the non-MPI version (see above).

Note that, in MPI mode, there can be an incredible amount of tracer output.  For convenience, the emperor uses a separate tracer to write a summary of all jobs that have been completed.  To receive only this as output in the standard output stream, use the **-mute all -unmute protocols.cyclic_peptide_predict.SimpleCycpepPredictApplication_MPI_summary** flags.  (This silences all output from non-emperor processes, and most output from the emperor process, except for the summary at the end.)  Since generating output and managing output from large numbers of processes takes clock and MPI communication cycles, muting unnecessary output is advised for better performance.

As a final note, intermediate master processes are optional; the minimum that one needs are an emperor node and a single slave node (though this setup would have no advantages over sampling with the non-MPI version of the app).  On a 4-core laptop, the following would be perfectly legal, for example:

```
mpirun -np 4 /my_rosetta_path/main/source/bin/simple_cycpep_predict.mpi.linuxgccrelease -cyclic_peptide:MPI_processes_by_level 1 3 -cyclic_peptide:MPI_batchsize_by_level 25 -nstruct 1000 -cyclic_peptide:MPI_sort_by energy -cyclic_peptide:MPI_output_fraction 0.05 ...(other options)...
```

This would farm out 1000 jobs to 3 slave processes in 25-job batches, with direct communication between the emperor and each slave (i.e. no intermediate masters).  This is inadvisable on very large systems, since the emperor can become inundated with too many communication requests from thousands of slaves, but is sensible on small systems.

# Known issues

- In MPI mode, only silent file output is permitted.  Users must provide an output file with **-out:file:silent**.
- Glycine's Ramachandran plot should be completely symmetric, but it is not, since it is based on statistics from the PDB.  (PDB structures disproportionately have glycine in the region of Ramachandran space that only it can access).  A flag will be added in the future to permit a symmetrized version of the glycine Ramachandran map to be used for sampling and scoring.
- Currently, there is no sampling of omega values, though these can deviate a bit from 180 degrees during final relaxation.
- Currently, only alpha-amino acids are supported, though it will be possible to generalize this to arbitrary backbones in the near future.
- Currently, there is no support for any sort of cyclization other than head-to-tail backbone cyclization, or for any sort of cross-link other than disulfide bonds.  These limitations will be addressed in the future.