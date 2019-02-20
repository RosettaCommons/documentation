#NoDesignPackerPalette

##Page history

`NoDesignPackerPalette` documentation created by Vikram K. Mulligan (vmulligan@flatironinstitute.org) on 20 February 2019.

###Description

A `PackerPalette` permitting only the existing residue type at each position.  This prevents any design.

Note that, although the same effect can be achieved using a [[PreventRepacking TaskOperation|PreventRepackingOperation]] and the [[DefaultPackerPalette]], it is slightly more efficient to use a [[NoDesignPackerPalette]].  Under the hood, the former involves creating a list of the 20 canonical amino acids, then throwing it away, while the latter involves only selecting the current residue type.  This only makes a difference in rare situations in which repeated packer setup occurs rapidly.

##RosettaScripts Details
[[include:packer_palette_NoDesignPackerPalette_type]]

##See also

* [[PackerPalettes|PackerPalette]]
* [[CustomBaseTypePackerPalette]]
* [[DefaultPackerPalette]]
