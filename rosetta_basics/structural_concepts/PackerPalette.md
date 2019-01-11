# PackerPalettes

`PackerPalette`s are used by a [[`PackerTask`|packer-task]] to determine which `ResidueType`s may be substituted at any given position in a `Pose` before any [[`TaskOperation`s|TaskOperations-RosettaScripts]] are applied.

The `PackerTask` can be thought of as an ice sculpture. By default, every position is able to packed _and_ design, but only by the 20 natural amino acid residues. By using `TaskOperation`s, a set of chisels, one can _limit_ packing/design to only certain residues or to only packing. As with _ice_, once these residues are restricted, they generally cannot be turned back on.

An ice sculpture, of course, is limited by the size of the starting piece of ice. If you want a bigger starting list, or palette, of residues with which you can design, you use a `PackerPalette`. The `DefaultPackerPalette` is like an ice cube, but if you use a modifiable `PackerPalette`, to which you can add residues, you can start with an _iceberg_.

[[_TOC_]]

Types
=====

The three `PackerPalette`s currently available are:

* `DefaultPackerPalette`<br />
This `PackerPalette` recreates the original packing and design system in Rosetta, before some of us went and mucked around with things by adding crazy chemistries that are not amino acids. If you do not specify a `PackerPalette`, the `DefaultPackerPalette` will be selected automatically.
  * Included Residues:
    * 20 canonical amino acid residues (including both tautomers of histidine)
    * 4 canonical DNA residues
    * every _non-modified_ carbohydrate residue in the Rosetta database (if and only if the `-include_sugars` option is on)

* `CustomBaseTypePackerPalette`<br />
  This `PackerPalette` includes all of the residues found in the `DefaultPackerPalette` but includes the ability to add a custom list of _base_, that is _non-variant_ `ResidueType`s. If you wish to add a few specific residues to the palette by name, you can, or you can add residues by family property, for example, all residues that have the property RNA or TERPENE.

* `CustomVariantTypePackerPalette`<br />
  This `PackerPalette` is similar to the `CustomBaseTypePackerPalette`, except that it allows for design of `VariantType` residues, including such things as modified sugars or post-translationally modified (PTM) amino acid residues.

In the future, there may be additional `PackerPalette`s allowing for design of alternative backbones, for example, a protein nucleic acid residue in place of an RNA residue.

Usage
=====
C++ and PyRosetta Code
----------------------

The main method used for interacting with `CustomBaseTypePackerPalette` is `add_type( <ResidueType name> )`, which takes the full `ResidueType` name, (not necessarily its three-letter code,) as a string.

Once the palette is established, it can either be given to a `TaskFactory` (preferred) or used directly in the construction of a `PackerTask` (not recommended).

###Pyrosetta Example

```
from pyrosetta.rosetta.core.pack.palette import CustomBaseTypePackerPalette

pp = CustomBaseTypePackerPalette()
pp.add_type( "adamantine" )

tf = TaskFactory()
tf.set_packer_palette(pp)

packer = PackRotamersMover()
packer.task_factory(tf)

packer.apply(pose)
```

RosettaScripts
--------------

In RosettaScripts, the interface with `PackerPalette` is through the `<PACKER_PALETTES>` XML tag.

* The `name` parameter of a `PackerPalette` is for providing a unique name to represent a given palette elsewhere in the script.
* The `additional_residue_types` is for providing the full `ResidueType` name, (not necessarily its three-letter code,) as a string.

The `PackerPalette` can be directly passed to a `PackRotamersMover` by using its `packer_palette` parameter.

###Example XML Script

```
<ROSETTASCRIPTS>
	<SCOREFXNS>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
	</RESIDUE_SELECTORS>
	<PACKER_PALETTES>
		<CustomBaseTypePackerPalette name="custom_palette" additional_residue_types="adamantine" />
	</PACKER_PALETTES>
	<TASKOPERATIONS>
	</TASKOPERATIONS>
	<FILTERS>
	</FILTERS>
	<MOVERS>
		<PackRotamersMover name="design_test" packer_palette="custom_palette" />
	</MOVERS>
	<PROTOCOLS>
		<Add mover="design_test" />
	</PROTOCOLS>
	<OUTPUT />
</ROSETTASCRIPTS>
```

Command-Line Applications
-------------------------

In the future, it will be possible to provide an input file defining which residues should be added to the palette.

Previous Behavior
=================

In earlier versions of Rosetta, when the `PackerPalette` did not exist, special `TaskOperation`s, which violated the idea of commutativity, had to be employed.

For example:
* _Before_ the `PackerPalette`: ```foo bar woo```; _after_ the `PackerPalette`: ```woo bar foo```
* _Before_ the `PackerPalette`: ```foo bar woo```; _after_ the `PackerPalette`: ```woo bar foo```
* _Before_ the `PackerPalette`: ```foo bar woo```; _after_ the `PackerPalette`: ```woo bar foo```

See Also
========

* [[resfiles]]: A description about Resfile syntax and conventions
* [[RosettaScripts]]: The RosettaScripts home page
* [[Recommended TaskOperations for design|Recommended_Design_TaskOperations]]
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[RosettaScripts Movers|Movers-RosettaScripts]]
* [[RosettaScripts Filters|Filters-RosettaScripts]]
* [[I want to do x]]: Guide for making specific structural perturbations using RosettaScripts
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Getting Started]]: A page for people new to Rosetta
* [[Glossary]]
* [[RosettaEncyclopedia]]
