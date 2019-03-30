# Simple Cyclic Peptide Prediction (simple_cycpep_predict) Application

Back to [[Application Documentation]].

Created 24 October 2015 by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).  Last updated 4 June 2018.<br/><br/>
<b><i>If you use this application, please cite:</i><br/>
Bhardwaj, G., V.K. Mulligan, C.D. Bahl, J.M. Gilmore, P.J. Harvey, O. Cheneval, G.W. Buchko, S.V.S.R.K. Pulavarti, Q. Kaas, A. Eletsky, P.-S. Huang, W.A. Johnsen, P. Greisen, G.J. Rocklin, Y. Song, T.W. Linsky, A. Watkins, S.A. Rettie, X. Xu, L.P. Carter, R. Bonneau, J.M. Olson, E. Coutsias, C.E. Correnti, T. Szyperski, D.J. Craik, and D. Baker. 2016.  <u>Accurate de novo design of hyperstable constrained peptides.</u> *Nature.* 538(7625):329-35.</b><br/>
(<a href="http://www.ncbi.nlm.nih.gov/pubmed/27626386">Link</a> to article).

[[_TOC_]]

# Description

The **simple_cycpep_predict** application is intended for rapidly sampling closed conformations of small peptides constrained by backbone cyclization.  These peptides may be composed of any mixture of L- or D-amino acid residues, achiral amino acid residues, peptoid residues, or L- or D-oligourea residues.  Optionally, the user may specify that solutions must have a certain number of backbone hydrogen bonds.  The user may also require disulfides between disulfide-forming residues, in which case all disulfide permutations are sampled using the [[TryDisulfPermutations|TryDisulfPermuationsMover]] mover.  The user may also specify that certain positions are cross-linked with cross-linking agents, in which case the [[CrosslinkerMover]] is used to place cross-linking agents.  Unlike sampling performed with the [[Abinitio-Relax|abinitio-relax]] application, sampling is fragment-_independent_; that is, no database of known structures is required.

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
**-cyclic_peptide:cyclization_type \<string\>** Optional input.  The type of cyclization.  Current options are "n_to_c_amide_bond" (the default, which sets up a terminal amide bond), "terminal_disulfide" (which cyclizes a linear peptide through a side-chain disulfide), "nterm_isopeptide_lariat", "cterm_isopeptide_lariat", and "sidechain_isopeptide".  If the "terminal_disulfide" option is used, the cyclization is performed through a disulfide linking the two disulfide-forming residues closest to the N- and C-termini (though these need not be _at_ the termini).  The "terminal_disulfide" option may be used with the "-cyclic_peptide:require_disulfides" option, in which case disulfide combinations between internal (_i.e._ non-terminal) disulfide-forming residues will be considered.  The "terminal_disulfide" option is _not_ compatible with cyclic permutations, nor with quasi-symmetric sampling.  For more information on isopeptide lariats, see the relevant section below.<br/><br/>
**-cyclic_peptide:use_chainbreak_energy \<bool\>** If true (the default), then the chainbreak energy is used to enforce the cyclic geometry of an N-to-C amide bond during minimization.  If false, then constraints are added instead.  Note that the chainbreak approach allows rotation of the terminal phi and psi angles, while the constraint approach currently does not.<br/><br/>
**-out:nstruct \<int\>** The number of structures that the application will attempt to generate.  Since closed conformations satisfying hydrogen bonding criteria might not be found for every attempt, the actual number of structures produced will be less than or equal to this number.<br/><br/>
**-cyclic_peptide:genkic_closure_attempts \<int\>**  For each structure attempted, how many times should the application try to find a closed conformation?  Default 10,000.  Values from 250 to 50,000 could be reasonable, depending on the peptide.<br/><br/>
**-cyclic_peptide:genkic_min_solution_count \<int\>**  For each structure attempted, the application will keep looking for closed solutions until either **genkic_closure_attempts** has been reached or this number of solutions has been found.  At this point, it will pick the lowest-energy solution from the set found.  Defaults to 1 (takes a solution as soon as one is found).<br/><br/>
**-cyclic_peptide:cyclic_permutations \<bool\>**  If true (the default setting), then random cyclic permutations of the sequence are used to avoid biases introduced by the choice of cutpoint.  (For example, if the user provides "ALA LYS PHE ASP DILE PRO", then we might try "PHE ASP DILE PRO ALA LYS" for the first structure, "DILE PRO ALA LYS PHE ASP" for the second, etc.)  All structures are de-permuted prior to final output for easy alignment.<br/><br/>
**-cyclic_peptide:use_rama_filter \<bool\>**  The kinematic closure algorithm uses three "pivot residues" to close the loop.  These pivot residues can end up with nonsensical phi and psi values.  If this flag is set to true (the default setting), then pivot residues for all solutions are filtered and solutions with poor Ramachandran scores are discarded.<br/><br/>
**-cyclic_peptide:rama_cutoff \<float\>**  If the **use_rama_filter** option is true (the default), then solutions with pivot residues with Ramachandran scores above this value will be discarded.  Defaults to 0.8 (somewhat permissive).<br/><br/>
**-cyclic_peptide:default_rama_sampling_table \<string\>**  By default, mainchain torsion sampling for alpha-amino acids is biased by the Ramachandran map for the residue in question.  This option allows the user to specify a custom Ramachandran map that will be used for sampling (unless the **-rama_sampling_table_by_res** option is used to override this flag).  Not used if not specified.  Current supported custom maps include: flat_l_aa_ramatable, flat_d_aa_ramatable, flat_symm_dl_aa_ramatable, flat_symm_gly_ramatable, flat_symm_pro_ramatable, flat_l_aa_ramatable_stringent, flat_d_aa_ramatable_stringent, flat_symm_dl_aa_ramatable_stringent, flat_symm_gly_ramatable_stringent, and flat_symm_pro_ramatable_stringent.<br/><br/>
**-cyclic_peptide:rama_sampling_table_by_res \<integer\> \<string\> \<integer\> \<string\> ...**  This flag allows the user to specify a custom Ramachandran to be used for sampling, by amino acid residue.  For example, "-cyclic_peptide:rama_sampling_table_by_res 3 flat_symm_pro_ramatable 4 flat_d_aa_ramatable_stringent" will assign a symmetric proline table to residue 3 and a high-stringency d-amino acid table to residue 4.  Not used if not specified.<br/><br/>
**-cyclic_peptide:use_classic_rama_for_sampling \<bool\>**  If true, the `rama` score term's Ramachandran maps are used to bias sampling instead of the newer `rama_prepro` score term's Ramachandran maps.  Not recommended.  Default false.<br/><br/>
**-cyclic_peptide:min_genkic_hbonds \<int\>**  This is the minimum number of mainchain hydrogen bonds that a tentatively-considered closure solution must have in order to avoid rejection.  Default 3.  If this is set to 0, the hydrogen bond criterion is not applied.<br/><br/>
**-cyclic_peptide:min_final_hbonds \<int\>**  This is the minimum number of mainchain hydrogen bonds that a final closure solution must have post-relaxation in order to avoid rejection.  This defaults to 0 (which means that the final number of hydrogen bonds is reported, but is not used as a filter).<br/><br/>
**-cyclic_peptide:total_energy_cutoff \<float\>**  The maximum total score, above which solutions are discarded.  Not used if not specified (_i.e._ solutions of any energy are accepted).<br/><br/>
**-cyclic_peptide:hbond_energy_cutoff \<float\>**  The maximum hydrogen bond energy, above which a hydrogen bond is not counted.  Defaults to -0.25.<br/><br/>
**-cyclic_peptide:do_not_count_adjacent_res_hbonds \<bool\> When counting hydrogen bonds, should we ignore hydrogen bonds between adjacent residues?  Default true.<br/><br/>
**-cyclic_peptide:high_hbond_weight_multiplier \<float\>**  For portions of the protocol that perform relaxation with an upweighted mainchain hydrogen bond score value (see the algorithm description, below), this is the factor by which the mainchain hydrogen bond score term is upweighted.  Defaults to 10.0 (tenfold increase).<br/><br/>
**-cyclic_peptide:count_sc_hbonds \<bool\>**  Should sidechain-mainchain hydrogen bonds be counted as mainchain hydrogen bonds?  Defaults to false.<br/><br/>
**-cyclic_peptide:fast_relax_rounds \<int\>**  At steps of the protocol at which relaxation is invoked, this is the number of rounds of the [[FastRelax|FastRelaxMover]] protocol that will be applied.  Defaults to 3.<br/><br/>
**-cyclic_peptide:exclude_residues_from_rms \<string\>**  A space-separated list of residues that should be excluded from the RMSD calculation.  Not used if not provided.<br/><br/>
**-cyclic_peptide:checkpoint_job_identifier \<string\>**  If this option is used, jobs will checkpoint themselves so that the **minirosetta** or **simple_cycpep_predict** apps can be interrupted and can pick up where they left off, without repeating failed jobs or re-doing successful jobs.  The string must be a unique session identifier used to distinguish between re-attempts of the current prediction or new runs.  Highly recommended for BOINC jobs.<br/><br/>
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
**-cyclic_peptide:sample_cis_pro_frequency \<Real\>** This option controls the frequency (between 0 and 1) with which *cis*-peptide bonds are sampled for residues preceding D- or L-proline.  If the option is not specified, the frequency defaults to 0.3; set it to 0.0 to disable *cis*-peptide bond sampling.  Note that this is based on the input sequence, and is not recommended for design unless certain positions are fixed to be proline.<br/><br/>
**-cyclic_peptide:angle_relax_rounds \<int\>** If this option is used, the specified number of FastRelax or FastDesign rounds is carried out with flexible bond angles.  The cart_bonded energy is automatically set to 0.5 for this step, and the pro_close energy to 0.0.  The order of operations is: ordinary FastRelax (if any), flexible bond angle FastRelax (if any), flexible bond angle / bond length FastRelax (if any), full Cartesian FastRelax (if any), and one more round of regular FastRelax (only if any rounds were specified that could result in non-ideal bond angles or bond lengths).  Default behaviour is to have no rounds of flexible bond angle relaxation.<br/><br/>
**-cyclic_peptide:angle_length_relax_rounds \<int\>** If this option is used, the specified number of FastRelax or FastDesign rounds is carried out with flexible bond angles and flexible bond lengths.  The cart_bonded energy is automatically set to 0.5 for this step, and the pro_close energy to 0.0.  Default behaviour is to have no rounds of flexible bond angle / bond length relaxation.  See note above for order of relaxation rounds.<br/><br/>
**-cyclic_peptide:cartesian_relax_rounds \<int\>** If this option is used, the specified number of FastRelax or FastDesign rounds is carried out with full Cartesian-space minimization.  The cart_bonded energy is automatically set to 0.5 for this step, and the pro_close energy to 0.0.  Default behaviour is to have no rounds of Cartesian-space relaxation.  See note above for order of relaxation rounds.<br/><br/>
**-out:file:o \<pdb_filename\>** OR **-out:file:silent \<silent_filename\>**  Prefix for PDB files that will be written out, OR name of the binary silent file that will be generated.<br/><br/>

## Additional flags for crosslinked structures

The simple\_cycpep\_predict application can also attempt to predict structures cross-linked with three-way crosslinkers like 1,3,5-tris(bromomethyl)benzene (TBMB) or trimesic acid (TMA).  Internally, this calls the [[CrosslinkerMover]], which is also accessible to RosettaScripts and PyRosetta.  Additional input flags are used to specify which L- or D-cysteine residues are linked with TBMB:

**-cyclic\_peptide:TBMB\_positions \<IntegerVector\>** If provided, then these positions will be linked by a 1,3,5-tris(bromomethyl)benzene crosslinker.  3N positions must be specified, and every group of three will be linked.  Unused if not specified.<br/><br/>
**-cyclic\_peptide:link\_all\_cys\_with\_TBMB \<bool\>** If true, then all cysteine residues in the peptide are linked with 1,3,5-tris(bromomethyl)benzene.  There must be exactly three cysteine residues for this flag to be used, and it cannot be used with the "-TBMB\_positions" flag (_i.e._ it represents a quicker alternative to that flag for the special case of sequences with exactly three cysteine residues).  False/unused by default.<br/><br/>
**-cyclic\_peptide:use\_TBMB\_filters \<bool\>** If true, then filters are applied based on distance between TBMB cysteines and on constraints to discard GenKIC solutions that can't be crosslinked easily.  True by default.<br/><br/>
**-cyclic\_peptide:TBMB\_sidechain\_distance\_filter\_multiplier \<Real\>** A multiplier for the distance cutoff for TBMB cysteines.  Higher values result in more permissive filtering.  Default 1.0.<br/><br/>
**-cyclic\_peptide:TBMB\_constraints\_energy\_filter\_multiplier \<Real\>** A multiplier for the constraints energy for TBMB cysteines.  Higher values result in more permissive filtering.  Default 1.0.<br/><br/>
**-cyclic\_peptide:TMA\_positions \<IntegerVector\>** If provided, then these positions will be linked by a trimesic acid crosslinker.  The positions must have sidechain primary amines, and there must be 3N positions specified.  Each group of three will be linked.  Unused if not specified.<br/><br/>
**-cyclic\_peptide:use\_TMA\_filters \<bool\>** If true, then filters are applied baed on distance between TMA-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked easily.  True by default.<br/><br/>
**-cyclic\_peptide:TMA\_sidechain\_distance\_filter\_multiplier \<Real\>** A multiplier for the distance cutoff for sidechains linked by trimesic acid (TMA).  Higher values result in more permissive filtering.  Default 1.0.<br/><br/>
**-cyclic\_peptide:TMA\_constraints\_energy\_filter\_multiplier \<Real\>** A multiplier for the constraints energy for sidechains linked by trimesic acid (TMA).  Higher values permit more permissive filtering.  Default 1.0.

## Additional flags for metal-bound structures

The simple\_cycpep\_predict application can attempt to model metal-mediated crosslinks, discarding samples that do not present side-chains in a manner compatible with one of several metal coordination geometries.  Sidechains of D- or L-histidine, aspartate, or glutamate residues can coordinate metals.  Since metals effectively cross-link several residues, internally the [[CrosslinkerMover]] is called.  Currently, octahedral, tetrahedral, square planar, square pyramidal, trigonal planar, and trigonal pyramidal coordination are supported.

### Flags for structures that coordinate metals octahedrally

**-cyclic\_peptide:octahedral\_metal\_positions \<StringVector\>**  If provided, then these positions will coordinate a metal, which will be represented by a virtual atom during sampling and in final output.  (Use the "-output\_virtual" flag to visualize the virtual atom in the PDB output.)  The positions must have sidechains that can coordinate a metal (_e.g._ histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,res4,res5,res6,metal.  For example, if positions 4, 6, 9, 13, 16, and 18 were to coordinate an iron in the Fe(II) oxidation state, the string would be 4,6,9,13,16,19,Fe2.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  Unused if not specified.<br/><br/>
**-cyclic\_peptide:use\_octahedral\_metal\_filters \<bool\>**  If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/><br/>
**-cyclic\_peptide:octahedral\_metal\_sidechain\_distance\_filter\_multiplier \<Real\>** A multiplier for the distance cutoff for side-chains linked by a octahedrally-coordinated metal.  Higher values result in more permissive filtering.  Default 1.0.<br/><br/>
**-cyclic\_peptide:octahedral\_metal\_constraints\_energy\_filter\_multiplier \<Real\>** A multiplier for the constraints energy for side-chains linked by a octahedrally-coordinated metal.  Higher values result in more permissive filtering.  Default 1.0.

### Flags for structures that coordinate metals tetrahedrally

**-cyclic\_peptide:tetrahedral\_metal\_positions \<StringVector\>**  If provided, then these positions will coordinate a metal, which will be represented by a virtual atom during sampling and in final output.  (Use the "-output\_virtual" flag to visualize the virtual atom in the PDB output.)  The positions must have sidechains that can coordinate a metal (_e.g._ histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,res4,metal.  For example, if positions 4, 6, 9, and 13 were to coordinate a zinc, the string would be 4,6,9,13,Zn.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  Unused if not specified.<br/><br/>
**-cyclic\_peptide:use\_tetrahedral\_metal\_filters \<bool\>**  If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/><br/>
**-cyclic\_peptide:tetrahedral\_metal\_sidechain\_distance\_filter\_multiplier \<Real\>** A multiplier for the distance cutoff for side-chains linked by a tetrahedrally-coordinated metal.  Higher values result in more permissive filtering.  Default 1.0.<br/><br/>
**-cyclic\_peptide:tetrahedral\_metal\_constraints\_energy\_filter\_multiplier \<Real\>** A multiplier for the constraints energy for side-chains linked by a tetrahedrally-coordinated metal.  Higher values result in more permissive filtering.  Default 1.0.

### Flags for structures that coordinate metals with square pyramidal geometry

**-cyclic\_peptide:square\_pyramidal\_metal\_positions \<StringVector\>**  If provided, then these positions will coordinate a metal, which will be represented by a virtual atom during sampling and in final output.  (Use the "-output\_virtual" flag to visualize the virtual atom in the PDB output.)  The positions must have sidechains that can coordinate a metal (_e.g._ histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,res4,res5,metal.  For example, if positions 6, 9, 13, 21, and 31 were to coordinate a nickel in the +2 oxidation state, the string would be 6,9,13,21,31,Ni2.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  Unused if not specified.<br/><br/>
**-cyclic\_peptide:use\_square\_pyramidal\_metal\_filters \<bool\>**  If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/><br/>
**-cyclic\_peptide:square\_pyramidal\_metal\_sidechain\_distance\_filter\_multiplier \<Real\>** A multiplier for the distance cutoff for side-chains linked by a metal with square pyramidal coordination geometry.  Higher values result in more permissive filtering.  Default 1.0.<br/><br/>
**-cyclic\_peptide:square\_pyramidal\_metal\_constraints\_energy\_filter\_multiplier \<Real\>** A multiplier for the constraints energy for side-chains linked by a metal with square pyramidal coordination geometry.  Higher values result in more permissive filtering.  Default 1.0.

### Flags for structures that coordinate metals with square planar geometry

**-cyclic\_peptide:square\_planar\_metal\_positions \<StringVector\>**  If provided, then these positions will coordinate a metal, which will be represented by a virtual atom during sampling and in final output.  (Use the "-output\_virtual" flag to visualize the virtual atom in the PDB output.)  The positions must have sidechains that can coordinate a metal (_e.g._ histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,res4,metal.  For example, if positions 6, 9, 13, and 18 were to coordinate a nickel in the +2 oxidation state, the string would be 6,9,13,18,Ni2.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  Unused if not specified.<br/><br/>
**-cyclic\_peptide:use\_square\_planar\_metal\_filters \<bool\>**  If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/><br/>
**-cyclic\_peptide:square\_planar\_metal\_sidechain\_distance\_filter\_multiplier \<Real\>** A multiplier for the distance cutoff for side-chains linked by a metal with square planar coordination geometry.  Higher values result in more permissive filtering.  Default 1.0.<br/><br/>
**-cyclic\_peptide:square\_planar\_metal\_constraints\_energy\_filter\_multiplier \<Real\>** A multiplier for the constraints energy for side-chains linked by a metal with square planar coordination geometry.  Higher values result in more permissive filtering.  Default 1.0.

### Flags for structures that coordinate metals with trigonal pyramidal geometry

**-cyclic\_peptide:trigonal\_pyramidal\_metal\_positions \<StringVector\>**  If provided, then these positions will coordinate a metal, which will be represented by a virtual atom during sampling and in final output.  (Use the "-output\_virtual" flag to visualize the virtual atom in the PDB output.)  The positions must have sidechains that can coordinate a metal (_e.g._ histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,metal.  For example, if positions 6, 9, and 13 were to coordinate a zinc, the string would be 6,9,13,Zn.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  Unused if not specified.<br/><br/>
**-cyclic\_peptide:use\_trigonal\_pyramidal\_metal\_filters \<bool\>**  If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/><br/>
**-cyclic\_peptide:trigonal\_pyramidal\_metal\_sidechain\_distance\_filter\_multiplier \<Real\>** A multiplier for the distance cutoff for side-chains linked by a metal with trigonal pyramidal coordination geometry.  Higher values result in more permissive filtering.  Default 1.0.<br/><br/>
**-cyclic\_peptide:trigonal\_pyramidal\_metal\_constraints\_energy\_filter\_multiplier \<Real\>** A multiplier for the constraints energy for side-chains linked by a metal with trigonal pyramidal coordination geometry.  Higher values result in more permissive filtering.  Default 1.0.

### Flags for structures that coordinate metals with trigonal planar geometry

**-cyclic\_peptide:trigonal\_planar\_metal\_positions \<StringVector\>**  If provided, then these positions will coordinate a metal, which will be represented by a virtual atom during sampling and in final output.  (Use the "-output\_virtual" flag to visualize the virtual atom in the PDB output.)  The positions must have sidechains that can coordinate a metal (_e.g._ histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,metal.  For example, if positions 6, 9, and 13 were to coordinate a zinc, the string would be 6,9,13,Zn.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  Unused if not specified.<br/><br/>
**-cyclic\_peptide:use\_trigonal\_planar\_metal\_filters \<bool\>**  If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/><br/>
**-cyclic\_peptide:trigonal\_planar\_metal\_sidechain\_distance\_filter\_multiplier \<Real\>** A multiplier for the distance cutoff for side-chains linked by a metal with trigonal planar coordination geometry.  Higher values result in more permissive filtering.  Default 1.0.<br/><br/>
**-cyclic\_peptide:trigonal\_planar\_metal\_constraints\_energy\_filter\_multiplier \<Real\>** A multiplier for the constraints energy for side-chains linked by a metal with trigonal planar coordination geometry.  Higher values result in more permissive filtering.  Default 1.0.

## Additional flags for N-methylated amino acids

**-cyclic_peptide:n\_methyl\_positions \<IntegerVector\>** A list of the positions in the peptide that are N-methylated.  N-methylated positions will have their geometry updated, and will use Ramachandran maps and rotamer libraries specific for N-methyl amino acids.

## Additional flags for quasi-symmetric sampling

Sometimes, one wishes to sample peptide conformations with cyclic symmetry (_e.g._ c2 symmetry, c3 symmetry, _etc._).  The **simple_cycpep_predict** application can do quasi-symmetric sampling.  It does this by copying mainchain torsion values for perturbable residues in different symmetry repeats, and by filtering post-closure to ensure that pivot residues are adopting symmetric conformations.  (See the [[Generalized Kinematic Closure|GeneralizedKIC]] documentation for details on perturbable and pivot residues).  Note that this is _quasi_-symmetric rather than truly symmetric because (a) it does not use the Rosetta symmetry machinery, and (b) mainchain torsion values can deviate slightly from symmetry repeat to symmetry repeat, within user-defined limits.  The following flags control quasi-symmetric sampling:

**-cyclic_peptide:require_symmetry_repeats \<int\>** If this option is used, then only backbones that are cN (or cN/m, if mirror symmetry is required) symmetric will be accepted.  For example, if set to 2, then only c2-symmetric backbones will be accepted.  Unused if not specified (_i.e._ no quasi-symmetric sampling is performed without this option).<br/><br/>
**-cyclic_peptide:require_symmetry_mirroring \<bool\>** If this option is used, then only backbones with mirror symmetry are accepted.  Must be used with the -cyclic_peptide:require_symmetry_repeats flag.<br/><br/>
**-cyclic_peptide:require_symmetry_angle_threshold \<int\>** The cutoff, in degrees, to use when comparing mainchain torsion values to determine whether symmetry repeats are truly symmetric.  Defaults to 10 degrees.<br/><br/>
**-cyclic_peptide:require_symmetry_perturbation \<int\>** If provided, this is the magnitude of the perturbation to apply when copying mainchain dihedrals for symmetric sampling.  Allows slightly asymmetric conformations to be sampled.  Default is 0.0 (no perturbation).

## Additional flags for predicting structures of isopeptide-bonded lariat peptides

In addition to an amide bond connecting the N- and C-termini, it is possible to synthesize peptides in which an amine-containing side-chain forms an amide bond with the C-terminus, a carboxyl-containing side-chain forms an amide bond with the -terminus, or two side-chains form an amide bond.  These one- or two-tailed lariat structures can also be predicted with **simple_cycpep_predict**.  The relevant flags are as follows:

**-cyclic_peptide:cyclization_type \<string\>**  This flag, mentioned earlier, can be set to "nterm_isopeptide_lariat" for a sidechain-to-N-terminus isopeptide lariat, "cterm_isopeptide_lariat" for a sidechain-to-Cterminus isopeptide lariat, or "sidechain_isopeptide" for a two-tailed macrocycle linked by a sidechain-sidechain isopeptide bond.

**-cyclic_peptide:lariat_sidechain_index \<int\>** If a lariat cyclization type is specified (_e.g._ "nterm_isopeptide_lariat", "cterm_isopeptide_lariat"), then this is the residue that provides the side-chain that connects to the N- or C-terminus of the peptide.  If not specified, the residue of appropriate type closest to the other end is used.

**-cyclic_peptide:sidechain_isopeptide_indices \<int\> \<int\>** If the "sidechain_isopeptide" cyclization type is specified, then these are the indices of the residues that are linked by a sidechain-sidechain isopeptide bond to make the loop.  If this option is not used, then the residues furthest apart of appropriate types are used.  Note that exactly two indices must be given.

Note that the **-cyclic_peptide:require_symmetry_repeats** and **-cyclic_peptide:cyclic_permutations** flags are incompatible with isopeptide lariats.  Also note that the **simple_cycpep_predict** application does _not_ use the GLX, ASX, or LYX residue types.  Sequence files and native PDB files must specify GLU, ASP, and LYS, respectively.

## Additional flags for oligourea or peptoid residues

No additional options are required to use oligourea or peptoid residues with the **simple_cycpep_predict** applications.  Simply include the full names of these residues in the sequence file, just as one would for a canonical or non-cannoical amino acid.

## Other useful flags

For mixed D/L peptides, the **-score:symmetric_gly_tables** flag can be a beneficial flag to use.  This flag symmetrizes the Ramachandran and p_aa_pp tables used for sampling and scoring glycine, so that it is equally likely to be in the D- or L-regions of Ramachandran space.  As of 23 February 2016, this flag also symmetrizes the gly tables used by the RamaPrePro energy term (so that talaris2013, talaris2014, and beta_nov15 scorefunctions are all fully symmetric).

# Output

This application generates PDB or binary silent file output.  If the latter is used (recommended), hydrogen bond counts and RMSD values to native (if a native file was provided) are in the ```SCORE``` lines in the silent file.  Additionally, these values are reported in the output log.

The BOINC compilation also has some groovy graphics.

# Algorithm

The algorithm is as follows:

1.  For each sampling attempt, the application generates a linear peptide with the given sequence (randomly circularly permuted if the **-cyclic_peptide:cyclic_permutations** flag is set to true, the default).  The starting conformation is randomized, with each residue's phi/psi pair biased by the Ramachandran plot for that residue type.  All omega angles are set to 180 degrees.
2.  The [[Generalized Kinematic Closure|GeneralizedKICMover]] (GenKIC) protocol is used to find closed (cyclic) conformations of the peptide.  A single residue is chosen at random to be an "anchor" residue (excluding the two end residues).  The rest of the peptide is now a giant loop to be closed with GenKIC.  The first, last, and a randomly-chosen middle residue are selected as "pivot" residues.  GenKIC performs a series of samples (up to a maximum specified with the **-cyclic_peptide:genkic_closure_attempts** flag) in which it:
     - 2a.  Randomizes all residues in the loop, biased by the Ramachandran map.
     - 2b.  Analytically solves for phi and psi values for the pivot residues to close the loop.  At this step, anywhere from 0 to 16 solutions might result from the linear algebra performed.
     - 2c.  Filters each solution based on internal backbone clashes, the Ramachandran score for the pivot residues (controlled with the **-cyclic_peptide:rama_cutoff** flag), the presence of oversaturated hydrogen bond acceptors (controlled with the **-cyclic_peptide:filter_oversaturated_hbond_acceptors** flag), and the number of backbone hydrogen bonds (controlled with the **-cyclic_peptide:min_genkic_hbonds** flag).  Solutions passing all filters are relaxed using [[FastRelax|FastRelaxMover]] with an elevated hydrogen bond weight (set using the **-cyclic_peptide:high_hbond_weight_multiplier** flag), then stored.  (Note that the user can specify multiple rounds of ordinary FastRelax, flexible bond angle FastRelax, flexible bond angle / bond length FastRelax, or Cartesian FastRelax.  These are applied in this order.  Note, too, that FastDesign can be substituted for FastRelax at this stage -- see the section below on design for more information.)
     - 2d.  Repeats 2a through 2c until the maximum number of samples is reached, or until GenKIC has stored the number of solutions (passing filters) specified with the **-cyclic_peptide:genkic_min_solution_count** flag.
     - 2e.  Chooses the lowest-energy solution, based on the scorefunction with the exaggerated hydrogen bonding weight.
3.  The resulting solution is then relaxed using the conventional scorefunction (hydrogen bond weight reset to normal value).  Again, the user may request multiple rounds of ordinary FastRelax, flexible bond angle FastRelax, flexible bond angle / bond length FastRelax, or full Cartesian FastRelax; these are carried out in this order.  If any form of FastRelax is used that can perturb bond angles or bond lengths from ideal values, a final round of ordinary FastRelax is also appended at the very end.
4.  A final hydrogen bond filter is applied (controlled with the **-cyclic_peptide:min_final_hbonds** flag).
5.  The structure, if one is found, is written to disk, and the application proceeds to the next attempt until the number of attempts specified with the **-out:nstruct** flag is reached.

Optionally, step 2c can be performed with [[FastDesign|FastDesignMover]] instead of FastRelax.  See the section on design, below, for more information about this.

# Design mode

Although originally intended solely for structure prediction, the **simple_cycpep_predict** application can also design sequences for each sampled conformation using [[FastDesign|FastDesignMover]].  Design-specific flags are as follows:

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

Note that the global amino acid composition may also be biased by providing an [[aa_composition|AACompositionEnergy]] file with the **-score:aa_composition_setup_file** flag, as in other protocols.  In the context of the **simple_cycpep_predict** application, using any aa_composition flag will automatically turn on the aa_composition energy term in the scoring function used.

# Large-scale sampling with BOINC

The **simple_cycpep_predict** protocol is one of the protocols that can be run from the [[minirosetta]] application, using the **-protocol simple_cycpep_predict** flag.  Custom BOINC OpenGL graphics have been written for this application.  It is strongly recommended that the **-cyclic_peptide:checkpoint_job_identifier** option be used to allow jobs to checkpoint themselves if run on BOINC (since BOINC jobs can be interrupted by the user).  See [[minirosetta]]'s documentation for more information.

# Large-scale sampling on HPC clusters with MPI (the Message Passing Interface)

When Rosetta is compiled with the "extras=mpi" flag, the compiled version of the **simple_cycpep_predict** app (bin/simple_cycpep_predict.mpi.[os][compiler][release/debug]) has some additional features, with additional flags controlling those features.  In MPI mode, the app has a custom-written scalable job distribution and collection system, suitable for parallel sampling on systems as small as a laptop or as large as the IBM Blue Gene/Q infrastructure (hundreds of thousands of parallel CPUs).  The compilation flags "extras=cxx11thread,mpi" will also enable multi-threaded parallelism within a computing node, and multi-process parallelism with jobs distributed by MPI between nodes.  This is covered in detail in the next section.

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

Note that, in MPI mode, there can be an incredible amount of tracer output.  For convenience, the emperor uses a separate tracer to write a summary of all jobs that have been completed.  This summary includes the energy of each sample, the RMSD to native (if a native structure was provided), and a goodness-of-funnel metric (PNear).  (The PNear metric takes two parameters: **lambda** in Angstroms, which controls how close a sample has to be to native to be considered native-like, and **Boltzmann temperature** in Rosetta energy units, which controls how high-energy a non-native sample must be for the funnel not to be considered "bad".  These are set with the **-cyclic_peptide:MPI_pnear_lambda** and **-cyclic_peptide:MPI_pnear_kbt** flags, respectively.  See Bhardwaj, Mulligan, Bahl, *et al.* (2016) *Nature*, in press for more information about the PNear metric.)  To receive only this as output in the standard output stream, use the **-mute all -unmute protocols.cyclic_peptide_predict.SimpleCycpepPredictApplication_MPI_summary** flags.  (This silences all output from non-emperor processes, and most output from the emperor process, except for the summary at the end.)  Since generating output and managing output from large numbers of processes takes clock and MPI communication cycles, muting unnecessary output is advised for better performance.

Note too that intermediate master processes are optional; the minimum that one needs are an emperor node and a single slave node (though this setup would have no advantages over sampling with the non-MPI version of the app).  On a 4-core laptop, the following would be perfectly legal, for example:

```
mpirun -np 4 /my_rosetta_path/main/source/bin/simple_cycpep_predict.mpi.linuxgccrelease -cyclic_peptide:MPI_processes_by_level 1 3 -cyclic_peptide:MPI_batchsize_by_level 25 -nstruct 1000 -cyclic_peptide:MPI_sort_by energy -cyclic_peptide:MPI_output_fraction 0.05 ...(other options)...
```

This would farm out 1000 jobs to 3 slave processes in 25-job batches, with direct communication between the emperor and each slave (i.e. no intermediate masters).  This is inadvisable on very large systems, since the emperor can become inundated with too many communication requests from thousands of slaves, but is sensible on small systems.

## Using MPI- and thread-based parallelism on HPC clusters

When compiled with the flags "extras=cxx11thread,mpi", the **simple_cycpep_predict** application can make use of both process-based parallelism (with jobs distributed by MPI) and thread-based parallelism (with concurrent threads that share a memory space executing jobs simultaneously).  The hierarchy described in the previous section gains a final level: an emperor distributes jobs to some number of layers of intermediate masters, which distribute jobs to some number of slave processes, which launch some number of worker threads within a node to carry out jobs in parallel.  The **-cyclic_peptide:threads_per_slave** commandline option specifies the number of worker threads each slave process can launch.  Note that a value of 1 results in no worker threads being launched; in this case, the behaviour is identical to the pure MPI-based job distribution.  Higher values result in worker threads, with the caveat that N-1 threads will be used as workers, with the remaining thread reserved for MPI communication and job management.  These threads will share a memory space, including a single copy of the Rosetta database loaded by the process into memory (resulting in considerable memory savings on an HPC node with limited memory and abundant CPUs).  Given an HPC cluster with L nodes, M CPUs per node, and N cores per CPU, it is recommended to launch a total of L processes (one per node), and M*N threads per process.  Note that if M*N is large, there may be some efficiency lost compared to pure MPI-based performance, however; in this case, the balance between memory usage and performance must determine the number of processes launched per node and the number of threads per process.

# Known issues

- In MPI mode, only silent file output is permitted.  Users must provide an output file with **-out:file:silent**.
- Glycine's Ramachandran plot should be completely symmetric, but it is not, since it is based on statistics from the PDB.  (PDB structures disproportionately have glycine in the region of Ramachandran space that only it can access).  A flag has been added (**-score:symmetric_gly_tables**) to permit a symmetrized version of the glycine Ramachandran map to be used for sampling and scoring.
- Currently, there is no sampling of omega values, though these can deviate a bit from 180 degrees during final relaxation.  (The exception is sampling *cis*-peptide bonds at positions preceding proline; by default, these are sampled as *cis* 30% of the time, though this can be controlled with the **-cyclic_peptide:sample_cis_proline_frequency** flag.)
- Currently, only alpha-amino acids are supported, though it will be possible to generalize this to arbitrary backbones in the near future.
- Currently, there is no support for any sort of cyclization other than head-to-tail backbone cyclization and disulfide-mediated cyclization, or for any sort of cross-link other than disulfide bonds, trimesic acid, or 1,3,5-tris(bromomethyl)benzene.  These limitations will be addressed in the future.
- When predicting structures of mixed D/L peptides, it is important to use a symmetric scorefunction (_i.e._ one in which mirror-image structures score and minimize identically).  The talaris2013, talaris2014, and beta_nov15 scorefunctions are all fully symmetric when used with the **-score:symmetric_gly_tables** flag, and fully symmetric but for glycine when used without the flag.  The Cartesian variants of these score functions (talaris2013_cart, talaris2014_cart, and beta_nov15_cart) are also fully symmetric, but for glycine.
- Similarly, the scorefunction used must support cyclic geometry.  All of talaris2013, talaris2014, and beta_nov15 (plus their Cartesian variants, talaris2013_cart, talaris2014_cart, and beta_nov15_cart) support cyclic geometry as of 20 September 2016.
