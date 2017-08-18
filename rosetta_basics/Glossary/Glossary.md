Glossary
========

This glossary collects lots of the Rosetta terms with short
(sentence-to-paragraph) definitions. You'll see definitions of objects
in the code, biophysics concepts, and adminstrivia. Many of these are terms of
art in structural biology with the particular nuances that apply in
Rosetta.

See also a [[more in-depth discussion of some topics|RosettaEncyclopedia]].

[[_TOC_]]

# **A**

Term  | Description
------------ | -------------
_ABEGO_ | Designation that indicates a residue's position in Ramachandran space (A = right-handed alpha or 3<sub>10</sub> helix; B = right-handed beta strands and extended conformations; E = left-handed beta strands; G = left-handed helices) and *cis* omega angles (O). See citation [[here|http://www.ncbi.nlm.nih.gov/pubmed/8568871]].
_Ab_ _Initio_ Structure Prediction | Prediction of molecular structure given only its sequence. Known also as **de novo modeling**. In Rosetta, _ab_ _initio_ modeling uses statistical information from the **PDB** such as **fragments** and **statistical potentials**.
_AllAtom Modeling_ | See **fullatom**.
_Alpha Helix_ | A common motif in the secondary structure of proteins, the alpha helix (α-helix) is a right-handed coiled or spiral conformation, in which every backbone N-H group donates a hydrogen bond to the backbone C=O group of the amino acid four residues earlier (i+4 - i hydrogen bonding). Among types of local structure in proteins, the α-helix is the most regular and the most predictable from sequence, as well as the most prevalent.
Analogue | Similar proteins without evolutionary relationships. See also **homologue**. Rosetta **homology modeling** doesn't actually need strict evolutionary relationships, and can use **analogues** as **templates**.
Annotated Aequence | Rosetta will often record the sequence of a protein as the one letter amino acid codes, expanding when necessary with square brackets to indicate patches like post-translational modifications.
_Atom_ | A class storing the Cartesian position of an atom in a Residue.
_Atom Tree_ | The atom tree connects atoms in the **pose**, and is used to convert **internal coordinates** into **cartesian Coordinates**. Normally derived from the **fold tree**.
_AtomTree_ | Core::kinematics class for defining atomic connectivity.
_AtomType_ | A class which stores the properties of a particular kind of atom. (e.g. a carboxylate oxygen). See [[Rosetta AtomTypes]] for more details.

----------------------------------------

# **B**

Term  | Description
------------ | -------------
_B factor_ |The "temperature factor" from crystallography and seen in PDB files, the larger the value the more "flexible" the atom is
_Backbone_ | In **biopolymers**, the backbone is those atoms which form the polymeric chain. In proteins these are the N, CA, C, and O atoms and their hydrogens. In nucleic acids it is the phophate and sugars. See also **main chain** 
_Backrub_ | A change in torsion angles seen routinely in structures in solution.  A change in one dihedral is compensated for by changes in the previous and next dihedrals.  This 'move' was implemented as a backbone-sampling protocol by Tanja Kortemme.
_Base_ | The non-**backbone** portion of a nucleotide. Analogous to a protein's **side chain**.
_Benchmark Study _| Tests done to confirm the performance of a new algorithm or method, results are compared to previous results using the same starting data
_Beta Sheet_ | A common motif in the secondary structure of proteins, the beta sheet (β-sheet) is a mostly flat extended structure made up of individual (possibly non-consecutive) extended chains (β-strand) held together by alternating hydrogen bonds.  
_Binding-Affinity or Binding-Energy_ | How strongly two molecules are associated with one another.
**Binding Interface** | The point of contact between two molecules. A common definition in Rosetta is any residue with the C-beta atom or any heavy atom within 6 Angstroms of the other binding partner.
_Biopolymers_ | Polymeric molecules important for biological systems. Typical biopolymers are proteins, RNA, DNA and carbohydrates. 
_Blind Docking_ | Docking where the structure of the docked complex is unknown.
_Bootcamp_ | An intense week-long Rosetta training session for new developers. 
_Bound Docking_ | The complex structure that is used for reference in docking and rmsd calculations is determined experimentally by X-rays/NMR. 
_Branches_ | A development term used in code version control. See trunk.
_Cartesian Coordinates_ | Coordinates with spatial positions specified by xyz coordinates. Contrast this with **internal coordinates**. The conversion between the two is **kinematics**. 
_Cartesian Minimization_ | **Gradient minimization** based on moving atoms in xyz Cartesian space, rather than with **Internal Coordinates**. This requires an extra term (cart_bonded) to maintain bond lengths and angles to their near-ideal values.

-------------------------

# **C**

Term  | Description
------------ | -------------
_CCD_ | Cyclic coordinate descent. A **loop closure** protocol where backbone dihedrals are progressively adjusted to minimizethe gap in the loop backbone. [Add a reference]
_Centroid_ |A reduced representation mode, used for simplifying the representation of the system, to permit faster sampling and scoring.For proteins, each residue is represented by five **backbone atoms** (N, CA, C, O and the polar hydrogen on N) and one pseudo-atom, the “centroid,” to represent the **side chain**. [Explain further how centroid is calculated.] *Gray et al., J. Mol. Biol. (2003) 331, 281–299*
_Chain_ | In Rosetta, a chain is a single, covalently connected molecule. Internally, it is stored as a number. In the **PDB** format, a chain is all residues which share a chain identification label.
_Chainbreak_ | A gap in connectivity (in the AtomTree) between chemically connected / sequentially adjacent residues.  These are used in CCD (Cyclic Coordinate Descent) loop closure.
_ChemicalManager_ | A singleton class in Rosetta which keeps track of things like ResidueTypeSets.
_chi angles_ | Chi angles are the **dihedral angles** which control the **heavy atom** positions of **side chain** components of residues. In carbohydrates, these are are rotatable OH groups.
_chi1, chi2, chi3, & chi4_ | Specific sidechain **chi angles** of protein residues. They are enumerated from the C-alpha atom outward, so chi1 would be the **dihedral** between N-Ca-Cb-Cg.
_clash_ | Two (or more) atoms being too close to be energetically favorable (essentially an overlap of vdW radii)
_cluster_ | Clustering of structures involves grouping structures with "similar" structures. These groups of similar structures are called "clusters". The measure of structure similarity are typically either **RMSD** or **GDT**.  
_coarse grain_ | Initial modeling, where all atoms or energy terms may not be represented. 
_commit_ | This is a term related to how version control is used. A commit is when you upload your changes from your computer to the common code source.
_comparative modeling_ | Prediction of protein structure based on sequence and the structures of closely related proteins. Also called "Homology Modeling"
_conformation_ | The three dimensional organization of atoms in a structure.
_Conformation_ | A class which contains Residue objects and FoldTree. This is the part of the Pose which keeps track of coordinates. This is linked by the kinematic layer to describe internal-coordinate folding.
_conformer_ | One of a set of 3 dimensional orientations a ligand, small molecule or amino acid side chain. Sometimes refered to in Rosetta as a "rotamer".
_constraint_ | When used with Rosetta, actually a "restraint": an adjustment to the score function to take into account additional geometric information
_contact order_ | Taken from "Contact order and ab initio protein structure prediction," Bonneau et. al, Protein Science (2002), 11:1937-1944: "The relative CO is the average sequence separation of residues that form contacts in the three dimensional structure divided by the length of the protein." 
_Critical Assessment of PRediction of Interactions (CAPRI)_ | Protein-protein interactions and other interactions between macromolecules are essential to all aspects of biology and medical sciences, and a number of methods have been developed to predict them. [CAPRI](http://www.ebi.ac.uk/msd-srv/capri/) is a community wide experiment designed to assess those that are based on structure. Since CAPRI began in 2001, the experiment has had two to four prediction rounds each year, with one or a few targets per round.
_Critical Assessment of Techniques for Protein Structure Prediction (CASP)_ | [The Critical Assessment of protein Structure Prediction](http://predictioncenter.org/) (CASP) experiments aim at establishing the current state of the art in protein structure prediction, identifying what progress has been made, and highlighting where future effort may be most productively focused. CASP has been held every two years starting in 1994. Rosetta has participated in several CASP experiments.
_crystal neighbors_ | Is crystal structure a so called native structure? Crystal is composed of approximately 40\~70% of water molecules, which gives crystallographers confidence saying proteins in crystal lattice should be able to represent proteins in biological environments, especially when proteins in crystal lattice often times are able to undergo biological reactions they are capable of in cells. However, there is an inevitable artifact in crystal lattice - that is regions where proteins adjacent to each other, making so called crystal contacts. Conformations in regions where proteins have contacts somehow are altered to some extent. Rosetta sometimes is able to sample conformations where the RMSD are 3 or 4 A away from "native crystal structure" but have lower energies, which are the results from variations of a section of loop. And this loop region happens to locate at the spot where crystal contact occurs. Therefore, we now are thinking about our definition of "native structure", where native structure is supposed to be the conformation of the protein exists in cell.
_crystallographic phasing_ | The critical step of solving a crystal structure is to get the phase either via molecular replacement or experimental methods. The technically easier way to get the phase is by the method of molecular replacement, where crystallographers utilize existing structures with high structural similarities to help guide the search of phase. However, in some hard cases, where there is no structurally similar structures exist, or structures have too low sequence identities (below 15\~20%), crystallographers then have to get the phase through experimental methods, which are much more tedious and difficult compared to molecular replacement method. Rosetta can generate or refine models using physically realistic full-atom force field, which sometimes can generate more accurate comparative models. For some of those hard cases, Rosetta therefore is able to provide better initial search models for molecular replace to find the solutions. ref: Qian et. al. High-resolution structure prediction and the crystallographic phase problem. Nature 450, 259-264 (2007)
_CxxTest_ | This is the framework we use for [[unit tests]]. See also [[http://cxxtest.com]].

--------------------------

# **D**

Term  | Description
------------ | -------------
_database_ | The Rosetta database directory contains key parameters for Rosetta. Examples of stored information is force field, definition of monomers (see: **residue types**), representation of the model, fundamental constant parameters, etc. 
_ddG_ | Also known as ΔΔG. The change in binding energy free energy (ΔG) upon a mutation. 
_de_ _novo_ modeling | Prediction of molecular structure given only its sequence. Known also as **ab initio structure predition**.
_decoy_ | A **model** produced by a computational protocol.
_density map_ | Experimental data showing where the electrons (and thus the atoms) are.
_design_ | Optimization of the amino acid sequence of a protein.
_devel_ | devel is one of the libraries within the Rosetta project. It contains code that is documented and tested but not necessarily scientifically validated to work well: code still under *devel*opment. It is not availible in the released version.  It should be deleted.
_dihedral angle_ | A four-body angle encoding the respective orientation of two atoms around the axis connecting two other atoms. Also known as a **torsion**.
_disulfides_ | The covalent attachement of two cysteine residues in close proximity. This depends on the protein being present in an oxidizing environment (like outside of the cell), rather than a reducing environment (like the inside of the cell). This covalent attachment can greatly stabilize the folding of a protein. 
_docking <a name="docking" />_ | Assembling two separate proteins (or protein-ligand, protein-surface) into their biologically relevant structure and finding the lower free energy of the complex.
_docking funnel_ | An energy funnel (score versus RMSD) for docking runs.
_Dunbrack library_ | A sidechain rotamer library compiled by the Dunbrack laboratory; the standard rotamer library of Rosetta.
_Dunbrack loop optimization_ | See **CCD**
_Dunbrack score_ | Statistical energy term of the rotamer (-log(p) where p is the probability of the given rotamer.)

--------------------------------
# **E**

Term  | Description
------------ | -------------
_Energies_ | A class in Pose which stores the energies computed by the ScoreFunction.
_energy function_ | Also called a "score function". The prediction of structural energy over which Rosetta operates.
_energy funnel_ | An attempt at representing the energy landscape of the protein. A plot which (ideally) shows low rmsd structures having lower energies than high rmsd structures.
_energy landscape <a name="general-terms_energy-landscape" />_ | [See this page (http://www.eoht.info/page/Energy+landscape)
_ensemble_ | a group of closely related structures
_EnergyMethod_ | The class which implements the scoring of a particular **score term** for the **ScoreFunction**.
_explicit water_ | Water modeled as atoms, rather than implicitly.
_ex1/ex2_ | Options that specify the size (extra sampling) of rotamer library being used

--------------------------------------

# **F**

Term  | Description
------------ | -------------
_fasta_ |Text based format describing the peptide sequence of a protein, single letter amino acid codes are used
_filter_ | A pass/fail check on structure quality during the middle of a run. Filters are applied to avoid wasting computational time on **trajectories** which are unlikely to result in successful results.Relevant **metrics** are calculated and those structures with poor values are discarded. 
_fixbb_ | A Rosetta application which does fixed backbone design.
_fixed backbone design_ | **Design** of a protein where the the **backbone** is not moved during the redesign.
_fixed backbone packing_ | Optimization (**packing**) of the side chain conformations, done without moving the **backbone**.
_flag(s) file_ | Also **options file**: a file that contains a set of flags (possibly with their respective parameters) to control the program or protocol. You can load it as an option when you start the program, instead of typing all options at the command line.
_flexible backbone design_ | **Design** of a protein where the the **backbone** is allowd to move during design.
_flexible backbone packing_ | Optimization (**packing**) of the side chain conformations, where the **backbone** is allowed to move during optimization.
_FoldTree (fold tree)_ | A directed, acyclic graph (tree) connecting all the residues in the **pose**. The fold tree is the residue-level description of how **internal coordinates** and **cartesian coordinates** interconvert, and how changes propogate between residues. Changing the dihedral of one residue will change the cartesian coordinates of all residues "downstream" in the fold tree due to **lever arm** effects. By changing the fold tree you can limit the propagation of these effects, keeping portions of the protein backbone fixed which would normally move. See also **atom tree** and **kinematics**.
_force field_ | See **scorefunction**.
_fragment_ | A section of a protein. Typical Rosetta usage is for 3- and 9-mer **backbone** fragments selected from **PDB** structures. 
_fragment insertion_ | Placing backbone **dihedrals** from a **fragment** into the structure. Used frequently for **loop modeling** and **ab initio**.  
_fragment picker_ | A Rosetta application used to pick fragments. 
_fullatom_ | Also "all atom": A representation of the protein where all physical atoms (including hydrogens) are present during modeling, in contrast to reduced representations like **centroid** mode.
_full-atom energy function_ | The energy terms and interactions are calculated in the atomistic scale (atom-atom pairwise).  As apposed to a reduced representational-mode such as centroid.

-----------------

# **G**

Term  | Description
------------ | -------------
_GDT_| Global Distance Test. A metric used in CASP instead of **RMSD**, which is less sensitive to regions of unaligned structure. [Insert reference here]
_GDTMM_ | A Rosetta-specific name for GDT. 
_Git_ | One of the most widely used distributed version control system, used to version control the Rosetta code. Developed originally for Linux development by Linus Torvold. We use GitHub for hosting.
_Gollum_ | [Gollum](http://github.com/gollum/gollum#gollum----a-wiki-built-on-top-of-git) (external link) is a Git-based wiki, used to create this wiki you are reading.
_global minimum_ | The 3 dimensional conformation of a protein which corresponds to the lowest possible energy state, this is (usually) the conformation found in nature.

-----------------------------------------------

# **H**

Term  | Description
------------ | -------------
_hard rep_ | Normal Lennard Jones repulsive - used in contrast to **soft_rep**.
_heavy atom_ | All atoms except hydrogens.
_homologue_ | Evolutionarily related proteins. They usually have similar structure and sequences, but don't necessarily have to. Within Rosetta however we are only interested in homologues that are similar in structure. Ones that are similar in sequence but not in structure are not necessarily useful, though proteins that share more than 20-25% of their sequence are usually structurally similar. (The 20-25% region is called the "twilight zone" of homology.) A protein that is structurally similar but not evolutionarily related is an analogue.
_homology modeling_ | Homology modeling of protein refers to constructing an atomic-resolution model of the "target" protein from its amino acid sequence and an experimental three-dimensional structure of a related homologous protein (the "template"). Homology modeling relies on the identification of one or more known protein structures likely to resemble the structure of the query sequence, and on the production of an alignment that maps residues in the query sequence to residues in the template sequence. Related to threading.

# **I**

Term  | Description
------------ | -------------
_idealization_ | Rosetta normally works only with changing **dihedral** angles. The idealize application program loads the pdb file and replaces all bond lengths and plane angles with the values defined in Rosetta database. The result of this simulation is non-deterministic, so many runs may be attempted. See also **Cartesian minimization** which work with non-ideal bond lengths and angles.  
_interaction graph_ |  A representation of protein interactions during packing; can affect simulation speed
_interface_ | The region of a structure where two chains interact
_internal coordinates_ | Storage of the positions of atom based on bond lengths, angles and dihedrals, rather than **Cartesian coordinates** (xyz coordinates). The conversion between the two is kinematics.

-------------------------

# **J**

Term  | Description
------------ | -------------
_jump_ | A portion of the **fold tree** representing a rigid body (non-covalent) movement.

-------------------------

# **K**

Term  | Description
------------ | -------------
_knowledge-based potentials_ | Also "statistical potentials": energy function terms based on the probability of occurrence in a data set

-------------------------

# **L**

Term  | Description
------------ | -------------
_Lennard-Jones_ | Also "LJ": A function that approximates the non-bonded interactions of neutral atoms, combines Pauli repulsion and the van der waals attractive term (also known as Lennard Jones 6-12 potential)
_ligand_ | A molecule which binds a protein; for Rosetta this is specifically a non-polymeric small molecule
_local minimum_ | The lowest energy 3 dimensional state of a protein in a neighborhood of similar conformations, there may be many local minimums of a protein, but only one global minimum.
_loop_ | Structurally a loop region is a combination of phi-psi angles which is in a certain area of the Ramachandran plot. Loops are very loosely defined: a working definition is secondary structure that isn't defined as either an alpha helix or a beta sheet. [XXX: A picture would be good here] In Rosetta code a loop is anything between two fixed ends that you want to model. This usually corresponds to the structural definition of loops, but can also refer to regions which aren't. 
_low energy_ | A 3 dimensional model of a protein is low energy if it has good packing, satisfied polar or charged residues, appropriately placed small molecules or ligands, etc.  However, it may need to be minimized into the given energy function before further use to prevent artifacts. 
_low Resolution_ | An experimentally determined structure of a protein is low resolution if atoms is not distinct, thypically this equates to a crystal structure resolution above 3-4 angstroms.

-------------------------

# **M**

Term  | Description
------------ | -------------
_main chain_ | Used interchangeably with backbone atoms.
_Metropolis criterion_ | Used by Monte Carlo methods, this equation tells whether to accept or reject a random move
_MiniCON_ | This was the winter Rosetta developer's meeting, which moved around the country to be hosted by different RosettaCommons labs. We discussed code issues of wide interest and narrow. The name has changed to Winter RosettaCON.
_minimization_ | Optimize the protein structure by making small movements to lower energy conformations
_minirosetta_ | The name of Rosetta3 project during initial development. Also, the name of a wrapper program which exposes multiple protocols, mainly used for Rosetta@Home.
_MiniRosettaCON_ | See MiniCON.
_mmCIF_ | Macromolecular Crystallographic Information File, file format used to describe the 3 dimensional structure of a protein
_model_ | A representation of the 3 dimensional structure of a protein "All models are wrong, but some are useful" George Box
_MOL format_ | A file type that contains information about the structure of a chemical; same as "SDF format"
_MolProbity_ | [[MolProbity|http://molprobity.biochem.duke.edu/]] is a general-purpose web server offering quality validation for 3D structures of proteins, nucleic acids and complexes. It provides detailed all-atom contact analysis of any steric problems within the molecules as well as updated dihedral-angle diagnostics and it can calculate and display the H-bond and van der Waals contacts in the interfaces between components. *MolProbity: all-atom contacts and structure validation for proteins and nucleic acids, Davis et al., Nucleic Acids Res. 2007 July; 35(Web Server issue): W375–W383.*
_monomer_ | Monomeric protein
_Monte Carlo method_ | Monte Carlo methods are a class of computational algorithms that rely on repeated random sampling to compute their results. In Rosetta, Monte Carlo methods are used frequently to sample: rotamers in repacking, amino acids in design, fragments in folding, numerous other chemical changes. (Discuss specifics of Monte Carlo in Rosetta)
_MoveMap <a name="movemap" />_ | A class in Rosetta which contains lists of mobile and immobile degrees of freedom. Normally used during minimization to specify which parts of the Pose can be minimized. (e.g. for fixed backbone minimization)
_Mover_ | An abstract class and parent of all protocols. Every protocol in Rosetta has to inherit from this class and implement the apply function, which then alters the Pose and implements the protocol.

-------------------------

# **N**

Term  | Description
------------ | -------------
_native structure_ | The structure of a protein, ligand, etc that is found in nature, usually refers to the crystal or NMR structure of a protein
_NNMAKE_ | An earlier version of the **fragment picker** application.
_nstruct_ |The number of models that Rosetta will output

-------------------------

# **O**

Term  | Description
------------ | -------------
_options_ | User specified directions given to Rosetta, either through the command line or through the options file, sometimes called "flags"

-------------------------

# **P**

Term  | Description
------------ | -------------
_PackerTask_ | A class which sets up what is allowed in packing.
_packing_ | In Rosetta, optimizing the conformation (and identity) of protein sidechains. The Rosetta Packer uses Metropolis Monte Carlo Simulated Annealing to optimize rotamers.
_packing density_ | How close atoms are to each other; closer is better, up to a point
_params file_ | A file which tells Rosetta how a residue behaves.
_Parser_ | Another name for RosettaScripts
_patch files_ | A file which makes a small adjustment to a score function
_PDB_ | Can refer to either the Protein Data Bank, a website that contains structural information of proteins, usually determined by x-ray crystallography or NMR. Or PDB can refer to the file type used by the protein data bank to represent the 3 dimensional structure of a protein
_phi_ | The dihedral angle describing the position of the C-N-Calpha-C atoms
_pilot apps_ | Rosetta applications written by the community that have not been yet officially released. 
_Pose_ | Represents a molecular structure in Rosetta (of proteins, RNA, etc) and contains all of its properties such as Energies, **FoldTree**, Conformation** and more. Each and every **Mover** in Rosetta operates on a pose through its *apply* function.
_protocol_ | Workflow to do specific calculations in Rosetta; sometimes a protocol uses **movers**. 
_psi_ | The dihedral angle describing the position of the N-Calpha-C-N atoms

-------------------------

# **R**

Term  | Description
------------ | -------------
_ReferenceCount_ | ReferenceCount was the core class in the smart pointer system that Rosetta3 used up until 2015.  Nearly every class in Rosetta ultimately inherits from this class.  The class remains as an empty class, because it was too hard to move after Luki Goldschmidt's transition to our [[newer smart pointers|development_documentation/tutorials/How to-use-pointers-correctly]], and because having a base class for nearly all classes is useful for the Pose DataCache.
_refinement_| Starting from a low-resolution model, use the **full-atom** **energy function** to modify the conformation so it is closer to an experimentally determined structure.
_relax_ | A protocol in Rosetta which optimizes the structure of the protein
_release_ | The Releases are when we make Rosetta code available to academic and industrial users.  The code in trunk is copied into a branch in git, cleaned up to remove unreleaseable code (usually devel and pilot_apps, then posted for wider use.  We are currently on a "weekly release" schedule, where a new release is produced more-or-less each week. (It is not every week, as certain weeks the code does not pass our quality control measures.)
_repack_ | Determine the conformation of sidechains which minimizes the energy
_representation_ | How Rosetta sees a protein molecule. Rosetta supports two representation: 1. **fullatom** - full atom representation, slow but accurate. 2. **centroid** - a reduced representation. faster, but less precise.
_repulsive term_ | fa_rep: The part of the Lennard Jones equation which describes the effects of overlapping electron orbitals, the energy will be positive
_resfile_ | The [[resfile|resfiles]] is a file format used to manually pass complex instructions to the [[packer]] / [[PackerTask|packer-task]].
_residue_ |Each Pose/Conformation is broken down into small units called "Residues", which could be amino acids, nucleic acids or any group atoms with certain rules of what they are and how they are connected, such as a small chemical ligand moiety. The chemical content of a Residue is stored in an object called "ResidueType" and aside from that each Residue has other data storing actual coordinate information of each atom it contains as well as coordinate-related data such as mainchain/sidechain torsion angles, sequence position etc. For example, in a protein there might be multiple Leucine residues, each of which will be an individual "Residue" object. Each Leu Residue has its own coordinate data, but all Leu will have the same Leu ResidueType which contains information on what are the atoms, their names, chemical elements and connectivity. This setup also allows a sidechain Rotamer to be represented just as a Residue.
_residue types_ | A set of atoms defined for each residue known to Rosetta. The set defines also bonds and local geometry. The data are stored in **database**). Each kind of residue normally has distinct ResidueType objects for each of the different Rosetta **representation**.
_Residue_ | A class in Rosetta which stores the coordinates and details about a specific residue in a **Pose**.
_ResidueType_ | A class in Rosetta specifying how a particular residue behaves chemically. It does not contain the coordinates of the residue (that is stored in a **Residue** object), but rather things like chemical connectivity and atom properties.
_ResidueTypeSet_ | A class containing a collection of **ResidueTypes** all of the same type. The standard ResidueTypeSets are **centroid** and **fullatom**.
_restraints_ | Adjustments to the energy function; often called "constraints" in Rosetta
_REU_ | Rosetta Energy Units - Rosetta's arbitrary energy term, does not correspond with physical energy measurements. With REF2015, REU is now optimized to approximate Kcal/mol
_rigid-body_ | There is no intramolecular flexibility between the protein backbone atoms or bonds and angles are frozen for the backbone.
_Rohl review_ | This term refers to Rohl et. al., 2004, [Protein structure prediction using Rosetta (http://www.ncbi.nlm.nih.gov/pubmed/15063647), the earliest review paper of Rosetta.  See its entry in the [[Rosetta Canon]].
_root mean square deviation (RMSD)_ | [It's not enough to just explain how RMSD is calculated: it's also important to discuss what significance it plays in Rosetta, and what values are to be expected calculating it in various places.] 
_Robetta_ | An online, automated tool for protein structure prediction and analysis.
_Rosetta_ | Best software ever? Or merely the easiest to use? You decide!
_Rosetta++_ |Rosetta++ was the 2.x edition of Rosetta. It is so-named because it was in C++, as a human-assisted machine translation of the original FORTRAN Rosetta.
_Rosetta3 paper_ | [ROSETTA3: an object-oriented software suite for the simulation and design of macromolecules] (http://www.ncbi.nlm.nih.gov/pubmed/21187238), which was the paper that described the transition from C++-but-monolithic Rosetta++ to [object-oriented](https://en.wikipedia.org/wiki/Object-oriented_programming)-C++ Rosetta3.
_RosettaCommons_ | This is [the organization](http://www.rosettacommons.org/) that manages the intellectual property of the Rosetta code.
_RosettaCON_ | This is a summer convention held every year, usually around the last week of July-first week of August, usually at the [Sleeping Lady](http://www.sleepinglady.com/) in Leavenworth, WA. It's a scientific conference just for Rosetta developers and users in industry or RosettaCommons labs, along with a few invited speakers.
_Rosetta Developer's Meeting_ | This is a one-day addendum to RosettaCON, usually held at the University of Washington in Seattle the day before RosettaCON. It's used to handle Rosetta code issues of wide interest that are too technical for the RosettaCON audience.
_RosettaScripts_ | An XML based interface for controlling Rosetta, allows the user greater control of methods, score functions, etc, without requiring the user to change the source code of Rosetta.
_rotamer_ | Rotamers, rotameric isomers, represent the most stable sidechain configurations, which are commonly observed in crystal structures. Using rotamers allows Rosetta to efficiently consider many discrete side chain conformations, where continuous side chain motion would be expensive.
_rotamer trial minimization_ | the optimal combination of rotamers (sidechains) is found using a simulated-annealing Monte Carlo search. Minimization techiniques are adopted afterwards to optimize sidechains and rigibody displacements simulataneously. 

-------------------------

# **S**

Term  | Description
------------ | -------------
_SASA_ | Solvent accessible surface area – the area of a protein that can be reached by water or another solvent
_scorefile_ | A flat-text file produced by Rosetta applications that contain all energy component values. Each row provides values for a single pose (structure). An equivalent file is can be also made from a **silent file** by the following grep command: `grep SCORE silentfile.out > scorefile.sc`
_ScoreFunction_ | The class in Rosetta which handles scoring the pose. A particular Rosetta run can use multiple different ScoreFunctions, each with their own **weights files** and settings.
_scoring grid_ | A rapid pre-calculation of scoring for ligand docking
_secondary structure_ | Secondary structures describe classes of local conformations of a molecule (usually a nucleic acid or protein). The most basic formulation of protein secondary structure classes are **alpha helices**, **beta sheets**, and loops. In ab-initio projects, Rosetta uses secondary structure prediction programs to predict the secondary structure of the target protein. The predicted secondary structure is then used to select fragments from the Vall database of fragments. Secondary structure prediction in Rosetta is currently achieved by a combination of the following three methods:  -   PsiPred. D.T. Jones, *J. Mol. Biol.* **292**, 195 (1999). -   SAM-T99. K. Karplus, R. Karchin, C. Barrett, S. Tu, M. Cline, M.    Diekhans, L. Grate, J. Casper, R. Hughey, *Protein Struct. Funct.   Genet.* **S5**, 86 (2001). -   JUFO. J. Meileer, M. Muller, A. Zeidler, F. Schmaschke, *J. Mol.   Biol.* 7, 360 (2001).
_sequence_ | Peptide sequence or amino acid sequence is the order in which amino acid residues, connected by peptide bonds, lie in the chain in peptides and proteins. The sequence is generally reported from the N-terminal end containing free amino group to the C-terminal end containing free carboxyl group. Peptide sequence is often called protein sequence if it represents the primary structure of a protein. In Rosetta, a sequence is input in a \*.fasta file format.
_SDF format_ | A file format that describes the structure and connectivity of a molecule, used primarily for small molecules, not for proteins; also known as MOL format
_Shultzy's_ | [[Shultzy's|http://www.shultzys.com/]] is a favorite bar and sausage grill of the Rosetta community when in Seattle for RosettaCON. It's on the east side of The Ave.
_side chain_ | The 20 aminoacids contain an amino group (NH2), a carboxylic acid group (COOH), and any of various sideChains R, and have the basic formula NH2-CH-COOH(R) 
_silent file_ | A flat-text file that stores poses (structures) computed with Rosetta along with the relevant scores (energies). By default, the file name is default.out but it may be changed with `-out::silent` flag.The file contains only internal degrees of freedom of a pose (Phi, Psi, omega and Chi angles). **Cartesian coordinates** must be restored with extract_pdbs application. 
_small molecule_ | For Rosetta, anything that's not a polymeric biomacromolecule
_soft_rep_ | An energy function where the Lennard Jones potential is adjusted so that clashes aren't scored as badly; contrast "hard_rep"
_ss2_ | File format used to store secondary structure information. Originally introduced by PsiPred program (by D. Jones) 
_symmetry definitions_ | symdef files tell Rosetta how to treat a symmetric protein

-------------------------

# **T**

Term  | Description
------------ | -------------
_target sequence_ | The sequence of the protein of unknown structure you're trying to model
_TaskFactory_ | A class to set up new PackerTasks as needed, by applying a number of TaskOperations.
_TaskOperation_ | A specification in RosettaScripts which tell the Packer how to optimize rotamers
_test servers_ | The Gray lab maintains a [[testing server]] which runs a set of standardized tests on each commit of the code to trunk. The [tests](http://benchmark.graylab.jhu.edu/) ensure that code compiles for each platform and distribution type.
_Thai Tom_ | Thai Tom is one of the two 'Rosetta restaurants' that many developers like to visit in Seattle before/after RosettaCON. 4543 University Way NE, Seattle, WA 98105 (it's on the west side of The Ave).  Excellent Thai food, can be very spicy. Wait times are a problem if 40 Rosetta people show up at once.
_theozyme_ | A theozyme, or "theoretical enzyme," is a convention used from enzyme design. Unsurprisingly, it's a good idea to generate a geometrically idea active site to stabilize the desired transition state conformation; once you set that up, you can thread it onto a pose.
_threading_ | Protein threading, also known as fold recognition, is a method of protein modeling (i.e. computational protein structure prediction) which is used to model those proteins which have the same fold as proteins of known structures, but do not have homologous proteins with known structure. Threading is the process of placing the amino acids of a target protein onto the 3D structure of a template according to a sequence alignment. A comparative model can then be build of the target protein sequence.
_ Top7 / Top7 paper_ | Top7 is the name of [a protein](http://www.rcsb.org/pdb/explore.do?structureId=1qys) _de novo_ designed with Rosetta. Its paper, [Design of a novel globular protein fold with atomic-level accuracy] (http://www.ncbi.nlm.nih.gov/pubmed/?term=14631033), is also of broad interest for its description of the early energy function.
_torsion angle_ | aka **dihedral**; the degree of freedom of rotating around a bond
_torsion space_ | Internal coordinates; torsion space minimization optimizes the protein by rotating dihedrals
_trunk_ | trunk is a name for where the developers' current version of Rosetta lives. It's called trunk because it's the main line of the code; side development projects are in branches. Also known as [[master|Glossary#master]].

-------------------------

# **U**

Term  | Description
------------ | -------------
_unbound docking_ | the crystal PDB structures of the 2 proteins are determined separately and then combined into one complex 

-------------------------

# **V**

Term  | Description
------------ | -------------
_Vall_ | Pronounced "V-all". The Vall database is a condensed representation of the entire PDB for the purpose of fragment picking. The **fragment picker** filters the Vall database based on the sequence and secondary structure predictions (and other information) to pull out those backbone conformations which represent the desired fragments.
_van der Waals_ | Describes the interactions between neutral, non-bonded atoms, in protein prediction often used interchangeably with Lennard-Jones potential

-------------------------

# **W**

Term  | Description
------------ | -------------
_weights file_ | The file which specifies the coefficients to use when linearly combining **score terms** into a **scoring function**.
_Winter RosettaCON_ | This is the winter Rosetta developer's meeting, which moves around the country to be hosted by different RosettaCommons labs. We discuss code issues of wide interest and narrow.


-------------------------

# **X**

Term  | Description
------------ | -------------
_XML_ | A hierachical data format, a custom version is used by RosettaScripts


##See Also

* [[RosettaEncyclopedia]]: Detailed descriptions of Rosetta terms
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Resources for learning biophysics and computational modeling]]
* [[Rosetta Timeline]]: History of Rosetta
* [[Units in Rosetta]]: Explains measurement units used in Rosetta