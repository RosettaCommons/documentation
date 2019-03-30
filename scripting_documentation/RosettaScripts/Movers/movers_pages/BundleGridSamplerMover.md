# BundleGridSampler
Page created by Vikram K. Mulligan (vmulligan@flatironinstitute.org).  Last updated 12 October 2018.
*Back to [[Mover|Movers-RosettaScripts]] page.*
## BundleGridSampler

Generates a helical bundle using the Crick equations (describing a coiled-coil) or modified Crick equations (describing a laterally squashed coiled-coil), sampling user-specified ranges of parameters and outputting the lowest-energy bundle encountered (and its accompanying parameter values).  Sampled parameters are evenly distributed in user-specified ranges; if more than one parameter is sampled, the mover samples an n-dimensional grid of sample values.  Optionally, this mover can also output PDB files for all bundle geometries sampled.  Parameters are stored with the pose, and are written in REMARK lines on PDB output.  Note that because a strand is a special case of a helix, this mover can also be used to sample beta-barrel conformations or mixed alpha-beta structures.

[[include:mover_BundleGridSampler_type]]

Note that default parameter ranges are applied separately to each helix.  For example, the following script would perform 16 samples (4 each for r0 of helix 1 and r0 of helix 2):

```xml
<BundleGridSampler name="bgs1" helix_length="20" scorefxn="sfxn1" r0_min="5.0" r0_max="8.0" r0_samples="4" omega0="0.05" delta_omega0="0" delta_omega1="0" delta_t="0">
     <Helix />
     <Helix delta_omega0="3.14" />
</BundleGridSampler>
```

In order to sample a range of parameters, keeping a parameter value for two different helices the same, the <b>[parameter]\_copies\_helix</b> option may be used in a <b>Helix</b> tag.  The helix to be copied must be declared before the helix that has the <b>[parameter]\_copies\_helix</b> option.  The following script, for example, carries out 4 samples, with r0 for both helices ranging from 5 to 8 (and always the same for both helices):

```xml
<BundleGridSampler name="bgs1" helix_length="20" scorefxn="sfxn1" r0_min="5.0" r0_max="8.0" r0_samples="4" omega0="0.05" delta_omega0="0" delta_omega1="0" delta_t="0">
     <Helix />
     <Helix delta_omega0="3.14" r0_copies_helix="1"/>
</BundleGridSampler>
```

##See Also

* [[The Crick params file format|Crick-params-files]]
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
