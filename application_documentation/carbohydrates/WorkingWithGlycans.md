Working With Glycans
====================


MetaData
========

The RosettaCarbohydrate Framework was created by Dr. Jason W Labonte (JWLabonte@jhu.edu), in collaboration with Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com)


PIs are: Dr. Jeff Gray of JHU (jgray@jhu.edu) and Dr. William Schief of Scripps (schief@scripps.edu).

References
==========

**Residue‐centric modeling and design of saccharide and glycoconjugate structures**
Jason W. Labonte  Jared Adolf‐Bryfogle  William R. Schief  Jeffrey J. Gray
_Journal of Computational Chemistry_, 11/30/2016
[[https://doi.org/10.1002/jcc.24679]]


**Automatically Fixing Errors in Glycoprotein Structures with Rosetta**
Brandon Frenz, Sebastian Rämisch, Andrew J. Borst, Alexandra C. Walls
Jared Adolf-Bryfogle, William R. Schief, David Veesler, Frank DiMaio
_Structure_, 1/2/2019
[[https://doi.org/10.1016/j.str.2018.09.00]]


[[_TOC_]]


## Structure Input

* All Rosetta runs with carbohydrate-containing structures should use an option to make Rosetta carbohydrate-aware. An error will be thrown if this is not present. This option is also needed if you plan on glycosylating structures. 

        -include_sugars




###  RSCB - .pdb files

PDBs from the RCSB should be able to be read in by default.  However, in order to load a PDB file, one must have LINK records present. Rosetta will build the glycans out using internal names and create the glycans based on connectivity.   

* Reading in most PDB files will require an option to map the non-specific HETNAM IDs to chemically accurate identifiers:  

        -alternate_3_letter_codes pdb_sugar

* When loading a file from the PDB, the order of HETATM and LINK records is important for reading it into Rosetta. Since pdb files are usually not formatted for Rosetta-compatibility, connections can be determined internally, ignoring the order of records. Instead atom distances are used to determine protein-sugar and sugar-sugar connections.  

        -auto_detect_glycan_connections
        -maintain_links

    * the maximum and minimum bond lengths for a conection to be found are at a default of 1.15 and 1.65 A. Since many structures are chemically incorrect, these parameters can be changed to detect unphysical bonds, too:

             -min_bond_length < Real >
             -max_bond_length < Real >
    * if automatic detection fails, all bond calculations and connections can be monitored with ```-out::level 999``` 
    * Maintain links option should generally be used for loading pdbs.  If you are having issues, try turning it off. 

    * You may also need to add the option, `-load_PDB_components false`.  

### GLYCAM
In order to load GLYCAM structures, one can pass the option ```-glycam_pdb_format``` in order to load in this type of file.

## Structure Output

In order to write out structures correctly pdb link records must be output.  This option is now the default.

    -write_pdb_link_records

## Full example

```
    score.default.macosclangrelease \
    -include_sugars \
    -alternate_3_letter_codes pdb_sugar \
    -load_PDB_components false \
    -auto_detect_glycan_connections \
    -min_bond_length 1.1 \
    -max_bond_length 1.7 \

    -ignore_zero_occupancy false \
    -ignore_unrecognized_res \
    -out:output \
    -s 5t3x.pdb

```

Tips
====
It is recommended to use the Rosetta Common Configurations to easily work with glycan structures in Rosetta.  More info can be found 
[[here | running-rosetta-with-options#common-options-and-default-user-configuration]].

Nomenclature
============
Most of the time we deal with glycans, we use IUPAC names.  The glycan 'root' as referred to in Rosetta, is the residue that the glycan is attached to protein.  Some components, such as the GlycanResidueSelector, use 'glycan positions' to easily specify residues of glycans.
These numbers go from 1 -> N, where 1 is the first glycan residue and N is the last residue.  In order to find out the glycan position of the residue you are interested in, use the [[GlycanInfo]] application. 


Sampling
========
 - [[GlycanSampler | GlycanRelaxMover ]] - Combination of sampling strategies for general use.
 - [[GlycanTreeModeler]] - Full protocol for modeling Carbohydrates.  This is preferred.

 - [[SmallMover]] - Make small changes to all of the torsion angles in a random glycosidic bond.
 - [[ShearMover]] - Make a shearing motion, by making opposite small changes to a pair of near-parallel glycosidic torsions.

 - [[RingConformationMover]] - Make a change to a cyclic residue's ring conformation. (Note that this is not normally an energetically favorable thing to do!)
 - [[LinkageConformerMover | mover_LinkageConformerMover_type]] - Make a change to all of the glycosidic torsion angles by using angles from a statistically favorable conformation.
 - [[RingPlaneFlipMover]] - Make a 180-degree shearing move to a residue with opposite, equatorial linkages, effectively flipping over the plane of its ring.
 - [[TautomerizeAnomerMover]] - Replace a reducing-end sugar residue with its anomer.


Applications
============
[[GlycanInfo]] - Get information on all glycan trees within a pose

[[GlycanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.

RosettaScript Components
========================
[[GlycanTreeModeler ]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.

[[SimpleGlycosylateMover]] - Glycosylate poses with glycan trees.  

[[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest.

[[LinkageConformerMover|mover_LinkageConformerMover_type]]

Scanning Glycan Sequons
=======================
Although an app is planned, one can use the `CreateGlycanSequonMover` in order to design the needed residues around a potential glycosylation site.  This effectively creates the Asn-X-Ser/Thr sequence motif.  Options are available to design the X, design around, or alternatively use other sequence motifs.   Please use rosetta_scripts.xxxrelease -info CreateGlycanSequonMover for more information and options.  A base script is shown below that uses the `-parser:script_vars` option to scan a protein for optimal glycosylation sites at the residues given and then glycosylate and model the carbohydrate.  It is recommended to create at least 100-1000 models of the carbohydrate at each position.

```
<ROSETTASCRIPTS>
	<RESIDUE_SELECTORS>
		<Index name="select" resnums="%%glycan_position%%" />
	</RESIDUE_SELECTORS>
	<MOVERS>
		<CreateGlycanSequonMover name="create_motif" residue_selector="select" basic_enhanced_n_sequon="false" design_x_positions="false" pack_neighbors="1"/>
		<SimpleGlycosylateMover name="glycosylate" residue_selector="select" glycosylation="%%glycosylation%%" strip_existing="1" />
		<GlycanRelaxMover name="basic_relax" />
		<GlycanTreeRelax name="tree_relax" quench_mode="false" rounds="1" layer_size="2" window_size="1"/>
	</MOVERS>
	<PROTOCOLS>
		<Add mover_name="create_motif" />
		<Add mover_name="glycosylate" />
		<Add mover_name="tree_relax" />
	</PROTOCOLS>
</ROSETTASCRIPTS>
``` 

Glycosylating Structures
=======================
Structures can be glycosylated either through a function accessible to PyRosetta or via RosettaScripts.
## RosettaScripts

See the [[SimpleGlycosylateMover]] documentation

## PyRosetta
Here is an example of adding a man9 to the pose.
This can now be done in two ways within PyRosetta, either via the core function, or the class wrapper. 

### Base Function
The following uses a function to glycosylate a pose using the IUPAC name:
```
/// @brief  Glycosylate the Pose at the given sequence position using an IUPAC sequence.
void glycosylate_pose(
	Pose & pose,
	uint const sequence_position,
	std::string const & iupac_sequence,
	bool const idealize_linkages = true );
```

Here is an example of using the function to glycosylate the pose using a man5 glycan, a commonly found glycan in biology.

```
from rosetta import *
from rosetta.core.pose.carbohydrates import glycosylate_pose
rosetta.init('-include_sugars -write_pdb_link_records')

p = Pose("my_pose.pdb")
glycosylate_pose(p, 10, "a-D-Manp-(1->3)-[a-D-Manp-(1->3)-[a-D-Manp-(1->6)]-a-D-Manp-(1->6)]-b-D-Manp-(1->4)-b-D-GlcpNAc-(1->4)-b-D-GlcpNAc-", True)

print p
print p.residue(3)
print p.chain_sequence()
```
 
 
### SimpleGlycosylateMover
This mover is accessible both in PyRosetta and RosettaScripts. It was written by Jared Adolf-Bryfogle.

see [[SimpleGlycosylateMover]] for a full description.

Example using a man5:

```
from rosetta import *
from rosetta.protocols.carbohydrates import SimpleGlycosylateMover
rosetta.init('-include_sugars -write_pdb_link_records')

p = Pose("my_pose.pdb")

glycosylator = SimpleGlycosylationMover()
glycosylator.set_glycosylation('man5')
glycosylator.set_positions(10)
glycosylator.apply(p)

print p
print p.residue(3)
print p.chain_sequence()
```

Building Pure Glycans
================
Glycans can be built by themselves (IE NOT attached to a protein) using PyRosetta.  There is currently no way to do this in RosettaScripts:
Glycans are creating using their IUPAC names. 

To properly build an oligosaccharide, Rosetta must know the following details about each sugar residue being created in the following order:
-	Main-chain connectivity — →2) (->2)), →4) (->4)), →6) (->6)), etc.; default value is ->4)-
-	Anomeric form — α (a or alpha) or β (b or beta); default value is alpha
-	Enantiomeric form — l (L) or d (D); default value is D
-	3-Letter code — required; uses sentence case
-	Ring form code — f (for a furanose/5-membered ring), p (for a pyranose/6-membered ring); required
Residues must be separated by hyphens. Glycosidic linkages can be specified with full IUPAC notation, e.g., -(1->4)- for “-(1→4)-”. Rosetta will assume -(1-> for aldoses and -(2-> for ketoses. Note that the standard is to write the IUPAC sequence of a saccharide chain in reverse order from how they are numbered.


The following example creates a pose from the IUPAC saccharide name:

```
from rosetta import *
from rosetta.core.pose import pose_from_saccharide_sequence
rosetta.init('-include_sugars -write_pdb_link_records')

galactose = pose_from_saccharide_sequence('Galp')
maltotriose = pose_from_saccharide_sequence('a-D-Glcp-' * 3)
mannose = pose_from_saccharide_sequence('->3)-a-D-Manp')
lactose = pose_from_saccharide_sequence('b-D-Galp-(1->4)-a-D-Glcp')

print lactose
print lactose.residue(1)
print lactose.chain_sequence()

```





## See Also

### Apps
* [[GlycanInfo]] - Get information on all glycan trees within a pose
* [[GlycanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.

### RosettaScript Components
* [[GlycanTreeModeler]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
* [[SimpleGlycosylateMover]] - Glycosylate poses with glycan trees.  
* [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest.
* [[LinkageConformerMover|mover_LinkageConformerMover_type]]

### Other
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files