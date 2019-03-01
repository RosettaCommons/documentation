# PerturbBundle
Documentation by Vikram K. Mulligan (vmullig@uw.edu).  Last updated 12 October 2018.

[[_TOC_]]

*Back to [[Mover|Movers-RosettaScripts]] page.*
## PerturbBundle

This mover operates on a pose generated with the [[MakeBundle|MakeBundleMover]] or [[BundleGridSampler]] movers.  It perturbs (<i>i.e.</i> adds a small, random value to) one or more Crick parameters, then alters the backbone conformation to reflect the altered Crick parameters.  This is useful for iterative Monte Carlo searches of Crick parameter space.  The mover can also set the absolute value of a parameter directly (_i.e._ without random perturbation)

##Usage

[[include:mover_PerturbBundle_type]]

Default options for all helices are set in the **PerturbBundle** tag.  A default perturber type for all perturbations can be set with the **default_perturbation_type** option; currently-accepted values are "gaussian" and "uniform".  These can be overridden on a parameter-by-parameter basis with individual **perturbation_type** options.  Default perturbation magnitudes are set with options ending in **\_perturbation**.  If an option is omitted, that Crick parameter is not perturbed.  These can also be overridden on a helix-by-helix basis by adding **Helix** sub-tags.  In the sub-tags, if an option is omitted, that degree of freedom is not perturbed unless a default perturbation was set for it in the main tag.  In the sub-tags, helices can also be set to copy degrees of freedom of other helices with **copies_helix** options.  A special case of this is the **pitch_copies_helix** option, which will set omega0 to whatever value is necessary to ensure that one helix copies the major helix pitch (the rise along the major helix axis per turn about the major helix axis) of another helix.

As of 24 May 2017, this mover can also be used to _set_ the value of a parameter to a desired absolute value.  To set the value of epsilon to 0.75, for example, one would use `epsilon="0.75"` (which would be used _in lieu_ of an `epsilon_perturbation` option).

##See Also

* [[The Crick params file format|Crick-params-files]]
* [[MakeBundle mover|MakeBundleMover]]
* [[BundleGridSampler mover|Mover]]
* [[BundleReporter filter|BundleReporterFilter]]