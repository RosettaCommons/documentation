#Enzyme design application

Metadata
========

Author: Florian Richter (floric@u.washington.edu)

This document was mostly written by Florian Richter (floric@u.washington.edu), last updated july 2010. Other contributors are Sinisa Bjelic (sinibjelic@gmail.com) and Lucas Nivon (nivon@u.washington.edu). the `       enzyme_design      ` application is maintained by David Baker's lab. Send questions to dabaker@u.washington.edu

Code and Demo
=============

The application executable is in rosetta/main/source/src/apps/public/enzdes/enzyme\_design.cc Most code resides in rosetta/main/source/src/protocols/enzdes/ and rosetta/main/source/src/protocols/toolbox/match\_enzdes\_util/. the most basic mover is the EnzdesFixBBMover, rosetta/main/source/src/protocols/enzdes/EnzdesFixBBProtocol.hh/cc

A basic usage example is the enzdes integration test, found in rosetta/main/tests/integration/tests/enzdes/ To do a production run, the flags file from the enzdes integration test should be expanded by the desired rotamer packing options (ex1, ex2, use\_input\_sc, linmem\_ig ), the number n (usually 2-4) of iterative design/minimization cycles the user would like to do (-design\_min\_cycles n ) and of course by the number of structures the user would like to produce (-nstruct). All options pertaining to enzdes are in the options documentation, [[options documentation page|full-options-list]] , section enzdes

A tutorial on protein design can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/protein_design/protein_design_tutorial).

References
==========

Richter F, Leaver-Fay A, Khare SD, Bjelic S, Baker D (2011) De Novo Enzyme Design Using Rosetta3. PLoS ONE 6(5): e19230. doi:10.1371/journal.pone.0019230
 The protocol/algorithm is very similar to the one in Rosetta 2.x, which was used to generate the designs in the aldolase and kemp papers:
 Lin Jiang et al., "De novo computational design of retro-aldol enzymes," Science (New York, N.Y.) 319, no. 5868 (March 7, 2008): 1387-1391.
 Daniela Röthlisberger et al., "Kemp elimination catalysts by computational enzyme design," Nature 453, no. 7192 (May 8, 2008): 190-195.

Prologue
========

Much of the enzyme design code is based on the Ligand Docking functionality. Please refer to the documentation for this application for instructions on how to prepare the small molecule of your desire ( ligands/substrates/cofactors/etc) for use in Rosetta ( e.g. setup the necessary .params files and rotamer libraries) .

Application purpose
===========================================

This application takes an input structure containing one ligand/substrate in contact with a protein and repacks or redesigns the protein around it. Optionally, special catalytic contacts between ligand and protein can be specified, and this application can be used to optimize them ( see section Setting up of catalytic constraints).

NOTE: it does NOT contain the RosettaMatch algorithm that can be used to position a ligand in a protein scaffold for de-novo enzyme design.

While the code has been tested most thouroghly for the case of one ligand in one protein binding site, it will also run for related problems, i.e. for any system with multiple chains, where one chain is the protein receptor and the other chain could either be another protein or a ligand. Systems with one protein chain and multiple ligands/cofactors/metal ions are also supported, but it is advisable to put the actual substrate last in the pdb file.

Setup
=====

The Setup of an enzyme design calculation requires two things: setting up the ligand input files and setting up the catalytic constraints. Ligand .params files and conformers are handled the same as in the ligand dock application. Thus, for setting up the ligand input files, PLEASE REFER TO THE LIGAND DOCKING MANUAL. Especially the section therein about Preparing the small-molecule ligand for docking is essential reading before starting to work with Rosetta enzyme design. It can be found here: [[LigandDocking documentation|ligand-dock]] .

Setup of catalytic constraints

1) What are Rosetta catalytic constraints? Enzyme active site residues can usually be divided into two sets: residues responsible for the chemical steps in a reaction (the so called catalytic residues) and residues responsible for substrate binding. Assessing how favorable for catalysis a given active site conformation is requires quantum-level calculations. Since the energy function underlying Rosetta is only comprised of classical terms, by itself it cannot differentiate active site conformations that favor catalysis from noncatalytic ones. To circumvent this problem, predefined constraints that penalize noncatalytic conformations of the catalytic residues are used in Rosetta enzyme design calculations. These constraints should be defined such that they yield a penalty if a catalytic residue is in a noncatalytic conformation. Practically, catalytic constraints are a set of distances, angles and dihedrals between a catalytic residue and a substrate that need to have a prespecified value for the active site to be catalytic. These values can either be derived from quantum mechanical calculations of the reaction, crystal structures of a related enzyme in complex with a substrate or transition state analog (if these exist), or simple chemical intuition.

2) Specification of catalytic constraints

Once the user has decided what the catalytic constraints should be like, (in terms of the geometric relationship between a catalytic residue and the substrate, or between two catalytic residues), these need to be specified in a constraints file (or cstfile in short). The cstfile format documentation can be found at [[Cstfile format documentation.|match-cstfile-format]] An example of a cstfile can be found in `       rosetta/main/tests/integration/tests/enzdes/inputs/Est_CHba_d2n.cst      ` . It describes the iteraction between a cysteine and a ligand abbreviated with name D2N.

Declaration of the catalytic residues in the input-pdb:

One piece of information is missing in the cstfile: which residues in the input pdb are the catalytic ones. This has to be specified in the REMARK records of the respective input pdb. For each block in the cstfile, there has to be a line of the following format in the REMARK section of the input pdb:

```
REMARK 666 MATCH TEMPLATE X D2N    0 MATCH MOTIF A CYS   10  1  1
```

The second to last column (13) declares which block in the cstfile the line is associated with. Columns 5,6 and 7 specify chain, name (in 3-letter format) and residue number on the chain for template residue A in the block. Columns 10,11 and 12 specify chain, name (in 3-letter format) and residue number on the chain for template residue B in the block. (Note: if the residue number for a certain position is set to 0, every residue of the specified name 3 will be constrained ). The above example line corresoponds to the cstfile example block shown above (from the enzyme design integration test). Histidine A37 and a ligand abbreviated D2N with pdb id X900 will be constrained according to the paramers specified in the first block of the cstfile.

The reason for declaring the constraints and the exact residues to constrain in two different places is the following: it allows to use the same .cstfile for any number of matches that have the same type of active site but are in different scaffolds or at different attachment points in the same scaffold.

Command line options relating to the setup of enzdes constraints: Once the cstfile has been created and the proper REMARK lines have been added to the starting pdb(s), the option -enzdes::cstfile \<name/path of cstfile\> will trigger usage of the catalytic constraints in the calculation.

Algorithm
=========

Simplified, a fixbb Rosetta enzyme design calculation consists of 4 steps:

1.  Determining which residues to design and which to repack
2.  optimizing the catalytic interactions
3.  cycles of sequence design/minimization (with catalytic constraints if specified)
4.  unconstrained fixed sequence rotamer pack /minimization

#### 1\.  Determining which residues to design and which to repack 

There are two ways of doing this: using a standard Rosetta resfile to exactly specify which residues are allowed at which position or automatic detection of the design region. In case there is only a small number of different starting structures, it is probably better to invest the time and use intuition to decide which positions in the protein to redesign or repack and which amino acids to allow. Please refer to the resfile documentation for information about the file format etc. [[resfile documentation|resfiles]]

In case there are a lot of input structures to be designed, it is also possible to automatically determine which residues to redesign. Rosetta can divide the protein's residues into 5 groups of increasing distance from the ligand:

1. residues that have their Calpha within a distance cut1 angstroms of any ligand heavyatom will be set to designable
2. res that have Calpha within a distance cut2 of any ligand heavyatom and the Cbeta closer to that ligand atom than the Calpha will be set to designable. cut2 has to be larger than cut1
3. res that have Calpha within a certain distance cut3 of any ligand heavyatom will be set to repackable. cut3 has to be larger than cut2
4. res that have Calpha within a distance cut4 of any ligand heavyatom and the Cbeta closer to that ligand atom will be set to repackable. cut4 has to be larger than cut3
5. all residues not in any of the above 4 groups are kept static.

Residues declared as catalytic in the input pdb will always be repackable (except if turned off by an option). At residue positions that are set to designable, every amino acid except cysteine will be allowed. Values for the different cuts commonly used in the Baker lab are: 6.0 (cut1), 8.0 (cut2), 10.0(cut3), 12.0(cut4)

Command line options affecting this stage:
```
 -resfile <name of resfile>            specifies the use of a resfile
 -enzdes:detect_design_interface       invokes automatic detection of designable region
 -enzdes:cut1 <value>                  value used for cut1
 -enzdes:cut2 <value>                  value used for cut2
 -enzdes:cut3 <value>                  value used for cut3
 -enzdes:cut4 <value>                  value used for cut4
 -enzdes:fix_catalytic_aa              prevents catalytic residues from being repacked
```
Further, these two ways of declaring the design and repack regions can be combined, i.e. a resfile and the detect\_design\_interface mechanism can be used concurrently. If the default behavior in the resfile is set to 'AUTO', the behavior of every residue which isn't specifically declared in the resfile will be determined according to the -detect\_design\_interface logic.

#### 2\.  Optimizing catalytic interactions

**2 A:**

 This stage consists of a gradient-based minimization of the input structure before design. During this minimization, all active site residues that are not catalytic (i.e. not constrained) are mutated to alanine (i.e. the active site is reduced to substrate and catalytic residues only), and a reduced energy function that does not contain vdW-attractive or solvation terms is used for the minimization. The purpose of this stage is to move the substrate to a position where the catalytic interactions are as ideal as possible.

Command line options affecting this stage
```
 -enzdes:cst_opt             will invoke this stage
 -enzdes:bb_min              optional but recommended. allows the backbone to be slightly flexible during the minimization
 -enzdes:chi_min             optional but recommended. allows the dihedrals of the catalytic residues to move during the minimization
```
 For backbone minimization, only the backbone phi/psi angles of residues in the designable/repackable region will be allowed to move. A special fold tree is created to contain backbone movement to the designed site, i.e. there will be no conformational changes in regions that are neither repackable nor designable.

**2 B:**

An alternative to the gradient-based restraint optimization is the Monte Carlo rigid body ligand sampling. It is invoked by

```
-enzdes:cst_predock 
-enzdes:trans_magnitude <value>
-enzdes:rot_magnitude <value>
-enzdes:dock_trials <value>
```

trans\_magnitude (in Angstrom) and rot\_magnitude (in degrees) flags set the largest possible displacement and rotation, respectively of the ligand during cst\_predock. The values are sampled with a Gaussian distribution of zero mean and one standard deviation. Number of rigid body moves is determined by dock\_trials. Rotation and translation center is determined by first identifying what distance restraints there are between ligand atoms and protein, and then using the coordinates of those ligand atoms to calculate the canter of rotation and translation. If there is more then one restrained atom an average position is calculated and the ligand is moved around it. This ensures most efficient sampling of the ligand with respect to the restraints. During sampling all residues that are designated to be designed will be mutated to alanine to allow ligand to sample all active site prior to design.

NOTE: Running this part of the calculation does not make sense if no cstfile is specified (i.e. no catalytic residues are declared ). If this stage is invoked without existing catalytic constraints, it might lead to the ligand being ejected from the active site, because there are no catalytic constraints that hold it there and the force field used in this stage is dominated by repulsive interactions. Further, to prevent the backbone of the active site to move considerably during the gradient-based minimization, the backbone Calphas are constrained to within 0.5A of their original positions.

#### 3\.  Cycles of sequence design/minimization

This is where the actual sequence design happens. At the designable positions, the standard Rosetta sequence selection Monte Carlo algorithm is employed to find a new lower energy sequence. Catalytic constraints are employed throughout. The resulting structure is then minimized. These two steps are typically iteratively repeated a small number of times (3-4).

Command line options affecting this stage
```
 -enzdes:cst_design                     will invoke this stage
 -enzdes:design_min_cycles              how many iterations of design/minimization will be done
 -enzdes:lig_packer_weight              determines the relative importance of protein-substrate interactions (variable weight specified by this flag) vs. protein-protein interactions (weight of 1) in the sequence selection calculation
 -enzdes:cst_min                        necessary to invoke minimization after the sequence design
 -enzdes:bb_min                         same as for stage 2
 -enzdes:chi_min                        same as for stage 2
 -packing:ex1                           optional but highly recommended. improved rotamer sampling around the first dihedral for every amino acid
 -packing:ex2                           optional but highly recommended. improved rotamer sampling around the second dihedral for every amino acid
 -packing:use_input_sc                  optional but highly recommended. include the input rotamer of every sidechain in the calculation
 -packing:soft_rep_design               triggers use of the soft-repulsive force field in design. see note below.
 -packing:linmem_ig 10                  optional but highly recommended. speeds up the sequence design step while at the same time reducing memory requirements.
 -packing:unboundrot <file vector>      optional. pdb files that contain additional rotamers to use in the packer. as opposed to ligand docking, for enzdes it doesn't matter whether the files given to this option also contain the ligand.
```

On using the soft-repulsive potential:

1) The Rosetta soft-repulsive potential is an energy function where the vdW repulsive term is scaled to shorter distances, i.e. the optimal interaction distance for two atoms is smaller than in the regular energy function. Using this potential during rotamer packing will lead to slight clashes being introduced into the structure, as combinations of rotamers will be selected where the atoms are closer than the optimal vdw distance. Therefore, when using the soft rep potential, every packing step has to be followed by a gradient-based minimization in the regular potential to relieve the clashes.
 The reason why this strategy is used is to overcome the limitations of the conformational discretation introduced by the rotamer approximation. Especially for large sidechains with lever-arm effects of chi1 or chi2, small deviations in these angles can lead to noticeable shifts in the side chain atoms (0-1A). The resolution of the Rosetta energy function, just like other molecular modellig energy functions, is high enough that these small shifts can significantly affect the score of a given conformation. This in turn can have the undesired effect that a conformation where the standard dunbrack rotamers are slightly clashing, but small changes in the chis would lead to tight packing, will be rejected by the MonteCarlo algorithm during rotamer packing. Using the soft-rep potential on the other hand will tolerate small clashes, and the hope is that the following minimization will then be able to turn a structure with slight clashes into a tightly packed one.

2) WARNING: The final design cycle will automatically use the standard force field, so when soft\_rep\_design is turned on design\_min\_cycles must be greater than 1. If design\_min\_cycles = 1 only one cycle without soft\_rep will be run, as if soft\_rep were never turned on!

#### 4\.  Unconstrained fixed sequence rotamer pack /minimization

After Rosetta has designed a new sequence, a final repack/minimization will be done without the catalytic constraints. This is to check whether the sequence that is designed actually supports the catalytic residues in their designed conformation, i.e. in a good design, the catalytic residues should be in a good conformation without artificial constraints holding them there.

Command line options affecting this stage:
```
 -enzdes:no_unconstrained_repack           will prevent this stage from being invoked
 -packing:ex1                              same as for stage 3
 -packing:ex2                              same as for stage 3
 -packing:use_input_sc                     same as for stage 3
 -enzdes:cst_min                           same as for stage 3
 -enzdes:bb_min                            same as for stage 2+3
 -enzdes:chi_min                           same as for stage 2+3
```

and ranking the results
=======================

In a typical enzyme design project, often hundreds or thousands of input structures will be designed. Typically these input structures stem from matching, and they can be very similar to each other (i.e. small deviations in the ligand placement ). It is also recommended to redesign every starting structure a few times, since the stochastic Monte Carlo algorithm can lead to slightly different results every time.

The question then is, after having produced 100s-1000s of design models, which ones to eventually express, i.e. how to analyse, score and rank all of the produced structures to find the best handful. There is no perfect or ideal way to do this, and only one of many possibilities is described in the paragraph below.

Expected Outputs
================

This protocol will produce -nstruct output pdbs for every input pdb and, if requested, one scorefile containing one line per output pdb. Upon succesful completion of a run, the message "Finished all [numstruct] structures in [numseconds] seconds." will be printed.

####Evaluating the results:
Every PDB file that is output by Rosetta has the scores broken down by residue and score type appended after the atom records. One can simply select the PDB that has the best overall score, or the best ligand score, or the best constraint score, etc. However, the Rosetta scores don't necessarily capture all the important characteristics of a given design. The enzyme\_design application is set up to evaluate each output structure with respect to the following additional properties and metrics: -number of hydrogen bonds (in the whole protein and catalyic residues) -number of buried unsatisfied polars in the catalyitc residues (whole protein/catalyic res) -non-local contacts (i.e. contacts between residues that are far away in sequence, for both whole protein/catalyic res) -score across the interface between protein/ligand -packstat of the designed structure with and without ligand present if the option -out:file:o \<filename\> is active, a scorefile containing will be written that contains one line for every output structure. An example of the format of this scorefile is in the file enz\_score.out that is produced by the enzdes integration test. The column labels in the score file have the following meaning:

####General syntax:
pm = Column labels ending in "\_pm" are determined using a pose metric calculator

The catalytic/constrained residues are SR1, SR2, SRN for N residues. e.g. if there is one catalytic residue only SR1. Note that if the same catalytic residue is involved in multiple interactions (such as in a triad), it will appear multiple times.

The ligand is the SR(N+1) and it is the last SR, e.g. if there is one catalytic residue it is SR2.

* total\_score: energy (excluding the constraint energy)
* fa\_rep: full atom repulsive energy
* hbond\_sc: hbond sidechain energy
* all\_cst: all constraint energy
* tot\_pstat\_pm: pack statistics, 0-1, 1 = fully packed
* total\_nlpstat\_pm: pack statistics withouth the ligand present
* tot\_burunsat\_pm: buried unsatisfied polar residues, higher = more buried unsat polars (just a count)
* tot\_hbond\_pm: total number of hbonds
* tot\_NLconst\_pm: total number of non-local contacts ( two residues form a nonlocal contact if they are farther than 8 residues apart in sequence but interact with a Rosetta score of lower than -1.0 )

For every catalytic residue and the ligand, there is a set of columns prefixed with SR\_\<i\>\_. The first column, SR\_\<i\>, gives the sequence position of SRN (e.g. 176 means residue 176). The following other columns are present: SR\_\<i\>\_total\_score, SR\_\<i\>\_fa\_rep, SR\_\<i\>\_hbond\_sc, SR\_\<i\>\_all\_cst, SR\_\<i\>\_hbond\_pm, SR\_\<i\>\_burunsat\_pm, SR\_\<i\>\_pstat\_pm, SR\_\<i\>\_nlpstat\_pm, which are the scores that the given residue has in these categories.

For the ligand, there are two additional columns. (The "1\_2" in the following terms refers to which chains were used in calculating the figures, usually the first chain (protein) and the second chain (ligand). If there are multiple protein chains, or if the ligand is not the last chain, these figures may not accurately represent the total figures for binding.)

* SR\_\<N+1\>\_interf\_E\_1\_2: interface energy between the ligand and the rest of the protein
* SR\_\<N+1\>\_dsasa\_1\_2: fraction of the ligand surface area that is covered up by the protein, i.e. a measure of how well the ligand is buried.

If option -enzdes:final\_repack\_without\_ligand is active, the generated structure will be repacked without the ligand, to test whether it will be in a different conformation in the apo-state. All constraints are removed for this stage. The following additional columns will appear in the score file:

* nlr\_totrms: The average CA-CB rmsd of the residues surrounding the ligand between the liganded and the apo state.
* nlr\_SR\<1-N\>\_rms: CA-CB rmsds of the catalytic residues between the liganded and apo states.

####Ranking the results:

Figuring out which designs of the usually high number of models to express is non trivial. As described above, if the scorefile option is used, every design is automatically evaluated with respect to a few dozen criteria. Ideally, one would want to only pick one or a few designs to express. Therefore, the designs need to be ranked according to some criteria. There is no clear answer as to what these criteria should be. One approach currently used in the Baker group is the following: first, a subset of the 4-5 most important criteria is picked, i.e. total\_score, ligand binding energy/SR\_interface\_E\_1\_2, total constraint score of the catalytic residues (all\_cst), packstat, and buried unsatisfied polars of the ligand. Then, for each of these criteria, a minimum value is decided, which all designs considered for expression have to exceed ( i.e. total\_score has to be lower than the corresponding Rosetta score of the undesigned scaffold, ligand\_binding energy has to be \< -10.0, and all\_cst has to be \< 1.0 ). The script 'DesignSelect.pl' (in rosetta/main/source/src/apps/public/enzdes ) can then be used to go through the output file and select only those structures that fulfill all of the required criteria.

To use DesignSelect.pl, one needs a Rosetta output file, as well as a file stating the necessary requirements. For example, if the outfile design.out contains data for a number of Rosetta designs, for an active site containing 3 protein residues (i.e. the ligand is 'catalytic' residue 4) and one wants to select only those that have a ligand binding energy \< -10.0 and a catalytic constraint score \< 1.0, then rank the selected designs by total score, one needs to write a requirements file containing the following lines:
```
req all_cst value < 1.0
req SR_4_interf_E_1_2 value < -10.0
output sortmin total_score
```

Then, running DesignSelect.pl with arguments:
```
 DesignSelect.pl -d design.out -c <requirements file> -tag_column last > filtered_designs.out
```

will yield a file filtered\_designs.out that contains only the desired designs, sorted by total\_score. The -tag\_column option tells the scripts which of the columns contains the name or description of each design. It can take an arbitrary number or 'last' in case the last column in the -d file contains the design name, as is the case in Rosetta scorefiles.

Command line options affecting this stage

```
-out:file:o                           will trigger writing of scorefile that has additional info about the design as described above.
-enzdes:no_packstat_calculation       will prevent the computationally intensive calculation of the packstat scores. This can be used in quick test calculations, where the packstat scores are not of interest.
-enzdes:final_repack_without_ligand   will trigger a repack of the structure without the ligand.
```

Limitations
===========

As previously mentioned, this code needs a match as input, i.e. a pdb with substrate and catalytic residues. It cannot compute theozymes or find placements of theozymes in a scaffold.

Modes
=====

At the moment there is only one mode, which is described in this document. In the next release, a flexbb mode will be added, which generates a small localized ensemble of the backbone regions surrounding the acitve site and considers these different backbones during the design stage. Also, a backbone remodelling protocol is being developed which will allow for larger changes to the backbone before the design stage. The overall framework for these additional modes will be the same though.

Input Files
===========

Input files that are needed:

-   a pdb file containing a ligand. a cst file describing the catalytic geometry. Note: the code will work just as fine without the cstfile, in this case all residues around the ligand will be designed (i.e. for receptor design). optionally a resfile that declares which residues to design and which to repack a .params file for the ligand and optionally a rotamer library for the ligand.

-   examples can be found in the enzdes integration test directory

Options
=======

Relevant command line options were described in the respective sections.

Tips
====

New things since last release
=============================

New feature for evaluating designs: The -final\_repack\_without\_ligand option has been added since the last release.

##See Also

* [Protein Design Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/protein_design/protein_design_tutorial)
* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
