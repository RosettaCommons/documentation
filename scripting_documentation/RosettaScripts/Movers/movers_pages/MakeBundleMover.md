# MakeBundle
Page created by Vikram K. Mulligan (vmullig@uw.edu).  Last modified 16 June 2016.
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MakeBundle

Generates a helical bundle using the Crick equations (which describe a helix of helices) or modified Crick equations (describing a laterally-squashed helix of helices).  This mover is general enough to create arbitrary helices using arbitrary backbones.  Since strands are a special case of a helix (in which the turn per residue is about 180 degrees), the mover can also generate beta-barrels or other strand bundles.  The generated secondary structure elements are disconnected, so subsequent movers (e.g. <b>GeneralizedKIC</b>) must be invoked to connect them with loops.  Parameters are stored with the pose, and are written in REMARK lines on PDB output.

Helix types are defined with crick_params files, located in the Rosetta database in database/protocol_data/crick_parameters (or provided by the user).  Support for Crick parameter files defining helices in which the repeating unit is more than one residue has recently been added.

```
<MakeBundle name=(&string) use_degrees=(false &bool) reset=(true &bool) symmetry=(0 &int) symmetry_copies=(0 &int) set_dihedrals=(true &bool) set_bondlengths=(true &bool) set_bondangles=(true &bool) residue_name=("ALA" &string) crick_params_file=("alpha_helix" &string)  helix_length=(0 &int) r0=(0.0 &real) omega0=(0.0 &real) delta_omega0=(0.0 &real) delta_omega1=(0.0 &real) delta_t=(0.0 &real) z1_offset=(0.0 &real) z0_offset=(0.0 &real) epsilon=(1.0 &real) invert=(false &bool) >
     <Helix set_dihedrals=(true &bool) set_bondlengths=(false &bool) set_bondangles=(false &bool) residue_name=("ALA" &string) crick_params_file=("alpha_helix" &string)  helix_length=(0 &int) r0=(0.0 &real) omega0=(0.0 &real) delta_omega0=(0.0 &real) delta_omega1=(0.0 &real) delta_t=(0.0 &real) z1_offset=(0.0 &real) z0_offset=(0.0 &real) epsilon=(1.0 &real) invert=(false &bool) repeating_unit_offset=(0 &int) />
...
</MakeBundle>
```

Options in the <b>MakeBundle</b> tag set defaults for the whole bundle.  Individual helices are added with the <b>Helix</b> sub-tags, each of which may include additional options overriding the defaults.  The parameters that can be adjusted are:

<b>set_bondlengths, set_bondangles, set_dihedrals</b>: Should the mover be able to set each of these DOF types?  By default, all three are set by the mover.  Allowing bond angles and bond lengths to be set creates non-ideal backbones, but which are flexible enough to more perfectly form a helix of helices.  (Slight deviations form perfect major helices are seen with only dihedrals being set.)<br/>
<b>residue_name</b>: The type of residue from which the helix should be constructed.  In the case of helices with repeating units of more than one residue (e.g. collagen), one must specify a comma-separated list of residue types (e.g. "PRO,PRO,GLY").<br/>
<b>r0</b>: The major helix radius (the radius of the bundle, in Angstroms).<br/>
<b>omega0</b>:  The major helix turn per residue, in radians (or degrees, if use_degrees is set to true).  If set too high, no sensible geometry can be generated, and the mover throws an error.  <i>Note: All angular values are in <b>radians</b> unless use_degrees is set to true.</i><br/>
<b>delta_omega0</b>:  An offset value for <b>omega0</b> that will rotate the generated helix about the bundle axis.<br/>
<b>crick_params_file</b>:  A filename containing parameters (e.g. minor helix radius, minor helix twist per residue, minor helix rise per residue, <i>etc.</i>) for the minor helix.  Crick parameters files for helices formed by arbitrary noncanonical backbones can be generated using the <b>fit_helixparams</b> app.  The Rosetta database currently contains several sets of minor helix parameters:<br/>
- "alpha_helix": A standard L-amino acid right-handed alpha-helix, with phi=-64.8, psi=-41.0, and omega=180.0.  Note that the turn per residue for this helix is 98.65 degrees, not exactly 100 degrees.<br/>
- "alpha_helix_100": An L-amino acid right-handed alpha-helix, with phi=-62.648, psi=-41.0, and omega=180.0, yielding a turn per residue of 100 degrees.  This is for backward compatibility with the Python scripts used to generate helical bundles previously.
- "beta_strand": An L-amino acid beta-strand, with phi=-135.0, psi=135.0, and omega=180.0.<br/>
- "collagen": <b>EXPERIMENTAL</b>.  This generates a collagen helix.  This is experimental because the repeating unit in this helix is a three-residue repeat rather than a single residue.
- "neutral_beta_strand": An unnaturally straight beta-strand, with phi=180.0, psi=180.0, and omega=180.0.  Both L- and D-amino acids can access this region of Ramachandran space.<br/>
- "L_alpha_helix": A left-handed alpha-helix, as can be formed by D-amino acids.  Phi=64.8, psi=41.0, and omega=180.0.<br/>
- "daa_beta_strand": A beta-strand formed by D-amino acids, mirroring that formed by L-amino acids.  Phi=135.0, psi=-135.0, and omega=180.0.<br/>
- "14_helix": A left-handed helix formed by beta-amino acids.  Phi=-139.9, theta=59.5, psi=-138.7, and omega=180.0.<br/>

<b>omega1</b>:  The minor helix turn per residue.  This is usually set with a Crick parameters file, but this option overrides whatever value is read in from the file.  <b>Not recommended</b>.  Most users should simply read omega1 from a Crick parameters file.<br/>
<b>delta_omega1</b>:  An offset value for <b>omega1</b>.  This rotates the generated helix about the minor helix axis ("rolling" the helix).<br/>
<b>z1</b>:  The minor helix rise per residue.  This is usually set with a Crick parameters file, but this option overrides whatever value is read in from the file.  <b>Not recommended</b>.  Most users should simply read omega1 from a Crick parameters file.<br/>
<b>delta_t</b>:  Shifts the registry of the helix.  (This value is the number of amino acid residues by which the helix should be shifted.)  Mainchain atoms are shifted along a path shaped like a helix of helices.<br/>
<b>z1_offset</b>:  Shifts the helix along the minor helix axis.  (The distance is measured in Angstroms along the <i>major helix axis</i>).  Mainchain atoms are shifted along a path shaped like a helix.  Inverted helices are shifted in the opposite direction.<br/>
<b>z0_offset</b>:  Shifts the helix along the major helix axis.  (The distance is measured in Angstroms).  Mainchain atoms are shifted along a path shaped like a straight line.  Inverted helices are shifted in the opposite direction.<br/>
<b>epsilon</b>:  Squashes the bundle laterally, which is useful for generating beta-barrels.  A value of 1.0 (the default) yields a bundle with a circular cross-section, and simplifies the generating equations to the original Crick equations.  A value between 0.5 and 1.0 is recommended for a slightly squashed bundle or beta-barrel.  The cross section is not a true ellipse, but rather the shape that results from the expression r=(1-epsilon)/2*(cos(2*theta)+1)+epsilon, where r is the radius and theta is the angle to the x-axis.  Values outside of the range [0.5,1.0] are not recommended.<br/>
<b>invert</b>:  This reverses the direction of a helix, which makes it easy to generate antiparallel bundles or sheets.<br/>
<b>repeating_unit_offset</b>:  In the special case of helices in which the repeating unit is more than one residue (e.g. collagen), this allows the user to offset the repeating unit in the helix by a certain number of residues.  A value of 0 means that the first residue in the helix will be the first residue in the repeating unit; a value of 1 means that the first residue in the helix will be the <i>second</i> residue in the repeating unit, <i>etc.</i><br/>

In addition, the following options can only be set for the bundle as a whole:

<b>use_degrees</b>:  By default, all angles are interpreted as being in radians.  If this is set to "true", however, the mover will interpret angles as being in degrees.  False by default.<br/>
<b>reset</b>:  If "true" (the default), then the input pose is deleted and new geometry is generated.  If "false", then the geometry is added to the input pose as new chains.<br/>
<b>symmetry</b>:  Defines the radial symmetry of the bundle.  If set to something other than 0 (the default) or 1, then each helix specified is repeated this many times around the z-axis.  For example, if the script defined 2 helices and symmetry were set to 3, a total of 6 helices would be generated.  <i>Note:  At the present time, this mover does not automatically set up a symmetric conformation that symmetry-aware movers will respect.</i>  Other symmetrization movers must be invoked if the intent is to preserve symmetry during subsequent design or minimization steps.<br/>
<b>symmetry_copies</b>:  Defines how many radially symmetric copies of the defined helices will be placed.  A value of 0 results in copies matching the symmetry (for example, given six-fold symmetry, one would get six copies of the defined helices about the z-axis.)  Nonzero values result in only a subset of the symmetric copies being placed, permitting the generation of partial bundles.<br/>

Example:  This script generates an antiparallel beta-barrel with a bundle of alpha-helices on the inside.
```
<MakeBundle name=bundle1 set_bondlengths=true set_bondangles=true residue_name=ALA crick_params_file=beta_strand symmetry=16 r0=29 omega0=0.075 helix_length=20 >
        #The parameters set above ensure that by default, each "helix" will actually be a strand:
	<Helix /> #A strand
	<Helix delta_omega0=0.19634954 invert=1 delta_t=0.25 delta_omega1=1.5707963 /> #An offset, inverted strand.
	<Helix r0=21 omega0=0.05 crick_params_file=alpha_helix helix_length=40 /> #An alpha-helix.
	#The three elements defined above are repeated 16 times about the bundle axis to make the bundle.
</MakeBundle>

```

Note that RosettaScripts requires some sort of input on which to operate, but this mover, by default, deletes input geometry and replaces it with the generated geometry.  When running RosettaScripts, one can either pass in a dummy PDB file with the -in:file:s flag, or a dummy FASTA file with the -in:file:fasta flag.


##See Also

* [[BundleGridSampler mover|BundleGridSamplerMover]]
* [[PerturbBundle mover|PerturbBundleMover]]
* [[BundleReporter filter|BundleReporterFilter]]
* [[Symmetry]]: Using symmetry in Rosetta
* [[SymmetryAndRosettaScripts]]
* [[SetupForSymmetryMover]]
* [[SetupNCSMover]]
* [[DetectSymmetryMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]
