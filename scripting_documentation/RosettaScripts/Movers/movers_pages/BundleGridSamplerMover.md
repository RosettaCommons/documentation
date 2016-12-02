# BundleGridSampler
*Back to [[Mover|Movers-RosettaScripts]] page.*
## BundleGridSampler

Generates a helical bundle using the Crick equations (describing a coiled-coil) or modified Crick equations (describing a laterally squashed coiled-coil), sampling user-specified ranges of parameters and outputting the lowest-energy bundle encountered (and its accompanying parameter values).  Sampled parameters are evenly distributed in user-specified ranges; if more than one parameter is sampled, the mover samples an n-dimensional grid of sample values.  Optionally, this mover can also output PDB files for all bundle geometries sampled.  Parameters are stored with the pose, and are written in REMARK lines on PDB output.  Note that because a strand is a special case of a helix, this mover can also be used to sample beta-barrel conformations or mixed alpha-beta structures.

```
<BundleGridSampler name=(&string) use_degrees=(false &bool) symmetry=(0 &int) symmetry_copies=(0 &int) set_dihedrals=(true &bool)
   set_bondlengths=(true &bool) set_bondangles=(true &bool) residue_name=("ALA" &string)
   crick_params_file=("alpha_helix" &string)  helix_length=(0 &int) invert=(false &bool)
   scorefxn=(&string) selection_type=("low"||"high" &string) pre_selection_mover=(&string)
   pre_selection_filter=(&string) dump_pdbs=(false &bool) pdb_prefix=("bgs_out" &string)
   max_samples=(10000 &int) reset=(true &bool) nstruct_mode=(false &bool) nstruct_repeats=(1 &int)
    r0=(&real) OR ( r0_min=(&real) r0_max=(&real) r0_samples=(&int) )
    omega0=(&real) OR ( omega0_min=(&real) omega0_max=(&real) omega0_samples=(&int) )
    delta_omega0=(&real) OR ( delta_omega0_min=(&real) delta_omega0_max=(&real) delta_omega0_samples=(&int) )
    delta_omega1=(&real) OR ( delta_omega1_min=(&real) delta_omega1_max=(&real) delta_omega1_samples=(&int) )
    delta_t=(&real) OR ( delta_t_min=(&real) delta_t_max=(&real) delta_t_samples=(&int) )
    z1_offset=(&real) OR (z1_offset_min=(&real) z1_offset_max=(&real) z1_offset_samples=(&int))
    z0_offset=(&real) OR (z0_offset_min=(&real) z0_offset_max=(&real) z0_offset_samples=(&int))
    epsilon=(&real) OR (epsilon_min=(&real) epsilon_max=(&real) epsilon_samples=(&int))
    repeating_unit_offset=0(&int)
   >
   <Helix set_dihedrals=(true &bool) set_bondlengths=(false &bool) set_bondangles=(false &bool) invert=(false &bool)
     residue_name=("ALA" &string) crick_params_file=("alpha_helix" &string) helix_length=(0 &int)
     r0=(&real) OR (r0_copies_helix=(&int)) OR ( r0_min=(&real) r0_max=(&real) r0_samples=(&int) )
     omega0=(&real) OR (omega0_copies_helix=(&int)) OR (pitch_from_helix=(&int)) OR ( omega0_min=(&real) omega0_max=(&real) omega0_samples=(&int) )
     delta_omega0=(&real) OR (delta_omega0_copies_helix=(&int)) OR ( delta_omega0_min=(&real) delta_omega0_max=(&real) delta_omega0_samples=(&int) )
     delta_omega1=(&real) OR (delta_omega1_copies_helix=(&int)) OR ( delta_omega1_min=(&real) delta_omega1_max=(&real) delta_omega1_samples=(&int) )
     delta_t=(&real) OR (delta_t_copies_helix=(&int)) OR ( delta_t_min=(&real) delta_t_max=(&real) delta_t_samples=(&int) )
     z1_offset=(&real) OR (z1_offset_copies_helix=(&int)) OR ( z1_offset_min=(&real) z1_offset_max=(&real) z1_offset_samples=(&int) )
     z0_offset=(&real) OR (z0_offset_copies_helix=(&int)) OR ( z0_offset_min=(&real) z0_offset_max=(&real) z0_offset_samples=(&int) )
     epsilon=(&real) OR (epsilon_copies_helix=(&int)) OR ( epsilon_min=(&real) epsilon_max=(&real) epsilon_samples=(&int) )
     repeating_unit_offset=0(&int)
   >
   <Helix ...>
   <Helix ...>
   ...
</BundleGridSampler>
```

Default parameter values or parameter ranges are set in the <b>BundleGridSampler</b> tag, and overrides are set in the individual <b>Helix</b> tags.  Refer to the **[[MakeBundle mover|MakeBundleMover]]** for options that both movers have in common.  Additional options include:
- <b>[parameter]\_min</b>, <b>[parameter]_max</b>: Minimum and maximum parameter values for a range to be sampled.
- <b>[parameter]\_samples</b>: The number of samples.  Note that the total number of samples is the product of all individual samples, and this can get quite large very fast.
- <b>[parameter]\_copies\_helix</b>: This option may only be specified in a <b>Helix</b> sub-tag.  It indicates that a particular parameter for that helix is always set to the same value as that parameter from a previously-defined helix.  See below for an example.
- <b>pitch_from_helix</b>: This is a special case.  As an alternative to <b>omega0_copies_helix</b>, which indicates that the major helix twist per residue should be matched to that of another helix, the user may specify that the helical pitch (the rise along the major helical axis per turn about the major helical axis) be matched to that of another helix.  This is useful in the case of bundles in which different helices may lie different distances from the bundle axis (i.e. have different r0 values), but which still need to pack together nicely.  If the helix pitch is matched, helices can run parallel to other helices despite having different r0 values.  The major helix pitch will be maintained despite sampling changes in r0 or omega0.
- <b>max\_samples</b>: The maximum number of samples permitted.  If the total number of samples is larger than this, the mover throws an error at apply time.  This is meant as a protection for the user, to prevent unreasonably large grid sampling jobs from being attempted.  The default value of 10,000 samples is conservative, and may be increased.
- <b>reset</b>: If true (the default setting), the pose is reset before generating bundles.  If false, the bundle geometry is added to the input geometry.
- <b>nstruct_mode</b>: By default, each separate trajectory samples all possible sets of Crick parameters and picks the lowest-energy one to pass to the next mover.  If you set nstruct_mode=true, then each separate trajectory (set using the -nstruct flag at the command line when calling the rosetta_scripts app) samples one set of Crick parameter values.  This is very useful in conjunction with the MPI compilation of RosettaScripts, since it provides an easy way to split the sampling over trajectories that will be handled in parallel.
- <b>nstruct_repeats</b>:  This option is ignored unless nstruct_mode is set to true. If nstruct_mode is set, and nstruct_repeats is set to a value greater than 1, each set of Crick parameter values will be sampled N times.  This is useful in conjunction with other sampling movers that split sampling over trajectories set with the -nstruct flag.  For example, if one were using the BundleGridSampler to sample 100 different sets of Crick parameter values, and a subsequent mover to sample another 100 different sets of parameter values of something else, there would be 10,000 pairwise combinations.  To sample all of these, one could set nstruct_repeats to 100, so that each set of Crick parameters is sampled 100 times and passed to the next mover which carries out 100 different trajectories with 100 different sets of the parameters sampled in step 2.
- <b>scorefxn</b>: The scoring function to use.  This must be specified, since this mover selects the lowest-energy bundle generated.
- <b>selection\_type</b>:  Although the lowest-energy bundle is selected by default ("low"), the user may optionally specify that the highest-energy bundle ("high") be selected instead.
- <b>pre\_selection\_mover</b>:  If specified, this mover will be applied to each generated bundle prior to energy evaluation.  This can be useful for side-chain packing or minimization as backbone conformations are sampled.  Note that this can greatly increase runtime, however.  Note also that, if a mover is used that alters the backbone conformation, the conformation may no longer lie within the Crick parameter space.
- <b>pre\_selection\_filter</b>:  If specified, this filter will be applied to each generated bundle prior to picking the lowest-energy bundle.  If PDB output has been turned on, only bundles passing filters will be written to disk.
- <b>dump\_pdbs</b>: If true, a PDB file is written for every bundle conformation sampled.  False by default.
- <b>pdb\_prefix</b>: The prefix for the PDB filenames if PDB files are being written.  Filenames will be of the format [prefix]\_#####.pdb.  This defaults to "bgs_out".

Note that default parameter ranges are applied separately to each helix.  For example, the following script would perform 16 samples (4 each for r0 of helix 1 and r0 of helix 2):

```
<BundleGridSampler name="bgs1" helix_length="20" scorefxn="sfxn1" r0_min="5.0" r0_max="8.0" r0_samples="4" omega0="0.05" delta_omega0="0" delta_omega1="0" delta_t="0">
     <Helix />
     <Helix delta_omega0="3.14" />
</BundleGridSampler>
```

In order to sample a range of parameters, keeping a parameter value for two different helices the same, the <b>[parameter]\_copies\_helix</b> option may be used in a <b>Helix</b> tag.  The helix to be copied must be declared before the helix that has the <b>[parameter]\_copies\_helix</b> option.  The following script, for example, carries out 4 samples, with r0 for both helices ranging from 5 to 8 (and always the same for both helices):

```
<BundleGridSampler name="bgs1" helix_length="20" scorefxn="sfxn1" r0_min="5.0" r0_max="8.0" r0_samples="4" omega0="0.05" delta_omega0="0" delta_omega1="0" delta_t="0">
     <Helix />
     <Helix delta_omega0="3.14" r0_copies_helix="1"/>
</BundleGridSampler>
```

##See Also

* [[MakeBundle mover|MakeBundleMover]]
* [[PerturbBundle mover|PerturbBundleMover]]
* [[BundleReporter filter|BundleReporterFilter]]
* [[BackboneGridSampler mover|BackboneGridSamplerMover]]
* [[Symmetry]]: Using symmetry in Rosetta
* [[SymmetryAndRosettaScripts]]
* [[SetupForSymmetryMover]]
* [[SetupNCSMover]]
* [[DetectSymmetryMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]
* [[I want to do x]]: Guide to choosing a mover
