# EnzymaticMovers

`EnzymaticMover`s are a subclass of `Mover` specifically designed to simulate 
the action of a virtual enzyme on a substrate, the `Pose`. The enzyme may be a 
biologically real enzyme or entirely hypothetical or constructed.

When the `Mover` is "applied", it will search the `Pose`'s sequence for a
particular sequence site at which to make its modification, based on enzyme
data. For each site found, it will either make the modification or not, based
upon its set "efficiency".

[[_TOC_]]

## Description
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

## Types
Currently, only two `EnzymaticMover`s are written, but many more can and will be
added to the Rosetta code base.

* [[GlycosyltransferaseMover]]<br />
  Simulates the activity of specific biological glycosyltransferases and
  oligosaccharyltrasferases by glycosylating a Pose.
* [[KinaseMover]]<br />
  Simulates the activity of specific biological kinase by phosphorylating a Pose.

## Usage

For the most part, `EnzymaticMover`s work like any other `Mover`, and any of the
three main Rosetta interfaces can be used. The major difference is that an
`EnzymaticMover` relies on the presence of enzyme data in the database. **If you
wish to use an `EnzymaticMover` for a particular enzyme, ensure that the data for
that enzyme is present in the database!** (See below for example enzyme data
files.)

### C++ & PyRosetta Code

After instantiating an `EnzymaticMover`, the methods `set_species()` and
`set_enzyme()` can be used to set the specific enzyme species and enzyme name,
respectively.

`set_efficiency()` can be used to override the efficiency of the
enzyme as provided by the enzyme file in the database. A value of 1.00
corresponds to 100%. If set to 0.5 for example, the `Mover` will only make a
change to any positions 50% of the time.

`exclude_site()` and `set_excluded_sites()` can be used to pass the sequence
position(s) of (a) site(s) that cannot be modified. Perhaps there is a known
interface with another protein, for example. `ensure_site()` and
`set_ensured_sites()` work in the opposite manner, forcing a modification.
(Note that `ResidueSelector`s do not currently work with `EnzymaticMover`s, but
this will be changed in the future.)

`perform_major_reaction_only` and `perform_all_reactions` toggle the behavior of
promiscuous enzymes.

#### PyRosetta Example

```python
from pyrosetta.rosetta.protocols.enzymatic_movers import KinaseMover

general_enzyme = KinaseMover()
general_enzyme.set_efficiency(0.25)
general_enzyme.apply(pose1)

specific_enzyme = KinaseMover()
specific_enzyme.set_species("h_sapiens")
specific_enzyme.set_enzyme("CLK1")
specific_enzyme.apply(pose2)
```

#### C++ Example

```c++
#include <protocols/enzymatic_movers/GlcyosyltransferaseMover.hh>

glycosyltransferase =
	enzymatic_movers::GlycosyltransferaseMoverOP( utility::pointer::make_shared< enzymatic_movers::GlycosyltransferaseMover >() );
glycosyltransferase->set_species( "c_jejuni" );
glycosyltransferase->set_enzyme( "PglB" );
glycosyltransferase->set_efficiency( 1.0 );
glycosyltransferase.apply( pose );
```

### RosettaScripts

In RosettaScripts, the interface with any `EnzymaticMover` is through the
`<MOVERS>` XML tag.

* The `name` parameter of a `EnzymaticMover` is for providing a unique name to
represent a given `EnzymaticMover` elsewhere in the script.
* The `species` parameter is for setting the species name of the simulated
enzyme.
* The `enzyme_name` parameter is for setting the specific name of the simulated
enzyme.
* The `efficiency` parameter is to directly set the efficiency of the enzyme,
ignoring whatever is in the database.
* The `perform_major_reaction_only` parameter is to set the `EnzymaticMover` to
perform only its major reaction, using only the first cosubstrate listed in its
enzyme data file.
* The `perform_all_reactions` parameter is for allowing the `EnzymaticMover` to
be promiscuous, performing a random transfer from among its possible
co-substrates. This is the default behavior.

#### Example RosettaScripts XML

```xml
<ROSETTASCRIPTS>
	<MOVERS>
		<KinaseMover name="kinase" species="h_sapiens" perform_major_reaction_only="true" />
	</MOVERS>
	<PROTOCOLS>
		<Add mover="kinase" />
	</PROTOCOLS>
	<OUTPUT />
</ROSETTASCRIPTS>
```

### Command-Line Applications

Two Rosetta options flags are used specifically for interfacing with
`EnzymaticMover`s used in any protocols.

* `-enzymes:species` is used to set the species name of any simulated enzymes
used by the protocol.
* `-enzymes:enzyme` is used to set the specific name of any simulated enzymes
used by the protocol.

#### Current Apps
* [[glycosyltransfer]]
* [[phosphorylation]]

#### Example Command Lines
```
$ glycosyltransfer -s input/1ABC.pdb -include_sugars -enzymes:species h_sapiens -enzymes:enzyme OGT -nstruct 5

$ phosphorylation -s input/2DEF.pdb -enzymes:species h_sapiens -nstruct 1
```

## Enzyme Data Files

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
  * The parser recognizes the IUPAC-approved one-letter codes `B`, `J`, `O`, `U`, and `Z`,
  which code for Asx, Xle, Pyl, Sec, and Glx, respectively.
  * `X` alone is recognized to be any of the 20 canonical amino acids; `X` followed
  by square brackets specifies a single non-canonical amino acid by 3-letter
  code. For example, `X[SEP]` specifies phosphoserine.
  * Parentheses are used to specify multiple possible residue types at that
  site, separated by forward slashes, _e.g._, `(A/G)` specifies either Ala or Gly at
  that position.
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

* ...implement the protected `perform_reaction()` method, which modifies, adds, or
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

Two `EnzymaticMover` methods are very helpful for performing the actual
reaction, as shown in the example above: `get_reactive_site_sequence_position`
and `get_reactive_site_atom_name`.

The rest of the code for any `EnzymaticMover` should be simple "boiler plate"
code. The core machinery of the base class uses enzymatic data found in the 
database to search for potential reaction sites. The `EnzymeManager` singleton
class is used to lazily load enzyme data in a thread-safe manner as needed by
any `EnzymaticMover`.

### Database Structure
All enzyme data for `EnzymaticMovers` should be located in the 
`database/virtual_enzymes/` folder.

Every child `EnzymaticMover` should have a subdirectory corresponding to the 
enzyme family of that `Mover`, which must match the family provided to the 
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

----------
Documentation created 5 April 2019 by Jason W. Labonte <JWLabonte@jhu.edu>.