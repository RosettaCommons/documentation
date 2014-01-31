<!-- --- title: Enzyme Design Deprecated -->Deprecated Documentation for the enzdes application

Metadata
========

This document was written 24 march 2009 by Florian Richter ( [floric@u.washington.edu](#) ) and was last updated:

 Id:   
enzyme\_design.dox 28193 2009-03-20 17:48:21Z davis

Example runs
============

See `       rosetta/rosetta_tests/integration/tests/enzdes      ` for an example enzyme design run and input files.

Prologue
========

Much of the enzyme design code is based on the Ligand Docking functionality. Please refer to the documentation for this application for instructions on how to prepare the small molecule of your desire ( ligands/substrates/cofactors/etc) for use in Rosetta ( e.g. setup the necessary .params files and rotamer libraries) .

Application purpose
===========================================

This application takes an input structure containing one ligand/substrate in contact with a protein and repacks or redesigns the protein around it. Optionally, special catalytic contacts between ligand and protein can be specified, and this application can be used to optimize them ( see section Setting up of catalytic constraints).

NOTE: it does NOT contain the RosettaMatch algorithm that can be used to position a ligand in a protein scaffold for de-novo enzyme design.

While the code has been tested most thouroghly for the case of one ligand in one protein binding site, it will also run for related problems, i.e. for any system with multiple chains, where one chain is the protein receptor and the other chain could either be another protein or a ligand. Right now there will be several bugs for systems with more than two chains, but these should be ironed out in the near future.

setup
=====

The setup of an enzyme design calculation requires two things: setting up the ligand input files and setting up the catalytic constraints. For setting up the ligand input files, please refer to the ligand docking manual.

Setup of catalytic constraints

1) What are Rosetta catalytic constraints? Enzyme active site residues can usually be divided into two sets: residues responsible for the chemical steps in a reaction ( the so called catalytic residues) and residues responsible for substrate binding. Assessing how favorable for catalysis a given active site conformation is requires quantum-level calculations. Since the energy function underlying Rosetta is only comprised of classical terms, by itself it cannot differentiate active site conformations that favor catalysis from noncatalytic ones. To circumvent this problem, predefined constraints that penalize noncatalytic conformations of the catalytic residues are used in Rosetta enzyme design calculations. These constraints should be defined such that they yield a penalty if a catalytic residue is in a noncatalytic conformation. Practically, catalytic constraints are a set of distances, angles and dihedrals between a cataltyc residue and a substrate that need to have a prespecified value for the active site to be catalytic. These values can either be derived from quantum mechanical calculations of the reaction, crystal structures of a related enzyme in complex with a substrate or transition state analog (if these exist ), or simple chemical intuition.

2) Specification of catalytic constraints

Once the user has decided what the catalytic constraints should be like, ( in terms of the geometric relationship between a catalytic residue and the substrate, or between two catalytic residues ), these need to be specified in a constraints file ( or cstfile in short ). An example of a cstfile can be found in `       rosetta/rosetta_tests/integration/tests/enzdes/inputs/Est_ha_d2n.cst      ` . It describes the iteraction between a histinide and a ligand abbreviated with name D2N. In this cstfile, there needs to be a block of the following format for each catalytic interaction:

CST::BEGIN
 TEMPLATE:: ATOM\_MAP: 1 atom\_name: C6 O4 O2
 TEMPLATE:: ATOM\_MAP: 1 residue3: D2N

TEMPLATE:: ATOM\_MAP: 2 atom\_type: Nhis,
 TEMPLATE:: ATOM\_MAP: 2 residue1: H

CONSTRAINT:: distanceAB: 2.00 0.30 100.00 1
 CONSTRAINT:: angle\_A: 105.10 6.00 100.00 360.00
 CONSTRAINT:: angle\_B: 116.90 5.00 50.00 360.00
 CONSTRAINT:: torsion\_A: 105.00 10.00 50.00 360.00
 CONSTRAINT:: torsion\_B: 180.00 10.00 25.00 180.00
 CONSTRAINT:: torsion\_AB: 0.00 0.00 0.00 180.00
 CST::END

The information in this block defines constraints between three atoms on residue 1 and three atoms on residue 2. Up to six parameters can be specified ( one distance, two angles, 3 dihedrals ).

The Records indicate the following:

'CST::BEGIN' and 'CST::END' indicate the beginning and end of the respective definition block for this catalytic interaction.

The 'TEMPLATE:: ATOM\_MAP:' records:
 These indicate what atoms are constrained and what type of residue they are in. The number in column 3 of these records indicates which catalytic residue the record relates to. It has to be either 1 or 2. The 'residue1' or 'residue3' tag specifies what type of residue is constrained. 'residue3' needs to be followed by the name of the residue in 3 letter abbrevation. 'residue1' needs to be followed by the name of the residue in 1 letter abbrevation. As a convenience, if several similar residue types can fulfill the constraint (i.e. ASP or GLU ), the 'residue1' tag can be followed by a string of 1-letter codes of the allowed residues ( i.e. ED for ASP/GLU, or ST for SER/THR ). The 'atom\_name' tag specifies exactly which 3 atoms of the residue are to be constrained. It has to be followed by the names of three atoms that are part of the catalytic residue. In the above example, for catalytic residue 1, atom 1 is C6, atom 2 is O4, and atom3 is O2. The 'atom\_type' tag is an alternative to the 'atom\_name' tag. It allows more flexible definition of the constrained atoms. It has to be followed by the Rosetta atom type of the first constrained atom of the residue. In case this tag is used, Rosetta will set the 2nd constrained atom as the base atom of the first constrained atom and the third constrained atom as the base atom of the 2nd constrained atom. ( Note: the base atoms for each atom are defined in the ICOOR records of the .params file for that residue type ). There are two advantages to using the 'atom\_type' tag: first, it allows constraining different residue types with the same file. For example if a catalytic hydrogen bond is to be constrained, but the user doesn't care if it's mediated by a SER-OH or a THR-OH. Second, if a catalytic residue contains more than one atom of the same type (as in the case of ASP or GLU ), but it doesn't matter which of these atoms mediates the constrained interaction, using this tag will cause Rosetta to evaluate the constraint for all of these atoms separately and pick the one with lowest score, i.e. the ambiguity of the constraint will automatically be resolved.

The 'CONSTRAINT::' records:
 These records specify the actualy value and strength of the constraint applied between the two residues specified in the block. Each of these records is followed by one string and 4 numbers. The string can have the following allowed values: 'distanceAB' means the distance Res1:Atom1 = Res2:Atom1, i.e. the distance between atom1 of residue 1 and atom1 of residue 2. 'angle\_A' is the angle Res1:Atom2 - Res1:Atom1 - Res2:Atom1 'angle\_B' is the angle Res1:Atom1 - Res2:Atom1 - Res2:Atom2 'torsion\_A' is the dihedral Res1:Atom3 - Res1:Atom2 - Res1:Atom1 - Res2:Atom1 'torsion\_AB' is the dihedral Res1:Atom2 - Res1:Atom1 - Res2:Atom1 - Res2:Atom2 'torsion\_B' is the dihedral Res1:Atom1 - Res2:Atom1 - Res2:Atom2 - Res2:Atom3

Each of these strings is followed by 4 columns of numbers. The 1st column specifies the optimum distance x0 for the respective value. The 2nd column specifies the allowed tolerance xtol of the value. The 3rd column specifies the force constant k, or the strength of this particular parameter. If x is the value of the constrained parameter, the score penalty applied will roughly be: 0 if |x - x0| \< xtol k \* ( |x - x0| - xtol )\^2 otherwise

The 4th column has a special meaning in case of the distanceAB parameter. It specifies whether the constrained interaction is covalent or not. 1 means covalent, 0 means non-covalent. If the constraint is specified as covalent, Rosetta will not evaluate the vdW term between Res1:Atom1 and Res2:Atom1 and their [1,3] neighbors.
 For the other 5 parameters, the 4th column specifies the periodicity per of the constraint. For example, if x0 is 120 and per is 360, the constraint function will have a its minimum at 120 degrees. If x0 is 120 and per is 180, the constraint function will have two minima, one at 120 degrees and one at 300 degrees. If x0 is 120 and per is 120, the constraint function will have 3 minima, at 120, 240, and 360 degrees.

Declaration of the catalytic residues in the input-pdb:

One piece of information is missing in the cstfile: which residues in the input pdb are the catalytic ones. This has to be specified in the REMARK records of the respective input pdb. For each block in the cstfile, there has to be a line of the following format in the REMARK section of the input pdb:

REMARK 0 BONE TEMPLATE X D2N 900 MATCH MOTIF A HIS 37 1

The last column (13) declares which block in the cstfile the line is associated with. Columns 5,6 and 7 specify chain, name (in 3-letter format) and residue number on the chain for template residue A in the block. Columns 10,11 and 12 specify chain, name (in 3-letter format) and residue number on the chain for template residue B in the block. (Note: if the residue number for a certain position is not given, every residue of the specified name 3 will be constrained ). The above example line corresoponds to the cstfile example block shown above (from the enzyme design integration test). Histidine A37 and a ligand abbreviated D2N with pdb id X900 will be constrained according to the paramers specified in the first block of the cstfile.

The reason for declaring the constraints and the exact residues to constrain in two different places is the following: it allows to use the same .cstfile for any number of matches that have the same type of active site but are in different scaffolds or at different attachment points in the same scaffold.

Command line options relating to the setup of enzdes constraints: Once the cstfile has been created and the proper REMARK lines have been added to the starting pdb(s), the option -enzdes::cstfile \<name/path of cstfile\> will trigger usage of the catalytic constraints in the calculation.

Running the Application
=======================

Simplified, a fixbb Rosetta enzyme design calculation consists of 4 steps:

1.  Determing which residues to design and which to repack
2.  optimizing the catalytic interactions
3.  cycles of sequence design/minimization with catalytic constraints
4.  unconstrained fixed sequence rotamer pack /minimization

1.  Determing which residues to design and which to repack There are two ways of doing this: using a standard rosetta resfile to exactly specify which residues are allowed at which position or automatic detection of the design region. In case there is only a small number of different starting structures, it is probably better to invest the time and use intuition to decide which positions in the protein to redesign or repack and which amino acids to allow. Please refer to the resfile documentation for information about the file format etc.

In case there are a lot of input structures to be designed, it is also possible to automatically determine which residues to redesign. Rosetta can divide the protein's residues into 5 groups of increasing distance from the ligand:
 1) residues that have their Calpha within a distance cut1 angstroms of any ligand heavyatom will be set to designable
 2) res that have Calpha within a distance cut2 of any ligand heavyatom and the Cbeta closer to that ligand atom than the Calpha will be set to designable. cut2 has to be larger than cut1
 3) res that have Calpha within a certain distance cut3 of any ligand heavyatom will be set to repackable. cut3 has to be larger than cut2
 4) res that have Calpha within a distance cut4 of any ligand heavyatom and the Cbeta closer to that ligand atom will be set to repackable. cut4 has to be larger than cut3
 5) all residues not in any of the above 4 groups are kept static.

Residues declared as catalytic in the input pdb will always be repackable (except if turned off by an option). At residue positions that are set to designable, every amino acid except cysteine will be allowed. Values for the different cuts commonly used in the Baker lab are: 6.0 (cut1), 8.0 (cut2), 10.0(cut3), 12.0(cut4)

Command line options affecting this stage:
 -resfile \<name of="" resfile=""\> specifies the use of a resfile
 -enzdes:detect\_design\_interface invokes automatic detection of designable region
 -enzdes:cut1 \<float\> value used for cut1
 -enzdes:cut2 \<float\> value used for cut2
 -enzdes:cut3 \<float\> value used for cut3
 -enzdes:cut4 \<float\> value used for cut4
 -enzdes:fix\_catalytic\_aa prevents catalytic residues from being repacked

1.  Optimizing catalytic interactions
     This stage consists of a gradient-based minimization of the input structure before design. During this minimization, all active site residues that are not catalytic (i.e. not constrained) are mutated to alanine (i.e. the active site is reduced to substrate and catalytic residues only), and a reduced energy function that does not contain vdW-attractive or solvation terms is used for the minimization. The purpose of this stage is to move the substrate to a position where the catalytic interactions are as ideal as possible.

Command line options affecting this stage
 -enzdes:cst\_opt will invoke this stage
 -enzdes:bb\_min optional but recommended. allows the backbone to be slightly flexible during the minimization
 -enzdes:chi\_min optional but recommended. allows the dihedrals of the catalytic residues to move during the minimization

NOTE: running this part of the calculation does not make sense if no cstfile is specified (i.e. no catalytic residues are declared ). If this stage is invoked without existing catalytic constraints, it might lead to the ligand being ejected from the active site, because there are no catalytic constraints that hold it there and the force field used in this stage is dominated by repulsive interactions. Further, to prevent the backbone of the active site to move considerably during this stage, the backbone Calphas are constrained to within 0.5A of their original positions.

1.  Cycles of sequence design/minimization
     This is where the actual sequence design happens. At the designable positions, the standard Rosetta sequence selection Monte Carlo algorithm is employed to find a new lower energy sequence. Catalytic constraints are employed throughout. The resulting structure is then minimimized. These two steps are typically iteratively repeated a small number of times (3-4 ).

Command line options affecting this stage
 -enzdes:cst\_design will invoke this stage
 -enzdes:design\_min\_cycles how many iterations of design/minimization will be done
 -enzdes:lig\_packer\_weight determines the relative importance of protein-substrate interactions vs. protein-protein interactions in the sequence selection calculation
 -enzdes:cst\_min necessary to invoke minimization after the sequence design
 -enzdes:bb\_min same as for stage 2
 -enzdes:chi\_min same as for stage 2
 -packing:ex1 optional but highly recommended. improved rotamer sampling around the first dihedral for every amino acid
 -packing:ex2 optional but highly recommended. improved rotamer sampling around the second dihedral for every amino acid
 -packing:use\_input\_sc optional but highly recommended. include the input rotamer of every sidechain in the calculation
 -packing:soft\_rep\_design triggers use of the soft-repulsive force field in design. see note below.

On using the soft-repulsive potential:
 1) The Rosetta soft-repulsive potential is an energy function where the vdW repulsive term is scaled to shorter distances, i.e. the optimal interaction distance for two atoms is smaller than in the regular energy function. Using this potential during rotamer packing will lead to slight clashes being introduced into the structure, as combinations of rotamers will be selected where the atoms are closer than the optimal vdw distance. Therefore, when using the soft rep potential, every packing step has to be followed by a gradient-based minimization in the regular potential to relieve the clashes.
 The reason why this strategy is used is to overcome the limitations of the conformational discretation introduced by the rotamer approximation. Especially for large sidechains with lever-arm effects of chi1 or chi2, small deviations in these angles can lead to noticeable shifts in the side chain atoms (0-1A). The resolution of the Rosetta energy function, just like other molecular modellig energy functions, is high enough that these small shifts can significantly affect the score of a given conformation. This in turn can have the undesired effect that a conformation where the standard dunbrack rotamers are slightly clashing, but small changes in the chis would lead to tight packing, will be rejected by the MonteCarlo algorithm during rotamer packing. Using the soft-rep potential on the other hand will tolerate small clashes, and the hope is that the following minimization will then be able to turn a structure with slight clashes into a tightly packed one.
 2) WARNING: The final design cycle will automatically use the standard force field, so when soft\_rep\_design is turned on design\_min\_cycles must be greater than 1. If design\_min\_cycles = 1 only one cycle without soft\_rep will be run, as if soft\_rep were never turned on!

1.  Unconstrained fixed sequence rotamer pack /minimization
     After Rosetta has designed a new sequence, a final repack/minimization will be done without the catalytic constraints. This is to check whether the sequence that is designed actually supports the catalytic residues in their designed conformation, i.e. in a good design, the catalytic residues should be in a good conformation without artificial constraints holding them there.

Command line options affecting this stage:
 -enzdes:no\_unconstrained\_repack will prevent this stage from being invoked
 -packing:ex1 same as for stage 3
 -packing:ex2 same as for stage 3
 -packing:use\_input\_sc same as for stage 3
 -enzdes:cst\_min same as for stage 3
 -enzdes:bb\_min same as for stage 2+3
 -enzdes:chi\_min same as for stage 2+3

and ranking the results
=======================

In a typical enzyme design project, often hundreds or thousands of input structures will be designed. Typically these input structures stem from matching, and they can be very similar to each other (i.e. small deviations in the ligand placement ). It is also recommended to redesign every starting structure a few times, since the stochastic MonteCarlo algorithm can lead to slightly different results every time.

The question then is, after having produced 100s-1000s of design models, which ones to eventually express, i.e. how to analyse, score and rank all of the produced structures to find the best handful. There is no perfect or ideal way to do this, and only one of many possibilities is described in the paragraph below.

calculation results
===================

Evaluating the results: Every PDB file that is output by rosetta has the scores broken down by residue and score type appended after the atom records. One can simply select the PDB that has the best overall score, or the best ligand score, or the best constraint score, etc. However, the rosetta scores don't necessarily capture all the important characteristics of a given design. The enzyme\_design application is set up to evaluate each output structure with respect to the following additional properties and metrics: -number of hydrogen bonds (in the whole protein and catalyic residues) -number of buried unsatisfied polars in the catalyitc residues (whole protein/catalyic res) -non-local contacts (i.e. contacts between residues that are far away in sequence, for both whole protein/catalyic res) -score across the interface between protein/ligand -packstat of the designed structure with and without ligand present if the option -out: <file:o> \<filename\> is active, a scorefile containing will be written that contains one line for every output structure. An example of the format of this scorefile is in the file enz\_score.out that is produced by the enzdes integration test. The column labels in the score file have the following meaning:

General syntax:
 pm = pose metric
 The catalytic residues are SR1, SR2, SRN for N residues. e.g. if there is one catalytic residue only SR1
 The ligand is the SR(N+1), e.g. if there is one cat res it is SR2. Itis the last SR.

total\_score energy (excluding the constraint energy)
 fa\_rep full atom repulsive energy
 hbond\_sc hbond sidechain energy
 all\_cst all constraint energy
 tot\_pstat\_pm pack statistics, 0-1, 1 = fully packed
 total\_nlpstat\_pm pack statistics withouth the ligand present
 tot\_burunsat\_pm buried unsatisfied polar residues, higher = more buried unsat polars (just a count)
 tot\_hbond\_pm total number of hbonds
 tot\_NLconst\_pm total number of non-local contacts ( two residues form a nonlocal contact if they are farther than 8 residues apart in sequence but interact with a rosetta score of lower than -1.0 )
 SR1 is sequence position of SR1 (e.g. 176 means residue 176)
 interf\_E\_1\_2 interface energy between the ligand and the rest of the protein
 SR\_2\_dsasa\_1\_2 fraction of the ligand surface area that is covered up by the protein, i.e. a measure of how well the ligand is buried

Ranking the results:
 Figuring out which designs of the usually high number of models to express is non trivial. As described above, if the scorefile option is used, every design is automatically evaluated with respect to a few dozen criteria. Ideally, one would want to only pick one or a few designs to express. Therefore, the designs need to be ranked according to some criteria. There is no clear answer as to what these criteria should be. One approach currently used in the baker group is the following: first, a subset of the 4-5 most important criteria is picked, i.e. total\_score, ligand binding energy/SR\_interface\_E\_1\_2, total constraint score of the catalytic residues (all\_cst), packstat, and buried unsatisfied polars of the ligand. Then, for each of these criteria, a minimum value is decided, which all designs considered for expression have to exceed ( i.e. total\_score has to be lower than the corresponding rosetta score of the undesigned scaffold, ligand\_binding energy has to be \< -10.0, and all\_cst has to be \< 1.0 ). The script 'DesignSelect.pl' (in rosetta/rosetta\_source/src/apps/public/enzdes ) can then be used to go through the output file and select only those structures that fulfill all of the required criteria.

To use DesignSelect.pl, one needs a Rosetta output file, as well as a file stating the necessary requirements. For example, if the outfile design.out contains data for a number of rosetta designs, for an active site containing 3 protein residues (i.e. the ligand is 'catalytic' residue 4) and one wants to select only those that have a ligand binding energy \< -10.0 and a catalytic constraint score \< 1.0, then rank the selected designs by total score, one needs to write a requirements file containing the following lines:

req all\_cst value \< 1.0
 req SR\_4\_interf\_E\_1\_2 value \< -10.0
 output sortmin total\_score

Then, running DesignSelect.pl with arguments:
 DesignSelect.pl -d design.out -c \<requirements file\> -tag\_column last \> filtered\_designs.out

will yield a file filtered\_designs.out that contains only the desired designs.

Command line options affecting this stage

-out: <file:o>
 Triggers writing of scorefile that has additional info about the design as described above
