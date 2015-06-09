Glossary
========

This glossary collects lots of the Rosetta terms with short
(sentence-to-paragraph) definitions. You'll see definitions of objects
in the code, biophysics concepts, and adminstrivia. Many of these are terms of
art in structural biology with the particular nuances that apply in
Rosetta.

[[_TOC_]]

General Terms
-------------

#### _ab_ _initio_ structure predition

Prediction of molecular structure given only its sequence. Known also as **de novo modeling**.

In Rosetta, _ab_ _initio_ modeling uses statistical information from the **PDB** such as 
**fragments** and **statistical potentials**.

#### all-atom modeling

#### alpha helix

A common motif in the secondary structure of proteins, the alpha helix
(α-helix) is a right-handed coiled or spiral conformation, in which
every backbone N-H group donates a hydrogen bond to the backbone C=O
group of the amino acid four residues earlier (i+4 - i hydrogen
bonding). Among types of local structure in proteins, the α-helix is the
most regular and the most predictable from sequence, as well as the most
prevalent.

#### analogue

Similar proteins without evolutionary relationships. See also **homologue**. 

Rosetta **homology modeling** doesn't actually need strict evolutionary relationships,
and can use **analogues** as **templates**.

#### Antibody fragment

#### atom free diagrams

#### atom tree

The atom tree connects atoms in the **pose**, and is used to convert 
**internal coordinates** into **cartesian coordinates**. Normally 
derived from the **fold tree**.

#### atom positions

#### backbone

In **biopolymers**, the backbone is those atoms which form the polymeric chain.
In proteins these are the N, CA, C, and O atoms and their hydrogens. 
In nucleic acids it is the phophate and sugars.

See also **main chain** 

#### backbone accuracy

#### base

The non-**backbone** portion of a nucleotide.
Analogous to a protein's **side chain**.

#### beta sheet

A common motif in the secondary structure of proteins, the beta sheet
(β-sheet) is a mostly flat extended structure made up of individual
(possibly non-consecutive) extended chains (β-strand) held together
by alternating hydrogen bonds.  

#### binding affinity or binding energy

How strongly two molecules are associated with one another.

#### binding interface

The point of contact between two molecules.

A common definition in Rosetta is any residue with the C-beta atom or any heavy atom within
6 Angstroms of the other binding partner.

#### biopolymers

Polymeric molecules important for biological systems.
Typical biopolymers are proteins, RNA, DNA and carbohydrates. 

#### blind docking

Docking where the structure of the docked complex is unknown.

#### bound docking

The complex structure that is used for reference in docking and rmsd calculations is determined experimentally by X-rays/NMR. 

#### Cartesian coordinates

Coordinates with spatial positions specified by xyz coordinates. Contrast this with **internal coordinates**.
The conversion between the two is **kinematics**. 

#### Cartesian minimization

**Gradient minimization** based on moving atoms in xyz Cartesian space, rather than with **internal coordinates**.

This requires an extra term (cart_bonded) to maintain bond lengths and angles to their near-ideal values.

#### CCD

Cyclic coordinate descent. A **loop closure** protocol where backbone dihedrals are progressively adjusted to minimize
the gap in the loop backbone.

[Add a reference]

#### centroid

A reduced representation mode, used for simplifying the representation of the system,
to permit faster sampling and scoring.

For proteins, each residue is represented by five **backbone atoms** 
(N, Ca, C, O and the polar hydrogen on N) and one pseudo-atom, 
the “centroid,” to represent the **side chain**.

[Explain further how centroid is calculated.]

*Gray et al., J. Mol. Biol. (2003) 331, 281–299*

#### centroid rigid-body orientation

#### chain

In Rosetta, a chain is a single, covalently connected molecule.

In the **PDB** format, a chain is all residues which share a chain identification label.

#### chi angles

Chi angles are the **dihedral angles** which control the **heavy atom** positions of **side chain** residues.

In nucleic acids, one of the 

#### chi1, chi2, chi3, & chi4

Specific sidechain **chi angles** of protein residues. They are enumerated from the C-alpha atom outward,
so chi1 would be the **dihedral** between N-Ca-Cb-Cg.

#### cluster

Clustering of structures involves grouping structures with "similar" structures. These groups of similar structures
are called "clusters". The measure of structure similarity are typically either **RMSD** or **GDT**.  

#### conformation

The three dimensional organization of atoms in a structure.

#### contact order

Taken from "Contact order and ab initio protein structure prediction," Bonneau et. al, Protein Science (2002), 11:1937-1944: "The relative CO is the average sequence separation of residues that form contacts in the three-dimensional structure divided by the length of the protein." 

#### Critical Assessment of PRediction of Interactions (CAPRI)

Protein-protein interactions and other interactions between
macromolecules are essential to all aspects of biology and medical
sciences, and a number of methods have been developed to predict them.
[CAPRI](http://www.ebi.ac.uk/msd-srv/capri/) is a community wide
experiment designed to assess those that are based on structure. Since
CAPRI began in 2001, the experiment has had two to four prediction
rounds each year, with one or a few targets per round.

#### Critical Assessment of Techniques for Protein Structure Prediction (CASP)

[The Critical Assessment of protein Structure
Prediction](http://predictioncenter.org/) (CASP) experiments aim at
establishing the current state of the art in protein structure
prediction, identifying what progress has been made, and highlighting
where future effort may be most productively focused. CASP has been held
every two years starting in 1994. Rosetta has participated in several
CASP experiments.

#### crystal neighbors

Is crystal structure a so called native structure? Crystal is composed
of approximately 40\~70% of water molecules, which gives
crystallographers confidence saying proteins in crystal lattice should
be able to represent proteins in biological environments, especially
when proteins in crystal lattice often times are able to undergo
biological reactions they are capable of in cells. However, there is an
inevitable artifact in crystal lattice - that is regions where proteins
adjacent to each other, making so called crystal contacts. Conformations
in regions where proteins have contacts somehow are altered to some
extent. Rosetta sometimes is able to sample conformations where the RMSD
are 3 or 4 A away from "native crystal structure" but have lower
energies, which are the results from variations of a section of loop.
And this loop region happens to locate at the spot where crystal contact
occurs. Therefore, we now are thinking about our definition of "native
structure", where native structure is supposed to be the conformation of
the protein exists in cell.

#### crystallography phasing

The critical step of solving a crystal structure is to get the phase
either via molecular replacement or experimental methods. The
technically easier way to get the phase is by the method of molecular
replacement, where crystallographers utilize existing structures with
high structural similarities to help guide the search of phase. However,
in some hard cases, where there is no structurally similar structures
exist, or structures have too low sequence identities (below 15\~20%),
crystallographers then have to get the phase through experimental
methods, which are much more tedious and difficult compared to molecular
replacement method. Rosetta can generate or refine models using
physically realistic full-atom force field, which sometimes can generate
more accurate comparative models. For some of those hard cases, Rosetta
therefore is able to provide better initial search models for molecular
replace to find the solutions.

ref: Qian et. al. High-resolution structure prediction and the
crystallographic phase problem. Nature 450, 259-264 (2007)

#### ddG

Also known as ΔΔG. The change in binding energy free energy (ΔG) upon a mutation. 

#### _de_ _novo_ modeling

Prediction of molecular structure given only its sequence. Known also as **ab initio structure predition**.

#### decoy

A **model** produced by a computational protocol.

#### design

Optimization of the amino acid sequence of a protein.

#### dihedral angle

A four-body angle encoding the respective orientation of two atoms around the axis connecting two other atoms.
Also known as a **torsion**.

#### disulfides

The covalent attachement of two cysteine residues in close proximity.
This depends on the protein being present in an oxidizing environment (like outside of the cell),
rather than a reducing environment (like the inside of the cell).

This covalent attachment can greatly stabilize the folding of a protein. 

#### docking

Assembling two separate proteins (or protein-ligand,
protein-surface) into their biologically relevant structure and finding
the lower free energy of the complex.

[Explain further: blind docking, bound docking, unbound docking]

#### Dunbrack loop optimization

#### electrostatic interactions

#### energy landscape

#### explicit water

Water modeled as 

#### fixed backbone design

**Design** of a protein where the the **backbone** is not moved during the redesign.

#### fixed backbone packing

Optimization (**packing**) of the side chain conformations, done without moving the **backbone**.

#### filter

A pass/fail check on structure quality during the middle of a run. Filters are applied to avoid
wasting computational time on **trajectories** which are unlikely to result in successful results.
Relevant **metrics** are calculated and those structures with poor values are discarded. 

#### flexible backbone design

**Design** of a protein where the the **backbone** is allowd to move during design.

#### flexible backbone packing

Optimization (**packing**) of the side chain conformations, where the **backbone** is allowed to move during optimization.

#### fold tree

A directed, acyclic graph (tree) connecting all the residues in the **pose**. The fold tree is the 
residue-level description of how **internal coordinates** and **cartesian coordinates** interconvert,
and how changes propogate between residues. Changing the dihedral of one residue will change the 
cartesian coordinates of all residues "downstream" in the fold tree due to **lever arm** effects.
By changing the fold tree you can limit the propigation of these effects, keeping portions of the
protein backbone fixed which would normally move. 

See also **atom tree** and **kinematics**.
  
#### fragment

A section of a protein. Typical Rosetta usage is for 3- and 9-mer **backbone** fragments selected from **PDB** structures. 

#### fragment insertion

Placing backbone **dihedrals** from a **fragment** into the structure. Used frequently for **loop modeling** and **ab initio**.  

#### fullatom

A representation of the protein where all physical atoms (including hydrogens) are present during modeling, in contrast 
to reduced representations like **centroid** mode.

#### full-atom energy function

[This definition should be checked by someone else] The energy terms and
interactions are calculated in the atomistic scale (atom-atom pairwise).

#### GDT

Global Distance Test. A metric used in CASP instead of **RMSD**, which is less sensitive to regions of unaligned structure.

[Insert reference here]

#### GDTMM

A Rosetta-specific name for GDT. 

#### gradient

#### gradient-based minimization

#### high resolution validation

#### homologue

Evolutionarily related proteins. They usually have similar structure and sequences,
but don't necessarily have to. Within Rosetta however we are only
interested in homologues that are similar in structure. Ones that are
similar in sequence but not in structure are not necessarily useful,
though proteins that share more than 20-25% of their sequence are
usually structurally similar. (The 20-25% region is called the "twilight
zone" of homology.)

A protein that is structurally similar but not evolutionarily related is
an analogue.

#### homology modeling

Homology modeling of protein refers to constructing an atomic-resolution
model of the "target" protein from its amino acid sequence and an
experimental three-dimensional structure of a related
homologous
protein (the "template"). Homology modeling relies on the identification
of one or more known protein structures likely to resemble the structure
of the query sequence, and on the production of an alignment that maps
residues in the query sequence to residues in the template sequence.
Related to
threading.

#### hydrogen bond

#### hydrogen bond acceptor

#### hydrogen bond donor

#### idealization

Rosetta normally works only with changing **dihedral** angles. The process of idealization
is changing a structure to use ideal bond lengths and angles

See also **Cartesian minimization** which works with non-ideal
bond lengths and angles.  

#### implicit solvation model

#### interface

#### internal coordinates

Storage of the positions of atom based on bond lengths, angles and dihedrals, rather than **Cartesian coordinates** 
(xyz coordinates). The conversion between the two is kinematics.

#### jump

#### kinematics

#### Lazaridis-Karplus

#### Lennard-Jones

#### lever arm

#### ligand

#### loop

Structurally a loop region is a combination of phi-psi angles which is in a certain area of the Ramachandran plot. Loops are very loosely defined: a working definition is secondary structure that isn't defined as either an alpha helix or a beta sheet.

[XXX: A picture would be good here]

In Rosetta code a loop is anything between two fixed ends that you want to model. This usually corresponds to the structural definition of loops, but can also refer to regions which aren't. 

#### loop library

#### loop modeling

#### low-resolution structure prediction

#### main chain

#### metric

#### minimization

#### monomer

#### Monomeric protein

#### Monte Carlo method

Monte Carlo methods are a class of computational algorithms that rely on
repeated random sampling to compute their results. In Rosetta, Monte
Carlo methods are used frequently to sample: rotamers in repacking,
amino acids in design, fragments in folding, numerous other chemical
changes.

(Discuss specifics of Monte Carlo in Rosetta)

#### Monte Carlo minimization

#### mutation

#### moiety

#### native water

#### neighbors

#### Normal perturbation

#### nuclear Overhauser effect

#### one-body energy

#### packing

#### Parallel perturbation

#### PDB

#### perturbation

#### protein

#### protocol

#### radius of divergence

#### ramachandran

#### Randomizing rigid-body orientation

#### refinement

Starting from a
low-resolution
model, use the [full-atom energy
function](https://wiki.rosettacommons.org/index.php/Glossary#full-atom_energy_function "Glossary")
to modify the
conformation
so it is closer to an experimentally determined structure.

#### relax

#### representation

#### residue

Each Pose/Conformation is broken down into small units called
"Residues", which could be amino acids, nucleic acids or any group atoms
with certain rules of what they are and how they are connected, such as
a small chemical ligand moiety. The chemical content of a Residue is
stored in an object called "ResidueType" and aside from that each
Residue has other data storing actual coordinate information of each
atom it contains as well as coordinate-related data such as
mainchain/sidechain torsion angles, sequence position etc. For example,
in a protein there might be multiple Leucine residues, each of which
will be an individual "Residue" object. Each Leu Residue has its own
coordinate data, but all Leu will have the same Leu ResidueType which
contains information on what are the atoms, their names, chemical
elements and connectivity. This setup also allows a sidechain Rotamer to
be represented just as a Residue.

#### resolution

#### rigid-body

There is no intramolecular flexibility between the protein
backbone
atoms or bonds and angles are frozen for the backbone.

#### rigid-body movement

#### rigid-body orientation

#### root mean square deviation (RMSD)

[It's not enough to just explain how RMSD is calculated: it's also
important to discuss what significance it plays in Rosetta, and what
values are to be expected calculating it in various places.]

#### root mean square deviation (RMSD)

[It's not enough to just explain how RMSD is calculated: it's also important to discuss what significance it plays in Rosetta, and what values are to be expected calculating it in various places.] 

#### rotamer

[Is this describing rotamers or the algorithm?] In the docking
algorithm,
side-chains
are added to the protein
backbones
using the Dunbrack rotamer packing algorithm where the rotamers
(side-chain conformations) are created from specific number of
chi1,2,3,4 angles to the backbone structure. *Protein Sci (1997),
6,1661*

#### rotamer

#### rotamer pair

#### rotamer library

#### rotamer trial minimization

the optimal combination of rotamers (sidechains) is found using a simulated-annealing Monte Carlo search. Minimization techiniques are adopted afterwards to optimize sidechains and rigibody displacements simulataneously. 

#### Rotational perturbation

#### SASA

#### scorefile

#### scoring

#### Scoring filter

#### scoring function

#### secondary structure

Secondary structures describe classes of local
conformations
of a molecule (usually a nucleic acid or protein). The most basic
formulation of protein secondary structure classes are [alpha
helices](https://wiki.rosettacommons.org/index.php/Glossary#alpha_helix "Glossary"),
[beta
sheets](https://wiki.rosettacommons.org/index.php/Glossary#beta_sheet "Glossary"),
and
loops.
In ab-initio projects, Rosetta uses secondary structure prediction
programs to predict the secondary structure of the target protein. The
predicted secondary structure is then used to select fragments from the
Vall database of fragments.

Secondary structure prediction in Rosetta is currently achieved by a
combination of the following three methods:

-   PsiPred. D.T. Jones, *J. Mol. Biol.* **292**, 195 (1999).
-   SAM-T99. K. Karplus, R. Karchin, C. Barrett, S. Tu, M. Cline, M.
    Diekhans, L. Grate, J. Casper, R. Hughey, *Protein Struct. Funct.
    Genet.* **S5**, 86 (2001).
-   JUFO. J. Meileer, M. Muller, A. Zeidler, F. Schmaschke, *J. Mol.
    Biol.* 7, 360 (2001).

#### sequence

Peptide sequence or amino acid sequence is the order in which amino acid
residues, connected by peptide bonds, lie in the chain in peptides and
proteins. The sequence is generally reported from the N-terminal end
containing free amino group to the C-terminal end containing free
carboxyl group. Peptide sequence is often called protein sequence if it
represents the primary structure of a protein. In Rosetta, a sequence is
input in a \*.fasta file format.

#### sequence number

#### side chain

The 20 aminoacids contain an amino group (NH2), a carboxylic acid group (COOH), and any of various sideChains R, and have the basic formula NH2-CH-COOH(R) 

#### simulated annealing

#### solvent accessible surface area (SASA)

Solvent Accessible Surface Area

#### structure

#### taboo

#### tautomers

#### template

#### threading

Protein threading, also known as fold recognition, is a method of
protein modeling (i.e. computational protein structure prediction) which
is used to model those proteins which have the same fold as proteins of
known structures, but do not have
homologous
proteins with known structure. Threading is the process of placing the
amino acids of a target protein onto the 3D structure of a template
according to a sequence alignment. A comparative model can then be build
of the target protein sequence.

#### torsion angles

#### trajectory

#### two-body energy

#### unbound docking

the crystal PDB structures of the 2 proteins are determined separately and then combined into one complex 

Rosetta- or related software-specific concepts
----------------------------------------------

#### Atom

Core::conformation class giving an (x,y,z) triple to an
AtomType.

#### AtomType

Core::chemical class.

#### AtomTree

Core::kinematics class for defining atomic connectivity.

#### ChemicalManager

Core::chemical singleton class.

Manages Chemicals

#### Conformation

Core::conformation class which contains
Residue
objects. This is linked by the kinematic layer to describe
internal-coordinate folding.

#### Dunbrack score

#### Energies

Core::scoring class to cache scores. It lives in
Pose.

#### EnergyMethods

Core::scoring class.

#### FoldTree

Core::kinematics class for defining residue connectivity.

#### MolProbity package

MolProbity is a general-purpose web server offering quality validation
for 3D structures of proteins, nucleic acids and complexes. It provides
detailed all-atom contact analysis of any steric problems within the
molecules as well as updated dihedral-angle diagnostics and it can
calculate and display the H-bond and van der Waals contacts in the
interfaces between components.

*MolProbity: all-atom contacts and structure validation for proteins and
nucleic acids, Davis et al., Nucleic Acids Res. 2007 July; 35(Web Server
issue): W375–W383.*

#### MoveMap

Core::kinematics class which contains lists of mobile and immobile
degrees of freedom.

#### Mover

An abstract class and parent of all protocols. Every protocol in Rosetta
has to inherit from this class and implement the apply function (which
is the one that does all the magic...)

#### PackerTask

A class which sets up what is allowed in packing.

#### Pose

Represents a molecular structure in Rosetta (of proteins, RNA, etc) and
contains all of its properties such as
Energies
,
FoldTree
,
Conformation
and more. Each and every
Mover
in Rosetta operates on a pose through its *apply* function

#### Residue

Core::conformation class which puts
Atom
objects on a
ResidueType
skeleton.

#### ResidueType

Core::chemical class for
defining which atoms are in a residue (or ligand) and
how they connect internally.

#### ResidueTypeSet

Core::chemical class.

#### ScoreFunction

Core::scoring class which scores and contains pointers to
EnergyMethods.

#### ScoringManager

Core::scoring singleton class.

#### TaskFactory

A class to set up new
PackerTasks
as needed.
Administrative terms
--------------------

#### release

The
Releases
are when we make Rosetta code available to academic and industrial
users. The code in
trunk
is copied into a branch in
SVN, cleaned up
to remove unreleaseable code (usually
devel
and
pilot\_apps,
then posted for wider use. We usually have two releases a year (Rosetta
3.1, 3.2, 3.3, etc). See also the [List of
releases](https://wiki.rosettacommons.org/index.php?title=List_of_releases&action=edit&redlink=1 "List of releases (page does not exist)").

Revision control concepts
-------------------------

#### branches

See
trunk.

#### commit

This is a term related to how [version
control](https://wiki.rosettacommons.org/index.php/Source_repository "Source repository")
is used. A commit is when you upload your changes from your computer to
the common code source.

#### devel

devel is one of the
libraries
within the Rosetta project. It contains code that is documented and
tested (ha ha!) but not necessarily scientifically validated to work
well: code still under *devel*opment.

#### trunk

trunk is a name for where the developers' current version of Rosetta
lives. It's called trunk because it's the main line of the code; side
development projects are in branches.

#### test servers

The [Gray
lab](https://wiki.rosettacommons.org/index.php?title=Gray_lab&action=edit&redlink=1 "Gray lab (page does not exist)")
maintains a suite of [testing
servers](https://wiki.rosettacommons.org/index.php/Test_server "Test server")
which run a set of standardized tests on each
commit
of the code to
trunk.
The [tests](http://rosettatests.graylab.jhu.edu/revs) ensure that:

-   the code compiles
-   the unit tests pass
-   the integration tests are correct
-   and many other things

