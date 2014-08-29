#Renamed and Deprecated Options

As Rosetta grows and changes, certain options which previously were used are now no longer relevant, or are renamed to be more consistent with other options. To assist in modernizing existing protocols, the following are details about options which have been either renamed, or have been removed from Rosetta entirely.

Note that this is not a comprehensive list of option system changes, but instead lists just those options which are in semi-common usage for existing protocols. More esoteric options may not be listed.

## Renamed Options

* `-residues:patch_selectors` --> `-chemical:patch_selectors`

## Removed Options

These options have been removed because they no longer serve any functional purpose in Rosetta. In most cases they can be safely removed from your option files with no ill effects.

* `-ddg:use_bound_cst`
* `-relax:membrane` -- Standard relax can now implicitly handle membrane proteins.
* `-run:silent` -- Silentfile output is now specified with other options