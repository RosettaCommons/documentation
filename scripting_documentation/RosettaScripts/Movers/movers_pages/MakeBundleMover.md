# MakeBundle
Page created by Vikram K. Mulligan (vmulligan@flatironinstitute.org).  Last modified 12 October 2018.
*Back to [[Mover|Movers-RosettaScripts]] page.*

[[_TOC_]]

## MakeBundle

Generates a helical bundle using the Crick equations (which describe a helix of helices) or modified Crick equations (describing a laterally-squashed helix of helices).  This mover is general enough to create arbitrary helices using arbitrary backbones.  Since strands are a special case of a helix (in which the turn per residue is about 180 degrees), the mover can also generate beta-barrels or other strand bundles.  The generated secondary structure elements are disconnected, so subsequent movers (e.g. <b>GeneralizedKIC</b>) must be invoked to connect them with loops.  Parameters are stored with the pose, and are written in REMARK lines on PDB output.

Helix types are defined with crick_params files, located in the Rosetta database in database/protocol_data/crick_parameters (or provided by the user).  Support for Crick parameter files defining helices in which the repeating unit is more than one residue has recently been added.  For more information on this file type, see [[this page|Crick-params-files]].

## Full options

[[include:mover_MakeBundle_type]]

## Crick params files
The Rosetta database currently contains several sets of minor helix parameters:<br/>
- "alpha_helix": A standard L-amino acid right-handed alpha-helix, with phi=-64.8, psi=-41.0, and omega=180.0.  Note that the turn per residue for this helix is 98.65 degrees, not exactly 100 degrees.<br/>
- "alpha_helix_100": An L-amino acid right-handed alpha-helix, with phi=-62.648, psi=-41.0, and omega=180.0, yielding a turn per residue of 100 degrees.  This is for backward compatibility with the Python scripts used to generate helical bundles previously.
- "beta_strand": An L-amino acid beta-strand, with phi=-135.0, psi=135.0, and omega=180.0.<br/>
- "collagen": <b>EXPERIMENTAL</b>.  This generates a collagen helix.  This is experimental because the repeating unit in this helix is a three-residue repeat rather than a single residue.
- "neutral_beta_strand": An unnaturally straight beta-strand, with phi=180.0, psi=180.0, and omega=180.0.  Both L- and D-amino acids can access this region of Ramachandran space.<br/>
- "L_alpha_helix": A left-handed alpha-helix, as can be formed by D-amino acids.  Phi=64.8, psi=41.0, and omega=180.0.<br/>
- "daa_beta_strand": A beta-strand formed by D-amino acids, mirroring that formed by L-amino acids.  Phi=135.0, psi=-135.0, and omega=180.0.<br/>
- "14_helix": A left-handed helix formed by beta-amino acids.  Phi=-139.9, theta=59.5, psi=-138.7, and omega=180.0.<br/>

## Example

This script generates an antiparallel beta-barrel with a bundle of alpha-helices on the inside.
```xml
<MakeBundle name="bundle1" set_bondlengths="true" set_bondangles="true" residue_name="ALA" crick_params_file="beta_strand" symmetry="16" r0="29" omega0="0.075" helix_length="20" >
        #The parameters set above ensure that by default, each "helix" will actually be a strand:
	<Helix /> #A strand
	<Helix delta_omega0="0.19634954" invert="1" delta_t="0.25" delta_omega1="1.5707963" /> #An offset, inverted strand.
	<Helix r0="21" omega0="0.05" crick_params_file="alpha_helix" helix_length="40" /> #An alpha-helix.
	#The three elements defined above are repeated 16 times about the bundle axis to make the bundle.
</MakeBundle>

```

Note that RosettaScripts requires some sort of input on which to operate, but this mover, by default, deletes input geometry and replaces it with the generated geometry.  When running RosettaScripts, one can either pass in a dummy PDB file with the -in:file:s flag, or a dummy FASTA file with the -in:file:fasta flag.


##See Also

* [[The Crick params file format|Crick-params-files]]
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
