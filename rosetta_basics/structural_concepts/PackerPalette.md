# PackerPalettes

`PackerPalette`s are used by a [[`PackerTask`|packer-task]] to determine which `ResidueType`s may be substituted at any given position in a `Pose` before any [[`TaskOperation`s|TaskOperations-RosettaScripts]] are applied.

The `PackerTask` can be thought of as an ice sculpture. By default, every position is able to packed _and_ design, but only by the 20 natural amino acid residues. By using `TaskOperation`s, a set of chisels, one can _limit_ packing/design to only certain residues or to only packing. As with _ice_, once a `TaskOperation` has chipped away (restricted) a particular residue type, that type cannot be put back by a subsequent `TaskOperation` (re-enabled for design).

An ice sculpture, of course, is limited by the size of the starting piece of ice. If you want a bigger starting list, or palette, of residues with which you can design, you use a `PackerPalette`. The `DefaultPackerPalette`, which provides the 20 canonical amino acid building-blocks, is like an ice cube, but if you use a modifiable `PackerPalette`, to which you can add more exotic residue types, you can start with an _iceberg_.

Note that, for most canonical design applications, you will want only the 20 canonical amino acids in your palette.  For this, the `DefaultPackerPalette` suffices, and so this is the `PackerPalette` that Rosetta uses in all cases automatically _unless_ explicitly overridden by the user.  (That is, if you are happy with the 20 canonical amino acids as a palette for design, you need not do anything.)

[[_TOC_]]

Types
=====

The three `PackerPalette`s currently available are:

* [[`DefaultPackerPalette`|DefaultPackerPalette]]<br />
  This `PackerPalette` recreates the original packing and design system in Rosetta, before some of us went and mucked around with things by adding crazy chemistries that are not amino acids. If you do not specify a `PackerPalette`, the `DefaultPackerPalette` will be selected automatically.
  * Included Residues:
    * 20 canonical amino acid residues (including both tautomers of histidine)
    * 4 canonical DNA residues
    * every _non-modified_ carbohydrate residue in the Rosetta database (if and only if the `-include_sugars` option is on)

* [[`NoDesignPackerPalette`|NoDesignPackerPalette]]<br/>
  In situtations in which one wishes to repack a `Pose` without designing anything, it is always possible to use a `DefaultPackerPalette` with a [[`PreventRepacking TaskOperation`|PreventRepacking]].  Under the hood, though, this is slightly inefficient: Rosetta populates a list of the 20 canonical amino acids, then discards all but the current amino acid at a given position.  Where efficiency is an issue (_e.g._ if packer setup is going to occur many thousands of times in rapid succession) you can instead restrict the palette of allowed residue types to the current residue type at each position in a `Pose` using a `NoDesignPackerPalette`.  This `PackerPalette` has no user-configurable options.

* [[`CustomBaseTypePackerPalette`|CustomBaseTypePackerPalette]]<br />
  This `PackerPalette` includes all of the residues found in the `DefaultPackerPalette` but includes the ability to add a custom list of _base_, that is _non-variant_ `ResidueType`s. If you wish to add a few specific residues to the palette by name, you can, or you can add residues by family property, for example, all residues that have the property RNA or TERPENE.

<!--
* [[`CustomVariantTypePackerPalette`|CustomVariantTypePackerPalette]]<br />
  This `PackerPalette` is similar to the `CustomBaseTypePackerPalette`, except that it allows for design of `VariantType` residues, including such things as modified sugars or post-translationally modified (PTM) amino acid residues.
-->

In the future, there may be additional `PackerPalette`s allowing for design with variant types, or possibly for design of alternative backbones (_e.g._ a protein nucleic acid residue in place of an RNA residue).

Usage
=====
C++ and PyRosetta Code
----------------------

The main method used for interacting with `CustomBaseTypePackerPalette` is `add_type( <ResidueType name> )`, which takes the full `ResidueType` name, (not necessarily its three-letter code,) as a string.

Once the palette is established, it can either be given to a `TaskFactory` (preferred) or used directly in the construction of a `PackerTask` (not recommended).

###Pyrosetta Example

```python
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

The `PackerPalette` can be directly passed to a `PackRotamersMover`, or to any other RosettaScripts-scriptable object that takes `TaskOperation`s, by using its `packer_palette` parameter.

###Example XML Script

```xml
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

By default, if a user does not specify a PackerPalette, Rosetta creates a `DefaultPackerPalette` for all packing tasks.  The global default `PackerPalette` can be changed to a `CustomBaseTypePackerPalette`, however, using the `-packer_palette:extra_base_type_file <filename>` command-line flag.  The provided file should be an ASCII text file containing a whitespace-separated list of residue type names (not 3-letter codes) that will be appended to the canonical 20 amino acids to form the palette of residue types with which to design.  For example, when using the Rosetta `fixbb` application to design, one can specify design with the 20 canonical amino acids _plus_ the 19 mirror-image D-amino acid counterparts of the L-amino acids using the following command at the commandline:

```
<path to rosetta>/Rosetta/main/source/src/fixbb.default.linuxgccrelease -packer_palette:extra_base_type_file d_amino_acids.txt <...other flags...>
```

In the above, "default.linuxgccrelease" must be replaced with the appropriate string for your operating system, compiler, compilation settings, and compilation mode.  The file `d_amino_acids.txt` would look like this:

```
DALA DCYS DASP DGLU DPHE DHIS DILE DLYS DLEU DMET DASN DPRO DGLN DARG DSER DTHR DVAL DTRP DTYR
```

Previous Behavior
=================

In earlier versions of Rosetta, when the `PackerPalette` did not exist, special `TaskOperation`s, which violated the idea of commutativity, had to be employed.

For example, before `PackerPalette`s existed, Rosetta's [[resfiles|Resfile]] could contain the commands `RESET` (which discarded the effects of past `TaskOperation`s and reset the allowed amino acids at a position to the 20 canonical amino acids), `NC` (which would add residue types to the allowed set at a position), and `EMPTY` (which would discard all allowed residue types at a position, including those added with `NC`).  These violated `TaskOperation` commutativity (the property that a set of `TaskOperations` applied in any order produce the same effect).  Now, these operations are prohibited.  Users instead must turn on whatever exotic building blocks that they want with a `PackerPalette`, and can then turn them _off_ with resfiles or other `TaskOperations` (the convention that has always existed for canonical design).  In the above example, of designing with the 20 canonical amino acids plus the D-amino acid mirror-images, one could prohibit all residue types except for D- or L-alanine at position 5 with the following resfile:

```
start
5 A PIKAA AX[DALA]
```

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
