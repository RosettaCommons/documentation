#Renamed and Deprecated Options

As Rosetta grows and changes, certain options which previously were used are now no longer relevant, or are renamed to be more consistent with other options. To assist in modernizing existing protocols, the following are details about options which have been either renamed, or have been removed from Rosetta entirely.

Note that this is not a comprehensive list of option system changes, but instead lists just those options which are in semi-common usage for existing protocols. More esoteric options may not be listed.

## Renamed Options

* `-residues:patch_selectors` --> `-chemical:patch_selectors`

## Deprecated Options

These options no longer function as one may expect, and should be replaced.

* `-LoopModel:input_pdb` -- Specify input files with `-s` instead
* `-RBSegmentRelax:cst_wt` -- Use `-constraints:cst_weight` instead
* `-RBSegmentRelax:cst_width` -- Use `-relax:coord_cst_width` instead

## Removed Options

These options have been removed because they no longer serve any functional purpose in Rosetta. Attempting to use them will result in an error. In most cases they can be safely removed from your option files with no ill effects.

* `-ddg:use_bound_cst`
* `-RBSegmentRelax:cst_pdb`
* `-relax:membrane` -- Standard relax can now implicitly handle membrane proteins.
* `-run:silent` -- Silentfile output is now specified with other options


##See Also

* [[Options overview]]: Description of options in Rosetta
* [[Full options list]]
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
