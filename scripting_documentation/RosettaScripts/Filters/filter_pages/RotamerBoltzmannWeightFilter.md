# RotamerBoltzmannWeight
*Back to [[Filters|Filters-RosettaScripts]] page.*
## RotamerBoltzmannWeight

Approximates the Boltzmann probability for the occurrence of a rotamer. The method, usage examples, and analysis scripts are published in Fleishman et al. (2011) Protein Sci. 20:753.

Residues to be tested are defined using a task\_factory (set all inert residues to no repack). A first-pass alanine scan looks at which residues contribute substantially to binding affinity. Then, the rotamer set for each of these residues is taken, each rotamer is imposed on the pose, the surrounding shell is repacked and minimized and the energy is summed to produce a Boltzmann probability. Can be computed in both the bound and unbound state.

This is apparently a good discriminator between designs and natives, with many designs showing high probabilities for their highly contributing rotamers in both the bound and unbound states.

The filter also reports a modified value for the complex ddG. It computes the starting ddG and then reduces from this energy a fraction of the interaction energy of each residue the rotamer probability of which is below a certain threshold. The interaction energy is computed only for the residue under study and its contacts with residues on another chain.

For real-valued contexts, the value of the filter by default is the modified ddG value. If the no\_modified\_ddG option is set true, then the value of the filter is equal to the negative of the average rotamer probablility across the evaluated residues.

Works with symmetric poses and poses with symmetric "building blocks".

```xml
<RotamerBoltzmannWeight name="(&string)" task_operations="(comma-delimited list)" radius="(6.0 &Real)" jump="(1 &Integer)" sym_dof_names="('' &string)" unbound="(1 &bool)" ddG_threshold="(1.5 &Real)" scorefxn="(score12 &string)" temperature="(0.8 &Real)" energy_reduction_factor="(0.5 &Real)" repack="(1&bool)" skip_ala_scan="(0 &bool)" skip_report="(0 &bool)" no_modified_ddG="(0 &bool)">
   <Threshold restype="???" threshold_probability="(&Real)"/>
   .
   .
   .
</RotamerBoltzmannWeight>
```

-   task\_operations: define what residues to work on. Set all residues not to be tested to no repack.
-   radius: repacking radius around the rotamer under consideration. These residues will be repacked and minimized for each rotamer tested
-   jump: what jump to look at
-   sym\_dof\_names: what jumps to look at: Look up jumps corresponding to sym\_dofs and separate the pose along these jumps. Can separate along multiple at once.
-   unbound: test the bound or unbound state?
-   ddG\_threshold: a further filter on which designs to test. Only residues that contribute more than the stated amount to binding will be tested.
-   temperature: the scaling factor for the Boltzmann calculations. This is actually kT rather than just T.
-   energy\_reduction\_factor: by what factor of the interaction energy to reduce the ddG.
-   repack: repack in the bound and unbound states before reporting binding energy values (ddG). If false, don't repack (dG).
-   skip\_ala\_scan: do not conduct first-pass ala scan. Instead compute only for residues that are allowed to repack in the task factory.
-   skip\_report: If true, the report() function of the filter will not re-compute the filter score.  This will not affect the filter value reported into the scorefile by report_sm(). If false, the report() function will recompute and report the filter score to stdout.  The filter score will be computed twice in a RosettaScripts run if this option is set to false. (Default=false for historical reasons)
-   no\_modified\_ddG: Skip the ddG calculation.
-   ??? any of the three-letter codes for residues (TRP, PHE, etc.)

## See also

* [[Design in Rosetta|application_documentation/design/design-applications]]
* [[PackRotamersMover]]
* [[AlaScanFilter]]
* [[DdgFilter]]

