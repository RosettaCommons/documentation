## BundleGridSampler
Generates a helical bundle, sampling user-specified ranges of parameters and outputting the lowest-energy bundle encountered (and its accompanying parameter values).  Optionally, this mover can also output PDB files for all bundle geometries sampled.

```
<BundleGridSampler name=(&string) symmetry=(0 &int) symmetry_copies=(0 &int) set_dihedrals=(true &bool)
   set_bondlengths=(false &bool) set_bondangles=(false &bool) residue_name=("ALA" &string)
   crick_params_file=("alpha_helix" &string)  helix_length=(0 &int)
   (r0=(&real) OR r0_min=(&real) r0_max=(&real))
   (omega0=(&real) OR omega0_min=(&real) omega0_max=(&real))
   (delta_omega0=(&real) OR delta_omega0_min=(&real) delta_omega0_max=(&real))
   (delta_omega1=(&real) OR delta_omega1_min=(&real) delta_omega1_max=(&real))
   (delta_t=(&real) OR delta_t_min=(&real) delta_t_max=(&real))
   >
</BundleGridSampler>
```