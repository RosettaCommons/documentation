## BundleGridSampler
Generates a helical bundle, sampling user-specified ranges of parameters and outputting the lowest-energy bundle encountered (and its accompanying parameter values).  Optionally, this mover can also output PDB files for all bundle geometries sampled.

```
<BundleGridSampler name=(&string) symmetry=(0 &int) symmetry_copies=(0 &int) set_dihedrals=(true &bool)
   set_bondlengths=(false &bool) set_bondangles=(false &bool) residue_name=("ALA" &string)
   crick_params_file=("alpha_helix" &string)  helix_length=(0 &int) scorefxn=(&string)
   selection_type=("low"||"high" &string) pre_selection_mover=(&string) dump_pdbs=(false &bool)
   pdb_prefix=("bgs_out" &string) max_samples=(10000 &int)
    r0=(&real) OR ( r0_min=(&real) r0_max=(&real) r0_samples=(&int) )
    omega0=(&real) OR ( omega0_min=(&real) omega0_max=(&real) omega0_samples=(&int) )
    delta_omega0=(&real) OR ( delta_omega0_min=(&real) delta_omega0_max=(&real) delta_omega0_samples=(&int) )
    delta_omega1=(&real) OR ( delta_omega1_min=(&real) delta_omega1_max=(&real) delta_omega1_samples=(&int) )
    delta_t=(&real) OR ( delta_t_min=(&real) delta_t_max=(&real) delta_t_samples=(&int) )
   >
   <Helix set_dihedrals=(true &bool) set_bondlengths=(false &bool) set_bondangles=(false &bool)
     residue_name=("ALA" &string) crick_params_file=("alpha_helix" &string) helix_length=(0 &int)
     r0=(&real) OR (r0_copies_helix=(&int)) OR ( r0_min=(&real) r0_max=(&real) r0_samples=(&int) )
     omega0=(&real) OR (omega0_copies_helix=(&int)) OR ( omega0_min=(&real) omega0_max=(&real) omega0_samples=(&int) )
     delta_omega0=(&real) OR (delta_omega0_copies_helix=(&int)) OR ( delta_omega0_min=(&real) delta_omega0_max=(&real) delta_omega0_samples=(&int) )
     delta_omega1=(&real) OR (delta_omega1_copies_helix=(&int)) OR ( delta_omega1_min=(&real) delta_omega1_max=(&real) delta_omega1_samples=(&int) )
     delta_t=(&real) OR (delta_t_copies_helix=(&int)) OR ( delta_t_min=(&real) delta_t_max=(&real) delta_t_samples=(&int) )
   >
   <Helix ...>
   <Helix ...>
   ...
</BundleGridSampler>
```

Default parameter values or parameter ranges are set in the <b>BundleGridSampler</b> tag, and overrides are set in the individual <b>Helix</b> tags.  Refer to the <b>MakeBundle</b> mover for options that both movers have in common.  Additional options include:
- <b>[parameter]\_min</b>, <b>[parameter]_max</b>: Minimum and maximum parameter values for a range to be sampled.
- <b>[parameter]\_samples</b>: The number of samples.  Note that the total number of samples is the product of all individual samples, and this can get quite large very fast.

Note that default parameter ranges are applied separately to each helix.  For example, the following script would perform 16 samples (4 each for r0 of helix 1 and r0 of helix 2):

```
<BundleGridSampler name="bgs1" helix_length=20 scorefxn="sfxn1" r0_low=5.0 r0_high=8.0 r0_samples=4 omega0=0.05 delta_omega0=0 delta_omega1=0 delta_t=0>
     <Helix />
     <Helix delta_omega0=3.14 />
</BundleGridSampler>
```

In order to sample a range of parameters, keeping a parameter value for two different helices the same, the <b>[parameter]\_copies\_helix</b> option may be used in a <b>Helix</b> tag.  The helix to be copied must be declared before the helix that has the <b>[parameter]\_copies\_helix</b> option.  The following script, for example, carries out 4 samples, with r0 for both helices ranging from 5 to 8 (and always the same for both helices):

```
<BundleGridSampler name="bgs1" helix_length=20 scorefxn="sfxn1" r0_low=5.0 r0_high=8.0 r0_samples=4 omega0=0.05 delta_omega0=0 delta_omega1=0 delta_t=0>
     <Helix />
     <Helix delta_omega0=3.14 r0_copies_helix=1/>
</BundleGridSampler>
```