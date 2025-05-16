#An Introduction to Important Rosetta Concepts

This document was originally written 11 Nov 2007 by Chu Wang and last updated 8 Jun 2015.

*For brief definitions of Rosetta-related terms, check the [[glossary]].*

This document is written for the purpose of helping developers to grasp some key concepts in Rosetta3. The knowledge, based on which this document is written, is mainly from my personal experience of learning and using Rosetta3 and it is very likely that some parts of this document may not be accurate due to my limited understanding. Moreover, all credits should go to Phil Bradley and Andrew Leaver-Fay, who have laid a solid foundation for Rosetta3, as well as all other Rosetta3 developers who have done tremendous amount of work for Rosetta3 development. Please feel free to add/modify/correct/update any part of its content as necessary.

Rosetta philosophy
====================

A simple abstract on how Rosetta works is that the molecular system to be modeled has a certain number of degrees of freedom (DOFs), such as phi/psi/chi in protein folding, rigid-body translation/rotation in docking and amino acid sequence in design. Together with other fixed parameters by default assumption, these DOFs are translated into actual xyz positions of atoms in Cartesian space, via processes such as "refold" and <a href="#packer">"pack\_rotamers"</a>. Afterwards, a physically-based energy function is used to evaluate the energy state of the current system based on these atom positions. The "DOF-XYZ-Energy" regime is coupled with algorithms such as Monte Carlo Minimization to sample the conformational space defined by those DOFs in order to locate the conformation with the lowest-energy state, which presumably should be close to the native state of the system.

For a detailed description of how Rosetta works, please see [[Leaver-Fay et al. 2011, Methods in Enzymology 487:545-74|http://www.ncbi.nlm.nih.gov/pubmed/21187238]].

Pose <a name="pose" />
====

"Pose" in Rosetta3 represents a certain state of molecular system to be modeled or simulated, such as protein, nucleic acid, small chemical ligand, and complexes with any combination of them. It stores information of chemical compositions and DOFs of the system. It can receive instructions on what changes are to be made on DOFs and know how to update atom XYZ positions given such changes. It keeps information of energy cached data and knows how to evaluate the energy of itself efficiently, based on the updated atom positions and energy evaluation methods to be used. In a standard modeling protocol, a Pose is initialized either from an input structure or from scratch, and then goes through a sequence/combination of operations which will change its DOFs to sample the conformational space and evaluate its energy so that the lowest-energy state can be located. There are two essential components in a Pose object, "Conformation" and "Energies", the former of which is in charge of translating changes on "DOF"s to XYZ atom positions and the latter of which is responsible for updating individual "Energy" components given the updated atom coordinates.

Conformation <a name="conformation" />
============

As mentioned above, "Conformation" layer maintains a molecular representation of the system to be modeled and is responsible for translating any changes on DOFs of the system to actual changes of atom Cartesian coordinates. This object has three categories of data:

-   chemical representation of the system with a set of "Residue" objects, each of which contains information about chemical composition/type of atoms, their connectivity ( both in ResidueType object) and spacial positions.
-   kinematic representation of the system with [[Fold-tree|foldtree-overview]] and [[Atom-tree|atomtree-overview]]. The merit of this "tree-like" topology of the biomacromolecular system is that torsional and rigid-body DOFs can be unified under one general representation and they can be flexibly enabled or frozen. Any changes to DOFs can be translated into XYZ atom Cartesian coordinates under rules encoded in the kinematic tree setup. Conversely, a new set of DOFs can also be derived provided the XYZ coordinates and the tree topology.
-   Cache data on which DOFs/coords have changed since last move. This is for efficient energy calculation since if a pair of atoms do not change relative to each other since last energy evaluation, the Energy object can re-use some cached energy data without calculating their pairwise energies.

Residue <a name="residue" />
-------

Each Pose/Conformation is broken down into small units called "Residues", which could be amino acids, nucleic acids or any group atoms with certain rules of what they are and how they are connected, such as a small chemical ligand moiety. The chemical content of a Residue is stored in an object called "ResidueType" and aside from that each Residue has other data storing actual coordinate information of each atom it contains as well as coordinate-related data such as mainchain/sidechain torsion angles, sequence position etc. For example, in a protein there might be multiple Leucine residues, each of which will be an individual "Residue" object. Each Leu Residue has its own coordinate data, but all Leu will have the same Leu ResidueType which contains information on what are the atoms, their names, chemical elements and connectivity. This setup also allows a sidechain Rotamer to be represented just as a Residue.

Chemical Layer <a name="chemical" />
==============

ResidueType <a name="residuetype" />
-----------

ResidueType contains information related to the chemical representation of a residue, for example, things like how many atoms it has, what is the index of first hydrogen atom and which atoms could be potential hydrogen bonding donors and acceptors, etc. Each individual ResidueType is created by inputting data from a [["params" file|Residue-Params-file]]. (see /path/to/rosetta/main/database/chemical/residue\_type\_sets/fa\_standard/residue\_types/l-caa/ALA.params for an example), which contains information on how to define properties of this ResidueType. The advantage of using ResidueType params file is obvious:

-   They can be grouped based on different level of representation, for example, a centroid Lysine will have less atoms than a full-atom Lysine. So all centroid residues are grouped into one ResidueTypeSet and all full-atom residues are grouped into another set. And based on the ResidueTypes a Pose of Residues have, one can model the system in different types of representations, i.e., centroid first, then coase-grained, and finally full-atom.
-   A new ResidueType can be easily created by "Patching" onto an existing ResidueType. A particular example is to create a N/C-terminal ResidueType, which differs from its base type only by adding a couple of atoms. Such "difference" is encoded in a "patch" file (which can also be founded in /path/to/rosetta/main/database/chemical/residue\_type\_set/fa\_standard/patches/...) and is applied to existing base ResidueTypes to create [[VariantTypes|VariantTypes-and-ResidueProperties]]. Once these variant types are linked to the corresponding Residues in a Pose, we can model the biomacromolecules with more accurate physical/chemical representation.

Besides chemical data, a ResidueType also contains information how to generate an idealized copy of a Residue. However, to be consistent with atom-tree representation in kinematic layer, ResidueType geometries are encoded in "[[internal coordinates]]" instead of "Cartesian coordinates". That is, for each atom in this ResidueType, a set of parameters are defined to instruct how to generate this atom from a set of (three) reference/stub atoms. These parameters, bond length, bond angle and torsion angle, are essentially DOFs in atom-tree. In addition to the internal coordinate data, a ResidueType object also contains information about how they can be connected to other ResidueTypes. For example, each amino acid ResidueType has two polymer connections, "backbone N" connecting to its lower end and "backbone C" connecting to its upper end. A cysteine ResidueType could have another non-polymer connection which allows its sulfur to be connected with a sulfur atom from another cysteine. Multi-residue ligands are also connected with those non-polymer connections.

AtomType <a name="atomtype" />
--------

A ResidueType has a group of atoms, more precisely, a group of atom names and their atom\_type\_index. By these atom\_type\_indexes, the actual chemical properties of individual atoms – its AtomType, such as chemical element, charges, LJ radius and LK solvation volume can be looked up from AtomTypeSet. In /path/to/rosetta/main/database/chemical/atom\_type\_sets/..., there are input files containing data of atom properties and a new AtomType can be easily created by supplying necessary data in that file. An AtomTypeSet object is linked with a ResidueType so that the ResidueType knows what atoms are supported and can look up their properties as necessary.

Kinematic Layer
===============

We have covered most of the "chemical" layer (from Pose to Conformation to Residue to ResidueType to AtomType) and lets move on to the "kinematic" layer to see how the degrees of freedom in the system are actually translated into actual atoms positions for scoring. The essential pieces of data of kinematic layer are FoldTree and AtomTree, which are solely the brainchildren of Phil Bradley.

[[FoldTree|foldtree-overview]] <a name="foldtree" />
--------

FoldTree is a residue-based description of macromolecular system. For more information, one can refer to two reference papers: [[Bradley et al, Proteins, 2006|http://www.ncbi.nlm.nih.gov/pubmed/17034045]]; [[Wang et al, JMB, 2007|http://www.ncbi.nlm.nih.gov/pubmed/17825317]] or see [[FoldTree Overview and Concepts|foldtree-overview]] . Each residue is connected to another residue in the tree either via a peptide connection or a rigid-body connection, known as a "Jump"). DOFs of the system are backbone and sidechain torsion angles and rigid-body transformations. Changes to these DOFs can be propagated properly in the FoldTree to generate desired structural changes.

[[AtomTree|atomtree-overview]] <a name="atomtree"/>
--------

AtomTree provides an even more general framework to model biomacormolecular system. As its name stands for, it represents all atoms in the system in a tree-like topology as compared to the residue-based representation in FoldTree. Atoms are connected to each other via bond distance, bond angles and torision/improper angles, and rigid-body transformation, all of which are potential DOFs of the system. (FoldTree can be thought as a special AtomTree in which bond length/angles are fixed and only torsional/rigid-body DOFs are allowed). Not only does the AtomTree allow users to treat more DOFs, its atom-based representation also has great advantage for handling non-polymer-type molecules with arbitrary atom connections, such as small chemical ligands. For more information, one can refer to a very good overview description on some important concepts to understand AtomTree written by Ian Davis ( [[AtomTree oveerview and concepts|atomtree-overview]] ). Here are a few basic key points:

-   Each atom has its own parent atom, its list of children and its own XYZ position. The XYZ coordinate can be defined given its three internal coordinates, d, theta and phi, namely, bond distance, bond angle and torsion/improper angle, in the context of a coordinate frame centered on its parent atom. A function "update\_xyz\_coord(root\_atom)" accomplishes this task and a function "update\_internal\_coords(root\_atom)" does the reverse operation.
-   The tree has one root atom which does not have a parent. From the root atom and the default coordinate frame, all the children atoms of the root can be generated from their internal coordinates. Once they are generated, each of them becomes the root of the sub-atom-tree originating from it. Since the whole molecular system is represented by a tree of atoms, traversing the whole tree is smartly performed by calling "update\_xyz\_coord(root\_atom)" recursively. Similarly, internal coordinates can be updated in the same recursive way by calling function "update\_internal\_coord(root\_atom)".
-   The "Atoms" in the atom-tree is internally categorized into two types based on how they are attached to their parents, namely "BondAtom" and "JumpAtom". The internal coordinates for a JumpAtom contains rigid-body transformation as compared to "d/theta/phi" for a BondAtom.
-   Any internal coordinate of any atom can be considered as one degree of freedom and any change to this DOF can be propagated to the rest of the tree to update atom xyz positions.

Rosetta3 internally uses only AtomTree to handle kinematics. FoldTree is still supported for defining kinematic representation of the modeled system as it is convenient to construct for protein-based modeling tasks. When a FoldTree is passed to Pose/Conformation, it will be converted into the corresponding AtomTree representation. For convenience purpose, the interface for setting most common types of DOFs are supported, for example, when pose.set\_psi(18, 70.0) is called, it will look up an internal mapping function to find the corresponding AtomTree internal coordinate of a specific atom and set it accordingly. Whenever there is a change to any AtomTree internal coordinates, a mark is turned on indicating that atom XYZ coordinates are outdated. So next time any operation which will rely on XYZ coordinates, such as scoring or accessing the position of a certain atom, is requested, a "refold" – update\_xyz\_coords() will be triggered to ensure the XYZ coordinates data is updated properly. Similarly, AtomTree also provides an interface for users to change XYZ coordinates for any atoms directly and in this situation, a similar tag will be set indicating internal coordinates need to be updated and the function of "update\_internal\_coords()" will be triggered if any internal coordinates data are to be used.

If you still remember, a Residue Object also has data for all its atom positions and its backbone/sidechain torsions. The source of these data will be updated from AtomTree kinematic layer whenever necessary. The AtomTree internally maintains a map of Atom Pointers so that given a residue number and atom number, a specific Atom can be looked up. Then its position can be accessed and any backbone/sidechain torsion can be mapped to a specific internal coordinate of a certain atom.

There are numerous member functions to manipulate AtomTree, such as, deleting/attaching/replacing a sub-tree by bond or by rigid-body, or re-rooting an AtomTree. An example would be during the construction an AtomTree for a protein, a Residue sub-tree is created first and then attached to the main AtomTree. Another one would be to change a Residue from centroid representation to full atom representation. Since they are treated as different residues in Rosetta now, a sub-tree for the fullatom residue will be created and replace the sub-tree of the centroid residue in the main AtomTree.

The last thing listed here about AtomTree is that change to any DOFs will be recorded in the cached data in Conformation, i.e., this torsion has moved or this rigid-body has moved so that it will be passed along to scoring routines for efficient and accurate energy evaluation.

[[Scoring|scoring-explained]] <a name="scoring" />
=======

I have not plowed through the scoring/energies part yet and this probably needs more input from Andrew and Phil.

Energies <a name="energies" />
--------

The Energies object contains cached energy components for a Pose/Conformation. It contains classic one-body and two-body energiy components, but the implementation of their storage are different. Residue pairwise (two-body) energies are stored in a EnergyGraph in which each node is a residue and an edge between the two nodes is the interaction energy between those two residues. This type of Graph has also been applied in many scoring-related implementations, such as residue-pair-wise distances for setting up neighbor lists. When structure has moved and a scoring is requested, the Energies object will check if any old cached data is re-usable and only update those which are necessary to be recalculated.

[[ScoreFunction|score-types]] <a name="scorefunction" />
-------------

A ScoreFunction has a set of weights, each of which is for an individual energy component. Each energy component will be evaluated by a certain type of EnergyMethod, for example, LJ-attractive will be evaluated by a Context-independent-2-body method (ci\_2B\_method) and Dunbrack will be evaluated by a Context-independent-1-body method. The list of all supported EnergyMethods is also maintained by A ScoreFunction object. When a ScoreFunction is applied to a Pose to evaluate its energy, all non-zero-weighted energy components will be calculated using their corresponding scoring methods. One can find more information about currently supported energy methods and their categories in src/core/scoring/methods/.

ScoreFunctionFactory <a name="scorefunctionfactory />
--------------------

This object mainly facilitates initializing ScoreFunction weights from an external file and additionally applying a patch to add or remove or change subset of the weights as necessary. A list of defined scoring function weights can be found in /path/to/rosetta/main/database/scoring/weights.

Protocol related
================

Once a Pose is initialized, either from an existing structure or from scratch, it can be passed to different protocol-level functions to perform certain types of modeling task. This includes but is not limited to MonteCarlo, gradient-based minimization, packer, rotamer\_trials and a more general object wrapper called "Mover". These upper-level protocols are under intensive development and the hope is that based on the machineries provided by Pose and all its internal building modules, users will be granted freedom to construct their own protocols, tailed specifically for their research goals. Here are very short descriptions about these upper-level building blocks:

MonteCarlo <a name="montecarlo />
----------

This object is used to determine whether a change made to a pose will be accepted or rejected based on the change in the pose's energy and a "temperature" (actually roughly equivalent to the temperature multiplied by the Boltzmann constant, in units of kcal/mol). It internally stores two Poses, which records the last accepted state and the lowest energy state so far visited, a <a href="#scorefunction">ScoreFunction</a> for scoring purpose and a temperature factor to adjust Boltzmann probability for acceptance/rejection.

AtomTreeMinimizer <a name="minimizer" />
-----------------

Since the kinematic setup for a Pose is solely via AtomTree now, the optimization function is carried out by this AtomTreeMinimizer object. This object has a member function called "run" which takes a <a href="#pose">Pose</a>, a <a href="#movemap">MoveMap</a>, a <a href="#scorefunction">ScoreFunction</a> and a MinimizerOption wrapper object to perform the task of energy minimization. The object energy function to be minimized is obviously from ScoreFunction and the variables are those DOFs in the Pose/Conformation/AtomTree. Which subset of DOFs are to be minimized is specified by this MoveMap object and what type of minimization to be carried out is defined in the MinimizerOption object (it also has minimization tolerance value and other minimization-related parameters). For more information on minimization, see [[Minimization overview and concepts|minimization-overview]] .

MoveMap <a name="movemap" />
-------

The purpose of MoveMap is to enable/disable certain types of DOFs in the system. For example, omega is fixed but phi/psi/chi are flexible. MoveMap is isolated from Pose in Rosetta3 and is passed separately to the AtomTreeMinimzer. A MoveMap supports enabling/disabling a specific type of DOFs, such as bond length and angles; or certain DOFs of a single residue, such as backbone torsion of residue i; or individual DOF in the AtomTree, such as torsion angle associated with atom j in residue i. This provides more freedom for users to control what DOFs to be optimized.

Packer and Rotamer\_trials <a name="packer" />
--------------------------

Both objects perform rotamer-based sidechain/sequence optimization given a Pose. The information about what to be repacked or redesigned is wrapped into the [[PackerTask|packer-task]] object, which can be supported by many command line options.

PackerTask <a name="packertask">
----------

The PackerTask controls which residues in a Pose will be designed, repacked, or held fixed during rotamer packing. Note that a PackerTask is generally only intended for a single use as it encodes the sequence of the pose that was used to create it and would therefore override any mutations made between PackerTask creation and packing. For protocols with multiple packing runs, use a TaskFactory to create PackerTasks immediately before packing. 

The PackerTask can be thought of as an ice sculpture.  By default, everything is able to pack AND design.  By using TaskOperations, or your set of chisels, one can limit packing/design to only certain residues.  As with ICE, once these residues are restricted, they generally cannot be turned back on.

An ice sculpture, of course, is limited by the size of the starting piece of ice. If you want a bigger starting list, or palette, of residues with which you can design, you use a PackerPalette. The DefaultPackerPalette is like an ice cube, but if you use a modifiable PackerPalette, to which you can add residues, you can start with an iceberg.

TaskFactory <a name="taskfactory" />
-----------

A TaskFactory is used to create PackerTasks to be used for rotamer repacking and design. The TaskFactory contains a set of TaskOperations that tell it which behavior to apply to each residue and a PackerPalette that tells it which residues that it can use in design. This decision is made immediately before packing.

TaskOperations <a name="taskoperations" />
--------------

TaskOperations are used by a TaskFactory to configure the behavior and create a PackerTask when it is generated on-demand for routines that use the "packer" to reorganize/mutate sidechains. The PackerTask controls which residues are packable, designable, or held fixed.  When used by certain Movers (at present, the PackRotamersMover and its subclasses), the set of TaskOperations control what happens during packing, usually by restriction "masks."  

For more information on TaskOperations, see the [[RosettaScripts TaskOperations page|TaskOperations-RosettaScripts]].

PackerPalette <a name="packerpalette" />
--------------

PackerPalettes are used by the PackerTask to provide a starting list of available residues with which one can design at every position in a pose. For example, if one wants to design with non-canonical amino acids (NCAA), instead of being limited to the 20 naturally occurring ones, she or he would use a PackerPalette to add the desired NCAAs.

For more information on PackerPalettes, see the [[PackerPalettes page|PackerPalette]].

Mover <a name="mover" />
-----

The design of this object has been brainstormed by many Rosetta developers, with the aim of creating a prototype class for representing any type of operations on a Pose which will change its structure. The setup of this class allows it to be easily extended to create new composite types of moves from single-type moves. Each Mover will take in a Pose and has a "apply" method which will do some certain changes to the Pose. Examples of single-type moves are SmallMover/ShearMove will do perform classical Rosetta small/shear backbone moves, RigidBodyMover that will change a rigid-body (jump) DOF. MonteCarlo, Minimization and Packer can also be considered as special type of Movers. So combining them can create Movers that carry out tasks like SmallMinTrial or RigidBodyPackerTrial etc. A single Mover or a series of Movers can also be applied repeatedly in a number of cycles. Moreover, a Protocol itself can be deemed as a composite Mover which is essentially constructed by combining any single-type Mover objects.

For a list of movers, see the [[RosettaScripts Movers list|Movers-RosettaScripts]]

##See Also

* [[Rosetta Basics]]: Rosetta basics homepage
* [[RosettaEncyclopedia]]: Detailed descriptions of concepts in Rosetta.
* [[Glossary]]: Brief definitions of Rosetta terms.
* [[Rosetta canon]]: List of important Rosetta papers
* [[Symmetry]]: Information about working with symmetry in Rosetta
* [[Resources for learning biophysics and computational modeling]]
* [[Rosetta Timeline]]: History of Rosetta
* [[Development Documentation]]: Page for people who want to write new code for Rosetta
