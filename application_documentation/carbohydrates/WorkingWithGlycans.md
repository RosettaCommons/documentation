


MetaData
========

The RosettaCarbohydrate Framework was created by Dr. Jason W Labonte (JWLabonte@jhu.edu), in collaboration with Drs. Jared Adolf-Bryfogle (jadolfbr@gmail.com) and Sebastian Raemisch (raemish@scripps.edu).  

PIs are: Jeff Gray of JHU (jgray@jhu.edu) and William Schief of Scripps (schief@scripps.edu).


Currently, it is still in development. Here are tips for use.  More will come.   

[[_TOC_]]


Structure Input
===============
All Rosetta runs with carbohydrate-containing structures should use the flag ```-include_sugars```.  An error will be thrown if this is not present.

##  RSCB

PDBs from the RCSB should be able to be read in by default.  However, in order to load a PDB file, one must have LINK records present. Rosetta will build the glycans out using internal names and create the glycans based on connectivity.   

## GLYCAN
In order to load GLYCAN structures, one can pass the option ```-glycam_pdb_format``` in order to load in this type of file.

Structure Output
================
In order to write out structures correctly, currently one must pass the flag ```-write_pdb_link_records```.  Without this flag, structures will NOT be able to be read back into Rosetta.  The flag will become default.

Internally, each linear glycan branch is a different chain ID due to the way Rosetta understands polymer connectivity. Currently, by default, Rosetta will output separate chains for each linear glycan.  This should change at some point in the not-to distant future.

Nomenclature
============
Most of the time we deal with glycans, we use IUPAC names.  The glycan 'root' as referred to in Rosetta, is the residue that the glycan is attached to protein.  Some components, such as the GlycanResidueSelector, use 'glycan positions' to easily specify residues of glycans.
These numbers go from 1 -> N, where 1 is the first glycan residue and N is the last residue.  In order to find out the glycan position of the residue you are interested in, use the [[GlycanInfo]] application. 

Further Carbohydrate Information
================================
Jason, fill this out!!!


Applications
============
[[GlycanRelax]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
[[GlycanInfo]] - Get information on all glycan trees within a pose
[[GlcyanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.

RosettaScript Components
========================
[[GlycanRelaxMover]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
[[SimpleGlycosylateMover]] - Glycosylate poses with glycan trees.  
[[GlycanTreeSelector]] - Select individual glcyan trees or all of them
[[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest.

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

Description:
```
/// @brief A mover for glycosylation of biological glycosylations.
///  Currently glysolylation is done based on string, not from PDB.
///  Use GlycanRelax to model the resulting glycosylation!.
///
/// @details
///  Single Glycosylation:
///    If a single glycosylation is passed, it will glycosylate all positions set with this glycan.
///
///  Multiple Glycosylations:
///    If multiple glycosylations are passed, will randomly select from these on apply to sample glycan hetergenecity.
///    see glyco.set_weights to set weights for these glycans to sample non-random heterogenecity in the glycoform.
///
///  The site should be ASN for N-linked glycosylations OR SER/THR for O-linked glycosylations
///    If a glycan already exists, will strip off the current glycan by default.
///    set glyco.set_strip_existing_glycans( false ) to branch off existing glycans instead of deleting them.
///
///    see CreateGlycoSiteMover to create glyco sites (as N-linked glycosylations will need a specific motif to be biological)
///
///  Will randomly select from set positions and glycosylate all positions set.
///
///  Glycosylations:
///    1) If your name ends with .iupac or .gws (GlycoWorkBench), will try to load the file
///
///    2) Next, it will check the short names in the Rosetta database for your string.
///       If the string is in common_names.txt, will load the paired iupac sequence.
///       See database/chemical/carbohydrates/common_glycans/common_names.txt for accepted short names.
///     Names include man3, man5, and man9.
///
///    3)
///      If the name is not found, will attempt to build the glycan as an iupac sequence from the string.
```

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

Building Glycans
================
Glycans can be built by themselves using PyRosetta.  There is currently no way to do this in RosettaScripts:
Glycans are creating using their IUPAC names. 

To properly build an oligosaccharide, Rosetta must know the following details about each sugar residue being created in the following order:
•	Main-chain connectivity — →2) (->2)), →4) (->4)), →6) (->6)), etc.; default value is ->4)-
•	Anomeric form — α (a or alpha) or β (b or beta); default value is alpha
•	Enantiomeric form — l (L) or d (D); default value is D
•	3-Letter code — required; uses sentence case
•	Ring form code — f (for a furanose/5-membered ring), p (for a pyranose/6-membered ring); required
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





##See Also
* [[WorkingWithGlycans]]

 - ### Apps
* [[GlycanRelax]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
* [[GlycanInfo]] - Get information on all glycan trees within a pose
* [[GlcyanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.

 - ### RosettaScript Components
* [[GlycanRelaxMover]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
* [[SimpleGlycosylateMover]] - Glycosylate poses with glycan trees.  
* [[GlycanTreeSelector]] - Select individual glcyan trees or all of them
* [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest.

 - ### Other
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files