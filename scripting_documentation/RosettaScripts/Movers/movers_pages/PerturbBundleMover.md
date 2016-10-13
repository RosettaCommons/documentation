# PerturbBundle
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PerturbBundle

This mover operates on a pose generated with the MakeBundle mover.  It perturbs (<i>i.e.</i> adds a small, random value to) one or more Crick parameters, then alters the backbone conformation to reflect the altered Crick parameters.  This is useful for iterative Monte Carlo searches of Crick parameter space.

```

<PerturbBundle name=(&string) use_degrees=(false &bool) default_perturbation_type=(&string)
     r0_perturbation=(&real) r0_perturbation_type=(&string)
     omega0_perturbation=(&real) omega0_perturbation_type=(&string)
     delta_omega0_perturbation=(&real) delta_omega0_perturbation_type=(&string)
     delta_omega1_perturbation=(&real) delta_omega1_perturbation_type=(&string)
     delta_t_perturbation=(&real) delta_t_perturbation_type=(&string)
     z1_offset_perturbation=(&real) z1_offset_perturbation_type=(&string)
     z0_offset_perturbation=(&real) z0_offset_perturbation_type=(&string)
     epsilon_perturbation=(&real) epsilon_perturbation_type=(&string)
>
          <Helix helix_index=(&int)
               r0_perturbation=(&real) r0_perturbation_type=(&string) r0_copies_helix=(&int)
               omega0_perturbation=(&real) omega0_perturbation_type=(&string) omega0_copies_helix=(&int) pitch_from_helix=(&int)
               delta_omega0_perturbation=(&real) delta_omega0_perturbation_type=(&string) delta_omega0_copies_helix=(&int)
               delta_omega1_perturbation=(&real) delta_omega1_perturbation_type=(&string) delta_omega1_copies_helix=(&int)
               delta_t_perturbation=(&real) delta_t_perturbation_type=(&string) delta_t_copies_helix=(&int)
               z1_offset_perturbation=(&real) z1_offset_perturbation_type=(&string) z1_offset_copies_helix=(&int)
               z0_offset_perturbation=(&real) z0_offset_perturbation_type=(&string) z0_offset_copies_helix=(&int)
               epsilon_perturbation=(&real) epsilon_perturbation_type=(&string) epsilon_copies_helix=(&int)
          />
</PerturbBundle>

```

Default options for all helices are set in the **PerturbBundle** tag.  A default perturber type for all perturbations can be set with the **default_perturbation_type** option; currently-accepted values are "gaussian" and "uniform".  These can be overridden on a parameter-by-parameter basis with individual **perturbation_type** options.  Default perturbation magnitudes are set with **perturbation** options.  If an option is omitted, that Crick parameter is not perturbed.  These can also be overridden on a helix-by-helix basis by adding **Helix** sub-tags.  In the sub-tags, if an option is omitted, that degree of freedom is not perturbed unless a default perturbation was set for it in the main tag.  In the sub-tags, helices can also be set to copy degrees of freedom of other helices with **copies_helix** options.  A special case of this is the **pitch_copies_helix** option, which will set omega0 to whatever value is necessary to ensure that one helix copies the major helix pitch (the rise along the major helix axis per turn about the major helix axis) of another helix.  Perturbable Crick parameters include:

<b>r0</b>: The major helix radius.<br/>
<b>omega0</b>: The major helix twist per residue.<br/>
<b>delta_omega0</b>: The radial offset about the major helix axis.<br/>
<b>delta_omega1</b>: The rotation of the minor helix about the minor helix axis.<br/>
<b>delta_t</b>: A value to offset the helix by a certain number of amino acid residues along its direction of propagation (i.e. along the helix-of-helices path through space).<br/>
<b>z1_offset</b>: A value to offset the helix by a certain number Angstroms along the minor helix axis (i.e. a helical path through space).  Note that the distance is measured along the z-axis (not along the helical path).  Inverted helices are shifted in the opposite direction.<br/>
<b>z0_offset</b>: A value to offset the helix by a certain number Angstroms along the major helix axis (i.e. a straight path through space).  Inverted helices are shifted in the opposite direction.<br/>
<b>epsilon</b>: A value to squash the bundle laterally, which is useful for generating beta-barrels. A value of 1.0 (the default) yields a bundle with a circular cross-section, and simplifies the generating equations to the original Crick equations. A value between 0.5 and 1.0 is recommended for a slightly squashed bundle or beta-barrel. The cross section is not a true ellipse, but rather the shape that results from the expression r=(1-epsilon)/2*(cos(2*theta)+1)+epsilon, where r is the radius and theta is the angle to the x-axis. Values outside of the range [0.5,1.0] are not recommended.<br/>

##See Also

* [[MakeBundle mover|MakeBundleMover]]
* [[BundleGridSampler mover|Mover]]
* [[BundleReporter filter|BundleReporterFilter]]