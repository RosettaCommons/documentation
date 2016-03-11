# Rosetta Encyclopedia

[[_TOC_]]

### Broken Chain Sampling (Jumping) 

Broken chain sampling (Jumping) is an important tool to improve sampling of proteins with high-contact order beta-strands and to allow resampling of specific beta-strand topologies during RASREC. To form a specific strand-strand contact between two residues i and j, the chain is cut in any location (preferably loop regions) between residues i and j. The two independent chains are then put into contact at residue i and j using one of the relative rigid body orientation that is found in the strand-strand database (main/database/scoring/score_functions/jump_templates_SSpairs_v2.dat). The generalized fragment sampling implemented in ROSETTA3 allows further to sample other relative rigid body orientations from the strand-strand database during the fragment assembly stages of the structure calculation protocols. Fragments taken from the strand-strand database are characterized by their direction (parallels, anti-parallel) and their pleating (CA atoms point inward/outward). Since exchange of conformations between these classes would be too disruptive during folding, we select one of the 4 classes for each jumping position at the beginning of a folding simulation and then exchange fragments for each jumping position according to its class identity.
The position and class of strand-strand contacts can be defined by input files. It is possible to define multiple pairs for jumps including multiple classes (direction, pleating) for the same pair of residues. In this case specific pairs and contact classes are selected randomly at the beginning of each folding trajectory and subsequently kept constant.

The beta-strand topology is the collection of residue pairs that are bonded by backbone hydrogen bonds and for which both residues are in extended conformation(beta-sheet). These pairs are usually organized in parallel or anti-parallel stretches which we call strand-strand contact. Anti-parallel strand-strand contacts, that start with the pairing of residue i, j have also the pairs i+1, j-1, i+2, j-2 etc. Hence, it makes sense to define an invariant quantity called register for each pair i,j as r=j-i for j>i. In parallel strand-strand contacts the register is defined as r=i+j. Sometimes a residue is skipped which creates a bulge and leads to a change of the register within a single strand-strand contact. ROSETTA3 has a condensed file-format to describe such topologies precisely. Such a topology file can be created using the application r_pdb2top using structures in pdb or silent format as input. If multiple structures are used as input, the program creates a topology description for each input structure and additionally scores the topologies such that topologies with high consensus among the input-models are ranked higher. This scoring is described in detail in Ref. [Lange2012a].

Using the broker-setup file (-broker:setup) one can add a TemplateJumpClaimer to sample specific beta-sheet topologies. Given a topology file (r_pdb2top) with specific and ranked topolgies, the TemplateJumpClaimer will randomly select a topology from the top-ranking topologies (from a topology file as created with r_pdb2top) for each trajectory. From the selected topology it further selects randomly a subset of the strand-strand contacts to be enforced by jumping. For each chosen strand-strand contact one residue-pair is chosen randomly for the actual residue-residue jump. The pleating and direction for this jump is given by the topology. The flag -templates:topology_rank_cutoff controls which topologies from the input file can be chosen.

If beta-strand topologies are not available one can also just define a plain list of residue-residue pairs including their contact class (direction, pleating) to be enforced as strand-strand jumps. If such a file is given, the TemplateJumpClaimer will select jumps from this list and uses the secondary structure information (as provided by a psi-pred file) to avoid selecting incompatible pairs (such as two pairs within the same strand-strand contact). This mechanism is used during the early stage of the RASREC protocol.

For each jump that fixes a strand-strand contact the protocol has to introduce an artificial chainbreak to avoid circularity in the AtomTree. This chainbreak has to be closed before the structure can be refined during the relax stage. To prepare the closing we ramp up a chainbreak energy penalty. During abinitio stages stageI through stageIII the linear_chainbreak energy term is used. During stage IV the overlap_chainbreak is switched on additionally. The weight for the linear-chainbreak energy is computed as W=S*IC, where IC is given by flag -jumps::increase_chainbreaks
with default 1.0, S depends on the stages as follows 0.25/3, 2.5/3*IP, 0.5/3*IP, (1.5*IP+2.5)/3 for stages stageII, stageIIIa, stageIIIb and stageIV, respectively, and IP the intra-stage progress (0...1, for multi-block stages stageIII and stageIV).

[Lange2012a] Resolution-adapted recombination of structural features significantly improves sampling in restraint-guided structure calculation., Lange, Oliver F., and Baker David, Proteins, 2012/00/01, Volume 80, Issue 3, p.884 - 895, (2012)

### Chainbreak Energy

The chainbreak energy is used to penalize unphysical chainbreaks as they occur during loop-building, loop-closing and jumping abinitio. These protocols introduce chainbreaks to avoid circlularities in the AtomTree. This allows to use the kinematics of the system to keep selected degrees of freedom in place and thus opens up other degrees of freedom to broad sampling. For instance, in loop-building a jump connects the two end-points of the sampled loop-region and introduces a new chainbreak somewhere in the loop between the end-points of the jump. The effect is that the loop-region now consists of two terminal peptide chains which can be moved without affecting the rest of the protein conformation. Using this principle of broken chain sampling, the loop conformational space can be sampled broadly. However, subsequently the loop has to be closed again. Rosetta provides dedicated movers for kinematic loop-closing, but these can create rather distorted loops if the loop is not already sufficiently similar to a closed loop. Hence, the first step in closing is usually to employ a penalty energy for open loops while continuing energy based sampling (e.g., MonteCarlo, TrialMove). This penalty energy is given by the ScoreType chainbreak, linear_chainbreak and overlap_chainbreak.

    * chainbreak A quadratic penalty on distance of the chain-ends
    * linear_chainbreak A linear penalty on distance of the chain-ends
    * overlap_chainbreak A linear penalty on the orientation of the peptide-planes at the chain-ends 

To compute distances and orientation virtual atoms are introduced at the respective chain-ends using the residue type variants. For a cutpoint at residue i these are

    * protein_cutpoint_upper introduces virtual atom OVU1 (to partner with atom C of residue i
    * protein_cutpoint_lower introduces virtual atoms OVL1 and OVL2 (to partner with atoms N and CA of residue i+1) 

To compute distance and orientation overlap the atoms C(i), N(i+1) and CA(i+1), and their corresponding virtual counterparts (OVU1, OVL1 and OVL2), respectively, are identified with each other to compute distances and differences in the orientation of the peptide plane.

### Constraints

Constraints should really be called restraints but the wrong use of the name has its history in Rosetta. A constraint in Rosetta is implemented as a biasing potential, often harmonic, that causes an energy penalty if a certain parameter strays far from its set value. If the total energy is optimized during a structural simulation a constraint thus can increase the number of final structures for which the respective parameter is close to the set value of the constraint. If one really wants to constrain a certain degree of freedom, i.e., that a certain length should be exactly the specified value, or that a torsion is not moved, one enforces such things usually by carefully selecting the move-set (such that a particular internal degree of freedom is not moved), and by changing the kinematics such that the length/angle or torsion of interest become an internal degree of freedom (see FoldTree and AtomTree).

### Deterministic

In general, Rosetta is not deterministic. Rosetta is a suite of algorithms and protocols but the underlying algorithm for many protocols is called Markov Chain Monte Carlo (MCMC) and is stochastic (random). Abstractly, MCMC algorithms allow users to withdraw samples from a distribution without explicit knowledge of the entire distribution structure (though some knowledge about constraints on the distribution is required). Rosetta was constructed to perform structural changes and scoring efficiently to make individual trajectories computationally inexpensive. Thus, an individual trajectory, such as a single ab initio job, is not expected to yield a very good prediction. With enough trials (adequate sampling), one or more trials will yield very good estimates (low scoring) of the unknown structure.
As a stochastic algorithm, the real output (with adequate sampling) is a distribution of structures. However, the search space for nearly all protein conformation questions is too large to extract statistical characteristics easily. Many statistical techniques can be used to analyze the set of structures (decoys) output by a Rosetta protocol but none are universally applicable. Simplistically this means that each new trajectory has the chance of producing a low scoring structure (most likely native-like) and thus, more trajectories yield a greater chance of producing a realistic structure.
Usually 800 or more trajectories is enough to produce useful results although it depends on the application. When developing new algorithms, construct a benchmarking set of structure to compare with. As is typical with bioinformatics software, some parameters of any algorithm with be tuned based on a trial set. This does not mean individual trials in Rosetta are useless. At very least, the output are indicative of the sampling performed by the algorithm. Several tools in Rosetta are deterministic (such as minimization). When testing out new protocols or Movers, try and learn if the application has a lot of variability or performs small random changes.

### ﻿FoldTree and AtomTree 

The kinematics of the molecular model, i.e., how atoms are connected, are represented in a non-cyclic graph-structure called AtomTree. If your molecular system is a single chain protein the root of the tree is the mainchain N-atom of the N-terminus. The CA-atom is considered a child of this Nitrogen and a branch-point. One branch of the tree moves into the side-chain whereas the other branch moves along the main-chain of the protein. The edges of the tree (i.e., the connections between atoms) store the internal coordinates that represent the conformation of the structure. In Rosetta the internal coordinate representation dominates and xyz-coordinates are computed as derived data each by starting with (0,0,0) for the root-atom and proceeding down the tree under application of the 3 internal coordinates (bond-length, angle and torsion) stored on each edge. Proteins can have ideal geometry, i.e., the bond-lengths and bond-angles are fixed to standard values (residue dependend), and for these proteins only the torsional degree of freedom has to be recorded. As long as only the torsional degrees of freedom are manipulated the protein stays in ideal geometry which demonstrates the advantage of the internal coordinate representation vs. a cartesian representation.

If the Pose contains multiple peptide-chains a special edge called Jump connects the C-term of the first chain with the N-term of the second chain. Since there are no kinematic restrictions for a Jump-Edge, this edge stores the full 6 degrees of freedom of translation and rotation.
 In a generalization of this concept Rosetta allows to place jump-edges in the middle of protein chains. In this case chain-breaks have to be introduced accordingly to avoid cycles in the AtomTree. Such intra-chain jump-edges allow, e.g., the remodelling of loops while the remainder of the structure is not moved. A second important application of intra-chain jumps is the modelling of beta-sheet topologies, where pre-determined strand-pairings are enforced throughout the simulation via jumps.

The FoldTree is a low-resolution abstraction of the AtomTree. The Fold-Tree nodes are residues rather than Atoms. Moreover, whole consecutive stretches of residues are summarized by a single peptide-edge such that a Fold-Tree consists only of peptide- and jump-edges between residues. In the simplest form of a single-chain protein without intra-chain jumping, the Fold-Tree would contain only a single peptide edge going from residue 1 to N. If one wants to remodel a loop from say residue 42-52 with a jump from 41-53 and a chainbreak at 48, the respective fold-tree would contain peptide edges 1-41, 41-48, 53-48, 53-N, and a jump-edge 41-53. Note the reversed folding-direction for 53-48.

### Fragment Assembly (Abinitio)

Fragment Assembly describes the basic Rosetta protocol for de-novo structure prediction. Fragments provided via a fragment library are randomly selected and inserted into the protein backbone.

In this context a fragment is a particular conformation of protein, RNA or DNA backbone. Usually fragments are the conformation of short consecutive monomeric units (e.g., residues, bases ) but the concept has also been generalized to allow description of broken-chain conformations such as residues in two contacting beta-strands[1]. In the former case, the conformation of a fragment is characterized by a set of backbone torsions (e.g., phi, psi omega angles) and in the latter case, the conformation consists of backbone torsions and rigid-body transformations (Jump).

Before the fragment assembly can commence a fragment library has to be constructed. That is for each set of degrees of freedom (e.g., protein backbone torsions, Jumps) where conformational sampling should take place fragments have to be obtained. For the standard de-novo protein structure prediction protocol, we use the fragment picker to select fragments of 3 and 9 residues length from a precomputed master library of high-resolution protein structures (this library is called vall). The fragment_picker relies on the observation that sequence alone already determines the conformation of short stretches of protein backbone[ref]. In CS-Rosetta the quality (i.e., accuracy and precision) of the selected fragments is greatly enhanced by using chemical shift information in addition to the sequence information[Lange2012a]. We usually pick 200 fragments per position.

For the beta-jump sampling, fragments are categorized into 4 types according to direction (parallel, anti-parallel) and pleating (inward, outward) of the strand-strand contact. A file in the rosetta-database has ca. 1000 conformations in each category taken from high-resolution protein structures. No further information but the category is used for their selection. 

[Lange2012a] Resolution-adapted recombination of structural features significantly improves sampling in restraint-guided structure calculation.,
Lange, Oliver F., and Baker David, Proteins, 2012/00/01, Volume 80, Issue 3, p.884 - 895, (2012)

#### Fragment Library 

The fragment library is a file that contains many possible conformations (fragments) for a given set of degrees of freedom. A fragment library for the protein backbone (abrelax protocol) contains a set of fragments for each (overlapping) position. The fragment library is generated using the fragment_picker application.

#### Fragment moves

The typical fragment move is the replacement of torsion angles for a stretch of consecutive residues with torsion angles stored in the fragment library. Moves of this kind are sampled by applying objects of the type FragmentMover to the Pose.
The fragment library is prepared for a specific protein and is position specific. The standard abrelax protocol uses the first 200 3mer fragments stored in a 3-mer fragment library and the first 25 9mer fragments stored in the respective 9mer library. The fragment libraries are given using the flags (-abinitio:frags3 and -abinitio:frags9). The protocol, however, doesn't care about the exact size of the fragments such that the same flags ( or their alias -abinitio:frags_small -abinitio:frags_large ) can be used to give any type of fragment library. The 9mer or large fragments are used during abinitio stages I-III and the 3-mer or smaller fragments are used during stage IV to achieve more fine-grained sampling.

Note, that the default behavior of the fragment_picker is to generate 200 fragments of each size (3mers and 9mers) such that the lower ranking 175 9mer fragments are ignored. If you wish to included all fragments in your fragment library, regardless, you can use the flags ( -abinitio:number_9mer_frags 0 ).

It is important to be aware that the fragment picking process can pick fragments of homologous protein structures. If you are using ROSETTA to model an unknown structure it is of course an advantage if homologous information is available and you can keep the homologous fragments. If, however, you are benchmarking a protocol to get a feeling how well ROSETTA works, or to develop new protocols, you may want to remove homologous fragments.

### Job Distributor (JD2) 

﻿Most protocols in Rosetta take 0 or 1 input structure and generate exactly 1 output structure. Usually one wants to run these protocols repeatedly and preferably distribute that work-load over multiple processors. The Job-Distributor is responsible to handle the technicalities of this on different platforms and queuing systems and to provide a common interface for all applications.

(Beware there is an outdated version of the job-distributor that also leads to a slightly different interface and behaviour. The
 Job-Distributor you should be working with exclusively has the splendid name JD2. If you are using an obsolete application you may be victim to the Job-Distributor called “jobdist”. If so, obnoxiously prod your favorite Rosetta developer until he updates the application to JD2. It is not difficult to do so.)

### Move

A move is a change to the conformation of the molecule in the Pose. A move invalidates the energies cached in the Pose-object and thus requires re-application of the ScoreFunction to the Pose. A TrialMover is a move followed by an energy evaluation and the application of the Metropolis-Criterion. If the trial-move is rejected by the Metropolis-Criterion the Pose is reset to the previous conformation (before the move).

Since the move is such a central concept Rosetta provides the class abstraction called Mover. An object of type Mover can be applied to a pose and changes its state and/or conformation. Mover objects allow to pre-set certain parameters (e.g., a step-size, or a pivot residue) and are usually applied to the pose multiple times during sampling. The advantage of the Mover-object is that it can be passed to code that implements a generic optimization protocol, such as simulated annealing.

Since a mover is simply an object that can change the state of a pose in some predefined manner, Mover-object are also frequently used for setup-tasks such as adding a set of constraints to the pose.

### Pose
The Pose is the container of the molecular system including its chemical-, kinematic- and conformational structure. The Pose also contains the Energies object, which stores energy information after a score-function has been applied. Experimental restraints such as distance restraints (ConstraintSet), RDC and PCS data are also often stored in the Pose object to make them accessible to scoring even deep in sub-routines of the program. 

It contains the residues numbered from 1 to N. Even if multiple chains are present (as e.g., in docking) numbering will be consecutively and starting from 1. The Pose contains your molecule in a particular conformation and remembers the energy values of the last scoring applied to the Pose. Thus, writing out the Pose to file (as PDB or via SilentIO) will result in the structure and information about scores. In PDB-format scores are written after the coordinates. In Silent-IO format scores will be written before the coords in a special line headed by the word “SCORE:”

### Protein Model 

Rosetta represents proteins as a polymer of residues. The chemical definiton of residues is called ResidueType and is defined in params files in the database or in your local directory. The standard amin-acids are of course pre-defined in the database. Additional to the possibility to define new ResidueType s one can also define residue type patch es. The latter are particular useful to define small modifications of residues (e.g., the extra atoms on terminal residues, phoshporylation and other post-translational modifications, but also the addition of virtual atoms, e.g., to allow the computation of chainbreak energies)

    * Centroid Model: The low-resolution representation
    * Fullatom Model: The all-atom representation

#### Centroid Model

The low-resolution mode in Rosetta is often dubbed Centroid Mode, since the side-chain atoms of each amino-acid are represented by a single centroid sphere. To add a splash of inconsistency the Centroid-Mode representation also has an explicit CB atom, but no HA or HB atoms. Since HA atoms are often important sources of (NOE) restraints in NMR structure determination, and there position in ideal geometry is known a Centroid-Variant has been implemented that contains also explicit HA-atoms. This variant is switched on using the flag -residues:patch_selectors CENTROID_HA (see Frequently used ResidueTypePatches).

#### Fullatom Model

In the all-atom representation of ROSETA every atom is explicitly represented. What is notable is that proton-names are quite different from what is used in the NMR community (http://www.bmrb.wisc.edu/referenc/nomenclature/). There are two main differences: a) if only 2 protons are present on an sp3 hybridized carbon Rosetta numbers them 1, 2 whereas the NMR community numbers them 2, 3. b) Rosetta puts the number that differentiates between protons bound to the same carbon in front of the atom name whereas the NMR community puts this number at the very end of the atom name. The reminder of the atom name is usually obtained by taking the name of the carbon and replacing C->H. CD1 –> nHD1, whereas n=1,2,3 is the id-number of the proton.

NMR 			Rosetta

HB2, HB3 		1HB, 2HB

HG12, HG13 		1HG1, 2HG1

HD11, HD12, HD13 	1HD1, 2HD1, 3HD1

... 			...

### Protocol
﻿
A protocol is not a strict definition in Rosetta. A Protocol usually describes a bunch of high-level code that combines the use of Poses, ScoreFunctions and Movers. A protocol often reads like a cooking recipe:

    * apply Mover X and Y. 
    * cycle 10 times through applications of Mover Z, minimization and final scoring. 
    *keep the lowest scoring pose of the 10 cycles 
	
A simulated annealing protocol demonstrates the usefuleness of the Mover-abstraction, as it allows to specify the protocol without specification of the exact move used during the sampling:

    * initialize temperature T=10000 
    * LOOP 
    * record current pose for metropolis step 
    * apply a move 
    * return to save pose according to metropolis criterion 
    * reduce temperature by dT=10 
    * repeat for 1000 steps from LOOP Protocols

Protocols are usually implemented in C++ but can also be implemented using the Python-bindings (REF) or using XML within the Rosetta-scripts framework(REF).

### Rosetta Database 

﻿The database contains common parameters and settings that are not specific to a particular system.
 You are responsible for telling the Rosetta application where the database can be found (e.g., with the flag -database ). A convenient alternative is to set the ROSETTA3_DB environment variable in your .bashrc or .cshrc. Bash-users, for instance, would insert the line export ROSETTA3_DB=$HOME/rosetta/main/database if they had installed the Rosetta distribution in their home-directory.

### ScoreFunction 

The ScoreFunction is a list of weights for predefined scoring terms (e.g., vdw, env, fa_atr...). The score-terms stand for a certain physical interaction whose calculation has been implemented as an EnergyMethod into Rosetta. The total score of a pose is computed as the weighted sum of the individual contributions of the non-zero terms in the ScoreFunction. By changing a weight from 0.0 to a non-zero value the respective score calculation is activated.

ScoreFunctions are often changed throughout a Protocol, which simply means that one set of weights is exchanged with a different set of weights (e.g., see Fragment Assembly (Abinitio) ).

A couple of predefined weight sets can be found in the Rosetta Database under scoring/weights/.... Many Rosetta applications honor the flags -score:weights and -score:patch to choose the weight-file (from the database or in the local directory) and allow successive application of patches. Unfortunately, the use of these particular flags is not consistent through-out all applications, and others require one to specify more than one ScoreFunction. In the latter case, the standard flags are often used to specify the ScoreFunction used to compute the score of the final output structure.

New scoring terms can be added as a novel EnergyMethod to Rosetta but this is somewhat involved and requires skills in C++.
Most things, however, can be achieved by changing the weights of the scoring terms.

### Silent Files
﻿
The silent file format is a Rosetta specific (trajectory) format that is used to store ensembles of structures. These are usually the final structures of a structure determination protocol but can also be structures collected from multiple runs at a certain intermediate check-point or a whole trajectory of a single run. 

A frame in a silent file is controlled by the SilentStruct class and is nearly a full serialization of a Pose object. The frame contains the annotated sequence to reconstruct the chemical identity of the pose (residue modifcations, protonation states and ligands) and the reconstruction of the internal degrees of freedom. If a non-trivial FoldTree is used, a respective entry allows reconstruction of the kinematics. Different SilentStruct classes exist to account for the different nature of structures that have to be stored. Ideal poses only require us to save the backbone and side-chain torsion angles, which is handled by the ProteinSilentStruct. Non-ideal poses, as they appear after, e.g., loop building are stored by a BinarySilentStruct. RNA is stored in instances of the corresponding RNASilentStruct and RNABinarySilentStruct classes. 

Additionally to the chemical-, kinematic- and conformational information the frame also contains a set of scores. These are found in a line starting with 'SCORE:', and are generally preceded by the 'score' which is the weighted sum of the individual score terms and depends on the ScoreFunction last used to score the pose before it was stored. Additionally to the scores which have to be an actual ScoreType, the score line can also contain other information that has been added during the run of a protocol using various mechanisms including the PoseEvaluator, PoseMetric, and Filter.

 The column-headers to identify the score terms are provided in the second line of the silent file. The columns headers are usually not repeated for every score line, which can cause problems if the number of columns changes due to heterogeneous behavior of the protocol (e.g., sampling is terminated at various filter stages). In such cases it is advisable to use the cmd-line flag -out:file:silent_print_all_score_headers. 

Each frame in a silent file has a unique identifier, which is in colloquial language called the decoy-tag. The decoy-tag is at the end of each line that belongs to the respective frame, which allows the use of grep to extract frames from the silent-structure. Each frame of a silent file is independent and thus simple python tools can be used to manage silent files (e.g., extract subsets of decoys, concatenate files, etc). The most important tools provided are silent_data.py, extract_decoys.py and extract_pdbs. The first allows to extract score information from the silent file, and extract_decoys.py, allows to filter the structures contained in the silent file and extract_pdbs allows to extract structures from a silent file and save them in PDB format. 

Note that problems can occur if a) decoy-tags are not unique (e.g., after concatenation) or b) the number of columns in the SCORE: line changes.  The provided python tools can deal with changing number of columns if a new SCORE-header line is provided in front of each column change (see above; -out:file:silent_print_all_score_headers). However, simple grep-commands might loose the changed SCORE-header, and thus should be used with care. 

The trajectory format is now widely used in the RosettaCommunity and is recommended over the use of single PDB files.


##See Also

* [[FAQ]]: Frequently Asked Questions
* [[Glossary]]: Brief definitions of Rosetta terms
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Rosetta canon]]: List of important Rosetta papers
* [[Resources for learning biophysics and computational modeling]]
* [[Rosetta Timeline]]: History of Rosetta
* [[Units in Rosetta]]: Explains measurement units used in Rosetta
* [[Solving a Biological Problem]]: Guide for applying Rosetta to your biological problem

<!--- search optimization
pose
pose
pose
pose
pose
pose
pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

pose
pose
pose
pose
pose
pose

encyclopedia
encyclopedia
encyclopedia
encyclopedia
encyclopedia
encyclopedia
encyclopedia
encyclopedia

--->
