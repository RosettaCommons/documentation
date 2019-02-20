#DefaultPackerPalette

##Page history

`DefaultPackerPalette` documentation created by Vikram K. Mulligan (vmulligan@flatironinstitute.org) on 20 February 2019.

###Description

A basic `PackerPalette` permitting design with the canonical 20 amino acids.  (Note that, to preserve backward compatibility, this `PackerPalette` also permits design with all DNA types at DNA positions.)  This `PackerPalette` has no user-configurable options.  Since a `DefaultPackerPalette` is created automatically by Rosetta by default in the absence of an explicit `PackerPalette` specified by the user, it is rarely necessary to script a `DefaultPackerPalette` explicitly.  (The one situation in which this might arise would be if the default `PackerPalette` were overridden on the command line with the `-packer_palette:extra_base_type_file` option, and one particular design step was to exclude the extra base types.)

To design with additional residue types, see [[`CustomBaseTypePackerPalette`|CustomBaseTypePackerPalette]].

##RosettaScripts Details
[[include:packer_palette_DefaultPackerPalette_type]]

##See also

* [[PackerPalettes|PackerPalette]]
* [[CustomBaseTypePackerPalette]]
* [[NoDesignPackerPalette]]
