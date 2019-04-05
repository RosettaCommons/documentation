# EnzymaticMovers

Documentation created 5 April 2019 by Jason W. Labonte <JWLabonte@jhu.edu>.

## Description

`EnzymaticMover`s are a subclass of `Mover` specifically designed to simulate 
the action of a virtual enzyme on a substrate, the `Pose`. The enzyme may be a 
biologically real enzyme or entirely hypothetical or constructed.

The main difference between most `Mover`s and an `EnzymaticMover` is that a
standard `Mover` makes a change to the 3D conformation of a `Pose`, but the 
identity of that `Pose`'s `Residue`s remain unchanged. An `EnzymaticMover`, on
the other hand, does not so much "move" a `Pose` as "change" it, changing its
sequence in some way and turning it into a new molecule or set of molecules. An
`EnzymaticMover` can add, delete, or modify `Residues` or join or split 
chains within a `Pose`&mdash;mirroring the same sorts of things that an enzyme
might do to a biopolymer _in vivo_.

Another thing to consider is that most `Mover`s are used in protocols to
ultimately generate a large number of decoys. A more common usage of an
`EnzymaticMover` might be to _initially_ generate a large number of biologically
relevant _starting variations_ of a `Pose`. For example, consider that most 
proteins are glycosylated _in vivo_, yet most crystal structures of proteins do
not have the glycans included in the structure. An `EnzymaticMover` could be
used to generate a biologically relevant ensemble of glycosylated variants of
the `Pose` to use for further modeling applications.

A key feature of the `EnzymaticMover` framework is the potential use of
biological enzymatic data. The Rosetta database will contain data for specific,
real-world enzymes, each with their own unique consensus sequences and
co-substrates. For example, some kinases are specific for phosphorylating serine
residues, while others will phosphorylate both serine _and_ threonine residues.
The specific enzyme desired can be set by various methods to ensure that the
phosphorylation patterns desired by the current modeler result and match what
would be seen in Nature.

Similarly, specific species can be passed to an `EnzymaticMover`. This feature
could allow one to write a protocol to generate an assortment of
post-translationally modified proteins given a variety of enzymes common to,
say, _E. coli_.

The `EnzymaticMover` framework was conceived of and implemented by Jason W.
Labonte <JWLabonte@jhu.edu>. Please contact him with any questions or criticism.

[[_TOC_]]

## Types

Currently, only two `EnzymaticMover`s are written, but many more can and will be
added to the Rosetta code base.

* [[GlycosyltransferaseMover]]<br />
  Simulates the activity of specific biological glycosyltransferases and oligosaccharyltrasferases by glycosylating a Pose.
* [[KinaseMover]]<br />
  Simulates the activity of specific biological kinase by phosphorylating a Pose.

## Usage

For the most part, `EnzymaticMover`s work like any other `Mover` and any of the
three main Rosetta interfaces can be used. The major difference is that an
`EnzymaticMover` relies on the presence of enzyme data in the database. **If you
wish to use an `EnzymaticMover` for a particular enzyme ensure that the data for
that enzyme is presence in the database!** (See below for example enzyme data
files.)



### PyRosetta Code


The main method used for interacting with `CustomBaseTypePackerPalette` is `add_type( <ResidueType name> )`, which takes the full `ResidueType` name, (not necessarily its three-letter code,) as a string.

Once the palette is established, it can either be given to a `TaskFactory` (preferred) or used directly in the construction of a `PackerTask` (not recommended).

#### PyRosetta Example

```python
from pyrosetta.rosetta.core.pack.palette import CustomBaseTypePackerPalette

## (Create pose here.)

##### Designing with one extra noncanonical (adamantine): #####
# 1. Create the PackerPalette and add an extra noncanonical type to the allowed types:
pp = CustomBaseTypePackerPalette() ## Only needed for noncanonical design
pp.add_type( "adamantine" ) ## Only needed for noncanonical design

# 2.  Create the task factory and set its PackerPalette:
tf = TaskFactory()
tf.set_packer_palette(pp) ## Only needed for noncanonical design

# 3.  Pass the task factory to the PackRotamersMover, and pack normally:
packer = PackRotamersMover()
packer.task_factory(tf)
packer.apply(pose)
```

### C++ Code

The Python example above translates almost directly into C++.

#### C++ Example

```c++
#include <core/pack/palette/CustomBaseTypePackerPalette.hh>
#include <core/pack/task/TaskFactory.hh>
#include <protocols/minimization_packing/PackRotamersMover.hh>

using namespace core::pack::palette;
using namespace core::pack::task;
using namespace protocols::minimization_packing;

// (Create pose here).

/***** Designing with one extra noncanonical (adamantine): *****/
// 1. Create the PackerPalette and add an extra noncanonical type to the allowed types:
CustomBaseTypePackerPaletteOP pp( utility::pointer::make_shared< CustomBaseTypePackerPalette > ); // Only needed for noncanonical design
pp->add_type( "adamantine" ) // Only needed for noncanonical design

// 2.  Create the task factory and set its PackerPalette:
TaskFactory OP tf( utility::pointer::make_shared< TaskFactory > );
tf->set_packer_palette(pp) // Only needed for noncanonical design

// 3.  Pass the task factory to the PackRotamersMover, and pack normally:
PackRotamersMover packer;
packer.task_factory(tf)
packer.apply(pose)

```

### RosettaScripts

In RosettaScripts, the interface with `PackerPalette` is through the `<PACKER_PALETTES>` XML tag.

* The `name` parameter of a `PackerPalette` is for providing a unique name to represent a given palette elsewhere in the script.
* The `additional_residue_types` is for providing the full `ResidueType` name, (not necessarily its three-letter code,) as a string.

The `PackerPalette` can be directly passed to a `PackRotamersMover`, or to any other RosettaScripts-scriptable object that takes `TaskOperation`s, by using its `packer_palette` parameter.

#### Example RosettaScripts XML

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

### Command-Line Applications

By default, if a user does not specify a PackerPalette, Rosetta creates a `DefaultPackerPalette` for all packing tasks.  The global default `PackerPalette` can be changed to a `CustomBaseTypePackerPalette`, however, using the `-packer_palette:extra_base_type_file <filename>` command-line flag.  The provided file should be an ASCII text file containing a whitespace-separated list of residue type names (not 3-letter codes) that will be appended to the canonical 20 amino acids to form the palette of residue types with which to design.  For example, when using the Rosetta `fixbb` application to design, one can specify design with the 20 canonical amino acids _plus_ the 19 mirror-image D-amino acid counterparts of the L-amino acids using the following command at the commandline:

```
<path to rosetta>/Rosetta/main/source/src/fixbb.default.linuxgccrelease -packer_palette:extra_base_type_file d_amino_acids.txt <...other flags...>
```
## Enzyme Date Files

`EnzymaticMover`s rely on the database to function properly. All enzyme data
files have the following format:
```
# Consensus  Sequence  Residue of    Atom
# Sequence   Type      CS to Modify  To Modify  Efficiency
  TARGET     AA        4             CA         1.00        # Rosettase perfectly appends a glycine in the target sequence with a branch.

# Co-substrates
ARROW
BULLET
BOLT
KNIFE
PROTONTORPEDO
```

The first line is assumed to contain a whitespace-delimited list of the
following, all of which are required:
* Consensus sequence &mdash; This may be a 1-letter-code AA or NA sequence or an
IUPAC carbohydrate sequence.
* Sequence type &mdash; This value must be `AA`, `NA`, or `SACCHARIDE`, for the 
three types of sequences accepted.
* Residue of CS to modify &mdash; An integer representing the sequence position
of the residue _in the consensus sequence_ to be modified in some way by the
`Mover`.
* Atom to modify &mdash; A string for the atom name of the atom to be modified,
if applicable. (Not all `EnzymaticMover`s will need this information and are 
allowed to ignore it, but a string value must be present.)
* Efficiency &mdash; A real value, where 1.00 is 100% efficiency. If set to
0.50, an `EnzymaticMover` will only perform its modification 50% of the time. If
not set to 1.00, please provide a comment of the source for the value used.

Any further lines are assumed by the database reader to be cosubstrates. This is
usually specified in the form of a sequence of some sort.

If no further lines are provided, the enzyme either does not have a cosubstrate
or else the cosubstrate is not needed by Rosetta to perform the modification.
(For example, a kinase does not need to provide ATP as a cosubstrate, because,
under the hood, Rosetta will simply modify a `Residue` to convert it into a
phosphorylated `VariantType`. Whereas, a ligase would need to know the sequence
of the structure to be joined to the `Pose`.)

If multiple cosubstrate lines are provided, this means that the enzyme being
simulated is promiscuous, that is, it will randomly select from the options
when performing the reaction.

## For Developers
### Nomenclature

Any `EnymaticMover` should be named as an enzyme (ending in "-ase") followed by 
"Mover". For example, `RosettaseMover`.

### C++ Code
Any `Mover` inheriting from the `EnzymaticMover` base class must:

* ...provide an enzyme family corresponding to a directory of enzyme data.<br />
  The enzyme family is passed as an argument to the `EnzymaticMover` constructor
  in the child class's own constructor. For example:<br />
```c++
KinaseMover::KinaseMover(): EnzymaticMover( "kinases" )
{
	type( "KinaseMover" );
}
```
* ...must implement the protected `perform_reaction()` method, which modifies, adds, or
  removes (a) Residue(s).<br />
  For example:
```c++
void
GlycosyltransferaseMover::perform_reaction(
	core::pose::Pose & input_pose,
	core::uint const site,
	std::string const & cosubstrate )
{
	core::pose::carbohydrates::glycosylate_pose(
		input_pose,
		get_reactive_site_sequence_position( site ),
		get_reactive_site_atom_name( site ),
		cosubstrate );
}
```

* ...use `EnzymaticMover`'s `xml_schema_complex_type_generator()` method to 
  provide the XML schema for RosettaScripts.
  For example:
```c++
void
DNALigaseMover::provide_xml_schema( utility::tag::XMLSchemaDefinition & xsd )
{
	using namespace utility::tag;

	EnzymaticMover::xml_schema_complex_type_generator()->element_name( mover_name() )
		.complex_type_naming_func( & moves::complex_type_name_for_mover )
		.description( "Enzymatic mover to connect two DNA Poses together." )
		.write_complex_type_to_schema( xsd );
}
```

The rest of the code for any `EnzymaticMover` should be simple "boiler plate"
code. The core machinery of the base class uses enzymatic data found in the 
database to search for potential reaction sites. The `EnzymeManager` singleton
class is used to lazily load enzyme data in a thread-safe manner as needed by
any `EnzymaticMover`.

### Database Structure
All enzyme data for `EnzymaticMovers` should be located in the 
`database/virtual_enzymes/` folder.

Every child `EnzymaticMover` should have a subdirectory corresponding to the 
enzyme family of that `Mover`, which much match the family provided to the 
`EnzymaticMover` constructor. (See above.) For example, data for the 
`MethylaseMover` should be stored in `database/virtual_enzymes/methylases/`.

Directories for each enzyme family include no files but only subdirectories
corresponding to species. Every enzyme family directory must, at minimum have an 
`h_sapiens/` subdirectory, because "h_sapiens" is encoded as the default species
for any `EnzymaticMover`. All other subdirectories are for enzymes from
non-human sources.

Every species subdirectory must include a `generic` enzyme data file as a
default example of this this family of enzymes. Generally, this data will
provide a minimal sequon, have 100% efficiency, and not be promiscuous.
